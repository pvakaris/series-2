module utils::Helpers

import IO;
import List;
import lang::java::m3::Core;
import lang::java::m3::AST;
import String;
import Location;

list[Declaration] getASTs(loc project) {
    M3 model = createM3FromMavenProject(project);
    list[Declaration] asts = [createAstFromFile(f, true) | f <- files(model.containment), isCompilationUnit(f)];
    return asts;
}

list[loc] getFiles(loc project) {
    M3 model = createM3FromMavenProject(project);
    list[loc] projectFiles = [f | f <- files(model.containment), isCompilationUnit(f)];
    return projectFiles;
}

list[Declaration] getASTsDirectory(loc directory) {
    M3 model = createM3FromDirectory(directory);
    list[Declaration] asts = [createAstFromFile(f, true) | f <- files(model.containment), isCompilationUnit(f)];
    return asts;
}

// Run the function on all files in the project
int computeProjectMetric(loc project, int (loc) function) {
    M3 projectModel = createM3FromMavenProject(project);
    int totalMetric = 0;
    for (file <- files(projectModel.containment)) {
        totalMetric += function(file.top);
    }
    return totalMetric;
}

// Run the function on one file
int computeFileMetric(loc file, int (loc) function) {
    return function(file);
}

// Convert each file into a list of strings for easier comparison
list[list[str]] getStringifiedProject(loc project) {
    list[loc] projectFiles = getFiles(project);
    list[list[str]] stringifiedProject = [];
    for (file <- projectFiles) {
        stringifiedProject += [readFileLines(file)];
    }

    return stringifiedProject;
}

int countChildren(node n, int maxDepth) {
    int count = 0;

    visit(n) {
        case node _n: {
			count += 1; 
			if (count >= maxDepth) {
				return count;
			}
   		}
	}
		

    return count;
}

list[str] classStr(Declaration class){
	str strRaw = getContent(class.src);
	list[str] res = split("\n", strRaw);
	return res;
}