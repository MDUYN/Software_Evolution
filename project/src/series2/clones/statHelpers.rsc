module series2::clones::statHelpers

import IO;
import Map;
import List;

import lang::java::m3::AST;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

public int countNonBlockStatements(node n) {
	int count = 0;
	visit(n) {
		case Statement s: {
			//iprintln(s);
			if(!(\block(_) := s) && !(\empty() := s)) count += 1;
		}
	}
	return count;
}

public int duplicatedLines(map[node,list[node]] nodes) {
	int lineCount = 0;
	for(key <- nodes) {
		int size = size(nodes[key]);
		lineCount += countNonBlockStatements(key) * size;
	}
	
	return lineCount;
}

tuple[int, list[loc]] findBiggestCloneClass(map[node,list[node]] buckets) {
	tuple[int count, list[loc] clones] currentMax = <0,[]>;
	for(class <- buckets) {
		int s = size(buckets[class]);
		if(s > currentMax.count) {
			list[loc] locs= ( [] | it + (getSourceLocation(x)) | x <- buckets[class]);
			currentMax = <s,locs>;
		}
	}
	return currentMax;
}

tuple[int,loc] findBiggestClone(map[node,list[node]] buckets) {
	tuple[int count, loc clone] currentMax = <0,|tmp:///|>;
	for(class <- buckets) {
		for(clone <- buckets[class]) {
			int s = countNonBlockStatements(clone);
			if(s > currentMax.count) {
				currentMax = <s,getSourceLocation(clone)>;
			}
		}
	}
	return currentMax;
}

loc getSourceLocation(node n) {
	if(Expression e := n) return e.src;
	if(Statement s := n) return s.src;
	if(Declaration d := n) return d.src;
}

int getNumberOfClones(map[node,list[node]] buckets) {
	int count = 0;
	for(n <- buckets) {
		count += size(buckets[n]);	
	}
	return count;
}