module series2::main

import IO;
import String;
import List;
import Node;
import Location;

import lang::java::m3::AST;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

import series2::clones::statHelpers;
import series2::clones::detection;
import series2::clones::type_one;
import series2::Server;

import util::Math;

alias Buckets = map[node,list[node]];

void main(){
	loc project = |project://smallsql0.21_src|;
	set[Declaration] asts = createAstsFromEclipseProject(project, true);
	
	Buckets buckets = detect(project, asts, 30, addToBucketTypeOne, isCloneFunctionTypeOne);
	value v = createData(project,asts,buckets);
	serveValue(|http://localhost:8080|,v);
}

value createData(loc project, set[Declaration] asts, Buckets buckets) {
	int lineCount = (0 | it + countNonBlockStatements(a) | a <- asts);
	int lineDuplication = duplicatedLines(buckets);
	int totalDuplication = percent(lineDuplication, lineCount);
	int numberOfClones = getNumberOfClones(buckets);
	tuple[int count,loc location] biggestCloneInLines = findBiggestClone(buckets);
	tuple[int count, list[loc] locations] biggestClass = findBiggestCloneClass(buckets);
	
	return (
		"percentage": totalDuplication, 
		"numberOfClones": numberOfClones,
		"biggestClone": getLocationData(biggestCloneInLines.location),
		"biggestClass": ([] | it + getLocationData(l) | l <- biggestClass.locations),
		"packageDensity": convertToJson(getCloneDensityByPackage(buckets))
	);
}

value getLocationData(loc l) {
	return (
		"path": l.path,
		"length": (l.end.line - l.begin.line),
		"content": getContent(l)
	);
}

map[str name, int count] getCloneDensityByPackage(Buckets buckets) {
	map[str name, int count] retval = ();
	for(n <- buckets) {
		for(clone <- buckets[n]) {
			loc l = getSourceLocation(clone);
			str package = getContainingPackage(l.path);
			if(package in retval) {
				retval[package] += 1;
			} else {
				retval[package] = 1;
			}
		}
	}
	
	return retval;
}

list[value] convertToJson(map[str name, int count] m) {
	list[value] retval = [];
	for(key <- m) {
		retval += ("name": key, "count": m[key]);
	}
	return retval;
}

str getContainingPackage(str input){
	list[str] output = [];
	list[str] excluded = ["src"];
	for(s <- split("/", input)) { 
		if(!(/.*\.java/ := s) && s notin excluded) {
			output += s;
		}
	}
	return ("" | it + "<e>/" | e <- output);
}