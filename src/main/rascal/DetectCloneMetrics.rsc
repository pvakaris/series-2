module DetectCloneMetrics

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

// class metrics
data metric = metric(int i1, int i2, real i3, int i4, int i5);
metric deltaCloneType3 = metric(5, 2, 2.0, 2, 5);
metric zeroMetric = metric(0, 0, 0.0, 0, 0);

bool compareMetrics(metric m1, metric m2, metric delta){
    if(metric(m1n1, m1n2, m1n3, m1n4, m1n5) := m1 && 
       metric(m2n1, m2n2, m2n3, m2n4, m2n5) := m2 && 
       metric(d1, d2, d3, d4, d5) := delta)
        return (abs(m1n1 - m2n1) <= d1 &&
                abs(m1n2 - m2n2) <= d2 &&
                abs(m1n3 - m2n3) <= d3 &&
                abs(m1n4 - m2n4) <= d4 &&
                abs(m1n5 - m2n5) <= d5);
    else
        return false;
}

metric sumMetrics(metric m1, metric m2){
    if(metric(m1n1, m1n2, m1n3, m1n4, m1n5) := m1 && metric(m2n1, m2n2, m2n3, m2n4, m2n5) := m2)
        return metric(m1n1 + m2n1, m1n2 + m2n2, m1n3 + m2n3, m1n4 + m2n4, m1n5 + m2n5);
    else
        return metric(-1, -1, -1.0, -1, -1);
}

int decisionComplexity(Expression expr)
{
    int comp = 0;
    visit(expr){
        case \less(_, _): comp+=1;
        case \greater(_, _): comp+=1;
        case \lessEquals(_, _): comp+=1;
        case \greaterEquals(_, _): comp+=1;
        case \equals(_, _): comp+=1;
        case \notEquals(_, _): comp+=1;
        case \xor(_, _): comp+=1;
        case \or(_, _): comp+=1;
        case \and(_, _): comp+=1;
        case \conditionalOr(_, _): comp+=1;
        case \conditionalAnd(_, _): comp+=1;
        case \preNot(_): comp+=1;
    }
    return comp;
}

metric calcClass(Declaration inp){
    if(\class(_, _, _, _, _, list[Declaration] body) := inp || \class(list[Declaration] body) := inp){
        list[str] aFuncCalled = [];
        list[loc] aDecl = [];
        list[loc] aEx = [];
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

        // decisions
        list[Expression] aDecision = [];
        visit(body){
            case \do(_, expr): aDecision += expr;
            case \foreach(_, expr, _): aDecision += expr;
            case \for(_, expr, _, _): aDecision += expr;
            case \if(expr, _): aDecision += expr;
            case \if(expr, _, _): aDecision += expr;
            case \switch(expr, _): aDecision += expr;
            case \while(expr, _): aDecision += expr;
        }

        list[str] aFuncUn = [];
        for(l <- aFuncCalled){
            bool bAdd = true;
            for(l2 <- aFuncUn){
                if(l == l2)
                    bAdd = false;
            }
            if(bAdd) aFuncUn+=l;
        }

        int totalComplexity = 0;
        for(e <- aDecision) totalComplexity += decisionComplexity(e);
        real averComp = (size(aDecision) == 0) ? 0.0 : (toReal(totalComplexity) / toReal(size(aDecision)));
        return metric(size(aFuncCalled), size(aFuncUn), averComp, size(aDecl), size(aEx));
    }
    return metric(-1, -1, -1.0, -1, -1);
}

// diagnostic tools
void printMetric(loc project, str className){
    visit(getASTs(project)){
        case c:\class(_, \stringLiteral(s, _), _, _, _, _): {
            if(s == className){
                if (metric(n1, n2, n3, n4, n5) := calcClass(c))
                {
                    log(n1);
                    log(n2);
                    log(n3);
                    log(n4);
                    log(n5);
                }
            }
        }
    }
}

list[list[loc]] classifyMetrics(loc project){
    rel[metric, list[loc]] aClass = {};
    visit(getASTs(project)){
        case c:\class(_, _, _, _, _, _): {
            metric met = calcClass(c);
            bool bAdd = true;
            for(elem <- aClass){
                if(<m, l> := elem && compareMetrics(met, m, zeroMetric)){
                    bAdd = false;
                    l += c.src;
                    aClass -= elem;
                    aClass += <m, l>;
                    break;
                }
            }
            if(bAdd) aClass += <met, [c.src]>;
        }
        case c:\class(_):{
            metric met = calcClass(c);
            bool bAdd = true;
            for(elem <- aClass){
                if(<m, l> := elem && compareMetrics(met, m, zeroMetric)){
                    bAdd = false;
                    l += c.src;
                }
            }
            if(bAdd) aClass += <met, [c.src]>;
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