```c
for (int i = 0; i < 10; i++) {
    printf("%d\n", i);
}
```

```c
void printTenTimes(int i) {
    if (i < 10) {
        printf("%d\n", i);
        printTenTimes(i + 1);
    }
}

int main() {
    printTenTimes(0);
}
```
