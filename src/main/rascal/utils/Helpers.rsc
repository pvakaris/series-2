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

str convertTypeToString(TypeSymbol typee) {
	switch (typee) {
		case \class(_, _): return "class";
  		case \interface(_, _): return "interface";
  		case \enum(_): return "enum";
  		case \method(_, _, _, _): return "method";
  		case \constructor(_, _): return "cons";
  		case \typeParameter(_, _): return "typeParam";
  		case \typeArgument(_): return "typeArg";
  		case \wildcard(_): return "wildcard";
  		case \capture(_, _): return "capture";
  		case \intersection(_): return "intersection";
  		case \union(_): return "union";
  		case \object(): return "object";
  		case \int(): return "int";
  		case \float(): return "float";
  		case \double(): return "double";
  		case \short(): return "short";
  		case \boolean(): return "bool";
  		case \char(): return "char";
  		case \byte(): return "byte";
  		case \long(): return "long";
  		case \void(): return "void";
  		case \null(): return "null";
  		case \array(_, _): return "array";
  		case \typeVariable(_): return "typeVar";
  		case \unresolved(): return "unresolved";
		default: return "unknown";
	}
}

str stringifyVariable(str name, Expression expression) {
	if (\qualifiedName(_, _) := expression)
		return "__qualifiedName__";

	switch (expression.typ) {
		case \int(): return convertTypeToString(expression.typ);
		case \float(): return convertTypeToString(expression.typ);
		case \double(): return convertTypeToString(expression.typ);
		case \short(): return convertTypeToString(expression.typ);
		case \boolean(): return convertTypeToString(expression.typ);
		case \char(): return convertTypeToString(expression.typ);
		case \byte(): return convertTypeToString(expression.typ);
		case \long(): return convertTypeToString(expression.typ);
		case \null(): return convertTypeToString(expression.typ);
		case \array(_, _): return convertTypeToString(expression.typ);
        case \class(className, _): return className.path;
		default: return name;
	}
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