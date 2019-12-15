module series2::main

import IO;
import String;
import List;
import Set;
import Node;
import Location;
import Map;

import lang::java::m3::AST;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

import series2::clones::statHelpers;
import series2::clones::detection;
import series2::clones::type_one;
import series2::clones::type_two;
import series2::Server;

import util::Math;

alias Buckets = map[node,list[node]];

void main(){
	loc project = |project://smallsql0.21_src|;
	set[Declaration] asts = createAstsFromEclipseProject(project, true);
	Buckets buckets1 = detect(project, asts, 30, addToBucketTypeOne, isCloneFunctionTypeOne, removeSubtreeNodesFunctionTypeOne);
	Buckets buckets2 = detect(project, asts, 30, addToBucketTypeTwo, isCloneFunctionTypeTwo, removeSubtreeNodesFunctionTypeTwo);
	
	map[str,map[str,int]] deps1 = getDependencies(buckets1);
	map[str,map[str,int]] deps2 = getDependencies(buckets2);
	
	value v1 = createData(project,asts,buckets1);
	value v2 = createData(project, asts, buckets2);
	list[value] d1 =  ([] | it + formatDependencies(k, deps1[k]) | k <- deps1);
	list[value] d2 =  ([] | it + formatDependencies(k, deps2[k]) | k <- deps2);
	
	serveValues(|http://localhost:8080|, ("/type1": v1, "/type2": v2, "/type1/dep": d1, "/type2/dep": d2));
}


map[str, map[str, int]] getDependencies(Buckets buckets) {
	map[str, map[str, int]] deps = ();
	for(k <- buckets){
		list[node] values = buckets[k];
		for(v <- values) {
			loc source = getSourceLocation(v);
			str path = source.path;
			if(path notin deps) {
				deps[path] = ();
			}
			list[loc] rest = ([] | it + getSourceLocation(l) | l <- values) - source;
			for(r <- rest) {
				str ref = r.path;
				if(ref in deps) {
					if(path notin deps[ref]){
						deps[path] += (ref: 1);
					}else {
						deps[ref][path] += 1;
					}
				}else if(ref in deps[path]){
					deps[path][ref] += 1;
				}else {
					deps[path] += (ref: 1);
				}
			}
		}
	}
	return deps;
}

list[value] formatDependencies(str from, map[str, int] valueData) { 
	list[value] retval = [];
	for(to <- valueData){
		if(isEmpty(to)){
			continue;
		}
		retval += (
			"from": from,
			"to": to,
			"weight": valueData[to]
		);
	}
	return retval;
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
		"packageDensity": convertToJson(getCloneDensityByPackage(buckets), "name", "count")
	);
}

value getLocationData(loc l) {
	return (
		"path": l.path,
		"length": (l.end.line - l.begin.line),
		"begin": l.begin,
		"end" : l.end,
		"content": getContent(l)
	);
}

list[value] getRawData(Buckets buckets) {
	list[value] retval = [];
	for(n <- buckets) {
		list[node] children = buckets[n];
		retval += (
			"bucket": n,
			"children": children
		);
	}
	return retval;
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
list[value] convertToJson(map[&T, &T] m, str keyId, str valueId) {
	list[value] retval = [];
	for(key <- m){
		retval += (keyId: key, valueId: m[key]);
	}
	return retval;
}

list[value] convertDependenciesToJson(map[loc, list[loc]] m) {
	list[value] retval = [];
	for(key <- m){
		list[str] vals = ([] | it + l.path | l <- m[key]); 
		retval += ("to": key.path, "from": vals);
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

set[loc] getFileLocations(loc project) {
	return files(createM3FromEclipseProject(project));
}
