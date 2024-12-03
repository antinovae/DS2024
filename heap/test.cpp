#include<bits/stdc++.h>
using namespace std;
mt19937 rnd(0);
#include"HeapSort.h"
void test(vector<int>data){
    std::vector<int> dataCopy;
    dataCopy = data;  
    auto start = std::chrono::high_resolution_clock::now();
    heapSort(dataCopy);
    auto end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> heapSortDuration = end - start;
    std::cout << "heapSort took: " << heapSortDuration.count() << " seconds." << std::endl;

    dataCopy = data; 
    std::make_heap(dataCopy.begin(), dataCopy.end());
    start = std::chrono::high_resolution_clock::now();
    std::sort_heap(dataCopy.begin(), dataCopy.end());
    end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> sortHeapDuration = end - start;

    std::cout << "sort_heap took: " << sortHeapDuration.count() << " seconds." << std::endl;

}
int main(){
    //test random data
    int N=1e6;
    vector<int>data;
    for(int i=0;i<N;i++){
        data.push_back(rnd()%(1000000000));
    }
    cout<<"random test"<<endl;
    test(data);
    data.clear();
    for(int i=0;i<N;i++){
        data.push_back(i);
    }
    
    cout<<"up test"<<endl;
    test(data);
    
    data.clear();
    for(int i=0;i<N;i++){
        data.push_back(N-i);
    }
    cout<<"down test"<<endl;
    test(data);

    for(int i=0;i<N;i++){
        data.push_back(rnd()%(10));
    } 
    cout<<"multi test"<<endl;
    test(data);

}