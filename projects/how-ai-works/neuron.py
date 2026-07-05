weight = 0.0
learning_rate = 5.0
training_data = [(1, 2), (2, 4), (3, 6), (4, 8)]

for epoch in range(200):
    for x, target in training_data:
        prediction = weight * x
        error = prediction - target
        gradient = error * x
        weight = weight - learning_rate * gradient
    if epoch % 20 == 0:
        print(epoch, weight)

print("Final weight:", weight)
