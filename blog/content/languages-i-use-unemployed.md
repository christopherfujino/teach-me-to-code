---
draft: true
---

## OCaml

### Pros
- Incredible type inference
  - Feels like the best compromise between the expressiveness of dynamic types
  and the verified correctness of static types when it comes to refactoring
- Sum types + Pattern matching
- Syntax rocks
    - Infix operators are nice/potentially confusing (functional version of
    operator overloading). `|>` is game changing.
- Freedom to do imperative programming or mutation for convenience or
performance
- Expression-oriented
- Tail-call optimization is nice
- First class modules are a great abstraction

### Cons
- Can be ambiguous when an expression ends; I end up wrapping many things in
parens and letting the formatter remove the redundant ones
    - if then
    - pattern matching
- Incredibly confusing type errors
    - because of currying, compiler can't catch sending too few args
    - usually after one type error, the compiler blows up
- Weak STDLIB
- Bad comment syntax
    - They allow nesting, so not as bad as C, but otherwise awful
- No module cycles can be a huge pain
- Incredibly confusing type errors
    - if clauses sometimes need parentheses
    - currying
        - compiler can't catch sending too few args
        - with named params, order of params matters
    - *some* refactors can break the compiler until they're finished
- Tail-call optimization obscures stacktraces
- Namespacing can be confusing; it is easy to accidentally shadow another name
- Macros are pretty magical
- Maintaining interface files can be annoying
- Functors can be awkward (more synctactically heavyweight than interfaces)

## Go

### Pros
- Simplicity
  - Writing algorithms **feels** good
- Goroutines and Channels
- Interfaces
    - Reader/Writers are an incredible abstraction
- Batteries included
    - JSON serialization/deserialization
    - Templating engine
- Named return values
- Panic/Defer
- Fast compilation paired with statically linked binaries feels like the best
compromise between interpreted and compiled language
- Great STDLIB, batteries included SDK

### Cons
- Package/Module setup outside of a monorepo
  - Directory based privacy is annoying compared to file-based
  - Capitalization for privacy is annoying (prefer Dart's)
- No sum types, unions, or enums
  - No exhaustiveness checks
  - Error handling
- Interfaces
- Statement semantics leads to some awkward code:
```go
var exitCode = 0
if didBuild {
  exitCode = 1
}

os.Exit(exitCode)
```

## Ultimate Language

- Statically typed
- Hindley Milner type inference
- Expression-oriented
- Sum types, pattern matching, exhaustiveness checks
- Namespaces, with the ability to import names
    - It's annoying in Go that you ALWAYS need to qualify external names with
    a namespace, although you can at least rename it.
    - ES6 has good flexibility: `import * from "foo.js"` vs. `import {Foo, Bar} from "foo.js"` vs. `import * as Bar from "foo.js"`
    - OCaml's ability to "open" a module in a local scope is cool, and sort of a necessity with infix operators that may be implemented for many types
