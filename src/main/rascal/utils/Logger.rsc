module utils::Logger

import IO;
import String;
import DateTime;
import List;
import Location;
import util::Math;
import utils::Calculator;
import metrics::Volume;

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

void logCloneMap(list[list[loc]] cloneMap){
    for (l1 <- cloneMap) {
        for (location <- l1) {
            log(location);
        }
        logDashedLine();
    }
}

void logCloneStat(str cloneType, str detectorType, loc project, list[list[loc]] aClones, bool bDetailed) {
    logDashedLine();

    log("Clone detector: <detectorType>");

    log("Clone type: <cloneType>");

    int sz = size(aClones);
    log("Number of clone classes:");log(sz);

    int maxx = 0;
    for(cl <- aClones)
    {
        if(maxx < size(cl))
            maxx = size(cl);
    }
    log("Biggest clone class (in members):");log(maxx);

    log("Number of clones: ");log(size(concat(aClones)));

    int duplLines = 0;
    int biggestClone = 0;
    for(l <- concat(aClones)){
        list[str] aStr = split("\n", getContent(l));
        int nL = size(removeComments(aStr));
        if(biggestClone < nL)
            biggestClone = nL;
        duplLines += nL;
    }
    log("Biggest clone (in lines):");log(biggestClone);
    real per = roundN2(100.0 * toReal(duplLines) / toReal(countFunctionalLinesProject(project)));
    log("Percentage of duplicated lines:");log(per);

    logDashedLine();

    if(bDetailed)
        logCloneMap(aClones);
}