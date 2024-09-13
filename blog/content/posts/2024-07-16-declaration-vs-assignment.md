---
title: Declaration vs. Assignment
date: 2024-07-16 00:00:00
---

```python
def func():
  if False:
    x = 1
  print(x) # UnboundLocalError: local variable 'x' referenced before assignment

func()
```

In this example, even though the declaration `x = 1` appears before we try to
print the expression `x`, we hit a `NameError` because the particular path
through the code that we took never hit that branch, `x` was never declared
and thus our error.

Before we continue with our examples, if you are asking "why would anyone
write that code?" then that is a fair question, it is silly code. It is an
over-simplification to make the features of language more obvious. A more
real-world example of the same concept would be:

```python
def makeRequest(request):
  try:
    response = makeNetworkCall(request)
  except:
    logger("The network call failed!")
  # UnboundLocalError: local variable 'response' referenced before assignment
  logger(response)
```

If `makeNetworkCall` could possibly throw, we may or may not have ever
assigned a value to the local variable `response`.

Now, returning to our simpler example (although the solution is the same),
how do we fix our code so that we never hit this error? There are several
methods, but the simplest would be to ensure that `x` is *always* assigned
(that is, there is no possible branch that will avoid it being assigned)
before we try to access its value:

```python
def func():
  x = None
  if False:
    x = 1
  print(x) # None

func()
```

Now what happens if I decide to more eagerly initialize `x`--in fact, at the
beginning of my program?

```python
x = None

def func():
  if False:
    x = 1
  print(x) # UnboundLocalError: local variable 'x' referenced before assignment

func()
```

Why do we get our `UnboundLocalError` again? We have certainly initialized `x`
before attempting to reference it. Well, notice the error message claims that
`x` is a local variable. Because Python does not have an explicit variable
declaration keyword (such as `var`), it could be ambiguous whether the
statement `x = 1` is a *declaration* of a new variable `x` that is initialized
to the value `1`, or if it is the *re-assignment* of the global variable `x`
that we declared at the beginning of our program. Thus, by default, these
statements within a function declare a new variable that *shadows* the previous
one from the greater scope.

As an example:

```python
x = 0
def func():
    x = 1

print(x) # 0
func()
print(x) # 0
```

Within the function `func()`, the name `x` is a local variable, and thus it
does not change the global variable `x`. If we do *not* want to shadow the
previous variable with our own local, we must use the keyword `global` to
explicitly tell the Python runtime that--within the current function--the name
that we provide should refer to the variable already existing in the outer
scope:

```python
x = 0
def func():
    global x
    x = 1

print(x) # 0
func()
print(x) # 1
```

