#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const int MAX_WIDTH = 80;
const int INITIAL_BUFFER_SIZE = 120;

typedef struct {
  char *buffer;
  int size;
  size_t capacity;
} Buffer;

Buffer *create_buffer(const char *initial);
void free_buffer(Buffer *buffer);

void append_to_buffer(Buffer *buffer, char ch);
Buffer *process_line(Buffer *buffer);

bool is_whitespace(char c);

int main(int argc, char **argv) {
  if (argc != 2) {
    fprintf(stderr, "Usage: formatter markdown_file");
    exit(1);
  }
  const char *target_path = argv[1];

  FILE *target = fopen(target_path, "r");

  int current = fgetc(target);
  Buffer *buffer = create_buffer("");
  while (current != EOF) {
    if (current == '\n') {
      buffer = process_line(buffer);
    } else {
      append_to_buffer(buffer, current);
    }

    current = fgetc(target);
  }
  if (buffer->size > 0) {
    Buffer *empty_buffer = process_line(buffer);
    free_buffer(empty_buffer);
  }

  return 0;
}

bool is_whitespace(char c) {
  return c == ' ' || c == '\t' || c == '\n' || c == '\r';
}

Buffer *create_buffer(const char *initial) {
  size_t initial_len = strlen(initial);
  Buffer *ptr = malloc(sizeof(Buffer));

  if (ptr == NULL) {
    fprintf(stderr, "Out of memory\n");
    abort();
  }

  ptr->buffer = malloc(INITIAL_BUFFER_SIZE);

  if (ptr->buffer == NULL) {
    fprintf(stderr, "Out of memory\n");
    abort();
  }
  memcpy(ptr->buffer, initial, initial_len);

  ptr->capacity = INITIAL_BUFFER_SIZE;
  ptr->size = initial_len;

  return ptr;
}

void append_to_buffer(Buffer *buffer, char ch) {
  if (buffer->size == buffer->capacity) {
    // grow buffer->buffer
    size_t new_cap = buffer->capacity * 2;
    char *old_buffer = buffer->buffer;
    buffer->buffer = malloc(new_cap);
    if (buffer->buffer == NULL) {
      fprintf(stderr, "Out of memory\n");
      exit(1);
    }
    memcpy(buffer->buffer, old_buffer, buffer->capacity);

    free(old_buffer);
    buffer->capacity = new_cap;
  }
  buffer->buffer[buffer->size] = ch;
  buffer->size += 1;
}

void free_buffer(Buffer *buffer) {
  free(buffer->buffer);
  free(buffer);
}

Buffer *process_line(Buffer *buffer) {
  int overflow = buffer->size - MAX_WIDTH;
  if (overflow <= 0) {
    // https://stackoverflow.com/questions/256218/the-simplest-way-of-printing-a-portion-of-a-char-in-c
    printf("%.*s\n", buffer->size, buffer->buffer);
    free_buffer(buffer);
    return create_buffer("");
  } else {
    // In case the best place to break is *after* MAX_WIDTH
    int best_end_ptr = -1;
    // Because arrays are zero-indexed
    int end_ptr = buffer->size - 1;
    while (true) {
      if (is_whitespace(buffer->buffer[end_ptr])) {
        if (end_ptr <= (MAX_WIDTH - 1)) {
          // found the optimal line ending
          printf("%.*s\n", end_ptr + 1, buffer->buffer);
          size_t new_str_size = buffer->size - (end_ptr + 1) + 1;
          // + 1 for trailing null
          char *new_str = (char *)malloc(new_str_size);
          memcpy(new_str, buffer->buffer + end_ptr + 1, new_str_size - 1);
          new_str[new_str_size - 1] = '\0';
          free_buffer(buffer);
          Buffer *new_buffer = create_buffer(new_str);
          free(new_str);
          return new_buffer;
        } else {
          best_end_ptr = end_ptr;
        }
      }
      end_ptr -= 1;
      if (end_ptr == 0) {
        fprintf(stderr, "TODO 1\n");
        abort();
      }
    }
  }
}
