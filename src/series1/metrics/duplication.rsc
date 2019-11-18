module series1::metrics::duplication

import utils;
import parser;

import List;
import String;
import Map;

import IO;
import util::Math;

list[str] partition(list[str] lines){
	list[str] retval = [];
	
	int max = 6; //(size(lines) > 6) ? 6 : 3;
	
	int pStart = 0;
	int pEnd = max;
	
	list[str] next = lines[pStart .. pEnd];
	
	do {
		retval += intercalate("", next);
		pStart += 1;
		pEnd += 1;
		next = lines[pStart .. pEnd];
	} while (size(next) >= max);
	
	return retval;
}

int getDuplicationCount(list[str] partitions) {
	lrel[str keys, int values] dist = toList(distribution(partitions));
	
	return sum([(i - 1) * 6 | i <- dist.values]);
}

real calcDuplicationPercentage(list[loc] files) {
	list[list[str]] cleaned = [clean(f) | f <- files];
	int fullCount = sum([size(c) | c <- cleaned]);
	list[str] ps = ([] | it + partition(c) | c <- cleaned);
	int dcount = getDuplicationCount(ps);
	return 100 * ((dcount / (toReal(fullCount))));
}
}