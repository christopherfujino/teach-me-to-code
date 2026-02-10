I feel like I have finally wrapped my mind around the C++ programming language:
it is an incredibly sophisticated C code generator.

I know that modern compilers are not literally generating C code; however, the
runtime model of C++ code is (as far as I know) very similar to that of C. Most
features of C++ fall into the category of "you could do that in C, but it would
be very tedious, repetitive, and error-prone."

The most obvious feature that lines up with my "sophisticated code generator"
conceit would be templating: it is literally generating valid C++ code from the
templates, albeit as part of the compilation process and probably directly into
some abstract format (apparently there is [a clang++ flag to print it](https://stackoverflow.com/questions/4448094/can-we-see-the-templates-instantiated-by-the-c-compiler)).
The only reason I even mention templates is because many other important
features of C++ build upon it (e.g. smart pointers, STL containers, iterators).

But let's now look at probably the core distinguishing (from its ancestor C)
feature of C++, classes:

```c++
class Buffer {
public:
    uint8_t *bytes;
};

int main() {
    printf("Hello, world!\n");
}
```
