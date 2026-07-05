w1 = 0.0
w2 = 0.0
b = 0.0
learning_rate = 0.1
training_data = [
    (0, 0, 0),
    (0, 1, 1),
    (1, 0, 1),
    (1, 1, 0),
]

for epoch in range(1000):
    total_error = 0
    for x1, x2, target in training_data:
        prediction = w1 * x1 + w2 * x2 + b
        error = prediction - target
        total_error += error ** 2
        w1 = w1 - learning_rate * error * x1
        w2 = w2 - learning_rate * error * x2
        b = b - learning_rate * error
    if epoch % 100 == 0:
        print(epoch, total_error)

print("w1:", w1, "w2:", w2, "b:", b)
for x1, x2, target in training_data:
    prediction = w1 * x1 + w2 * x2 + b
    print(x1, x2, "-> predicted:", round(prediction, 3), "actual:", target)