module DetectCloneMetrics

import List;
import Set;
import String;
import DateTime;
import Location;
import lang::java::m3::Core;
import lang::java::m3::AST;

import utils::Helpers;
import utils::Calculator;
import utils::Logger;

import metrics::Volume;

// class metrics
data metric = metric(int i1, int i2, int i3, int i4);

bool compareMetrics(metric m1, metric m2){
    if(metric(m1n1, m1n2, m1n3, m1n4) := m1 && metric(m2n1, m2n2, m2n3, m2n4) := m2)
        return m1n1 == m2n1 && m1n2 == m2n2 && m1n3 == m2n3 && m1n4 == m2n4;
    else
        return false;
}

metric sumMetrics(metric m1, metric m2){
    if(metric(m1n1, m1n2, m1n3, m1n4) := m1 && metric(m2n1, m2n2, m2n3, m2n4) := m2)
        return metric(m1n1 + m2n1, m1n2 + m2n2, m1n3 + m2n3, m1n4 + m2n4);
    else
        return metric(-1, -1, -1, -1);
}

bool bigMetric(metric m){
    if(metric(_, _, nDecl, nSt) := m)
        return (nSt+nDecl)>10;
    else
        return false;
}

metric calcClass(Declaration inp){
    list[str] aFuncCalled = [];
    list[loc] aDecl = [];
    list[loc] aEx = [];
    int nDecl = 0;
    int nStEx = 0;
    if(\class(_, _, _, _, _, list[Declaration] body) := inp || \class(list[Declaration] body) := inp)
    {
        visit(body){
            case \methodCall(_, name, _): {
                if(\id(st) := name)
                    aFuncCalled += st;
            }
            case \methodCall(_, _, name, _):{
                if(\id(st) := name)
                    aFuncCalled += st;
            }
            case \superMethodCall(_, name, _):{
                if(\id(st) := name)
                    aFuncCalled += st;
            }
            case \superMethodCall(_, _, name, _):{
                if(\id(st) := name)
                    aFuncCalled += st;
            }
            //DECLARATION
            case inst:\enum(_, _, _, _, _): aDecl += inst.src;
            case inst:\enumConstant(_, _, _, _): aDecl += inst.src;
            case inst:\enumConstant(_, _, _): aDecl += inst.src;
            case inst:\field(_, _, _): aDecl += inst.src;
            case inst:\method(_, _, _, _, _, _, _): aDecl += inst.src;
            case inst:\method(_, _, _, _, _, _): aDecl += inst.src;
            case inst:\constructor(_, _, _, _, _): aDecl += inst.src;
            case inst:\variables(_, _, _): aDecl += inst.src;
            //case inst:\variable(_, _): aDecl += inst.src;
            //case inst:\variable(_, _, _): aDecl += inst.src;
            //case inst:\typeParameter(_, _): aDecl += inst.src;
            case inst:\parameter(_, _, _, _): aDecl += inst.src;
            // EXPRESSION
            case inst:\newArray(_, _, _): aEx += inst.src;
            case inst:\newArray(_, _): aEx += inst.src;
            case inst:\assignment(_, _, _): aEx += inst.src;
            case inst:\cast(_, _): aEx += inst.src;
            case inst:\newObject(_, _, _, _, _): aEx += inst.src;
            case inst:\newObject(_, _, _, _): aEx += inst.src;
            case inst:\newObject(_, _, _): aEx += inst.src;
            case inst:\postIncrement(_): aEx += inst.src;
            case inst:\postDecrement(_): aEx += inst.src;
            case inst:\preIncrement(_): aEx += inst.src;
            case inst:\preDecrement(_): aEx += inst.src;
            case inst:\prePlus(_): aEx += inst.src;
            case inst:\preMinus(_): aEx += inst.src;
            case inst:\preComplement(_): aEx += inst.src;
            case inst:\lambda(_, _): aDecl += inst.src;
            // Statement
            case inst:\assert(_): aEx += inst.src;
            case inst:\assert(_, _): aEx += inst.src;
            case inst:\break(): aEx += inst.src;
            case inst:\break(_): aEx += inst.src;
            case inst:\continue(): aEx += inst.src;
            case inst:\continue(_): aEx += inst.src;
            case inst:\do(_, _): aEx += inst.src;
            case inst:\return(_): {aEx += inst.src;}
            case inst:\return(): aEx += inst.src;
            case inst:\synchronizedStatement(_, _): aEx += inst.src;
            case inst:\throw(_): aEx += inst.src;
            case inst:\try(_, _): aEx += inst.src;
            case inst:\try(_, _, _): aEx += inst.src;
            case inst:\catch(_, _): aEx += inst.src;
            case inst:\expressionStatement(_): aEx += inst.src;
        }
    }
    list[str] aFuncUn = [];
    for(l <- aFuncCalled)
    {
        bool bAdd = true;
        for(l2 <- aFuncUn)
        {
            if(l == l2)
                bAdd = false;
        }
        if(bAdd) aFuncUn+=l;
    }
    /*
    log("Class:");
    log(inp.src);
    log("Metrics:");
    log(size(aFuncCalled));
    log(size(aFuncUn));
    log(size(aDecl));
    log(size(aEx));
    log("Decl:");
    for(l <- aDecl) log(l);
    log("Ex:");
    for(l <- aEx) log(l);
    */
    return metric(size(aFuncCalled), size(aFuncUn), size(aDecl), size(aEx));
}

rel[loc, loc] analyze(loc project, bool bBigOnly){
    list[tuple[metric, loc]] aPair = [];
    visit(getASTs(project)){
        case c:\class(_, _, _, _, _, _): {
            if(!bBigOnly || bigMetric(calcClass(c)))
                aPair += <calcClass(c), c.src>;
        }
        case c:\class(_):{
            if(!bBigOnly || bigMetric(calcClass(c)))
                aPair += <calcClass(c), c.src>;
        }
    }

    rel[loc, loc] ans = {};
    for(p1 <- aPair){
        for(p2 <- aPair){
            if(<m1, l1>:=p1 && <m2, l2>:=p2 && isLexicallyLess(l1, l2)){
                if(compareMetrics(m1,m2))
                    ans += <l1,l2>;
            }
        }
    }
    return ans;
}