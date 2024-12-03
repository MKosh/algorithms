#include <stdlib.h>
#include <stdio.h>
#include "stack.h"

int main(int argc, char *argv[])
{
  Stack s = {0, nullptr};
  for (int i = 1; i < 4; ++i) {
    PushLog(&s, i);
  }
  puts("");
  ClearLog(&s);
  return EXIT_SUCCESS;
}
