#include <stdlib.h>
#include <stdio.h>
#include "stack.h"


////////////////////////////////////////////////////////////////////////////////
/// Push to the top of the stack
void Push(Stack* stack, int value) {
  stack->count++;
  Node* old_head = stack->head;
  stack->head = malloc(sizeof(Node));
  stack->head->value = value;
  stack->head->next = old_head;
}

////////////////////////////////////////////////////////////////////////////////
/// Push to the top of the stack with logging
void PushLog(Stack* stack, int value) {
  stack->count++;
  Node* old_head = stack->head;
  stack->head = malloc(sizeof(Node));
  stack->head->value = value;
  stack->head->next = old_head;
  printf("Push node %d: value = %d\n", stack->count, stack->head->value);
}

////////////////////////////////////////////////////////////////////////////////
/// Pop the top of the stack
int Pop(Stack* stack) {
  Node* old_head = stack->head;
  stack->head = stack->head->next;
  int value = old_head->value;
  free(old_head);
  stack->count--;
  return value;
}

////////////////////////////////////////////////////////////////////////////////
/// Pop the top of the stack with logging
int PopLog(Stack* stack) {
  Node* old_head = stack->head;
  stack->head = stack->head->next;
  int value = old_head->value;
  free(old_head);
  printf("Pop node %d: value = %d\n", stack->count, value);
  stack->count--;
  return value;
}

////////////////////////////////////////////////////////////////////////////////
/// Pop the top of the stack without logging
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

////////////////////////////////////////////////////////////////////////////////
/// Clear the stack without logging
void Clear(Stack* stack) {
  puts("Clearing stack");
  for (Node* n = stack->head; n != nullptr; n = stack->head) {
    PopQuiet(stack);
  }
}

////////////////////////////////////////////////////////////////////////////////
/// Clear the stack with logging
void ClearLog(Stack* stack) {
  puts("Clearing stack");
  for (Node* n = stack->head; n != nullptr; n = stack->head) {
    PopLog(stack);
  }
}

////////////////////////////////////////////////////////////////////////////////
/// Print the Stack
void Print(Stack* stack) {
  int iter = 0;
  for (Node* n = stack->head; n != nullptr; n = n->next) {
    printf("Node %d: value = %d\n", iter, n->value);
    iter++;
    if (iter > stack->count) break;
  }
}
