import random
talk = 0
words = input()
greetings = ["Hello","hello","hey","Hey","Hi","hi","greetings","Greetings"]
greetingsNumber = 0

while words != "off":
  if any(sub in words for sub in greetings):
    talk = 1
  if talk == 1:
    print(random.choice(greetings) + " again" * greetingsNumber)
    talk = 0
    greetingsNumber = greetingsNumber + 1
    words = input()