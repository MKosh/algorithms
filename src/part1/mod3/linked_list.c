#include <stdio.h>
#include <stdlib.h>

typedef struct Node Node;
struct Node {
  int value;
  Node* next;
};

typedef struct Stack Stack;
struct Stack {
  int count;
  Node* head;
};

void Push(Stack* stack, int value) {
  stack->count++;
  Node* old_head = stack->head;
  stack->head = malloc(sizeof(Node));
  stack->head->value = value;
  stack->head->next = old_head;
}

void PushLog(Stack* stack, int value) {
  stack->count++;
  Node* old_head = stack->head;
  stack->head = malloc(sizeof(Node));
  stack->head->value = value;
  stack->head->next = old_head;
  printf("Push node %d: value = %d\n", stack->count, stack->head->value);
}

int Pop(Stack* stack) {
  Node* old_head = stack->head;
  stack->head = stack->head->next;
  int value = old_head->value;
  free(old_head);
  stack->count--;
  return value;
}

int PopLog(Stack* stack) {
  Node* old_head = stack->head;
  stack->head = stack->head->next;
  int value = old_head->value;
  free(old_head);
  printf("Pop node %d: value = %d\n", stack->count, value);
  stack->count--;
  return value;
}

void PopQuiet(Stack* stack) {
  Node* old_head = stack->head;
  if (stack->head != nullptr) {
    stack->head = stack->head->next;
  } else {
    puts("stack->head is nullptr");
  }
  int value = old_head->value;
  free(old_head);
  stack->count--;
}

void Clear(Stack* stack) {
  puts("Clearing stack");
  for (Node* n = stack->head; n != nullptr; n = stack->head) {
    PopQuiet(stack);
  }
}

void ClearLog(Stack* stack) {
  puts("Clearing stack");
  for (Node* n = stack->head; n != nullptr; n = stack->head) {
    PopLog(stack);
  }
}


void Print(Stack* stack) {
  int iter = 0;
  for (Node* n = stack->head; n != nullptr; n = n->next) {
    printf("Node %d: value = %d\n", iter, n->value);
    iter++;
    if (iter > stack->count) break;
  }
}

// Ignore this, just trying to get a memory error to make sure Asan is working...
// it's not btw...
int x[10];

int main(int argc, char *argv[])
{

  // Ignore this, just trying to get a memory error to make sure Asan is working...
  // it's not btw...
  /* x[10] = 5; */

  Stack s = { 0, nullptr };

  for (int i = 0; i < 3; ++i) {
    Push(&s, i);
  }

  Print(&s);

  /* for (Node* n = s.head; n != nullptr; n = s.head) { */
  /*   printf("Pop: %d, n->next: %p\n", Pop(&s), s.head); */
  /* } */
  puts("");
  PopLog(&s);

  puts("");
  for (int i = 3; i < 6; ++i) {
    PushLog(&s, i);
  }

  puts("");
  Print(&s);

  puts("");
  ClearLog(&s);
  Print(&s);

  return EXIT_SUCCESS;
}
