#include<bits/stdc++.h>
using namespace std;
void heapSort(std::vector<int>& vec) {
    std::make_heap(vec.begin(), vec.end());
    for (size_t i = vec.size() - 1; i > 0; --i) {
        std::pop_heap(vec.begin(), vec.begin() + i + 1);
    }
}