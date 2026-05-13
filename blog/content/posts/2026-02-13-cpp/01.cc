#include <cassert>
#include <cstdio>
#include <cstring>

template <typename T> class DynamicArray {
public:
  DynamicArray() {
    buffer = new T[capacity];
  }

  T get(int i) {
    assert(i >= 0 && i < _size);
    return buffer[i];
  }

  void set(int i, T t) {
    assert(i >= 0 && i < _size);
    buffer[i] = t;
  }

  void add(T t) {
    if (_size == capacity) {
      capacity *= 2;
      T *oldBuffer = buffer;
      buffer = new T[capacity];
      memcpy(buffer, oldBuffer, _size * sizeof(T));
      delete[] oldBuffer;
    }

    buffer[_size] = t;
    _size += 1;
  }

  int size() { return _size; }

private:
  int _size = 0;
  int capacity = 4;
  T *buffer;
};

int main() {
  auto arr = DynamicArray<int>();
  int x = 20;
  for (int i = 0; i < x; i++) {
    arr.add(i);
  }
  for (int i = 0; i < x; i++) {
    printf("%2d = %2d\n", i, arr.get(i));
  }
}
