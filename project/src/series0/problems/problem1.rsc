module series0::problems::problem1

import IO;
import Set;
import List;
import Map;

import lang::java::m3::Core;
import lang::java::m3::AST;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

int getNumberOfForLoops(list[Declaration] asts){
	int numberOfForLoops = 0;
	for(Declaration d <- asts){
		numberOfForLoops += getNumberOfForLoops(d);
	}
	return numberOfForLoops;
}

int getNumberOfForLoops(node asts){
	int numberOfForLoops = 0;
	visit(asts){
		case \foreach(_, _, _): numberOfForLoops += 1;
		case \for(_, _, _, _): numberOfForLoops += 1;
		case \for(_, _, _): numberOfForLoops += 1;
	}
	return numberOfForLoops;
}