def decorator(func):
    return func

def name():
    print("hello world")

name = decorator(name)
print(name)