kaplay({
  width: 640,
  height: 480,
  background: [30, 30, 40],
  letterbox: true,
});

const PLAYER_SPEED = 300;
const RED_SPEED = 100; // hard monsters: fast
const GREEN_SPEED = 60; // easy monsters: slow
const GOLD_COUNT = 10;

// Cap how much time counts per frame, so a slow page load or a lagging
// browser tab can't produce one giant frame that teleports things.
function safeDt() {
  return Math.min(dt(), 1 / 30);
}

let gameOver = false;
let goldCollected = 0;

const player = add([
  rect(40, 40),
  pos(width() / 2, height() / 2),
  anchor("center"),
  area(),
  color(255, 200, 60),
  outline(4),
  "player",
]);

let totalMonsters = 0;
let monstersDefeated = 0;

// Whenever a monster shows up (fresh spawn or fresh revive), it gets a
// 5-8 second grace period: it won't chase you and can't hurt you yet.
function startCooldown(m) {
  m.cooldownTimer = rand(5, 8);
}

function spawnMonster(x, y, speed, col, hp) {
  totalMonsters++;
  const m = add([
    rect(44, 44),
    pos(x, y),
    anchor("center"),
    area(),
    color(...col),
    outline(4),
    opacity(1),
    "monster",
  ]);
  m.hp = hp; // how many rock hits it takes to defeat this one
  m.maxHp = hp;
  m.revived = false; // each monster gets exactly one revive before it's gone for good
  startCooldown(m);
  // Every monster steers straight toward wherever the player currently is;
  // speed is what makes red monsters hard and green ones easy.
  m.onUpdate(() => {
    if (gameOver) return;

    if (m.cooldownTimer > 0) {
      m.cooldownTimer -= safeDt();
      m.opacity = 0.4; // dimmed = still cooling down, safe to touch
      return;
    }
    m.opacity = 1;

    const dx = player.pos.x - m.pos.x;
    const dy = player.pos.y - m.pos.y;
    const dist = Math.sqrt(dx * dx + dy * dy);
    if (dist > 1) {
      const step = speed * safeDt();
      m.pos.x += (dx / dist) * step;
      m.pos.y += (dy / dist) * step;
    }
  });
  return m;
}

const RED = [220, 40, 40];
const GREEN = [60, 200, 90];

spawnMonster(60, 60, RED_SPEED, RED, 2);
spawnMonster(width() - 60, 60, GREEN_SPEED, GREEN, 1);
spawnMonster(60, height() - 60, GREEN_SPEED, GREEN, 1);

function spawnGold() {
  const pad = 40;
  const safeDist = 100;
  let gx, gy;
  do {
    gx = rand(pad, width() - pad);
    gy = rand(pad, height() - pad);
  } while (Math.hypot(gx - player.pos.x, gy - player.pos.y) < safeDist);
  add([
    circle(10),
    pos(gx, gy),
    anchor("center"),
    area(),
    color(255, 225, 100),
    outline(3),
    "gold",
  ]);
}

for (let i = 0; i < GOLD_COUNT; i++) spawnGold();

const goldLabel = add([
  text(`Gold: 0 / ${GOLD_COUNT}`, { size: 20 }),
  pos(12, 12),
]);

const monsterLabel = add([
  text(`Monsters defeated: 0 / ${totalMonsters}`, { size: 20 }),
  pos(12, 36),
]);

// Winning needs both: every monster permanently defeated AND all the gold.
function checkWin() {
  if (goldCollected >= GOLD_COUNT && monstersDefeated >= totalMonsters) {
    endGame("You Win!", [100, 220, 120]);
  }
}

const facing = { x: 0, y: -1 }; // which way to throw a rock, updated as you move

player.onUpdate(() => {
  let dx = 0, dy = 0;
  if (isKeyDown("left")) dx -= 1;
  if (isKeyDown("right")) dx += 1;
  if (isKeyDown("up")) dy -= 1;
  if (isKeyDown("down")) dy += 1;

  if (dx !== 0 || dy !== 0) {
    const len = Math.sqrt(dx * dx + dy * dy);
    facing.x = dx / len;
    facing.y = dy / len;
  }

  if (!gameOver) {
    const step = PLAYER_SPEED * safeDt();
    player.pos.x += dx * step;
    player.pos.y += dy * step;
  }
  player.pos.x = clamp(player.pos.x, player.width / 2, width() - player.width / 2);
  player.pos.y = clamp(player.pos.y, player.height / 2, height() - player.height / 2);
});

const ROCK_SPEED = 400;
const THROW_COOLDOWN = 0.5;
let canThrow = true;

function throwRock() {
  if (!canThrow) return;
  canThrow = false;
  wait(THROW_COOLDOWN, () => { canThrow = true; });

  const vx = facing.x * ROCK_SPEED;
  const vy = facing.y * ROCK_SPEED;

  const rock = add([
    circle(6),
    pos(player.pos.x, player.pos.y),
    anchor("center"),
    area(),
    color(150, 150, 150),
    outline(2),
    "rock",
  ]);

  rock.onUpdate(() => {
    const step = safeDt();
    rock.pos.x += vx * step;
    rock.pos.y += vy * step;
    if (rock.pos.x < -20 || rock.pos.x > width() + 20 || rock.pos.y < -20 || rock.pos.y > height() + 20) {
      destroy(rock);
    }
  });

  rock.onCollide("monster", (monsterObj) => {
    destroy(rock);
    monsterObj.hp -= 1;
    if (monsterObj.hp > 0) return;

    if (!monsterObj.revived) {
      monsterObj.revived = true;
      monsterObj.hp = monsterObj.maxHp;
      startCooldown(monsterObj);
      const popup = add([
        text("Revived!", { size: 20 }),
        anchor("center"),
        pos(monsterObj.pos.x, monsterObj.pos.y - 30),
        color(255, 255, 255),
      ]);
      wait(0.6, () => destroy(popup));
    } else {
      destroy(monsterObj);
      monstersDefeated++;
      monsterLabel.text = `Monsters defeated: ${monstersDefeated} / ${totalMonsters}`;
      checkWin();
    }
  });
}

player.onCollide("gold", (goldPiece) => {
  destroy(goldPiece);
  goldCollected++;
  goldLabel.text = `Gold: ${goldCollected} / ${GOLD_COUNT}`;
  checkWin();
});

player.onCollide("monster", (monsterObj) => {
  if (monsterObj.cooldownTimer > 0) return; // still cooling down, safe to touch
  endGame("Game Over", [220, 60, 60]);
});

function endGame(message, col) {
  gameOver = true;
  add([
    text(message, { size: 48 }),
    anchor("center"),
    pos(width() / 2, height() / 2),
    color(...col),
  ]);
  add([
    text("Press SPACE to play again", { size: 20 }),
    anchor("center"),
    pos(width() / 2, height() / 2 + 50),
  ]);
}

onKeyPress("space", () => {
  if (gameOver) {
    location.reload();
  } else {
    throwRock();
  }
});
