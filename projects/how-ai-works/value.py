import math

class Value:
    def __init__(self, data, _children=()):
        self.data = data
        self.grad = 0
        self._prev = set(_children)
        self._backward = lambda: None

    def __repr__(self):
        return f"Value(data={self.data})"

    def __add__(self, other):
        other = other if isinstance(other, Value) else Value(other)
        out = Value(self.data + other.data, (self, other))
        def _backward():
            self.grad += out.grad
            other.grad += out.grad
        out._backward = _backward
        return out

    def __mul__(self, other):
        other = other if isinstance(other, Value) else Value(other)
        out = Value(self.data * other.data, (self, other))
        def _backward():
            self.grad += other.data * out.grad
            other.grad += self.data * out.grad
        out._backward = _backward
        return out

    def __pow__(self, power):
        out = Value(self.data ** power, (self,))
        def _backward():
            self.grad += power * (self.data ** (power - 1)) * out.grad
        out._backward = _backward
        return out

    def __neg__(self):
        return self * -1

    def __sub__(self, other):
        return self + (-other)

    def tanh(self):
        t = math.tanh(self.data)
        out = Value(t, (self,))
        def _backward():
            self.grad += (1 - t**2) * out.grad
        out._backward = _backward
        return out

    def backward(self):
        topo = []
        visited = set()
        def build_topo(v):
            if v not in visited:
                visited.add(v)
                for child in v._prev:
                    build_topo(child)
                topo.append(v)
        build_topo(self)

        self.grad = 1.0
        for v in reversed(topo):
            v._backward()

a = Value(3)
b = Value(4)
d = a * b + a
d.backward()
print(a.grad, b.grad)

import random

w1a = Value(random.uniform(-1,1)); w1b = Value(random.uniform(-1,1)); b1 = Value(random.uniform(-1,1))
w2a = Value(random.uniform(-1,1)); w2b = Value(random.uniform(-1,1)); b2 = Value(random.uniform(-1,1))
w3a = Value(random.uniform(-1,1)); w3b = Value(random.uniform(-1,1)); b3 = Value(random.uniform(-1,1))
v1 = Value(random.uniform(-1,1)); v2 = Value(random.uniform(-1,1)); v3 = Value(random.uniform(-1,1)); c = Value(random.uniform(-1,1))

training_data = [(0,0,0), (0,1,1), (1,0,1), (1,1,0)]
parameters = [w1a,w1b,b1, w2a,w2b,b2, w3a,w3b,b3, v1,v2,v3,c]
learning_rate = 0.1

for epoch in range(3000):
    total_loss = Value(0.0)
    for x1, x2, target in training_data:
        h1 = (w1a*x1 + w1b*x2 + b1).tanh()
        h2 = (w2a*x1 + w2b*x2 + b2).tanh()
        h3 = (w3a*x1 + w3b*x2 + b3).tanh()
        output = v1*h1 + v2*h2 + v3*h3 + c
        loss = (output - target)**2
        total_loss = total_loss + loss

    for p in parameters:
        p.grad = 0
    total_loss.backward()
    for p in parameters:
        p.data -= learning_rate * p.grad

    if epoch % 300 == 0:
        print(epoch, total_loss.data)

print()
for x1, x2, target in training_data:
    h1 = (w1a*x1 + w1b*x2 + b1).tanh()
    h2 = (w2a*x1 + w2b*x2 + b2).tanh()
    h3 = (w3a*x1 + w3b*x2 + b3).tanh()
    output = v1*h1 + v2*h2 + v3*h3 + c
    print(x1, x2, "-> predicted:", round(output.data, 3), "actual:", target)