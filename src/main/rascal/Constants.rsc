module Constants

// Can be used without importing the test-projects into the workspace
public loc SMALLSQL_CWD = |cwd:///test-projects/smallsql0.21_src|;
public loc HSQLDB_CWD = |cwd:///test-projects/hsqldb-2.3.1/hsqldb|;
public loc SIMPLE_PROJECT_CWD = |cwd:///test-projects/SimpleJavaProject|;

// The following are to be used after the projects from /test-projects directory have been imported into the workspace
public loc SMALLSQL_PROJECT = |project://smallsql0.21_src|;
public loc HSQLDB_PROJECT = |project://hsqldb-2.3.1/hsqldb|;
public loc SIMPLE_PROJECT = |project://SimpleJavaProject|;

// MATH Constants
public real ROUNDING_DIGITS = 0.01;

// AST Clone detection constants
public int AST_SIZE = 30;
public real SIMILARITY_THRESHOLD = 0.9;
