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

import Constants;

// This function condences string to standard representation.
// This function takes two arguments:
// 1) The string itself
// 2) Boolean flag specifying if the beginning of the string is comment. It can be true for example, for multi-string comment.
// This function returns condenced string and boolean flag for the next string
tuple[str, bool] condenceStr(str input, bool bCom){
    //log(input);
    //remove whitespaces
    input = replaceAll(input, " ", "");
    input = replaceAll(input, "\r", "");
    input = replaceAll(input, "\n", "");

    if(bCom){
        if(findFirst(input, "*/") != -1){
            int pos = findFirst(input, "*/");
            input = substring(input, pos+2);
        }
        else
            return <"", true>;
    }

    if(findFirst(input, "//") != -1){
        int pos = findFirst(input, "//");
        input = substring(input, 0, pos);
    }

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
        if(posEn != -1){
            str rem = substring(input, posSt, posEn + 2);
            input = replaceAll(input, rem, "");
        }
        else
            break;
    }

    if(findFirst(input, "/*") != -1){
        int pos = findFirst(input, "/*");
        input = substring(input, 0, pos);
        return <input, true>;
    }
    else
        return <input, false>;
}

data reprClass = reprClass(int h1, int h2, list[str]);

reprClass classStandardRepr(Declaration class){
    list[str] raw = classStr(class);
    list[str] processed = [];
    bool bCom = false;
    for(s <- raw){
        if(<st, bC> := condenceStr(s, bCom)){
            bCom = bC;
            if(!isEmpty(st))
                processed += st;
        }
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

list[list[loc]] classifyTextual(loc project){
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