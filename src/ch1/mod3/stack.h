#pragma once

typedef struct Node Node;
typedef struct Stack Stack;

struct Node {
  int value;
  Node* next;
};

struct Stack {
  int count;
  Node* head;
};

void Push(Stack* stack, int value);

void PushLog(Stack* stack, int value);

int Pop(Stack* stack);

int PopLog(Stack* stack);

void PopQuiet(Stack* stack);

void Clear(Stack* stack);

void ClearLog(Stack* stack);

void Print(Stack* stack);
