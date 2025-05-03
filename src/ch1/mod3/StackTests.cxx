#include "int_types.hxx"
#include "stackList.hxx"
#include "Deque.hxx"
#include <iostream>
#include <string>

auto main() -> int {
  Deque<i32> deque;
  auto f = deque.popFirst();
  std::cout << "First: " << (f.has_value() ? std::to_string(f.value()) : "Null") << '\n';
  deque.prepend(12);
  deque.prepend(3);
  deque.append(5);
  deque.append(6);
  deque.prepend(1);
  deque.printLinks();
  f = deque.popFirst();
  std::cout << "First: " << (f.has_value() ? std::to_string(f.value()) : "Null") << '\n';
  deque.printLinks();
  return EXIT_SUCCESS;
}
