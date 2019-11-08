module series1::metrics::volume

import IO;
import Set;
import List;
import Map;

import lang::java::m3::Core;
import lang::java::m3::AST;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

int calcLLOC(list[Declaration] asts) {
	int lloc = 0;
	visit(asts) {
		case \compilationUnit(i,_): lloc += size(i);
		case \compilationUnit(p,i,_): lloc += size(i) + 1;
		case \enum(_,_,c,_): lloc += size(c) + 1;
		case \class(_,_,_,_): lloc += 1;
		case \class(_): lloc += 1;
		case \interface(_,_,_,_): lloc += 1;
		case \field(_,_): lloc += 1;
		case \method(_,_,_,_,_): lloc += 1;
		case Statement x: {
			if(!(\block(_) := x)) lloc += 1;
		} 
	}
	return lloc;
}
