module utils::Logger

import IO;
import String;
import DateTime;
import utils::Calculator;

void log(str message) {
    println(message);
}

void log(value val) {
    println("<val>");
}

void logDashedLine() {
    println("------------------------------------------------");
}

void logEmptyLine() {
    println("");
}

void logDuration(str title, Duration dur) {
     str result = "";
    
    if (dur.years != 0) {
        result += "<dur.years> years ";
    }
    if (dur.months != 0) {
        result += "<dur.months> months ";
    }
    if (dur.days != 0) {
        result += "<dur.days> days ";
    }
    if (dur.hours != 0) {
        result += "<dur.hours> h ";
    }
    if (dur.minutes != 0) {
        result += "<dur.minutes> min ";
    }
    if (dur.seconds != 0) {
        result += "<dur.seconds> s ";
    }
    if (dur.milliseconds != 0) {
        result += "<dur.milliseconds> ms";
    }
    
    log("<title> <trim(result)>");
}

void logCloneMap(map[value, set[loc]] cloneMap){
    for (key <- cloneMap) {
        for (location <- cloneMap[key]) {
            log(location);
        }
        logDashedLine();
    }
}

void logCloneMap(str cloneType, int functionalLines, int numberOfClones, tuple[int, int] cloneCounts) {
    int numberOfCloneClasses = cloneCounts[0];
    int numberOfClonedLines = cloneCounts[1];
    
    logDashedLine();
    log(cloneType);
    logDashedLine();
    log("Clones: <numberOfClones>");
    log("Clone classes: <numberOfCloneClasses>");
    log("Cloned lines: <numberOfClonedLines>");
    log("Cloned lines percentage (of functional): <percent(numberOfClonedLines, functionalLines)>%");
}