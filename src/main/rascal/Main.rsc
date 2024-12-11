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

import ast::AstHelpers;
import ast::AstAlgorithm;

void runAnalysisOn(loc project, str projectName) {
    log("Running analysis on: <projectName>");
    datetime startTime = now();
    logDashedLine();

    astCloneAnalysis(project);
    logDashedLine();

    metricsCloneAnalysis(project, true);
    logDashedLine();

    interval runtime = createInterval(startTime, now());
    logDuration("Analysis of the project took:", createDuration(runtime));
    logDashedLine();
}

void main() {
    logDashedLine();
    runAnalysisOn(SMALLSQL_CWD, "SmallSQL Project");
    // runAnalysisOn(HSQLDB_CWD, "HSQLDB Project");
    // runAnalysisOn(SIMPLE_PROJECT_CWD, "Simple Java Project");
}

// PRIVATE METHODS

private void astCloneAnalysis(project) {
    log("AST Clone Analysis");
    logDashedLine();
    int total = computeProjectMetric(project, countLines);
    log("Lines of Code (Total): <total>");

    int functional = countFunctionalLinesProject(project);
    log("Lines of Code (Functional): <functional>");

    list[Declaration] asts = getASTs(project);

    // Type 1
    // map[value, set[loc]] mapOne = typeOne(asts);
    // logCloneMap("TYPE 1 CLONES", functional, sumMap(mapOne), sumMapDeep(mapOne));

    // Type 2
    // map[value, set[loc]] mapTwo = typeTwo(asts);
    // logCloneMap("TYPE 2 CLONES", functional, sumMap(mapTwo), sumMapDeep(mapTwo));

    // Type 3
    // map[value, set[loc]] mapThree = typeThree(asts);
    // logCloneMap("TYPE 3 CLONES", functional, sumMap(mapThree), sumMapDeep(mapThree));
}

private void metricsCloneAnalysis(project, bool bBigOnly) {
    log("Metrics Clone Analysis");
    logDashedLine();

    rel[loc, loc] aClones = analyze(project, bBigOnly);
    for(tuple[loc, loc] pair <- aClones){
        log("Clone pair:");
        if(<l1, l2> := pair){
            log(l1);
            log(l2);
        }
    }
}