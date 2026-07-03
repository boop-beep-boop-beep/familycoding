# CLAUDE.md — Project 1: How AI Works

> Read the root `CLAUDE.md` first. All the teaching rules there apply here too.

## Goal
Help Em and Anna understand how AI *actually* works by building tiny models
themselves, then running a small real one. The journey goes from "we wrote every
single line" to "we ran a real AI" — so they can feel the difference for themselves.

---

## Important: generating text/output IS allowed here
The "no AI-generated assets" guardrail is about **Project 2** (the app). Project 1
is the opposite — the whole point is to build and run generators to see how they
work under the hood. That's *studying the machine*, not using AI to make product
art. So text-generating programs are exactly what we want here.

---

## Language & tools
- **Python**, kept as simple as possible.
- Minimal dependencies. The first milestone uses only Python's built-in tools.
  Later steps may use `numpy`. Explain what "installing a package" means the first
  time we do it.

---

## The learning arc (three milestones)

### 1. The Babbler — a Markov chain text generator (~30 lines)
- Feed it some text (a book, song lyrics they like, or their own writing).
- It learns which words tend to follow which, then generates new sentences in that
  style.
- **Teaches:** prediction from patterns, and probability — the core idea behind all
  language AI.
- A great one for **Anna** to own: change the input text and watch how the output
  changes.
- Checkpoint: can they explain *why* it produces gibberish that still sounds familiar?

### 2. A tiny neural network, from scratch
- Build a very small neural net. Start simple; a `micrograd`-style build is a great
  target for **Em**.
- Train it to do something visible — recognize handwritten digits, or learn a simple
  pattern.
- **Teaches:** weights, training, and error — "learning" as adjusting numbers to
  reduce mistakes.
- Checkpoint: can they point to the exact place in the code where the "learning"
  happens?

### 3. Run a real small model locally (Ollama)
- Install Ollama and run a small LLM (for example, a ~1-billion-parameter model) on
  the laptop.
- Compare it to their own 30-line Babbler.
- **Teaches:** what *scale* buys you — the same basic idea, just millions of times
  bigger.
- Checkpoint: what can the big model do that the Babbler can't? What is still the
  same underneath?

---

## How to teach it
- Always show output. They should *see* something happen at every step.
- Connect each step back to the big picture ("remember how the Babbler guessed the
  next word? This does that too — just much better").
- Let them tinker. Changing inputs and settings and seeing what happens is the best
  kind of learning here.
