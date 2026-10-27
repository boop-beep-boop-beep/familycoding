# Game Studio — Notes & Progress

## The pitch
A peaceful sheep-herding life sim set in ancient Greece. You play a shepherd
(built in a character creator): tend your sheep, shear them for wool, and sell
the wool in a nearby town. You can talk to travelers and townsfolk, and the
world has supernatural elements woven in — Greek gods and shapeshifters among
the people you meet. Pitched by Em, 2026-10-26. Smallest playable version:
still TBD (see ticket board).

## Ticket board
1. **Meadow + watching the sheep** — tiny over-the-shoulder 3D meadow, 3-5
   sheep that wander/graze on their own, player can walk around and look.
   Built 2026-10-26, not yet playtested by Em.
2. **Crouching** — queued by Em after playtesting #1, not started yet.
3. **More visible player body** (legs/feet, not just the head bump) — queued
   by Em to help with spatial awareness while walking/looking around, not
   started yet.
4. **Sheep look too small** — minor polish, noticed during playtesting.
   Em's call: not worth fixing now, revisit later. Not started.
*(more tickets to be added after playtesting #1 — wool/selling, town,
traveler dialogue, gods/shapeshifters, and the character creator are all on
deck but intentionally not started yet, per "smallest playable version"
first.)*

## Where things are
Godot project created directly in this folder (`project.godot`, `scenes/`,
`scripts/`). Ticket #1 built, playtested, and confirmed working by Em.
Next: commit this ticket, then start Ticket #2 (crouching) or keep playing
with the current build first.

## Log
- **2026-10-26** — Director: Em. Mode: direct and review. Pitched the game
  (peaceful ancient-Greek shepherd life sim with wool economy, town/traveler
  dialogue, Greek gods/shapeshifters, and a character creator). Narrowed the
  core loop down to "just watching the sheep" (not herding/chasing). Built
  Ticket #1 (meadow, over-the-shoulder camera, wandering/grazing sheep) via a
  gameplay-programmer helper. Playtesting surfaced three camera bugs in a row
  (ground clipping, no facing cue, then a pitch-swing bug that took two fix
  rounds to properly solve by restructuring the camera rig instead of just
  retuning numbers) — all fixed and confirmed by Em. Queued for later:
  crouching, a more visible player body, and sheep looking too small.
  Ticket #1 is done and ready to commit.
