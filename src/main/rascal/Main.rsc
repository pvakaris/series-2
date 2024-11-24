module Main

import List;
import Set;
import String;
import DateTime;
import lang::java::m3::Core;
import lang::java::m3::AST;

import utils::Helpers;
import utils::Calculator;
import utils::Logger;

import Constants;

void runAnalysisOn(loc project, str projectName) {
    logDashedLine();
    log("Running analysis on: <projectName>");
    datetime startTime = now();

    // Add clone detection here

    logDashedLine();
    interval runtime = createInterval(startTime, now());
    logDuration("Analysis of the project took:", createDuration(runtime));
    logDashedLine();
}

void main() {
    // runAnalysisOn(SMALLSQL_CWD, "SmallSQL Project");
    // runAnalysisOn(HSQLDB_CWD, "HSQLDB Project");
}

// PRIVATE METHODS