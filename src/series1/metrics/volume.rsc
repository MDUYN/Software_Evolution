module series1::metrics::volume

import IO;
import Set;
import List;
import Map;

import lang::java::m3::Core;
import lang::java::m3::AST;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

int calcLLOC(Declaration ast){
	int lloc = 0;
	top-down visit(ast) {
		case \compilationUnit(i,_): lloc += size(i);
		case \compilationUnit(p,i,_): lloc += size(i) + 1;
		case \enum(_,_,c,_): lloc += size(c) + 1;
		case \class(_,_,_,_): lloc += 1;
		case \class(_): lloc += 1;
		case \interface(_,_,_,_): lloc += 1;
		case \field(_,_): lloc += 1;
		case Declaration d: {
			if(\method(_,_,_,_,_) := d) lloc += 1;
			else if(\method(_,_,_,_) :=d) lloc += 1;
		}
		case Statement x: {
			if(!(\block(_) := x)) lloc += 1;
		} 
	}
	
	return lloc;
}