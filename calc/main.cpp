#include"expression_evaluator.h"

int main(){
    int T;
    cin>>T;//test cases.
    for(int t=1;t<=T;t++){
        cout<<"Test Case #"<<t<<endl;
        string a;
        cin>>a;
        double ans=calculate(a);
        if(ans!=1e9)cout<<ans<<endl;
    }   
}