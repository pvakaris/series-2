module tests::TestDetectTypeOneClones

import List;
import Set;
import String;
import DateTime;
import lang::java::m3::Core;
import lang::java::m3::AST;
import util::Math;

import DetectTypeOneClones;

test bool testCondenceStr1() {return condenceStr("a+b;", false) == <"a+b;", false>;}
test bool testCondenceStr2() {return condenceStr("     a+b;", false) == <"a+b;", false>;}
test bool testCondenceStr3() {return condenceStr("a+b;     ", false) == <"a+b;", false>;}
test bool testCondenceStr4() {return condenceStr(" a + b ; ", false) == <"a+b;", false>;}
test bool testCondenceStr5() {return condenceStr("     a   +    b    ;    ", false) == <"a+b;", false>;}
test bool testCondenceStr6() {return condenceStr("  a + b  ;   ", false) == <"a+b;", false>;}
test bool testCondenceStr7() {return condenceStr("//just some comment", false) == <"", false>;}
test bool testCondenceStr8() {return condenceStr("//// many dash comment", false) == <"", false>;}
test bool testCondenceStr9() {return condenceStr("/*start of comment", false) == <"", true>;}
test bool testCondenceStr10() {return condenceStr("end of comment*/", true) == <"", false>;}
test bool testCondenceStr11() {return condenceStr("a+b;//some comment", false) == <"a+b;", false>;}
test bool testCondenceStr12() {return condenceStr("a+b;/*ntougun*/", false) == <"a+b;", false>;}
test bool testCondenceStr13() {return condenceStr("a+b;/*ntougun", false) == <"a+b;", true>;}
test bool testCondenceStr14() {return condenceStr("/*ntougun*/a+b;", false) == <"a+b;", false>;}
test bool testCondenceStr15() {return condenceStr("a/*ntougun*/+b;", false) == <"a+b;", false>;}
test bool testCondenceStr16() {return condenceStr("a/*ntougun*/ + b;", false) == <"a+b;", false>;}
test bool testCondenceStr17() {return condenceStr("a    /*ntougun*/    +    b;       ", false) == <"a+b;", false>;}
test bool testCondenceStr18() {return condenceStr("end of comment*/a+b;", true) == <"a+b;", false>;}
test bool testCondenceStr19() {return condenceStr("a + b ; /*start of comment", false) == <"a+b;", true>;}
test bool testCondenceStr20() {return condenceStr("a + b ; /*", false) == <"a+b;", true>;}
test bool testCondenceStr21() {return condenceStr("a/*/*nested comment*/+b;", false) == <"a+b;", false>;}
test bool testCondenceStr22() {return condenceStr("*/d=f+g;/*com*/a=g+h;/*com", true) == <"d=f+g;a=g+h;", true>;}
test bool testCondenceStr23() {return condenceStr("                        \" */ FROM /* -- comment */\" + TABLE_NAME + \" -- my comment /* \n\r\" +", true) == <"FROM\"+TABLE_NAME+\"--mycomment", true>;}
test bool testCondenceStr24() {return condenceStr("*/", true) == <"", false>;}
test bool testCondenceStr25() {return condenceStr("a+b;", true) == <"", true>;}
test bool testCondenceStr26() {return condenceStr("a+b;/*", false) == <"a+b;", true>;}