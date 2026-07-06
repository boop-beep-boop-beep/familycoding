# CLAUDE.md — Project 3: CAD Modeling & Circuit Design

> Read the root `CLAUDE.md` first. All the teaching rules there apply here too.

## Goal
Design real, physical things two ways: shapes in **OpenSCAD** (code that becomes a
3D model) and circuits on a real **Arduino/breadboard kit** (code that controls real
electricity). Both tracks end in something you can point to and say "I made that" —
a 3D model, and a blinking, sensing, real circuit. The capstone brings them together:
a 3D-printed case for a circuit you built.

---

## Session memory: read and update the learning logs
Each kid has their own running log, since they progress separately:
`projects/cad-modeling/LEARNING_LOG_EM.md` and
`projects/cad-modeling/LEARNING_LOG_ANNA.md`. (As of now, only Em is working on this
project — Anna's is a stub.)

- **At the start of a session**, read the log for whoever is driving before deciding
  what to teach next. Each log records which milestones are done, what that kid
  already understood, and specific examples used — reuse those rather than
  inventing new ones, so callbacks land.
- **Don't assume shared progress between the two logs.** If Em is ahead, teach Anna
  from Milestone 1 fresh when she joins.
- **During or at the end of a session**, add a dated entry when a milestone
  finishes, a good "aha" moment happens, or a notable experiment runs. Keep entries
  short. Update the "Where ~ is" section at the top of that log.
- These are normal files in the repo — `git add`ed and committed like any other file.

---

## Guardrail: they design it, not the AI
Same spirit as the root guardrail for Project 2. Claude's job is to teach OpenSCAD
syntax and circuit concepts, explain what each block/wire/line does, and suggest
*directions* to try — not to hand over a finished `.scad` file or wiring diagram for
a specific project idea without them building it step by step. Sketch on paper or
describe in words what to build before writing the code/wiring for it together.

---

## Tools
- **CAD:** [OpenSCAD](https://openscad.org/) — free, code-based. You write a `.scad`
  file describing shapes (`cube`, `cylinder`, `sphere`) and operations
  (`union`, `difference`, `intersection`); it renders the 3D model. Explain that this
  is "CAD" (computer-aided design) done by writing code instead of dragging a mouse.
- **Circuits:** a real Arduino + breadboard kit (already on hand). Explain the
  vocabulary as it comes up: breadboard, resistor, LED, digital pin, sketch (an
  Arduino program), upload.
- **Editor:** Zed or VS Code, same as the other projects.
- **git + GitHub**, same habits as always — commit `.scad` files and Arduino
  sketches (`.ino`) as they're built.

---

## Track A: CAD with OpenSCAD

1. **First shape** — install OpenSCAD, render a single `cube()`, then a `cylinder()`
   and `sphere()`. Learn the coordinate system: x (left/right), y (front/back), z
   (up/down).
   - Checkpoint: given a shape's code, can they predict roughly what it'll look like
     before rendering?

2. **Combine shapes** — use `union()` to stick shapes together, `difference()` to cut
   one shape out of another (e.g., a hole through a block), `intersection()` for
   where two shapes overlap. Build something small and real: a keychain, a name
   tag, a simple box with a lid.
   - Checkpoint: can they explain why `difference()` cares about order (first shape
     minus the rest), while `union()` doesn't?

3. **Parametric design** — pull the magic numbers out into variables at the top of
   the file (`width = 20;`) so resizing the whole model means changing one number,
   not redrawing it.
   - Checkpoint: change one variable and correctly predict what changes in the
     model before re-rendering.

4. **Design something real** — a small useful or fun object of their choosing.
   3D print it if a printer is available; otherwise this is the moment to look into
   print services or plan for one.

---

## Track B: Circuits with Arduino

1. **Blink an LED** — first breadboard circuit and first sketch. Wire an LED with a
   resistor, upload the classic "Blink" sketch. Explain voltage, current, and why
   the resistor is there (protecting the LED from too much current).
   - Checkpoint: can they explain what would happen (and why it'd be bad) if the
     resistor were left out?

2. **Add an input** — wire a pushbutton, read it in code. Introduce digital input vs
   output pins, and `pinMode()`.
   - Checkpoint: can they trace, in their own words, the path from "finger presses
     button" to "LED turns on"?

3. **Combine outputs** — multiple LEDs in a sequence (e.g. a mini traffic light).
   Introduces timing (`delay()`) and sequencing logic.

4. **Sensor triggers output** — a sensor (light, temperature, distance — whatever's
   in the kit) controls an output. This is the first "it senses the world and reacts"
   project.
   - Checkpoint: can they point to the line where the sensor's reading becomes a
     decision ("if bright enough, turn off the LED")?

---

## Capstone: bring the tracks together
Once both tracks have at least reached their "combine" milestone, design a 3D-printed
enclosure in OpenSCAD for one of the circuit builds — measuring the real components
and modeling a case that actually fits them. This is where "design on screen" meets
"build in real life" directly.

---

## How to teach it
- Always make something visible or tangible happen — a render, a blinking light, a
  physical part.
- Connect the two tracks explicitly ("remember how `difference()` cut a hole in the
  cube? We're about to cut a hole for this exact LED to poke through").
- Encourage a tinkering variation at each step (resize it, change the blink speed,
  swap which pin the button uses) before moving to the next milestone — see the
  root CLAUDE.md's pacing section.
