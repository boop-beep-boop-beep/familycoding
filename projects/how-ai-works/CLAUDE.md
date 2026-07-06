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

## Session memory: read and update the learning logs
Each kid has their own running log, since they're progressing separately:
`projects/how-ai-works/LEARNING_LOG_EM.md` and
`projects/how-ai-works/LEARNING_LOG_ANNA.md`. (As of now, only Em has started —
Anna's is a stub.)

- **At the start of a session**, read the log for whoever is driving (or both,
  if they're pairing) before deciding what to teach next. Each log records
  which milestones are done, what that kid already understood, and specific
  examples used (input texts, numbers, code snippets) — reuse those rather than
  inventing new ones from scratch, so callbacks land ("remember when the
  Babbler sounded like Tolstoy?").
- **Don't assume shared progress between the two logs.** If Em is ahead, don't
  expect Anna to know something just because it's in Em's log — teach it to her
  fresh when she gets there.
- **During or at the end of a session**, add a new dated entry to the relevant
  log when a milestone finishes, a good "aha" moment happens, or a notable
  experiment runs. Keep entries short: what was built, what it taught, and any
  example worth returning to. Update the "Where ~ is" section at the top of
  that log so the next session knows where to pick up.
- These files are just normal files in the repo — they get `git add`ed and
  committed like any code the kids write. That's a feature, not an
  afterthought: it's a live example of using git to track a project's own notes,
  not just its code.

---

## Language & tools
- **Python**, kept as simple as possible.
- Minimal dependencies. The first milestone uses only Python's built-in tools.
  Later steps may use `numpy`. Explain what "installing a package" means the first
  time we do it.

---

## The learning arc
The arc has grown from three milestones to six. **Do not rush to Ollama
(Milestone 6).** The whole point of Milestones 3–5 is to build, by hand, the
ideas that make a real language model different from the Babbler and the tiny
XOR net — so that when Ollama finally shows up, it feels like "oh, that's the
same stuff we built, just huge" instead of a black box. Only move to Milestone 6
once 3–5 have each had their checkpoint moment.

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

### 3. A neural word-predictor — merge the Babbler and the neural net
- Rebuild the Babbler, but replace its lookup table with the neural net from
  Milestone 2: instead of counting "what word actually followed this pair in the
  text," train a small network to *predict* the next word.
- Turn words into numbers first — start as simple as possible (e.g. each unique
  word gets an ID, or a one-hot vector) so the net has something to multiply.
- Reuse the `Value` autograd engine from Milestone 2 if it's still comfortable;
  drop to `numpy` if the vocabulary gets big enough that hand-rolled autograd is
  too slow.
- **Teaches:** this *is* a language model — a neural network trained to predict
  the next word is the same core idea as every modern LLM. The Babbler's lookup
  table and this network are solving the identical problem two different ways.
- Checkpoint: generate text from both the old lookup-table Babbler and the new
  neural version on the same source. Where do they sound different? Does the
  neural one ever produce a combination that was never in the lookup table?

### 4. Word embeddings — giving words a location, not just an ID
- Instead of a one-hot vector (all words equally different from each other),
  let the network learn a short list of numbers (a vector) for each word as
  part of training Milestone 3's predictor.
- Hands-on demo: after training, pick a word and find its nearest neighbors by
  comparing vectors (closest numbers = most similar meaning/usage in the text).
- **Teaches:** AI doesn't store meaning as text — it stores it as *geometry*.
  Words used in similar ways end up in similar "locations" in number-space.
- Checkpoint: do the nearest neighbors make sense? Can they explain why "king"
  and "queen" (or whatever shows up in their own text) might end up near each
  other without ever being told they're related?

### 5. Attention — "which earlier words actually matter?"
- The Babbler and the Milestone 3 predictor only ever look at a fixed, tiny
  window (one or two previous words). Build a small, simplified attention demo:
  given a short sentence, compute a similarity score between the current word's
  vector and every earlier word's vector, turn those into weights, and use the
  weights to blend the earlier words together instead of picking just the last
  one or two.
- Keep the math small enough to trace by hand on a short example sentence —
  the goal is intuition, not a full transformer implementation.
- **Teaches:** this is the specific idea (from the "Attention Is All You Need"
  lineage) that let language models stop being limited to a fixed short memory
  and instead weigh an entire sentence — or an entire conversation — at once.
- Checkpoint: can they point to why the Babbler is stuck remembering only the
  last couple of words, while attention isn't stuck that way?

### 6. Run a real small model locally (Ollama)
- Only start this once Milestones 3–5 are done and have had their checkpoint
  moments — see the note at the top of this section.
- Install Ollama and run a small LLM (for example, a ~1-billion-parameter model) on
  the laptop.
- Compare it to their own homemade neural word-predictor with embeddings and
  attention.
- **Teaches:** what *scale* buys you — the same basic ideas they just built by
  hand (predicting the next word, embeddings, attention), just millions of times
  bigger and trained on vastly more text.
- Checkpoint: what can the big model do that their homemade version can't? What
  is still the same underneath?

---

## How to teach it
- Always show output. They should *see* something happen at every step.
- Connect each step back to the big picture ("remember how the Babbler guessed the
  next word? This does that too — just much better").
- Let them tinker. Changing inputs and settings and seeing what happens is the best
  kind of learning here.
