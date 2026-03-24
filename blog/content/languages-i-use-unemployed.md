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
    - See [tql@c4f3e1263a](http://pea-central.local/git/local/tql/commit/?id=c4f3e1263ade0750640f8bbe88972945a60db4c4)
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

See standalone doc.

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
