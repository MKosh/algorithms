#include "stackList.hxx"
#include <iostream>

int main() {
  std::cout << "hello \n";
  Stack<int> stack;
  stack.push(1);
  stack.push(2);
  stack.print();
  std::cout << "pop: " << stack.pop() << "\n\n";
  stack.print();
}
