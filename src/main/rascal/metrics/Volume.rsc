module metrics::Volume

import IO;
import List;
import Set;
import String;
import lang::java::m3::Core;
import lang::java::m3::AST;

import utils::Helpers;

// Lines that are not comments and not blank
int countFunctionalLinesProject(loc project) {
    return computeProjectMetric(project, countFunctionalLines);
}

int countFunctionalLines(loc file) {
    list[str] functionalLines = removeComments(getFileLines(file));
    // FOR TESTING PURPOSES
    // for (line <- functionalLines) {
    //     println(line);
    // }
    return size(functionalLines);
}

list[str] getFileLines(loc file) {
    return readFileLines(file);
}

int countLines(loc file) {
    return size(readFileLines(file));
}

list[str] removeComments(list[str] lines) {
    lines = filterLines(lines);
    return processLines(lines);
}

// PRIVATE METHODS

private list[str] processLines(list[str] lines) {
    list[str] cleanedLines = [];
    bool insideComment = false;

    for (line <- lines) {
        int commentIdx = findFirst(line, "//");
        line = (commentIdx != -1) ? line[0..commentIdx] : line;

        if (insideComment && !contains(line, "*/")) {
            continue;
        }

        if (contains(line, "/*") || contains(line, "*/")) {
            <insideComment, line> = processMultiLineComments(insideComment, line);
        }

        if (!isEmptyOrCommentLine(line)) {
            cleanedLines += trim(line);
        }
    }
    return cleanedLines;
}

private tuple[bool, str] processMultiLineComments(bool insideComment, str line) {
    int lineLength = size(line);
    str updatedLine = line;
    int startIdx = findFirst(line, "/*");
    int endIdx = findFirst(line, "*/");

    if ((endIdx < startIdx || startIdx == -1) && endIdx != -1) {
        insideComment = false;
        updatedLine = updatedLine[endIdx + 2..lineLength];
    }

    while (startIdx != -1) {
        if (endIdx == -1) {
            insideComment = true;
            updatedLine = updatedLine[0..startIdx];
        } else {
            insideComment = false;
            updatedLine = updatedLine[0..startIdx] + updatedLine[endIdx + 2..lineLength];
        }
        startIdx = findFirst(updatedLine, "/*");
    }

    return <insideComment, updatedLine>;
}

private bool isEmptyOrCommentLine(str line) {
    return /^\s*\/\/.*/ := line || /^\s*$/ := line;
}

private list[str] filterLines(list[str] lines) {
    return [line | str line <- lines, !isEmptyOrCommentLine(line)];
}