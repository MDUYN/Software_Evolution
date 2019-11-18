module parser

import utils;

import IO;
import String;

bool isCommentLine(str line) {
	return /^[\/*]/ := line;
}

list[str] clean(loc file) {
	list[str] retval = [];
	for( str line <- readFileLines(file) ) {
		nline = trim(line);
		if(size(nline) > 0 && !isCommentLine(nline)) retval += nline;
	}
	
	return retval;
}