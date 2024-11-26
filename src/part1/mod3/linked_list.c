#include <stdio.h>
#include <stdlib.h>

typedef struct node node;
struct node {
  int value;
  node* next;
};

int main(int argc, char *argv[])
{
  puts("Hello, world");
  node n1;
  n1.value = 1;
  node n2;
  n2.value = 2;

  n1.next = &n2;
  n2.next = nullptr;

  node n = n1;
  int i = 1;
  while (n.next != nullptr) {
    printf("node: %d, value: %d\n", i, n.value);
    n = *n.next;
    i++;
    if (i > 3) break;
  }
  return EXIT_SUCCESS;
}
