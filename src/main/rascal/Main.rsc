module Main

import List;
import Set;
import String;
import DateTime;
import lang::java::m3::Core;
import lang::java::m3::AST;

import utils::Helpers;
import utils::MapHelpers;
import utils::Calculator;
import utils::Logger;

import metrics::Volume;

import Constants;
import DetectCloneMetrics;
import DetectTypeOneClones;
import DetectCloneAst;

import ast::AstHelpers;

void runAnalysisOn(loc project, str projectName) {
    log("Running analysis on: <projectName>");
    datetime startTime = now();
    logDashedLine();

    logCloneStat("1", "AST", project, classifyAST(project, false), false);
    // logCloneStat("2", "AST", project, classifyAST(project, true), false);
    logCloneStat("1", "textual", project, classifyTextual(project), false);
    logCloneStat("2", "metrics", project, classifyMetrics(project), false);

    interval runtime = createInterval(startTime, now());
    logDuration("Analysis of the project took:", createDuration(runtime));
    logDashedLine();
}

void main() {
    logDashedLine();
    runAnalysisOn(SMALLSQL_CWD, "SmallSQL Project");
    runAnalysisOn(HSQLDB_CWD, "HSQLDB Project");
    runAnalysisOn(SIMPLE_PROJECT_CWD, "Simple Java Project");
}

// PRIVATE METHODS
