#include<bits/stdc++.h>
//standard functions we need
//cpp style I/O
const double eps=1e-9;
using std::cerr;
using std::cin;//input
using std::cout;//output
using std::endl;//'\n'
//stl containers
using std::vector;//array with dynamic space
using std::map;//A standard container made up of (key,value) pairs
using std::stack;//A standard container giving FILO behavior.
using std::string;//A string of @c char
//random function
std::mt19937 rnd;
//hash for unsigned long long
using ull = unsigned long long;

//the Symbol in input expression
struct Sym{
    string x;// the symbol itself
    string type;//type: number,variable,function.
};
//Operators and its priority.
const map<string,int>mp={
    {"(",-1},{"+",0},{"-",0},{"*",1},{"/",1},{"^",2},
};
//Numbers of function's arguments.
const map<string,int>args_cnt={
    {"+",2},{"-",2},{"*",2},{"/",2},{"^",2},{"ln",1},{"exp",1},{"pow",2},{"log",2},{"sin",1},{"cos",1},{"tan",1},
};

//this functions transform the input expression into a suffix expression.
//parameters:the input string 
//return:the suffix expression, as a vector which contains type Sym.
vector<Sym> trans_Expr(string &s){
    for(auto i=s.begin();i!=s.end();i++){
        if(i==s.begin()){
            if(*i=='-'){
                s="0"+s;
            }
        }
        else{
            if(*i=='-'&&*prev(i)=='('){
                s=s.substr(0,i-s.begin())+"0"+s.substr(i-s.begin(),s.end()-s.begin());
            }
        }
    }
    vector<Sym>suf;
    auto p=s.begin();
    stack<string>op;//the stack of functions
    while(p!=s.end()){
        string res="";
        if(*p<='9'&&*p>='0'){//if next symbol is a number:
            while(p!=s.end()&&((*p<='9'&&*p>='0')||*p=='.'))res+=*p,++p;   
            suf.push_back({res,"number"});
        }
        else if(*p=='('){//if next symbol is a left bracket:
            res+=*p;++p;
            op.push(res);
        }
        else if(*p==')'){//if next symbol is a right bracket:
            res+=*p;++p;
            while(!op.empty()&&op.top().back()!='('){
                suf.push_back({op.top(),"func"});
                op.pop();
            }
            if(op.empty()){//check bracket
                cout<<"Invalid Expression"<<endl;
                return vector<Sym>();
            }
            op.pop();
        }
        else if(mp.find((string)""+*p)!=mp.end()){//if next symbol is +-*/^
            res+=*p;++p;
            while(!op.empty()&&
            (mp.find(op.top())->second>=mp.find(res)->second)==(op.top()!="^")){
                suf.push_back({op.top(),"func"});
                op.pop();
            }
            op.push(res);
        }
    }
    while(!op.empty()){
        suf.push_back({op.top(),"func"});
        op.pop();
    }
    return suf;
}

//this function builds the expression tree and calculate at the same time.
//parameter: the input string of the expression
//return: ans
double calculate(string &a){
    vector<Sym>suf=trans_Expr(a);
    if(suf.size()==0)return 1e9;
    vector<double>args;
    for(auto v:suf){
        if(v.type=="number"){//Add numbers and variables to the stack of parameters
            args.push_back(std::stof(v.x));//the function stoi(string) translate a string to an double.
        }
        else{//the functions with two parameters.
            if(args.size()<2){
                cout<<"Invalid Expression"<<endl;
                return 1e9;
            }
            double a=args.back();args.pop_back();
            double b=args.back();args.pop_back();
            
            if(v.x=="+"){
                args.push_back(a+b);
            }
            else if(v.x=="-"){
                args.push_back(b-a);
            }
            else if(v.x=="*"){
                args.push_back(a*b);
            }
            else if(v.x=="/"){
                if(fabs(a)<eps){//check /0
                    cout<<"Invalid Expression"<<endl;
                    return 1e9;
                }
                args.push_back(b/a);//translate / into *
            }
        }
    }
    return args.back();
}