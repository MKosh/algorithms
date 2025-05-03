#pragma once

#include<cstdint>
#include<iostream>
#include<optional>

template<typename T>
class Stack {
private:
  struct Node {
    T data;
    // Node* next = nullptr;
    std::optional<Node*> next;
  };

  std::size_t m_length = 0;
  std::optional<Node*> m_first = nullptr;

public:

  auto push(T item) -> void {
    Node* temp = new Node;
    temp->data = item;
    temp->next = m_first.value();
    m_first = temp;
  }

  auto pop() -> T {
    T temp = m_first->data;
    Node* old_first = m_first;
    m_first = old_first->next;
    delete old_first;
    return temp;
  }

  auto length() -> std::size_t {
    return length;
  }

  auto print() -> void {
    for (Node* current = m_first; current != nullptr; current = current->next) {
      std::cout << "Node: " << current->data << "\n";
    }
    std::cout << "\n";
  }
};
