<TeXmacs|2.1.1>

<style|<tuple|generic|chinese>>

<\body>
  <section|Introduction>

  <subsection|Discriptions>

  You are given an expression including: operators(<math|+,-,\<times\>,\<div\>>),
  \ basic symbols(bracket and comma), and numbers. Calculate it.

  <subsection|Background of the Algorithms>

  Algorithms: Shunting yard algorithm.

  Containers: string, vector in STL.

  Other <cpp|C++> Features: class, cpp style IO.

  <section|Algorithm Specifications>

  <subsection|Translate the Expression into Suffix Expression>

  First, we should translate the given expression into suffix expression,
  which is easy to compute.

  Define a stack of functions, and read the symbols one by one.

  1. if we meet a number, push it to output.

  2. if we meet an operator, keep poping the top operator, if the top is
  left-binded and its priority is bigger than current operator; <strong|or
  the top is right-binded and its priority is smaller than current operator>,
  we pop the top and push it into output. Finally, push current operator into
  stack.

  4. if we meet a left bracket, push it to the stack.

  5. if we meet a right bracket, \ pop the top of the stack until meeting a
  left bracket, and pop the left bracket.

  Finally, we pop the rest of the elements in the stack to output.

  <subsection|Build the Expression Tree and Calculate>

  Now we have a suffix expression, it is easy for us to build the expression
  tree.\ 

  Define a stack of argument, then check each symbol one by one, each time we
  meet a variable or number, put it into top of the stack.\ 

  Each time we meet a function, take one or two arguments from the stack, and
  push the result expression into the stack.

  <section|Testing Result>

  Let us show some of the test cases here. We will show the test purpose in
  comments.

  <subsection|sample input>

  <\cpp>
    10

    1.43+2.323+3.2//simple pure-number expression

    3*(-2.5)//negative number

    1+2*3+4.4/3*5.2//test the priority

    (1+2)*3-4/(3*5)//test the bracket

    (2+(4/5))/(3*2)//multi bracket

    ((3+2)//wrong bracket

    (2+3))//wrong bracket

    3/0+5// divide by 0

    1++++1//to many operator

    +3+4//wrong arguments

    \;
  </cpp>

  <subsection|sample output>

  <\cpp-code>
    Test Case #1

    6.953

    Test Case #2

    7.5

    Test Case #3

    10.5455

    Test Case #4

    -5.25

    Test Case #5

    1.84615

    Test Case #6

    Invalid Expression

    Test Case #7

    Invalid Expression

    Test Case #8

    Invalid Expression

    Test Case #9

    Invalid Expression

    Test Case #10

    Invalid Expression

    \;

    \;
  </cpp-code>

  <section|Analysis and Comments>

  <subsection|Time : <math|O<around*|(|n<rsup|>|)>> >

  Here <em|n> means the length of the input.

  The shunting yard algorithm's time complexity is <math|O<around*|(|n|)>>.
  We read each symbol once, and each symbol is push into and pop out of the
  stack once.

  <subsection|Space: <math|O<around*|(|n<rsup|2>|)>>>

  The space complexity is same as the expression tree, which is same as the
  length of the result, which is <math|O<around*|(|n|)>>, similarly.

  <section|Source Code (in cpp)>

  <subsection|expression_evaluator.h>

  <\cpp-code>
    #include\<less\>bits/stdc++.h\<gtr\>

    //standard functions we need

    //cpp style I/O

    const double eps=1e-9;

    using std::cerr;

    using std::cin;//input

    using std::cout;//output

    using std::endl;//'\\n'

    //stl containers

    using std::vector;//array with dynamic space

    using std::map;//A standard container made up of (key,value) pairs

    using std::stack;//A standard container giving FILO behavior.

    using std::string;//A string of @c char

    //random function

    std::mt19937 rnd;

    //hash for unsigned long long

    using ull = unsigned long long;

    <next-line>

    //the Symbol in input expression

    struct Sym{

    <nbsp> <nbsp> string x;// the symbol itself

    <nbsp> <nbsp> string type;//type: number,variable,function.

    };

    //Operators and its priority.

    const map\<less\>string,int\<gtr\>mp={

    <nbsp> <nbsp> {"(",-1},{"+",0},{"-",0},{"*",1},{"/",1},{"^",2},

    };

    //Numbers of function's arguments.

    const map\<less\>string,int\<gtr\>args_cnt={

    <nbsp> <nbsp> {"+",2},{"-",2},{"*",2},{"/",2},{"^",2}};

    <next-line>

    //this functions transform the input expression into a suffix expression.

    //parameters:the input string\ 

    //return:the suffix expression, as a vector which contains type Sym.

    vector\<less\>Sym\<gtr\> trans_Expr(string &s){

    <nbsp> <nbsp> for(auto i=s.begin();i!=s.end();i++){

    <nbsp> <nbsp> <nbsp> <nbsp> if(i==s.begin()){

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> if(*i=='-'){

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> s="0"+s;

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> }

    <nbsp> <nbsp> <nbsp> <nbsp> }

    <nbsp> <nbsp> <nbsp> <nbsp> else{

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> if(*i=='-'&&*prev(i)=='('){

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp>
    s=s.substr(0,i-s.begin())+"0"+s.substr(i-s.begin(),s.end()-s.begin());

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> }

    <nbsp> <nbsp> <nbsp> <nbsp> }

    <nbsp> <nbsp> }

    <nbsp> <nbsp> vector\<less\>Sym\<gtr\>suf;

    <nbsp> <nbsp> auto p=s.begin();

    <nbsp> <nbsp> stack\<less\>string\<gtr\>op;//the stack of functions

    <nbsp> <nbsp> while(p!=s.end()){

    <nbsp> <nbsp> <nbsp> <nbsp> string res="";

    <nbsp> <nbsp> <nbsp> <nbsp> if(*p\<less\>='9'&&*p\<gtr\>='0'){//if next
    symbol is a number:

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp>
    while(p!=s.end()&&((*p\<less\>='9'&&*p\<gtr\>='0')\|\|*p=='.'))res+=*p,++p;
    <nbsp>\ 

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> suf.push_back({res,"number"});

    <nbsp> <nbsp> <nbsp> <nbsp> }

    <nbsp> <nbsp> <nbsp> <nbsp> else if(*p=='('){//if next symbol is a left
    bracket:

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> res+=*p;++p;

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> op.push(res);

    <nbsp> <nbsp> <nbsp> <nbsp> }

    <nbsp> <nbsp> <nbsp> <nbsp> else if(*p==')'){//if next symbol is a right
    bracket:

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> res+=*p;++p;

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp>
    while(!op.empty()&&op.top().back()!='('){

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp>
    suf.push_back({op.top(),"func"});

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> op.pop();

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> }

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> if(op.empty()){//check bracket

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp>
    cout\<less\>\<less\>"Invalid Expression"\<less\>\<less\>endl;

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> return
    vector\<less\>Sym\<gtr\>();

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> }

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> op.pop();

    <nbsp> <nbsp> <nbsp> <nbsp> }

    <nbsp> <nbsp> <nbsp> <nbsp> else if(mp.find((string)""+*p)!=mp.end()){//if
    next symbol is +-*/^

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> res+=*p;++p;

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> while(!op.empty()&&

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp>
    (mp.find(op.top())-\<gtr\>second\<gtr\>=mp.find(res)-\<gtr\>second)==(op.top()!="^")){

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp>
    suf.push_back({op.top(),"func"});

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> op.pop();

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> }

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> op.push(res);

    <nbsp> <nbsp> <nbsp> <nbsp> }

    <nbsp> <nbsp> }

    <nbsp> <nbsp> while(!op.empty()){

    <nbsp> <nbsp> <nbsp> <nbsp> suf.push_back({op.top(),"func"});

    <nbsp> <nbsp> <nbsp> <nbsp> op.pop();

    <nbsp> <nbsp> }

    <nbsp> <nbsp> return suf;

    }

    <next-line>

    //this function builds the expression tree and calculate at the same
    time.

    //parameter: the input string of the expression

    //return: ans

    double calculate(string &a){

    <nbsp> <nbsp> vector\<less\>Sym\<gtr\>suf=trans_Expr(a);

    <nbsp> <nbsp> if(suf.size()==0)return 1e9;

    <nbsp> <nbsp> vector\<less\>double\<gtr\>args;

    <nbsp> <nbsp> for(auto v:suf){

    <nbsp> <nbsp> <nbsp> <nbsp> if(v.type=="number"){//Add numbers and
    variables to the stack of parameters

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp>
    args.push_back(std::stof(v.x));//the function stoi(string) translate a
    string to an double.

    <nbsp> <nbsp> <nbsp> <nbsp> }

    <nbsp> <nbsp> <nbsp> <nbsp> else{//the functions with two parameters.

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> if(args.size()\<less\>2){

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp>
    cout\<less\>\<less\>"Invalid Expression"\<less\>\<less\>endl;

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> return 1e9;

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> }

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> double
    a=args.back();args.pop_back();

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> double
    b=args.back();args.pop_back();

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> if(v.x=="+"){

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp>
    args.push_back(a+b);

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> }

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> else if(v.x=="-"){

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp>
    args.push_back(a-b);

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> }

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> else if(v.x=="*"){

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp>
    args.push_back(a*b);

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> }

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> else if(v.x=="/"){

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp>
    if(a\<less\>eps){//check /0

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp>
    cout\<less\>\<less\>"Invalid Expression"\<less\>\<less\>endl;

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp>
    return 1e9;

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> }

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp>
    args.push_back(a/b);//translate / into *

    <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> <nbsp> }

    <nbsp> <nbsp> <nbsp> <nbsp> }

    <nbsp> <nbsp> }

    <nbsp> <nbsp> return args.back();

    }

    <nbsp> <nbsp> string type;//type: number,variable,function.
  </cpp-code>

  \;
</body>

<\initial>
  <\collection>
    <associate|page-medium|paper>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|3|..\\..\\..\\AppData\\Roaming\\TeXmacs\\texts\\scratch\\no_name_1.tm>>
    <associate|auto-10|<tuple|4|5|..\\..\\..\\AppData\\Roaming\\TeXmacs\\texts\\scratch\\no_name_1.tm>>
    <associate|auto-11|<tuple|4.1|5|..\\..\\..\\AppData\\Roaming\\TeXmacs\\texts\\scratch\\no_name_1.tm>>
    <associate|auto-12|<tuple|4.2|5|..\\..\\..\\AppData\\Roaming\\TeXmacs\\texts\\scratch\\no_name_1.tm>>
    <associate|auto-13|<tuple|5|5|..\\..\\..\\AppData\\Roaming\\TeXmacs\\texts\\scratch\\no_name_1.tm>>
    <associate|auto-14|<tuple|5.1|6|..\\..\\..\\AppData\\Roaming\\TeXmacs\\texts\\scratch\\no_name_1.tm>>
    <associate|auto-15|<tuple|6|6|..\\..\\..\\AppData\\Roaming\\TeXmacs\\texts\\scratch\\no_name_1.tm>>
    <associate|auto-16|<tuple|6|6|..\\..\\..\\AppData\\Roaming\\TeXmacs\\texts\\scratch\\no_name_1.tm>>
    <associate|auto-17|<tuple|5.2|6|..\\..\\..\\AppData\\Roaming\\TeXmacs\\texts\\scratch\\no_name_1.tm>>
    <associate|auto-18|<tuple|6|6|..\\..\\..\\AppData\\Roaming\\TeXmacs\\texts\\scratch\\no_name_1.tm>>
    <associate|auto-19|<tuple|5.1|7|..\\..\\..\\AppData\\Roaming\\TeXmacs\\texts\\scratch\\no_name_1.tm>>
    <associate|auto-2|<tuple|1.1|3|..\\..\\..\\AppData\\Roaming\\TeXmacs\\texts\\scratch\\no_name_1.tm>>
    <associate|auto-20|<tuple|5.2|7|..\\..\\..\\AppData\\Roaming\\TeXmacs\\texts\\scratch\\no_name_1.tm>>
    <associate|auto-21|<tuple|6|8|..\\..\\..\\AppData\\Roaming\\TeXmacs\\texts\\scratch\\no_name_1.tm>>
    <associate|auto-22|<tuple|5.2|8|..\\..\\..\\AppData\\Roaming\\TeXmacs\\texts\\scratch\\no_name_1.tm>>
    <associate|auto-23|<tuple|6|8|..\\..\\..\\AppData\\Roaming\\TeXmacs\\texts\\scratch\\no_name_1.tm>>
    <associate|auto-24|<tuple|6|20|..\\..\\..\\AppData\\Roaming\\TeXmacs\\texts\\scratch\\no_name_1.tm>>
    <associate|auto-25|<tuple|6|22|..\\..\\..\\AppData\\Roaming\\TeXmacs\\texts\\scratch\\no_name_1.tm>>
    <associate|auto-3|<tuple|1.2|3|..\\..\\..\\AppData\\Roaming\\TeXmacs\\texts\\scratch\\no_name_1.tm>>
    <associate|auto-4|<tuple|2|3|..\\..\\..\\AppData\\Roaming\\TeXmacs\\texts\\scratch\\no_name_1.tm>>
    <associate|auto-5|<tuple|2.1|3|..\\..\\..\\AppData\\Roaming\\TeXmacs\\texts\\scratch\\no_name_1.tm>>
    <associate|auto-6|<tuple|2.2|3|..\\..\\..\\AppData\\Roaming\\TeXmacs\\texts\\scratch\\no_name_1.tm>>
    <associate|auto-7|<tuple|3|4|..\\..\\..\\AppData\\Roaming\\TeXmacs\\texts\\scratch\\no_name_1.tm>>
    <associate|auto-8|<tuple|3.1|5|..\\..\\..\\AppData\\Roaming\\TeXmacs\\texts\\scratch\\no_name_1.tm>>
    <associate|auto-9|<tuple|3.2|5|..\\..\\..\\AppData\\Roaming\\TeXmacs\\texts\\scratch\\no_name_1.tm>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Introduction>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <with|par-left|<quote|1tab>|1.1<space|2spc>Discriptions
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2>>

      <with|par-left|<quote|1tab>|1.2<space|2spc>Background of the Algorithms
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>Algorithm
      Specifications> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-4><vspace|0.5fn>

      <with|par-left|<quote|1tab>|2.1<space|2spc>Translate the Expression
      into Suffix Expression <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5>>

      <with|par-left|<quote|1tab>|2.2<space|2spc>Build the Expression Tree
      with Abstarct Data Structure <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-6>>

      <with|par-left|<quote|1tab>|2.3<space|2spc>Take Derivatives
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-7>>

      <with|par-left|<quote|1tab>|2.4<space|2spc>Simplify the Expression
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-8>>

      <with|par-left|<quote|2tab>|2.4.1<space|2spc>A Tree Hash Method
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-9>>

      <with|par-left|<quote|2tab>|2.4.2<space|2spc>Improvement on addition
      and multiplication <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-10>>

      <with|par-left|<quote|1tab>|2.5<space|2spc>Write Your Own Containers!
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-11>>

      <with|par-left|<quote|2tab>|2.5.1<space|2spc>string
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-12>>

      <with|par-left|<quote|2tab>|2.5.2<space|2spc>vector
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-13>>

      <with|par-left|<quote|2tab>|2.5.3<space|2spc>stack
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-14>>

      <with|par-left|<quote|2tab>|2.5.4<space|2spc>map/set/multiset
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-15>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|3<space|2spc>Test
      Result> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-16><vspace|0.5fn>

      <with|par-left|<quote|1tab>|3.1<space|2spc>sample input
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-17>>

      <with|par-left|<quote|1tab>|3.2<space|2spc>sample output
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-18>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|4<space|2spc>Analysis
      and Comments> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-19><vspace|0.5fn>

      <with|par-left|<quote|1tab>|4.1<space|2spc>Time :
      <with|mode|<quote|math>|O<around*|(|n<rsup|2>m logn|)>> (worst)/
      <with|mode|<quote|math>|O<around*|(|n m logn|)><around*|(|best|)>>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-20>>

      <with|par-left|<quote|1tab>|4.2<space|2spc>Space:
      <with|mode|<quote|math>|O<around*|(|n<rsup|2>|)>>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-21>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|5<space|2spc>Source
      Code (in cpp)> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-22><vspace|0.5fn>

      <with|par-left|<quote|1tab>|5.1<space|2spc>main.cpp
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-23>>

      <with|par-left|<quote|1tab>|5.2<space|2spc>gen.cpp
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-24>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|6<space|2spc>Declaration>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-25><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>