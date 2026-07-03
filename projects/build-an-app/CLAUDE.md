# CLAUDE.md — Project 2: Build an App

> Read the root `CLAUDE.md` first. All the teaching rules there apply here too.

## Goal
Build a real, working web app that ends up **live on the internet at its own URL** —
using the simplest, most transparent stack possible, so Em and Anna learn the whole
*pipeline*, not just how to write code.

---

## The stack (deliberately simple — no hidden magic)
- **Plain HTML, CSS, and JavaScript.** No frameworks, no build tools. Every file
  does something they can see and understand.
- **Editor:** Zed or VS Code.
- **git + GitHub** for version control and the shared repo.
- **GitHub Pages** (or Netlify) to deploy to a real, public URL.

Explain what each language is for: **HTML** = structure, **CSS** = looks,
**JavaScript** = behavior. Explain what the browser does with them.

---

## The pipeline we're really teaching
Prove and narrate this full loop early — with a trivial "hello world" page first,
then build on it:

**write code → open it in the browser → commit → push to GitHub → deploy → see it live**

Once that loop works end to end, everything else just rides on top of it.

---

## HARD GUARDRAIL: no AI-generated assets
This is the most important rule for this project.

- **No** AI-generated images, text, art, or sound in the app. None.
- Everything in the app comes from:
  - **Code the kids write** — especially *procedural generation*: drawing shapes,
    patterns, mazes, game levels, and animations from math and rules; or
  - Things the **family makes themselves** — their own drawings, their own words,
    photos they took.
- This isn't a limitation, it's the point. Procedural generation teaches real
  algorithms and is far more educational than dropping in ready-made assets.

If an idea would need generated art or text, steer toward a code-drawn or
family-made version instead.

---

## Picking what to build
Let Em and Anna choose, but steer toward ideas that shine with procedural generation
and code-drawn visuals. Good candidates:
- A **maze generator** — code draws a brand-new maze every time.
- A **drawing / pattern toy** — spirographs, symmetry, generative geometric art from
  math.
- A **simple game** with graphics drawn in code on an HTML canvas.
- A **quiz or flashcard app** where *they* write all the questions.
- A **clock, timer, or dashboard** with a look they design themselves.

---

## How to build it
- Static page first → add CSS → add JavaScript interactivity → add procedural/canvas
  features → deploy.
- Small steps, visible results, commit often.
- Introduce the browser's **developer tools** early (how to see errors). It
  demystifies debugging and makes them feel in control.
