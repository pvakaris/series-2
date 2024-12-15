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

void logCloneStat(str cloneType, str detectorType, loc project, list[list[loc]] aClones) {
    logDashedLine();

    log("Clone detector: <detectorType>");

    log("Clone type: <cloneType>");

    log("Number of clone classes: <size(aClones)>");

    int maxx = 0;
    for(cl <- aClones)
    {
        if(maxx < size(cl))
            maxx = size(cl);
    }
    log("Biggest clone class (in members): maxx")

    log("Number of clones: <size(concat(aClonse))>");

    int duplLines = 0;
    int biggestClone = 0;
    for(l <- concat(aClones)){
        list[str] aStr = split("\n", getContent(l));
        int nL = size(removeComments(aStr));
        if(biggestClone < nL)
            biggestClone = nL;
        dupLines += nL;
    }
    real percDup = toReal(dupLines) / toReal(countFunctionalLinesProject(project)) * 100.0;
    log("Biggest clone (in lines): <biggestClone>");
    log("Percentage of duplicated lines: <percDup>");

    logDashedLine();
}