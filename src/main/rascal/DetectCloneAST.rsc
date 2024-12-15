module DetectCloneAst

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

bool compareDecl(Declaration d1, Declaration d2){
    if(\enum(aMod1, _, aType1, aConst1, aBod1):=d1 && \enum(aMod2, _, aType2, aConst2, aBod2):=d2){
        return size(aMod1) == size(aMod2) && size(aType1) == size(aType2) && size(aConst1) == size(aConst2) && size(aBod1) == size(aBod2);
    }
    if(\enumConstant(aMod1, _, aArg1, _):=d1 && \enumConstant(aMod2, _, aArg2, _):=d2){
        return size(aMod1) == size(aMod2) &&  size(aArg1) == size(aArg2);
    }
    if(\enumConstant(aMod1, _, aArg1):=d1 && \enumConstant(aMod2, _, aArg2):=d2){
        return size(aMod1) == size(aMod2) && size(aArg1) == size(aArg2);
    }
    if(\class(aMod1, _, aPar1, aEx1, aImpl1, aBod1):=d1 && \class(aMod2, _, aPar2, aEx2, aImpl2, aBod2):=d2){
        return size(aMod1) == size(aMod2) && size(aPar1) == size(aPar2) && size(aEx1) == size(aEx2) && size(aImpl1) == size(aImpl2) && size(aBod1) == size(aBod2);
    }
    if(\class(aDecl1):=d1 && \class(aDecl2):=d2){
        return size(aDecl1) == size(aDecl2);
    }
    if(\interface(aMod1, _, aPar1, aEx1, aImpl1, aBod1):=d1 && \interface(aMod2, _, aPar2, aEx2, aImpl2, aBod2):=d2){
        return size(aMod1) == size(aMod2) && size(aPar1) == size(aPar2) && size(aEx1) == size(aEx2) && size(aImpl1) == size(aImpl2) && size(aBod1) == size(aBod2);
    }
    if(\field(aMod1, _, aFrag1):=d1 && \field(aMod2, _, aFrag2):=d2){
        return size(aMod1) == size(aMod2) && size(aFrag1) == size(aFrag2);
    }
    if(\initializer(aMod1, _):=d1 && \initializer(aMod2, _):=d2){
        return size(aMod1) == size(aMod2);
    }
    if(\method(aMod1, aPar1, t1, _, aPara1, aExc1, _):=d1 && \method(aMod2, aPar2, t2, _, aPara2, aExc2, _):=d2){
        return size(aMod1) == size(aMod2) && size(aPar1) == size(aPar2) && size(aPara1) == size(aPara2) && size(aExc1) == size(aExc2);
    }
    if(\method(aMod1, aPar1, t1, _, aPara1, aExc1):=d1 && \method(aMod2, aPar2, t2, _, aPara2, aExc2):=d2){
        return size(aMod1) == size(aMod2) && size(aPar1) == size(aPar2) && size(aPara1) == size(aPara2) && size(aExc1) == size(aExc2);
    }
    if(\constructor(aMod1, _, aPar1, aExc1, _):=d1 && \constructor(aMod2, _, aPar2, aExc2, _):=d2){
        return size(aMod1) == size(aMod2) && size(aPar1) == size(aPar2) && size(aExc1) == size(aExc2);
    }
    if(\import(aMod1, _):=d1 && \import(aMod2, _):=d2){
        return size(aMod1) == size(aMod2);
    }
    if(\importOnDemand(aMod1, _):=d1 && \importOnDemand(aMod2, _):=d2){
        return size(aMod1) == size(aMod2);
    }
    if(\package(aMod1, _):=d1 && \package(aMod2, _):=d2){
        return size(aMod1) == size(aMod2);
    }
    if(\variables(aMod1, _, aFrag1):=d1 && \variables(aMod2, _, aFrag2):=d2){
        return size(aMod1) == size(aMod2) && size(aFrag1) == size(aFrag2);
    }
    if(\variable(_, aDim1):=d1 && \variable(_, aDim2):=d2){
        return size(aDim1) == size(aDim2);
    }
    if(\variable(_, aDim1, _):=d1 && \variable(_, aDim2, _):=d2){
        return size(aDim1) == size(aDim2);
    }
    if(\typeParameter(_, aEx1):=d1 && \typeParameter(_, aEx2):=d2){
        return size(aEx1) == size(aEx2);
    }
    if(\annotationType(aMod1, _, aBod1):=d1 && \annotationType(aMod2, _, aBod2):=d2){
        return size(aMod1) == size(aMod2) && size(aBod1) == size(aBod2);
    }
    if(\annotationTypeMember(aMod1, _, _):=d1 && \annotationTypeMember(aMod2, _, _):=d2){
        return size(aMod1) == size(aMod2);
    }
    if(\annotationTypeMember(aMod1, _, _, _):=d1 && \annotationTypeMember(aMod2, _, _, _):=d2){
        return size(aMod1) == size(aMod2);
    }
    if(\parameter(aMod1, _, _, aDim1):=d1 && \parameter(aMod2, _, _, aDim2):=d2){
        return size(aMod1) == size(aMod2) && size(aDim1) == size(aDim2);
    }
    if(\dimension(aAnn1):=d1 && \dimension(aAnn2):=d2){
        return size(aAnn1) == size(aAnn2);
    }
    if(\vararg(aMod1, _, _):=d1 && \vararg(aMod2, _, _):=d2){
        return size(aMod1) == size(aMod2);
    }
    return false;
}

bool compareExpr(Expression e1, Expression e2, bool bType2){
    if(\arrayAccess(_, _):=e1 && \arrayAccess(_, _):=e2){
        return true;
    }
    if(\newArray(t1, arr1, _):=e1 && \newArray(t1_2, arr1_2, _):=e2){
        return size(arr1) == size(arr1_2);
    }
    if(\newArray(t1, arr1):=e1 && \newArray(t1_2, arr1_2):=e2){
        return size(arr1) == size(arr1_2);
    }
    if(\arrayInitializer(arr1):=e1 && \arrayInitializer(arr1_2):=e2){
        return size(arr1) == size(arr1_2);
    }
    if(\assignment(_, name1, _):=e1 && \assignment(_, name1_2, _):=e2){
        return name1 == name1_2;
    }
    if(\cast(t1, _):=e1 && \cast(t1_2, _):=e2){
        return true;
    }
    if(\characterLiteral(name1):=e1 && \characterLiteral(name1_2):=e2){
        return name1 == name1_2;
    }
    if(\newObject(_, t1, arr1, arr2, _):=e1 && \newObject(_, t1_2, arr1_2, arr2_2, _):=e2){
        return size(arr1) == size(arr1_2) && size(arr2) == size(arr2_2);
    }
    if(\newObject(_, t1, arr1, arr2):=e1 && \newObject(_, t1_2, arr1_2, arr2_2):=e2){
        return size(arr1) == size(arr1_2) && size(arr2) == size(arr2_2);
    }
    if(\newObject(t1, arr1, arr2, _):=e1 && \newObject(t1_2, arr1_2, arr2_2, _):=e2){
        return size(arr1) == size(arr1_2) && size(arr2) == size(arr2_2);
    }
    if(\newObject(t1, arr1, arr2):=e1 && \newObject(t1_2, arr1_2, arr2_2):=e2){
        return size(arr1) == size(arr1_2) && size(arr2) == size(arr2_2);
    }
    if(\qualifiedName(arr1):=e1 && \qualifiedName(arr1_2):=e2){
        return size(arr1) == size(arr1_2);
    }
    if(\conditional(_, _, _):=e1 && \conditional(_, _, _):=e2){
        return true;
    }
    if(\fieldAccess(_):=e1 && \fieldAccess(_):=e2){
        return true;
    }
    if(\fieldAccess(_, _):=e1 && \fieldAccess(_, _):=e2){
        return true;
    }
    if(\superFieldAccess(_, _):=e1 && \superFieldAccess(_, _):=e2){
        return true;
    }
    if(\instanceof(_, t1):=e1 && \instanceof(_, t1_2):=e2){
        return true;
    }
    if(\methodCall(arr1, _, arr2):=e1 && \methodCall(arr1_2, _, arr2_2):=e2){
        return size(arr1) == size(arr1_2) && size(arr2) == size(arr2_2);
    }
    if(\methodCall(_, arr1, _, arr2):=e1 && \methodCall(_, arr1_2, _, arr2_2):=e2){
        return size(arr1) == size(arr1_2) && size(arr2) == size(arr2_2);
    }
    if(\superMethodCall(arr1, _, arr2):=e1 && \superMethodCall(arr1_2, _, arr2_2):=e2){
        return size(arr1) == size(arr1_2) && size(arr2) == size(arr2_2);
    }
    if(\superMethodCall(_, arr1, _, arr2):=e1 && \superMethodCall(_, arr1_2, _, arr2_2):=e2){
        return size(arr1) == size(arr1_2) && size(arr2) == size(arr2_2);
    }
    if(\null():=e1 && \null():=e2){
        return true;
    }
    if(\number(s1):=e1 && \number(s1_2):=e2){
        return s1 == s1_2;
    }
    if(\booleanLiteral(s1):=e1 && \booleanLiteral(s1_2):=e2){
        return s1 == s1_2;
    }
    if(\stringLiteral(s1, ss1):=e1 && \stringLiteral(s1_2, ss1_2):=e2){
        return s1 == s1_2 && ss1 == ss1_2;
    }
    if(\textBlock(s1, ss1):=e1 && \textBlock(s1_2, ss1_2):=e2){
        return s1 == s1_2 && ss1 == ss1_2;
    }
    if(\type(t1):=e1 && \type(t1_2):=e2){
        return true;
    }
    if(\bracket(_):=e1 && \bracket(_):=e2){
        return true;
    }
    if(\this():=e1 && \this():=e2){
        return true;
    }
    if(\this(_):=e1 && \this(_):=e2){
        return true;
    }
    if(\super():=e1 && \super():=e2){
        return true;
    }
    if(\declarationExpression(_):=e1 && \declarationExpression(_):=e2){
        return true;
    }
    if(\times(_, _):=e1 && \times(_, _):=e2){
        return true;
    }
    if(\divide(_, _):=e1 && \divide(_, _):=e2){
        return true;
    }
    if(\remainder(_, _):=e1 && \remainder(_, _):=e2){
        return true;
    }
    if(\plus(_, _):=e1 && \plus(_, _):=e2){
        return true;
    }
    if(\minus(_, _):=e1 && \minus(_, _):=e2){
        return true;
    }
    if(\leftShift(_, _):=e1 && \leftShift(_, _):=e2){
        return true;
    }
    if(\rightShift(_, _):=e1 && \rightShift(_, _):=e2){
        return true;
    }
    if(\rightShiftSigned(_, _):=e1 && \rightShiftSigned(_, _):=e2){
        return true;
    }
    if(\less(_, _):=e1 && \less(_, _):=e2){
        return true;
    }
    if(\greater(_, _):=e1 && \greater(_, _):=e2){
        return true;
    }
    if(\lessEquals(_, _):=e1 && \lessEquals(_, _):=e2){
        return true;
    }
    if(\greaterEquals(_, _):=e1 && \greaterEquals(_, _):=e2){
        return true;
    }
    if(\equals(_, _):=e1 && \equals(_, _):=e2){
        return true;
    }
    if(\notEquals(_, _):=e1 && \notEquals(_, _):=e2){
        return true;
    }
    if(\xor(_, _):=e1 && \xor(_, _):=e2){
        return true;
    }
    if(\or(_, _):=e1 && \or(_, _):=e2){
        return true;
    }
    if(\and(_, _):=e1 && \and(_, _):=e2){
        return true;
    }
    if(\conditionalOr(_, _):=e1 && \conditionalOr(_, _):=e2){
        return true;
    }
    if(\conditionalAnd(_, _):=e1 && \conditionalAnd(_, _):=e2){
        return true;
    }
    if(\postIncrement(_):=e1 && \postIncrement(_):=e2){
        return true;
    }
    if(\postDecrement(_):=e1 && \postDecrement(_):=e2){
        return true;
    }
    if(\preIncrement(_):=e1 && \preIncrement(_):=e2){
        return true;
    }
    if(\preDecrement(_):=e1 && \preDecrement(_):=e2){
        return true;
    }
    if(\prePlus(_):=e1 && \prePlus(_):=e2){
        return true;
    }
    if(\preMinus(_):=e1 && \preMinus(_):=e2){
        return true;
    }
    if(\preComplement(_):=e1 && \preComplement(_):=e2){
        return true;
    }
    if(\preNot(_):=e1 && \preNot(_):=e2){
        return true;
    }
    if(\id(name1):=e1 && \id(name1_2):=e2){
        return bType2 ? true : name1 == name1_2;
    }
    if(\switch(_, arr1):=e1 && \switch(_, arr1_2):=e2){
        return size(arr1) == size(arr1_2);
    }
    if(\methodReference(t1, arr1, _):=e1 && \methodReference(t1_2, arr1_2, _):=e2){
        return size(arr1) == size(arr1_2);
    }
    if(\methodReference(_, arr1, _):=e1 && \methodReference(_, arr1_2, _):=e2){
        return size(arr1) == size(arr1_2);
    }
    if(\creationReference(t1, arr1):=e1 && \creationReference(t1_2, arr1_2):=e2){
        return size(arr1) == size(arr1_2);
    }
    if(\superMethodReference(arr1, _):=e1 && \superMethodReference(arr1_2, _):=e2){
        return size(arr1) == size(arr1_2);
    }
    if(\lambda(arr1, _):=e1 && \lambda(arr1_2, _):=e2){
        return size(arr1) == size(arr1_2);
    }
    if(\lambda(arr1, _):=e1 && \lambda(arr1_2, _):=e2){
        return size(arr1) == size(arr1_2);
    }
    if(\memberValuePair(_, _):=e1 && \memberValuePair(_, _):=e2){
        return true;
    }
    return false;
}

bool compareStat(Statement s1, Statement s2){
    if(\assert(_):=s1 && \assert(_):=s2){
        return true;
    }
    if(\assert(_, _):=s1 && \assert(_, _):=s2){
        return true;
    }
    if(\block(aSt1):=s1 && \block(aSt2):=s2){
        return size(aSt1) == size(aSt2);
    }
    if(\break():=s1 && \break():=s2){
        return true;
    }
    if(\break(_):=s1 && \break(_):=s2){
        return true;
    }
    if(\continue():=s1 && \continue():=s2){
        return true;
    }
    if(\continue(_):=s1 && \continue(_):=s2){
        return true;
    }
    if(\do(_, _):=s1 && \do(_, _):=s2){
        return true;
    }
    if(\empty():=s1 && \empty():=s2){
        return true;
    }
    if(\foreach(_, _, _):=s1 && \foreach(_, _, _):=s2){
        return true;
    }
    if(\for(aIn1, _, aUpd1, _):=s1 && \for(aIn2, _, aUpd2, _):=s2){
        return size(aIn1) == size(aIn2) && size(aUpd1) == size(aUpd2);
    }
    if(\for(aIn1, aUpd1, _):=s1 && \for(aIn2, aUpd2, _):=s2){
        return size(aIn1) == size(aIn2) && size(aUpd1) == size(aUpd2);
    }
    if(\if(_, _):=s1 && \if(_, _):=s2){
        return true;
    }
    if(\if(_, _, _):=s1 && \if(_, _, _):=s2){
        return true;
    }
    if(\label(id1, _):=s1 && \label(id2, _):=s2){
        return id1 == id2;
    }
    if(\return(_):=s1 && \return(_):=s2){
        return true;
    }
    if(\return():=s1 && \return():=s2){
        return true;
    }
    if(\switch(_, aSt1):=s1 && \switch(_, aSt2):=s2){
        return size(aSt1) == size(aSt2);
    }
    if(\case(aExp1):=s1 && \case(aExp2):=s2){
        return size(aExp1) == size(aExp2);
    }
    if(\caseRule(aExp1):=s1 && \caseRule(aExp2):=s2){
        return size(aExp1) == size(aExp2);
    }
    if(\defaultCase():=s1 && \defaultCase():=s2){
        return true;
    }
    if(\synchronizedStatement(_, _):=s1 && \synchronizedStatement(_, _):=s2){
        return true;
    }
    if(\throw(_):=s1 && \throw(_):=s2){
        return true;
    }
    if(\try(_, aSt1):=s1 && \try(_, aSt2):=s2){
        return size(aSt1) == size(aSt2);
    }
    if(\try(_, aCat1, _):=s1 && \try(_, aCat2, _):=s2){
        return size(aCat1) == size(aCat2);
    }
    if(\catch(_, _):=s1 && \catch(_, _):=s2){
        return true;
    }
    if(\declarationStatement(_):=s1 && \declarationStatement(_):=s2){
        return true;
    }
    if(\while(_, _):=s1 && \while(_, _):=s2){
        return true;
    }
    if(\expressionStatement(_):=s1 && \expressionStatement(_):=s2){
        return true;
    }
    if(\constructorCall(aT1, aArg1):=s1 && \constructorCall(aT2, aArg2):=s2){
        return size(aT1) == size(aT2) && size(aArg1) == size(aArg2);
    }
    if(\superConstructorCall(_, aT1, aArg1):=s1 && \superConstructorCall(_, aT2, aArg2):=s2){
        return size(aT1) == size(aT2) && size(aArg1) == size(aArg2);
    }
    if(\superConstructorCall(aT1, aArg1):=s1 && \superConstructorCall(aT2, aArg2):=s2){
        return size(aT1) == size(aT2) && size(aArg1) == size(aArg2);
    }
    if(\yield(_):=s1 && \yield(_):=s2){
        return true;
    }
    return false;
}

tuple[list[Declaration], list[Expression], list[Statement]] transformClassToAST(Declaration class){
    list[Declaration] aDecl = [];
    list[Expression] aExpr = [];
    list[Statement] aStat = [];
    visit(class){
        case inst:\enum(_, _, _, _, _): aDecl += inst;
        case inst:\enumConstant(_, _, _, _): aDecl += inst;
        case inst:\enumConstant(_, _, _): aDecl += inst;
        case inst:\class(_, _, _, _, _, _): aDecl += inst;
        case inst:\class(_): aDecl += inst;
        case inst:\interface(_, _, _, _, _, _): aDecl += inst;
        case inst:\field(_, _, _): aDecl += inst;
        case inst:\initializer(_, _): aDecl += inst;
        case inst:\method(_, _, _, _, _, _, _): aDecl += inst;
        case inst:\method(_, _, _, _, _, _): aDecl += inst;
        case inst:\constructor(_, _, _, _, _): aDecl += inst;
        case inst:\import(_, _): aDecl += inst;
        case inst:\importOnDemand(_, _): aDecl += inst;
        case inst:\package(_, _): aDecl += inst;
        case inst:\variables(_, _, _): aDecl += inst;
        case inst:\variable(_, _): aDecl += inst;
        case inst:\variable(_, _, _): aDecl += inst;
        //case inst:\typeParameter(_, _): aDecl += inst;
        case inst:\annotationType(_, _, _): aDecl += inst;
        case inst:\annotationTypeMember(_, _, _): aDecl += inst;
        case inst:\annotationTypeMember(_, _, _, _): aDecl += inst;
        case inst:\parameter(_, _, _, _): aDecl += inst;
        case inst:\dimension(_): aDecl += inst;
        case inst:\vararg(_, _, _): aDecl += inst;
        case inst:\module(_, _, _): aExpr += inst;
        case inst:\opensPackage(_, _): aExpr += inst;
        case inst:\providesImplementations(_, _): aExpr += inst;
        case inst:\requires(_, _): aExpr += inst;
        case inst:\uses(_): aExpr += inst;
        case inst:\exports(_, _): aExpr += inst;
        case inst:\arrayAccess(_, _): aExpr += inst;
        case inst:\newArray(_, _, _): aExpr += inst;
        case inst:\newArray(_, _): aExpr += inst;
        case inst:\arrayInitializer(_): aExpr += inst;
        case inst:\assignment(_, _, _): aExpr += inst;
        case inst:\cast(_, _): aExpr += inst;
        case inst:\characterLiteral(_): aExpr += inst;
        case inst:\newObject(_, _, _, _, _): aExpr += inst;
        case inst:\newObject(_, _, _, _): aExpr += inst;
        case inst:\newObject(_, _, _, _): aExpr += inst;
        case inst:\newObject(_, _, _): aExpr += inst;
        case inst:\qualifiedName(_): aExpr += inst;
        case inst:\conditional(_, _, _): aExpr += inst;
        case inst:\fieldAccess(_): aExpr += inst;
        case inst:\fieldAccess(_, _): aExpr += inst;
        case inst:\superFieldAccess(_, _): aExpr += inst;
        case inst:\instanceof(_, _): aExpr += inst;
        case inst:\methodCall(_, _, _): aExpr += inst;
        case inst:\methodCall(_, _, _, _): aExpr += inst;
        case inst:\superMethodCall(_, _, _): aExpr += inst;
        case inst:\superMethodCall(_, _, _, _): aExpr += inst;
        case inst:\null(): aExpr += inst;
        case inst:\number(_): aExpr += inst;
        case inst:\booleanLiteral(_): aExpr += inst;
        case inst:\stringLiteral(_, _): aExpr += inst;
        case inst:\textBlock(_, _): aExpr += inst;
        case inst:\type(_): aExpr += inst;
        case inst:\bracket(_): aExpr += inst;
        case inst:\this(): aExpr += inst;
        case inst:\this(_): aExpr += inst;
        case inst:\super(): aExpr += inst;
        case inst:\declarationExpression(_): aExpr += inst;
        case inst:\times(_, _): aExpr += inst;
        case inst:\divide(_, _): aExpr += inst;
        case inst:\remainder(_, _): aExpr += inst;
        case inst:\plus(_, _): aExpr += inst;
        case inst:\minus(_, _): aExpr += inst;
        case inst:\leftShift(_, _): aExpr += inst;
        case inst:\rightShift(_, _): aExpr += inst;
        case inst:\rightShiftSigned(_, _): aExpr += inst;
        case inst:\less(_, _): aExpr += inst;
        case inst:\greater(_, _): aExpr += inst;
        case inst:\lessEquals(_, _): aExpr += inst;
        case inst:\greaterEquals(_, _): aExpr += inst;
        case inst:\equals(_, _): aExpr += inst;
        case inst:\notEquals(_, _): aExpr += inst;
        case inst:\xor(_, _): aExpr += inst;
        case inst:\or(_, _): aExpr += inst;
        case inst:\and(_, _): aExpr += inst;
        case inst:\conditionalOr(_, _): aExpr += inst;
        case inst:\conditionalAnd(_, _): aExpr += inst;
        case inst:\postIncrement(_): aExpr += inst;
        case inst:\postDecrement(_): aExpr += inst;
        case inst:\preIncrement(_): aExpr += inst;
        case inst:\preDecrement(_): aExpr += inst;
        case inst:\prePlus(_): aExpr += inst;
        case inst:\preMinus(_): aExpr += inst;
        case inst:\preComplement(_): aExpr += inst;
        case inst:\preNot(_): aExpr += inst;
        case inst:\id(_): aExpr += inst;
        case inst:\methodReference(_, _, _): aExpr += inst;
        case inst:\methodReference(_, _, _): aExpr += inst;
        case inst:\creationReference(_, _): aExpr += inst;
        case inst:\superMethodReference(_, _): aExpr += inst;
        case inst:\lambda(_, _): aExpr += inst;
        case inst:\lambda(_, _): aExpr += inst;
        case inst:\memberValuePair(_, _): aExpr += inst;
        case inst:\assert(_): aStat += inst;
        case inst:\assert(_, _): aStat += inst;
        case inst:\block(_): aStat += inst;
        case inst:\break(): aStat += inst;
        case inst:\break(_): aStat += inst;
        case inst:\continue(): aStat += inst;
        case inst:\continue(_): aStat += inst;
        case inst:\do(_, _): aStat += inst;
        case inst:\empty(): aStat += inst;
        case inst:\foreach(_, _, _): aStat += inst;
        case inst:\for(_, _, _, _): aStat += inst;
        case inst:\for(_, _, _): aStat += inst;
        case inst:\if(_, _): aStat += inst;
        case inst:\if(_, _, _): aStat += inst;
        case inst:\label(_, _): aStat += inst;
        case inst:\return(_): aStat += inst;
        case inst:\return(): aStat += inst;
        case inst:\switch(_, _): aStat += inst;
        case inst:\case(_): aStat += inst;
        case inst:\caseRule(_): aStat += inst;
        case inst:\defaultCase(): aStat += inst;
        case inst:\synchronizedStatement(_, _): aStat += inst;
        case inst:\throw(_): aStat += inst;
        case inst:\try(_, _): aStat += inst;
        case inst:\try(_, _, _): aStat += inst;
        case inst:\catch(_, _): aStat += inst;
        case inst:\declarationStatement(_): aStat += inst;
        case inst:\while(_, _): aStat += inst;
        case inst:\expressionStatement(_): aStat += inst;
        case inst:\constructorCall(_, _): aStat += inst;
        case inst:\superConstructorCall(_, _, _): aStat += inst;
        case inst:\superConstructorCall(_, _): aStat += inst;
        case inst:\yield(_): aStat += inst;
        //case inst:\switch(_, _): aStat += inst;
    }
    return <aDecl, aExpr, aStat>;
}

bool compareAST(tuple[list[Declaration], list[Expression], list[Statement]] t1, tuple[list[Declaration], list[Expression], list[Statement]] t2, bool bType2){
    if(<aDecl1, aExpr1, aStat1> := t1 && <aDecl2, aExpr2, aStat2> := t2)
    {
        if(size(aDecl1) != size(aDecl2))
            return false;
        if(size(aExpr1) != size(aExpr2))
            return false;
        if(size(aStat1) != size(aStat2))
            return false;
        
        int i = 0;
        while(i<size(aDecl1)){
            if(!compareDecl(elementAt(aDecl1, i), elementAt(aDecl2, i)))
                    return false;
            i+=1;
        }
        i = 0;
        while(i<size(aExpr1)){
            if(!compareExpr(elementAt(aExpr1, i), elementAt(aExpr2, i), bType2))
                return false;
            i+=1;
        }
        i = 0;
        while(i<size(aStat1)){
            if(!compareStat(elementAt(aStat1, i), elementAt(aStat2, i)))
                return false;
            i+=1;
        }
        return true;
    }
}

list[list[loc]] classifyAST(loc project, bool bType2){
    list[tuple[tuple[list[Declaration], list[Expression], list[Statement]], loc]] aClass = [];
    visit(getASTs(project)){
        case c:\class(_, _, _, _, _, _): {
            aClass += <transformClassToAST(c), c.src>;
        }
        case c:\class(_): {
            log(c.src);
            aClass += <transformClassToAST(c), c.src>;
        }
    }

    int i = 0;
    list[list[loc]] ans = [];
    while(i<size(aClass)){
        int j = i + 1;
        while(j<size(aClass)){
            if(<t1, l1>:=elementAt(aClass, i) && <t2, l2>:=elementAt(aClass, j)){
                if(compareAST(t1, t2, bType2)){
                    ans = insertAt(ans, 0, [l1, l2]);
                }
            }
            j+=1;
        }
        i+=1;
    }

    while(true){
        int sz = size(ans);
        i = 0;
        int j = 0;
        while(i<size(ans)){
            j = i + 1;
            while(j<size(ans)){
                list[loc] l1 = elementAt(ans, i);
                list[loc] l2 = elementAt(ans, j);
                list[loc] ls = dup(l1 + l2);
                if(size(ls) < size(l1) + size(l2)){
                    ans = delete(ans, j);
                    ans = delete(ans, i);
                    ans = insertAt(ans, 0, ls);
                }
                j+=1;
            }
            i+=1;
        }
        if(sz == size(ans))
            break;
    }

    return ans;
}