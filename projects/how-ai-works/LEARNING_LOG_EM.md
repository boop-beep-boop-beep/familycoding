# Learning Log — Em — How AI Works

> **For Claude:** Read this at the start of a session where Em is working, before
> deciding what to teach next. It records which milestones are done, what Em
> already understood, and specific examples used (input texts, numbers, code) —
> reuse those rather than inventing new ones from scratch, so callbacks land
> ("remember when the Babbler sounded like Tolstoy?"). Add a new dated entry
> when a milestone finishes, an "aha" moment happens, or a notable experiment
> runs. Keep entries short. Update "Where Em is" at the top. This file gets
> committed to git like any other file in the repo — that's on purpose.

## Where Em is
- **Current milestone:** wrapping up the Babbler and the from-scratch neural net
  (Milestones 1 and 2).
- **Next up:** the "bridge" milestones connecting the tiny neural net to real
  language-model ideas (neural word-predictor → embeddings → attention) before
  touching Ollama. See `CLAUDE.md` for the full arc.
- **Good examples to reuse:** the XOR problem (`xor.py` fails, `value.py` solves
  it with a hidden layer) is the go-to demo for "why do we need more than one
  neuron?" The Babbler's source-swapping (Tolstoy vs. Conan Doyle vs. Em's own
  story) is the go-to demo for "more/different data changes what the model can
  say."

## Session history

### 2026-07-03 — Project setup
Set up the repo structure and the CLAUDE.md guides for both projects.

### 2026-07-04 — The Babbler + first neural net code
- **Babbler (Milestone 1):** built a Markov-chain text generator in `babbler.py`.
  It reads a text file, breaks it into words, and builds a lookup table of "what
  word came next after this word" — then walks the table randomly to generate new
  text. First version used single words as the lookup key.
- **Tiny neural net (Milestone 2), step 1 — `neuron.py`:** one weight, no bias,
  trained by hand-rolled gradient descent to learn `y = 2x` from four
  examples. This is the simplest possible version of "adjust a number to reduce
  error."
- **Tiny neural net, step 2 — `xor.py`:** a single-layer perceptron (two weights
  + a bias, no hidden layer) trying to learn XOR. **It fails to converge** —
  this is a deliberate checkpoint: a single layer can't separate XOR's outputs,
  which is the classic historical reason neural nets needed hidden layers.
- **Tiny neural net, step 3 — `value.py`:** built a `Value` class from scratch
  (a mini autograd engine, micrograd-style) that tracks `+`, `*`, `**`, `tanh`,
  and can run `backward()` to compute gradients automatically through a chain of
  operations. Used it to build a real MLP — 3 hidden neurons (tanh) feeding one
  output neuron — and it **does** learn XOR correctly after ~3000 epochs. Direct
  payoff from the `xor.py` failure: same problem, hidden layer fixes it.

### 2026-07-05 — Testing the Babbler with different sources and memory sizes
- Downloaded free public-domain books from **Project Gutenberg** to use as
  training text: `babbler.txt` is now the full text of *War and Peace* by Leo
  Tolstoy, and `sherlock.txt` is *The Adventures of Sherlock Holmes* by Arthur
  Conan Doyle. Also tried `my_story.txt` — a short story Em wrote herself.
  Worth a quick aside next time: Project Gutenberg hosts books whose copyright
  has expired ("public domain"), which is why they're free to grab and reuse.
- Watched how the Babbler's *voice* changes with the source — Tolstoy-flavored
  gibberish vs. Sherlock-flavored gibberish vs. story-flavored gibberish, even
  though the code didn't change at all.
- Experimented with "word memory size": moved the lookup key from a single word,
  to a pair of words, to three words, then settled back on **pairs** — three
  words made the output just quote the source verbatim too often (not enough
  new combinations to choose from); pairs struck the best balance between
  "sounds coherent" and "actually generates something new."
