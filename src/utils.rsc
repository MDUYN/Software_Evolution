module utils

import IO;
import Set;
import List;
import Map;
import util::FileSystem;
import String;

import lang::java::m3::AST;
import lang::java::jdt::m3::Core;
import lang::java::m3::Core;
import lang::java::m3::AST;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import analysis::m3::AST;

list[loc] getFileLocations(M3 model) {
	return toList(files(model));
}

list[Declaration] getDeclarations(M3 model){
	list[Declaration] asts = [];
	for (m <- model.containment, m[0].scheme == "java+compilationUnit"){
		asts += createAstFromFile(m[0], true);
	}
	return asts;
}

// Function that returns all method statements from a list of Declarations
list[Statement] getStatements(list[Declaration] declarations) {
	list[Statement] methods = [];
	
	visit(declarations) {
	 	case \method(_,_,_,_,statement): methods += statement;
	 	case \constructor(_,_,_,statement): methods += statement;
	}
	return methods;
}

/**
* Function to calculate the logical lines of code of a method body
* Keep in mind that you need to add one line for the function declaration.
* The declarations of these can be found here:
* http://tutor.rascal-mpl.org/Rascal/Rascal.html#/Rascal/Libraries/lang/java/m3/AST/Declaration/Declaration.html
*/
public int getLLOCStatement(Statement statement) {
	//We leave out block because, we are technically already in block when we 
	//are in a method. If we counted all the blocks, we would count double. 
	//Inturn we also don't do this for switch and try and catch statements
	int result = 0;
	visit (statement) {
		case \assert(_): result += 1;
		case \assert(_, _): result += 1;
		case \block(statements): result += sum([getLLOCStatement(body) | body <- statements] + [0]);
	    case \break(): result += 1;
	    case \break(_): result += 1;
	    case \continue(): result += 1;
		case \continue(_): result += 1;   
	    case \do(body, _) : result += 1 + getLLOCStatement(body);
	    case \empty() : result += 1;
	    case foreach(_, _, body) : result += 1 + getLLOCStatement(body);	
		case \for(_, _, body) : result += 1 + getLLOCStatement(body);	
		case \for(_, _, _, body) : result += 1 + getLLOCStatement(body);	
		case \if(_, body) : result += 1 + getLLOCStatement(body);	
		case \if(_, thenBranch, elseBranch) : result += 1 + getLLOCStatement(thenBranch) + getLLOCStatement(elseBranch);		
		case \label(_, body) : result += 1 + getLLOCStatement(body);	
		case \return(_) : result += 1;	
		case \return(): result +=1;
		case \switch(_, statements): result += sum([getLLOCStatement(body) | body <- statements] + [0]);
		case \case(_) : result += 1;	
		case \defaultCase() : result += 1;
		case \synchronizedStatement(_, body) : result += 1 + getLLOCStatement(body);
		case \try(_, statements) : result += sum([getLLOCStatement(body) | body <- statements] + [0]);
		case \throw(_) : result += 1;
		case \catch(_, body) : result += 1 + getLLOCStatement(body);
		case \declarationStatement(_) : result += 1;
		case \while(_, body) : result += 1 + getLLOCStatement(body);
		case \expressionStatement(_) : result += 1;
		case \conditional(_, _, _) : result += 1;		
		case \constructorCall(_, _, _) : result += 1;
		case \constructorCall(_, _) : result += 1;
	}
	return result;
}

/** 
* Function to calculate the unit complexity, the function will visit a list of declarations and will calc for every node the  
* McCabe cyclomatic complexity. This number represents the number of non-cyclic paths through the control-flow graph of the unit
* and can be calculated by counting the number of decision points that are present in the source code.
* Ref: https://www.softwareimprovementgroup.com/wp-content/uploads/2019/08/20180509-SIG-TUViT-Evaluation-Criteria-Trusted-Product-Maintainability-Guidance-for-producers-1.pdf
* The code was inspired by the following git project: https://stackoverflow.com/questions/40064886/obtaining-cyclomatic-complexity
*/ 

/**
* It is only needed for statements to calculate the cc, because unit complexity will only measured over the smallest named piece of executable code
*/
public int getCCStatement(Statement statement) {
	int result = 1;
    
    visit (statement) {
        case \if(_, _) : result += 1;
        case \if(_, _, _) : result += 1;
        case \case(_) : result += 1;
        case \do(_, _) : result += 1;
        case \while(_, _) : result += 1;
        case \for(_, _, _) : result += 1;
        case \for(_, _, _, _) : result += 1;
        case foreach(_, _, _) : result += 1;
        case \catch(_, _): result += 1;
        case \conditional(_, _, _): result += 1;
        case infix(_, "&&", _) : result += 1;
        case infix(_, "||", _) : result += 1;
    }
    return result;
}

// Helper function to get a list with methods from a m3 project
public list[loc] getMethods(M3 project) {
	return toList(methods(project));
}

str pad(int i){
	return right("<i>", 7);
}

public void printFoo(){
	int volumeMetric = 13;
	int ccMetric = 10;
	int dupMetric = 5;
	int sizeMetric = 10;
	int testMetric = 9;
	
	println("                 ||       |   c   |       |       |       ||");
	println("                 ||       |   o   |       |       |       ||");
	println("                 ||       |   m   |       |       |       ||");
	println("                 ||       |   p   |       |       |       ||");
	println("                 ||       |   l   |       |       |       ||");
	println("                 ||       |   e   |       |       |       ||");
	println("                 ||       |   x   |       |       |       ||");
	println("                 ||       |   i   |       |       |   u   ||");
	println("                 ||       |   t   |   d   |       |   n   ||");
	println("                 ||       |   y   |   u   |       |   i   ||");
	println("                 ||       |       |   p   |   u   |   t   ||");
	println("                 ||       |   p   |   l   |   n   |       ||");
	println("                 ||       |   e   |   i   |   i   |   t   ||");
	println("                 ||   v   |   r   |   c   |   t   |   e   ||");
	println("                 ||   o   |       |   a   |       |   s   ||");
	println("                 ||   l   |   u   |   t   |   s   |   t   ||");
	println("                 ||   u   |   n   |   i   |   i   |   i   ||");
	println("                 ||   m   |   i   |   o   |   z   |   n   ||");
	println("                 ||   e   |   t   |   n   |   e   |   g   ||");
	println("-----------------||-------|-------|-------|-------|-------||");
	println("metric           ||<pad(volumeMetric)>|<pad(ccMetric)>|<pad(dupMetric)>|<pad(sizeMetric)>|<pad(testMetric)>||");
	println("-----------------||-------|-------|-------|-------|-------||");
	println("analysability    ||-------|-------|-------|-------|-------||");
	println("-----------------||-------|-------|-------|-------|-------||");
	println("changeability    ||-------|-------|-------|-------|-------||");
	println("-----------------||-------|-------|-------|-------|-------||");
	println("stability        ||-------|-------|-------|-------|-------||");
	println("-----------------||-------|-------|-------|-------|-------||");
	println("testability      ||-------|-------|-------|-------|-------||");
	println("-----------------||-------|-------|-------|-------|-------||");
	println("-----------------||---------------------------------------||");
	println("MAINTAINABILITY  ||-------|-------|-------|-------|-------||");
	println("-----------------||---------------------------------------||");
	println("----------------------------------------------------------||");
}

