CC = clang
RELEASE_BIN = md_formatter

.PHONY: debug
debug: a.out
	lldb --batch --one-line r --one-line-on-crash bt --file a.out demo.md

.PHONY: build
build: main.c Makefile
	$(CC) main.c -o $(RELEASE_BIN)

a.out: main.c Makefile
	$(CC) main.c -O0 -g -fno-omit-frame-pointer -o a.out

.PHONY: memcheck
memcheck: a.out
	valgrind --leak-check=yes ./a.out demo.md
