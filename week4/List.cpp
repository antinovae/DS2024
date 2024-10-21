#include "List.h"
#include <iostream>
#include <list>
using std::cin;
using std::cout;
using std::endl;
using std::list;
template <typename T> void print(T &a) {
  cout << "size: " << a.size() << "  ";
  cout << "elements: ";
  for (auto v : a) {
    cout << v << " ";
  }
  cout << endl;
}

int main() {
  List<int> lst = {1, 2, 3, 4, 5};
  list<int> lst2 = {1, 2, 3, 4, 5};
  cout << "test construct" << endl;
  print(lst);
  print(lst2);
  cout << "test front and back" << endl;
  cout << lst.front() << " " << lst.back() << endl;
  cout << lst2.front() << " " << lst2.back() << endl;
  cout << "test pushback, pushfront, popfront, and popback" << endl;
  lst.push_back(10);
  lst2.push_back(10);
  print(lst);
  print(lst2);
  lst.pop_back();
  lst2.pop_back();
  print(lst);
  print(lst2);
  lst.push_front(0);
  lst2.push_front(0);
  print(lst);
  print(lst2);
  lst.pop_front();
  lst2.pop_front();
  print(lst);
  print(lst2);

  auto it = lst.begin();
  auto it2 = lst2.begin();
  ++it;
  ++it2;
  cout << "test iterator++: " << endl << *it << " " << *it2 << endl;
  --it;
  --it2;
  cout << "test iterator--: " << endl << *it << " " << *it2 << endl;
  cout << "test insert" << endl;
  lst.insert(it, 11);
  lst2.insert(it2, 11);
  print(lst);
  print(lst2);
  ++it;
  ++it2;
  cout << "test erase" << endl;
  it = lst.erase(it);
  it2 = lst2.erase(it2);
  print(lst);
  print(lst2);
  auto it3 = it;
  ++it3;
  ++it3;
  auto it4 = it2;
  ++it4;
  ++it4;
  it = lst.erase(it, it3);
  it2 = lst2.erase(it2, it4);
  print(lst);
  print(lst2);

  cout << "test copy" << endl;
  auto lst3 = lst;
  auto lst4 = lst2;
  auto lst5(lst);
  auto lst6(lst2);
  lst.pop_back();
  lst2.pop_back();
  lst.pop_back();
  lst2.pop_back();
  print(lst);
  print(lst2);
  print(lst3);
  print(lst4);
  print(lst5);
  print(lst6);
  lst.clear();
  lst2.clear();
  cout << "test clear" << endl;
  print(lst);
  print(lst2);
  lst = std::move(lst3);
  lst2 = std::move(lst4);
  cout << "test move" << endl;
  print(lst);
  print(lst2);

  return 0;
}
