module series1::metrics::volume

import IO;
import Set;
import List;
import Map;

import lang::java::m3::Core;
import lang::java::m3::AST;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

import parser;

int calcLLOC(list[Declaration] ast){
	int lloc = 0;
	top-down visit(ast) {
		case \compilationUnit(i,_)	: lloc += size(i);
		case \compilationUnit(p,i,_): lloc += size(i) + 1;
		case \enum(_,_,c,_)			: lloc += size(c) + 1;
		case \class(_,_,_,_)		: lloc += 1;
		case \class(_)				: lloc += 1;
		case \interface(_,_,_,_)	: lloc += 1;
		case \field(_,_)			: lloc += 1;
		case Declaration d: {
			//The \method(4*) pattern seems to be included in the \method(5*) definition, resulting in a double count
			// in interfaces
			if(\method(_,_,_,_,_) := d) lloc += 1;
			else if(\method(_,_,_,_) :=d) lloc += 1;
		}
		case Statement x: {
			// Ignoring blocks, as the visit statement will visit it's children anyway
			if(!(\block(_) := x)) lloc += 1;
		} 
	}
	
	return lloc;
}

int calcSLOC(set[loc] files) {
	return sum([size(clean(f)) | f <- files]); 
}

str evaluateJavaVolumeScore(int volume) {
		 if (volume <=   6600) 	return "++";
	else if (volume <=  24600) 	return 	"+";
	else if (volume <=  66500) 	return 	"o";
	else if (volume <= 131000) 	return 	"-";
	else 						return "--";
}