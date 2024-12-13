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

list[str] classStandardRepr(Declaration class){
    list[str] raw = classStr(class);
    list[str] processed = [];
    for(s <- raw){
        if(!isEmpty(condenceStr(s)))
            processed += condenceStr(s);
    }
    return processed;
}

bool compClassWithStdRepr(Declaration class, list[str] repr){
    list[str] repr2 = classStandardRepr(class);
    if(size(repr) == size(repr2)){
        int i = 0;
        while(i < size(repr)){
            if(elementAt(repr, i) != elementAt(repr2, i))
                return false;
            i += 1;
        }
        return true;
    }
    else
        return false;
}

list[list[loc]] classifyType1(loc project){
    rel[list[str], list[loc]] aClass = {};
    visit(getASTs(project)){
        case c:\class(_, _, _, _, _, _): {
            bool bAdd = true;
            for(elem <- aClass){
                if(<r, l> := elem && compClassWithStdRepr(c, r)){
                    bAdd = false;
                    l += c.src;
                    aClass -= elem;
                    aClass += <r, l>;
                    break;
                }
            }
            if(bAdd) aClass += <classStandardRepr(c), [c.src]>;
        }
        case c:\class(_): {
            bool bAdd = true;
            for(elem <- aClass){
                if(<r, l> := elem && compareClassWithStdRepr(c, r)){
                    bAdd = false;
                    l += c.src;
                    aClass -= elem;
                    aClass += <r, l>;
                    break;
                }
            }
            if(bAdd) aClass += <classStandardRepr(c), [c.src]>;
        }
    }

    list[list[loc]] ans = [];
    for(elem <- aClass){
        if(<_, l> := elem){
            ans += [l];
        }
    }
    return ans;
}