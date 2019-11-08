module utils

import IO;
import Set;
import List;
import Map;
import util::FileSystem;
import String;

import lang::java::m3::Core;
import lang::java::m3::AST;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import analysis::m3::AST;

// Function to find all file locations matched against a set of extensions
set[loc] extractFileLocations(set[str] extensions, loc project) {
	
	// Make sure that you convert all the file extensions to lower case
	set[str] extensionsLowerCase = { toLowerCase(e) | e <- extensions};
	
	// Create a set of all the locations
	return { location | /file(location) <- crawl(project), !startsWith(location.file, "."), (toLowerCase(location.extension) in extensionsLowerCase) || location.extension in extensions};
}

// Function to create a list of Declarations with a given java file location
list[Declaration] getASTs(loc location){
	M3 model = createM3FromEclipseProject(location);
	list[Declaration] asts = [];
	for (m <- model.containment, m[0].scheme == "java+compilationUnit"){
		asts += createAstFromFile(m[0], true);
	}
	return asts;
}

// Function that parses the contents of a loc of a file to txt
public str fileContent(loc file) {
	return readFile(file);
}

// Function that returns all method statements from a list of Declarations
list[Statement] findMethods(list[Declaration] declarations) {
	list[Statement] methods = [];
	
	visit(declarations) {
	 	case \initializer(statement): methods += statement;
	 	case \method(_,_,_,_,statement): methods += statement;
	 	case \constructor(_,_,_,statement): methods += statement;
	}
	return methods;
}

// Function to calculate the logical lines of code of a method body
// Keep in mind that you need to add one line for the function declaration.
int calcLLOCMethod(Statement impl) {
	//We leave out block because, we are technically already in block when we 
	//are in a method. If we counted all the blocks, we would cound double. 
	//Inturn we also don't do this for switchm and try and catch statements
	int result = 0;
	visit (impl) {
		case \assert(_): result += 1;
		case \assert(_, _): result += 1;
	    case \break(): result += 1;
	    case \break(_): result += 1;
	    case \continue(): result += 1;
		case \continue(_): result += 1;   
	    case \do(_,_) : result += 1;
	    case \empty() : result += 1;
	    case foreach(_,_,_) : result += 1;	
		case \for(_,_,_) : result += 1;	
		case \for(_,_,_,_) : result += 1;	
		case \if(_,_) : result += 1;	
		case \if(_,_,_) : result += 1;	
		case \label(_, _) : result += 1;	
		case \return(_) : result += 1;	
		case \return(): result +=1;
		case \switch(_, statements): result += 1;
		case \case(_) : result += 1;	
		case \defaultCase() : result += 1;
		case \synchronizedStatement(_, _) : result += 1;
		case \try(_, catchClauses) : result += 1;
		case \try(_, catchClauses, _) : result += 2;
		case \throw(_) : result += 1;
		case \catch(_,_) : result += 1;
		case \declarationStatement(_) : result += 1;
		case \while(_,_) : result += 1;
		case \expressionStatement(_) : result += 1;
		case \conditional(_,_,_) : result += 1;		
		case \constructorCall(_, _,_) : result += 1;
		case \constructorCall(_, _) : result += 1;
		
	}
	return result;
}