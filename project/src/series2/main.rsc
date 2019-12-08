module series2::main

import IO;
import List;
import Node;

import lang::java::m3::AST;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

import series2::clones::statHelpers;
import series2::clones::detection;
import series2::clones::type_one;

import util::Math;

alias Buckets = map[node,list[nodes]];

void main(){
	loc project = |project://smallsql0.21_src|;
	set[Declaration] asts = createAstsFromEclipseProject(project, true);
	
	Buckets buckets = detect(project, asts, 30, addToBucketTypeOne, isCloneFunctionTypeOne);
}

void printLog(loc project, Buckets buckets) {
	int lineCount = (0 | it + countNonBlockStatements(a) | a <- asts);
	int lineDuplication = duplicatedLines(buckets);
	int totalDuplication = percent(lineDuplication, lineCount);
	int numberOfClones = getNumberOfClones(buckets);
	tuple[int,loc] biggestCloneInLines = findBiggestClone(buckets);
	tuple[int, list[loc]] biggestClass = findBiggestCloneClass(buckets);
}