module series1::metrics::duplication

import utils;
import parser;

import List;
import String;

list[str] partition(list[str] lines){
	list[str] retval = [];
	
	int max = 6; //(size(lines) > 6) ? 6 : 3;
	
	int pStart = 0;
	int pEnd = max;
	
	list[str] next = lines[pStart .. pEnd];
	
	do {
		retval += ("" | it + e | str e <- next);
		pStart += 1;
		pEnd += 1;
		next = lines[pStart .. pEnd];
	} while (size(next) >= max);
	
	return retval;
}

int findDuplicateBlocks(list[str] file, list[str] rhs) {
	int retval = 0;
	for(str f <- file) {
		if(f in rhs) retval += 1;
	}
	return retval;
}