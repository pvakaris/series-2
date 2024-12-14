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
    //log(input);
    //remove whitespaces
    input = replaceAll(input, " ", "");
    input = replaceAll(input, "\r", "");
    input = replaceAll(input, "\n", "");
    
    //remove comments
    while(findFirst(input, "/*") != -1){
        int posSt = findFirst(input, "/*");
        list[int] aPosEn = findAll(input, "*/");
        int posEn = -1;
        for(pos <- aPosEn){
            if(pos > posSt + 1){
                posEn = pos;
                break;
            }
        }
        if(posEn == -1){
            input = substring(input, 0, posSt);
        }
        else{
            str rem = substring(input, posSt, posEn + 2);
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
test bool testCondenceStr20() {return condenceStr("a + b ; /*") == "a+b;";}
test bool testCondenceStr21() {return condenceStr("a/*/*nested comment*/+b;") == "a+b;";}
test bool testCondenceStr22() {return condenceStr("*/d=f+g;/*com*/a=g+h;/*com") == "d=f+g;a=g+h;";}
test bool testCondenceStr23() {return condenceStr("                        \" */ FROM /* -- comment */\" + TABLE_NAME + \" -- my comment /* \n\r\" +") == "FROM\"+TABLE_NAME+\"--mycomment";}
test bool testCondenceStr24() {return condenceStr("*/") == "";}

data reprClass = reprClass(int h1, int h2, list[str]);

reprClass classStandardRepr(Declaration class){
    list[str] raw = classStr(class);
    list[str] processed = [];
    for(s <- raw){
        if(!isEmpty(condenceStr(s)))
            processed += condenceStr(s);
    }

    int h1 = size(processed);
    int h2 = 0;
    for(s <- processed){
        h2 += size(s);
    }

    return reprClass(h1, h2, processed);
}

int compStdRepr(reprClass repr1, reprClass repr2){
    if(reprClass(h1_1, h1_2, aStr1) := repr1 && reprClass(h2_1, h2_2, aStr2) := repr2){
        if(h1_1 < h2_1)
            return -1;
        if(h1_1 > h2_1)
            return 1;
        if(h1_2 < h2_2)
            return -1;
        if(h1_2 > h2_2)
            return 1;

        int i = 0;
        while(i < size(aStr1)){
            if(elementAt(aStr1, i) < elementAt(aStr2, i))
                return -1;
            if(elementAt(aStr1, i) > elementAt(aStr2, i))
                return -1;
            i += 1;
        }
        return 0;
    }
    return -2;
}

bool lessThen(tuple[reprClass, loc] m1, tuple[reprClass, loc] m2){
    if(<r1, _> := m1 && <r2, _> := m2){
        return compStdRepr(r1, r2) == -1;
    }
    return false;
}

list[list[loc]] classifyType1(loc project){
    list[tuple[reprClass, loc]] aClass = [];
    visit(getASTs(project)){
        case c:\class(_, _, _, _, _, _): {
            aClass += <classStandardRepr(c), c.src>;
        }
        case c:\class(_): {
            aClass += <classStandardRepr(c), c.src>;
        }
    }

    list[tuple[reprClass, loc]] aClassSorted = [];
    while(size(aClass) > 0){
        int ind = 0;
        int i = 0;
        while(i < size(aClass)){
            if(lessThen(elementAt(aClass, i), elementAt(aClass, ind)))
                ind = i;
            i+=1;
        }
        aClassSorted += elementAt(aClass, ind);
        aClass = remove(aClass, ind);
    }

    for(t <- aClass){
        if(<_, l>:=t)
        log(l);
    }

    list[list[loc]] ans = [];
    int i = 0;
    list[loc] curClass = [];
    while(i < (size(aClassSorted) - 1)){
        if(<r1, l> := elementAt(aClassSorted, i) && <r2, _> := elementAt(aClassSorted, i+1)){
            curClass += l;
            if(compStdRepr(r1, r2) != 0){
                if(size(curClass) > 1){
                    ans += [curClass];
                }
            curClass = [];
            }
        }
        i+=1;
    }
    return ans;
}