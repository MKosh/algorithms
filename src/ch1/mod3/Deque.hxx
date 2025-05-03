#pragma once

#include "int_types.hxx"
#include <iostream>
#include <optional>

using std::size_t;

template<typename T>
class Deque {
private:
  struct Node {
    T data{};
    Node* next = nullptr;
  };
  size_t m_length;
  Node* m_first = nullptr;
  Node* m_last = nullptr;

public:
  auto size() -> size_t { return m_length; }
  auto isEmpty() -> bool { return m_length == 0; }

  auto prepend(T data) -> void {
    Node* new_node = new Node;
    new_node->data = data;
    new_node->next = m_first;
    m_first = new_node;
    m_length++;
    if (m_last == nullptr) m_last = m_first;
  }

  auto append(T data) -> void {
    Node* new_node = new Node;
    new_node->data = data;
    new_node->next = nullptr;
    m_last->next = new_node;
    m_last = new_node;
    m_length++;
    if (m_first == nullptr) m_first = m_last;
  }

  auto printStack() -> void {
    int i = 0;
    for (Node* current = m_first; current != nullptr; current = current->next) {
      std::cout << "Node " << i << ": " << current->data << "\n";
      i++;
    }
    std::cout << "\n";
  }

  auto printLinks() -> void {
    for (Node* current = m_first; current != nullptr; current = current->next) {
      std::cout << current->data << " -> ";
    }
    std::cout << "null\n\n";
  }

  auto popFirst() -> std::optional<T> {
    if (m_first == nullptr) return {};
    T temp = m_first->data;
    Node* old_first = m_first;
    m_first = old_first->next;
    delete old_first;
    m_length--;
    return temp;
  }

  ~Deque() {
    std::cout << "Destroying deque\n";
    for (Node* current = m_first; current != nullptr;) {
      Node* temp = current;
      current = current->next;
      delete temp;
    }
  }
};
