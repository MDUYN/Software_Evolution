module series0::problems::problem2

import IO;
import Set;
import List;
import Map;

import lang::java::m3::Core;
import lang::java::m3::AST;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

map[str, int] variableOccurences(list[Declaration] asts){
	map[str, int] wc = ();
	visit(asts){
		case \fieldAccess(_, _, name): if(name in wc) wc[name] = wc[name] + 1; else wc[name] = 1;
    	case \fieldAccess(_, name): if(name in wc) wc[name] = wc[name] + 1; else wc[name] = 1;
		case \variable(name, _): if(name in wc) wc[name] = wc[name] + 1; else wc[name] = 1;
    	case \variable(name, _, _): if(name in wc) wc[name] = wc[name] + 1; else wc[name] = 1;
    	case \simpleName(name): if(/^<letter:[a-z]><rest:.*$>/ := name){ if(name in wc) wc[name] = wc[name] + 1; else wc[name] = 1;}
    	case \memberValuePair(name, _): if(name in wc) wc[name] = wc[name] + 1; else wc[name] = 1;
    	case \vararg(_, name): if(name in wc) wc[name] = wc[name] + 1; else wc[name] = 1;
    	case \parameter(_, name, _): if(name in wc) wc[name] = wc[name] + 1; else wc[name] = 1;
    	case \annotationTypeMember(_, name): if(name in wc) wc[name] = wc[name] + 1; else wc[name] = 1;
    	case \annotationTypeMember(_, name, _): if(name in wc) wc[name] = wc[name] + 1; else wc[name] = 1;
	}
	return wc;
}

tuple[int, list[str]] findMostUsed(list[Declaration] asts, map[str, int] varCount){
	int highest = 0;
	list[str] vars = [];
	for(str varName <- varCount){
		int count = varCount[varName];
		if(count > highest){
			highest = count;
			vars = [varName];
		} else if(count == highest){
			vars += varName;
		}
	}
	return <highest, vars>;
}

tuple[int, list[str]] findMostUsed(list[Declaration] asts, map[str, int] (list[Declaration]) countFunction){
	map[str, int] varCount = countFunction(asts);
	return findMostUsed(asts, varCount);
}