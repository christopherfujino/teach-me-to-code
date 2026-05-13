---
draft: true
---

```lua
(function()
  x = 23
  y = 19
  print("The answer is " .. x + y)
end)()

print("The following will not work...")

(function()
  x = 23
  y = 19
  print("The answer is " .. x + y)
end)()
```
