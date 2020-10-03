---
title: Teaching C To A JavaScript Developer
tags: JavaScript C
date: 2016-07-21 17:52:14
layout: post
---


According to Douglas Crockford, [JavaScript is the world's most misunderstood programming language](http://www.crockford.com/javascript/javascript.html), and I am inclined to agree. Especially in the '90s, I think a lot of programmers first encountered JavaScript from a C/C++ or Java background (indeed, JavaScript-inventor Brendan Eich has said that he was tasked with creating Java's little brother to run in the browser). I was one of them. We found the syntax very familiar. In fact, after reading a tutorial or two, I was able to write a slot machine game. JavaScript is such a flexible language that it is possible to write all kinds of applications in it without really understanding how the language works.

This has led to books such as those in the [You Don't Know JS](https://github.com/getify/You-Dont-Know-JS) series. This has also led me to ask myself the question: is JavaScript a good first language for a programmer to learn? Certainly it would be easy to do some cool things with the language, but what about when the time comes to learn about [variable hoisting](http://www.w3schools.com/js/js_hoisting.asp)? And I only recently learned that JavaScript always passes by value, [even if that value happens to be a reference(?!)](http://stackoverflow.com/questions/518000/is-javascript-a-pass-by-reference-or-pass-by-value-language).

Basically, there are a lot of educational materials out there for those from C-family or Java backgrounds to learn JavaScript, but I thought I would write this post as sort of the transitive, demonstrating the relative simplicity of C. It's been many years on and I'm still trying to learn JavaScript, but I feel like it would be relatively easy to teach a programmer familiar with the complexities of JavaScript the straightforward and literal C language.

### Variable Types

Maybe the biggest difference between C and JavaScript is that C has statically-typed variables while JavaScript has dynamic, untyped variables. In C, variables must be defined before they are used as belonging to a fixed type, and must remain that type for the duration of their life.

```C
int i = 1;
float pi = 3.14159
char c = 'C'; // this is a character variable, it can only hold a single character
char string[13] = "Hello, world!";  // this is a string, or an array of characters
int array[5] = { 1, 2, 3, 4, 5 }; // this is an array
```

Variables don't have to be initialized when they're declared, but they have to be declared with a keyword corresponding to their type. Some important distinctions between JavaScript:

1. Integers and floats are separate types. There are other number types, such as `unsigned int` for unsigned integers, or `long int` for 32-bit integers, but for most cases integers and floats are sufficient.
2. Arrays are not really a built-in data type as they are in JavaScript, but a collection of like-typed variables. You can create an array of any type. Arrays must be initialized with a size when it's declared, and cannot be resized.
3. Characters are their own type, and are essentially the same as an 8-bit integer. "Strings" in C are simply arrays of characters.
4. Single quotes are used to denote single characters in C, while double quotes are used for strings.
5. Since C isn't object-oriented, these data types have no properties or methods. Arrays have no `.length` property, and numbers have no `.toString()` methods. There are, however, libraries for manipulating these data types.

### Variable Scope

In C, variables are block-scoped. Global variables can be declared explicitly by declaring them outside of any function. C has no variable hoisting, and C variables cannot be used without declaring them.

``` C
int i = 1;

int main() {
  int i = 2;

  if (1) {
    int i = 3;
    printf("%i\n", i);  // will print out "3", the local block value
  }

  func(); // will print out "1", global value
  return 0;
}

void func() {
  printf("%i\n", i);
}
```

This is similar to the ES6 `let` operator's behavior, though `let` still hoists the declaration to the top of the block.

### Pointers

Probably the most feared part of the C language is pointers. They're really not that awful, though.

A normal variable in C contains a value, which is stored in some address in memory. A pointer in C contains an address in memory, which contains (maybe) some value. Pointers are declared by adding an `*` before the variable's name. Uninitialized pointers are dangerous because we don't know what they're pointing at. Regular pointers can return their address through the use of the `&` operator. By default, pointers return the address they contain, but they can return the value of the address they point to by prefacing them again by the `*` operator. For example:

```C
int x = 5;
int *pointer = &x;

printf("%i", pointer);  // this will return a memory address, not sure what it will be
printf("%i", *pointer); // this will turn 5, where pointer points to
```

Printing a memory address to standard output is not very helpful. However, using pointers is helpful in passing larger data structures like arrays to a function. In fact, under the hood, this is similar to how JavaScript passes objects to functions. Pointers can also be used to change the value of a variable within an external function. Without pointers, variables are passed to functions by value. For example:

```C
int main (void) {
  int x = 5;
  int pointer = &x;

  func(pointer);  // here the address is passed to the function
  printf("%i\n", *pointer); // value is now 3
}

void func(int *x) {
  *x = 3;
}
```

As noted earlier, arrays are not really a built-in type in C. Actually, array notation is just a shorthand for a pointer which accesses adjacent locations in memory. For instance if you create a string of 8 characters, those characters will all be stored next to each other in memory. It's important to note, also, that the name of an array (or string) by itself will refer to the address of its first element. Thus a pointer can be assigned to an array like so: `pointer = array;`. This pointer will now point to the address of the first element. A neat trick is that since the memory locations in an array are adjacent, the increment operator `++` will increment through the elements of the array. For example:

```C
char string[] = "Hello, world!";
char *pointer = string; // pointer assigned to address of string
while(*pointer) { // while our pointer still points to a valid character
  printf("%c", *pointer); // print out the contents the pointer points to
  pointer++;  // point to the next location in memory
}
```

This code will print out characters of the string one by one. The while-loop works because in C, strings are terminated with a `null` character.

### Memory Allocation

In JavaScript, memory management is automated. When you make an array bigger in JavaScript, the additional memory is allocated for you. When variables are no longer referenced, they are garbage collected for you.

In C, you have to handle this yourself. Let's say you have a program that creates an array of `x` integers, where `x` is a count read from the user. We cannot initialize the array in our code, because we do not know what size to make it before runtime. The `malloc` function, specified by the `malloc.h` header file, will allocate memory of a specified size from the heap, and return an address to it. For example:

```C
int main(void) {
  int size = 0; // this will be the size of our string
  char *initial;  // this will point to the beginning of our string

  printf("How big of a string would you like? ");
  scanf("%i", &size); // read an integer from input, and store in size
  initial = (char *)malloc(size); // allocate a string of "size" length
  char *increment = initial;  // this pointer will move through the string
  for (int i=0; i<size; i++) {
    *increment = '!'; // fill the string with exclamation points
    increment++;
  }
  printf("%s\n", initial);  // print out the string

  return 0;
}
```

This can potentially lead to memory leaks, if your application continues to allocate for itself more and more memory. It is up to the programmer to keep track of this memory that has been allocated, and then free it when it is no longer used. This is done with the `free()` function, which takes a pointer to the allocated chunk as its argument. E.g.

```C
myFunc(char *string, int size) {
  char *pointer = (char *)malloc(size);
  strcpy(pointer, string);
  printf("%s", pointer);
  free(pointer);
}
```

This isn't a particularly useful example, but it shows code that would be a potential memory leak if not for the use of `free(pointer)` at the end. Otherwise, each time the function was called, the application would use more memory, while the pointer to it would be lost.

### Conclusion

So what have we learned? Well, for one, it's pretty clear to me that JavaScript uses pointers a lot, it just abstracts the programmer away from those details. I can see how JavaScript not only uses them to arrays/objects to and from functions, but even for the implementation of the objects themselves.

It's also very clear to me that programming in JavaScript is like getting a job done with your big brother holding your hand; a big brother who steps in and manages certain difficult tasks for you, so that you can focus on the big picture. On the other hand, coding in C is flying solo, without anyone checking on what you do, or helping you to manage everything going on. Which explains why a lot of C programmers (myself included) mocked JavaScript at first. It seemed like a kid's toy. And yet, in retrospect, it's clear that higher-level languages like JavaScript are more suited to large, complex projects. Also, memory limits and processor speed are less of a concern these days, so most applications today don't **NEED** to be written in C.

The classic example of the limitations of C is the buffer overrun. Because arrays in C basically use a pointer to look at consecutive addresses in memory, there is no built-in bounds checking. If you look beyond the end of the array, the pointer simply points further in memory than it should, and can read/write to someplace potentially dangerous. See:

```C
void getPin() {
  char pin[5];  // since every string ends with NULL, we make this 5 elements big
  printf("Enter your 4-digit pin: ");
  scanf("%s", pin);
  // process the pin
}
```

With this code, we are passing `scanf()` the location of the first element in the `pin` string we have created, but it doesn't know how big it is. If the user types in a string longer than 4 characters long, scanf will continue writing the contents past the end of the `pin` string. At best, this will cause unpredictable results, at worst this could lead to a malicious user injecting malicious code into the application. We never have to worry about this with JavaScript strings.
