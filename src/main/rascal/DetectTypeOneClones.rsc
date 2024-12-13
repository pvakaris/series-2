module DetectTypeOneClones

import List;
import Set;
import String;
import DateTime;
import lang::java::m3::Core;
import lang::java::m3::AST;
import util::Math;

import utils::Helpers;
import utils::MapHelpers;
import utils::Calculator;
import utils::Logger;

import metrics::Volume;

import ast::AstHelpers;
import ast::AstAlgorithm;

import Constants;

str condenceStr(str input){
    //remove whitespaces
    input = replaceAll(input, " ", "");

    while(findFirst(input, "/*") != -1){
        int pos1 = findFirst(input, "/*");
        int pos2 = findFirst(input, "*/");
        if(pos2 == -1){
            input = substring(input, 0, pos1);
        }
        else{
            str rem = substring(input, pos1, pos2 + 2);
            input = replaceAll(input, rem, "");
        }
    }

    if(findFirst(input, "//") != -1){
        int pos = findFirst(input, "//");
        input = substring(input, 0, pos);
    }

    if(findFirst(input, "*/") != -1){
        int pos = findFirst(input, "*/");
        input = substring(input, pos+2);
    }

    return input;
}

test bool testCondenceStr1() {return condenceStr("a+b;") == "a+b;";}
test bool testCondenceStr2() {return condenceStr("     a+b;") == "a+b;";}
test bool testCondenceStr3() {return condenceStr("a+b;     ") == "a+b;";}
test bool testCondenceStr4() {return condenceStr(" a + b ; ") == "a+b;";}
test bool testCondenceStr5() {return condenceStr("     a   +    b    ;    ") == "a+b;";}
test bool testCondenceStr6() {return condenceStr("  a + b  ;   ") == "a+b;";}
test bool testCondenceStr7() {return condenceStr("//just some comment") == "";}
test bool testCondenceStr8() {return condenceStr("//// many dash comment") == "";}
test bool testCondenceStr9() {return condenceStr("/*start of comment") == "";}
test bool testCondenceStr10() {return condenceStr("end of comment*/") == "";}
test bool testCondenceStr11() {return condenceStr("a+b;//some comment") == "a+b;";}
test bool testCondenceStr12() {return condenceStr("a+b;/*ntougun*/") == "a+b;";}
test bool testCondenceStr13() {return condenceStr("a+b;/*ntougun") == "a+b;";}
test bool testCondenceStr14() {return condenceStr("/*ntougun*/a+b;") == "a+b;";}
test bool testCondenceStr15() {return condenceStr("a/*ntougun*/+b;") == "a+b;";}
test bool testCondenceStr16() {return condenceStr("a/*ntougun*/ + b;") == "a+b;";}
test bool testCondenceStr17() {return condenceStr("a    /*ntougun*/    +    b;       ") == "a+b;";}
test bool testCondenceStr18() {return condenceStr("end of comment*/a+b;") == "a+b;";}
test bool testCondenceStr19() {return condenceStr("a + b ; /*start of comment") == "a+b;";}

str stand(Declaration class){
    return "placeholder";
}