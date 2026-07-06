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
for i in range(len(words) - 2):
    current_pair = (words[i], words[i + 1])
    next_word = words[i + 2]
    if current_pair not in lookup:
        lookup[current_pair] = []
    lookup[current_pair].append(next_word)

start = random.randint(0, len(words) - 3)
current_pair = (words[start], words[start + 1])
sentence = [current_pair[0], current_pair[1]]

for i in range(50):
    if current_pair not in lookup:
        break
    next_word = random.choice(lookup[current_pair])
    sentence.append(next_word)
    current_pair = (current_pair[1], next_word)

#print(len(words))
#print(words[:25])
#print(lookup[])
sentence[0] = sentence[0][0].upper() + sentence[0][1:]
output = " ".join(sentence) + "."
print(output)