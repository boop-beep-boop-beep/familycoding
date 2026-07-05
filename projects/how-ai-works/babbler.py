import random

with open("babbler.txt", "r", encoding="utf-8") as f:
    text = f.read()
text = text.replace("–", " ")
words = text.split()
punctuation = ".,!?;:\"“”…"
cleaned_words = []
for word in words:
    cleaned_words.append(word.strip(punctuation))
words = cleaned_words
lookup = {}
for i in range(len(words) - 1):
    current_word = words[i]
    next_word = words[i + 1]
    if current_word not in lookup:
        lookup[current_word] = []
    lookup[current_word].append(next_word)
    current_word = random.choice(words)
sentence = [current_word]

for i in range(20):
    if current_word not in lookup:
        break
    next_word = random.choice(lookup[current_word])
    sentence.append(next_word)
    current_word = next_word

#print(len(words))
#print(words[:25])
#print(lookup[])
print(" ".join(sentence))