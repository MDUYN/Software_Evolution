module series0::main

import IO;
import Set;
import List;
import Map;

import lang::java::m3::Core;
import lang::java::m3::AST;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

import series0::problems::problem1;
import series0::problems::problem2;
import series0::problems::problem3;
import series0::problems::problem4;

void main(){
	list[Declaration] asts = getASTs(|project://smallsql0.21_src|);
	println("For loops = <getNumberOfForLoops(asts)>");
	println("Most occuring variables =<findMostUsed(asts, variableOccurences)>");
	println("Most occuring numbers =<findMostUsed(asts, numberOccurences)>");
}

list[Declaration] getASTs(loc projectLocation){
	M3 model = createM3FromEclipseProject(projectLocation);
	list[Declaration] asts = [];
	for (m <- model.containment, m[0].scheme == "java+compilationUnit"){
		asts += createAstFromFile(m[0], true);
	}
	return asts;
}