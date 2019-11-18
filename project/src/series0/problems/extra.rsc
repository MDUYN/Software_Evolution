module series0::problems::extra

import IO;
import Set;
import List;
import Map;

import lang::java::m3::Core;
import lang::java::m3::AST;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

import problems::problem1;
import problems::problem2;

// EXTRA: Number of nested for-loops
int getNumberOfNestedForLoops(list[Declaration] asts){
	int numberOfForLoops = 0;
	visit(asts){
		case \foreach(_, _, body): if(getNumberOfForLoops(body)>0) numberOfForLoops += 1;
		case \for(_, _, _, body): if(getNumberOfForLoops(body)>0) numberOfForLoops += 1;
		case \for(_, _, body): if(getNumberOfForLoops(body)>0) numberOfForLoops += 1;
	}
	return numberOfForLoops;
}

// EXTRA: Get top x most used
list[tuple[int, list[str]]] findMostUsed(list[Declaration] asts, map[str, int] (list[Declaration]) countFunction, int top){
	list[tuple[int amount, list[str] names]] mostUsed = [];
	map[str, int] varCount = countFunction(asts);
	for(i <- [0..top]){
		mostUsed += findMostUsed(asts, varCount);
		for(str name <- last(mostUsed).names){
			varCount = delete(varCount, name);
		}
	}
	return mostUsed;
}

int getNumberOfInterfaces(list[Declaration] asts){
	int interfaces = 0;
	visit(asts){
		case \interface(_, _, _, _): interfaces += 1; 
	}
	return interfaces;
}