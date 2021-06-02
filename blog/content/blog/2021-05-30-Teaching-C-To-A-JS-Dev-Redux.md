---
title: Teaching C to a JavaScript Developer, Redux
date: 2021-05-30 00:00:00
layout: post
---

## Pointers

```c
int i = 1;
int *ptr;
ptr = &i;
*ptr = 2;
printf("i is %i\n", i); // "i is 2"
```

```c
void increment(int *i) {
  *i += 1;
}

int i = 1;
increment(&i);
printf("is is %i\n", i); // "i is 2"
```

## Arrays

```c
int my_favorite_numbers[] = {2, 3, 5, 7};
printf("The second element is %i\n", my_favorite_numbers[1]);
  // "The second element is 3"
printf("The fifth element is %i\n", my_favorite_numbers[4]);
  // Undefined behavior, don't do this!
```

Array names are actually pointers to the first element:

```c
int nums[] = {2, 3, 5, 7};
printf("The first element is %i\n", *nums); // "The first element is 2"

// These two lines are equivalent
printf("The third element is %i\n", *(nums + 2));
printf("The third element is %i\n", nums[2]);

// Undefined behavior, don't do this!
printf("The fifth element is %i\n", *(nums + 4));
```

When doing pointer arithmetic (e.g. `nums + 2`), the compiler knows how big the
underlying data type is (in the above example, `nums` points to `int`s), and
thus knows how to increment past the current element that it is pointing to.
However, it does **not** know the size of the array that was allocated, and thus
it is possible to use pointer arithmetic to point past the end of your allocated
array (in the above example, `nums + 4`). Thus, it is essential when using
arrays to keep track of their size.

## Strings

In C, strings are arrays of characters that are terminated with a null-byte
(`\0`).

NOTE: all code samples tested with clang version 7.0.0.
