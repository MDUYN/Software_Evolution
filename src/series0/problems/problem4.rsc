module series0::problems::problem4

import IO;
import Set;
import List;
import Map;

import lang::java::m3::Core;
import lang::java::m3::AST;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

list[loc] findNullReturned(list[Declaration] asts){
	list[loc] nullReturnLocations = [];
	visit(asts){
		case \return(expr): if(expr is \null) nullReturnLocations += expr.src; 
	}
	return nullReturnLocations;
}

//list[loc] findThisReturned(list[Declaration] asts){
//	list[loc] nullReturnLocations = [];
//	visit(asts){
//		case \return(thisExpr:\this): nullReturnLocations += thisExpr.src; 
//	}
//	return nullReturnLocations;
//}