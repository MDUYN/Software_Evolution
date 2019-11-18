module series0::problems::problem3

import IO;
import Set;
import List;
import Map;

import lang::java::m3::Core;
import lang::java::m3::AST;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

import problems::problem2;

map[str, int] numberOccurences(list[Declaration] asts){
	map[str, int] cnt = ();
	
	visit(asts){
		case \number(numberValue): if(numberValue in cnt) cnt[numberValue] = cnt[numberValue] + 1; else cnt[numberValue] = 1;
	}
	
	return cnt;
}