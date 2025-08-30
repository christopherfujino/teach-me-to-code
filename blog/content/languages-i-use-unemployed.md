---
draft: true
---

## OCaml

### Pros
- Incredible type inference
  - Feels like the best compromise between the expressiveness of dynamic types
  and the verified correctness of static types when it comes to refactoring
- Sum types + Pattern matching

### Cons
- Incredibly confusing type errors
    - if clauses sometimes need paranetheses
    - because of currying, compiler can't catch sending too few args
    - usually after one type error, the compiler blows up
- Weak STDLIB
- Worst comment syntax
- Maintaining interface files can be annoying

## Go

### Pros
- Simplicity
  - Writing algorithms **feels** good
- Goroutines and Channels
- Interfaces
  - Reader/Writers are an incredible abstraction
- Named return values
- Panic/Defer
- Fast compilation paired with statically linked binaries feels like the best
compromise between interpreted and compiled language
- Great STDLIB, batteries included SDK

### Cons
- Package/Module setup outside of a monorepo
  - I would prefer file-based privacy, rather than directory
- No sum types, unions, or enums
  - Error handling
- Interfaces
