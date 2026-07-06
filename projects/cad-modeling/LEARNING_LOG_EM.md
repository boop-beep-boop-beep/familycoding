# Learning Log — Em — CAD Modeling & Circuit Design

> **For Claude:** Read this at the start of a session where Em is working.
> Add a dated entry each time a milestone finishes, a good "aha" moment happens,
> or a notable experiment runs. Keep entries short: what was built, what it
> taught, and any example worth returning to. Update "Where Em is" below so the
> next session knows where to pick up.

## Where Em is
- **Track A (OpenSCAD):** Milestone 1 done. Milestone 2 (combining shapes) in
  progress — mid-`union()` exercise: two cubes, second one offset with
  `translate([5,5,5])`, to predict/observe how much they overlap. Pick back up
  by re-typing that example (not yet saved to a file) and finishing the
  prediction-then-render check before moving to `difference()`.
- Also asked what Tinkercad was and why we chose OpenSCAD/real hardware
  instead — good context if she brings up comparing tools again.
- **Track B (Arduino):** not started yet. Next up: Milestone 1, blink an LED —
  kit is already on hand.
- **Good examples to reuse:** `cube([10,10,10])` as the first-ever shape;
  `cube([20,10,5])` for the width/depth/height axis-mapping check (width=x=red
  axis); `cube([-5,10,10])` as the "silent failure" edge case — no warning in
  the log, shape just doesn't render. Good callback material for later
  debugging lessons ("remember the disappearing cube?").

## Session history
- **2026-07-06:** Installed OpenSCAD (2021.01, Windows x86-64). Along the way,
  accidentally downloaded the `.sha512` checksum file instead of the installer
  — good real-world mixup, tied back into a checksum/hash explanation.
  Rendered first cube, correctly predicted how `[x,y,z]` maps to width/depth/
  height using an asymmetric box, confirmed via the red/green/blue axis
  colors. Tried a negative dimension as a "break it" experiment — shape
  vanished with no warning in the console, used it to introduce the idea of
  a **silent failure** (invalid input that fails quietly instead of erroring
  loudly). Milestone 1 complete.
