module parser

import utils;

import IO;
import String;

list[str] cleanFile(loc file){ 
	 lines = [ line | line <-(readFileLines(file))];
	 cleaned = [ replaceAll(line,"\t", "") | line <- lines];
	 return [ line | line <- cleaned, /^[^\/]/ := line ];
}

bool isCommentLine(str line) {
	return /^[\/*}{]/ := line;
}


list[str] clean(loc file) {
	list[str] retval = [];
	for( str line <- readFileLines(file) ) {
		nline = trim(line);
		if(size(nline) > 0 && !isCommentLine(nline)) retval += nline;
	}
	
	return retval;
}