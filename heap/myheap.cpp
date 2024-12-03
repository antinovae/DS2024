#include<bits/stdc++.h>
using namespace std;
void heapSort(std::vector<int>& vec) {
    std::make_heap(vec.begin(), vec.end());
    for (size_t i = vec.size() - 1; i > 0; --i) {
        std::pop_heap(vec.begin(), vec.begin() + i + 1);
    }
}
mt19937 rnd(0);
int main() {
    int N=1e6;
    vector<int>data;
    for(int i=0;i<N;i++){
        data.push_back(rnd()%(1000000000));
    }
    
    std::vector<int> dataCopy;
    dataCopy = data;  
    auto start = std::chrono::high_resolution_clock::now();
    heapSort(dataCopy);
    auto end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> heapSortDuration = end - start;
/*
    std::cout << "After heapSort: ";
    for (const int& num : dataCopy) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
    */
    std::cout << "heapSort took: " << heapSortDuration.count() << " seconds." << std::endl;

    // sort_heap test
    dataCopy = data; 
    std::make_heap(dataCopy.begin(), dataCopy.end());
    start = std::chrono::high_resolution_clock::now();
    std::sort_heap(dataCopy.begin(), dataCopy.end());
    end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> sortHeapDuration = end - start;
/*
    std::cout << "After sort_heap: ";
    for (const int& num : dataCopy) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
    */
    std::cout << "sort_heap took: " << sortHeapDuration.count() << " seconds." << std::endl;

    return 0;
}
