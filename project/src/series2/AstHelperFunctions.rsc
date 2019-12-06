module series2::AstHelperFunctions

import lang::java::m3::AST;
import lang::java::jdt::m3::Core;
import Node;

list[node] normaliseLeaves(list[node] ast){
	return visit(ast) {
		case x => normaliseLeaf(x)
	}
}

node normaliseLeaf(node n) {
	return visit(n) {
		case \characterLiteral(_) => \characterLiteral("q")
		case \fieldAccess(b, e, _) => \fieldAccess(b, e, "q")
		case \fieldAccess(b, _) => \fieldAccess(b, "q")
		case \methodCall(b, _, a) => \methodCall(b, "q", a)
		case \methodCall(b, r, _, a) => \methodCall(b, r, "q", a)
		case \number(_) => \number("1")
		case \booleanLiteral(_) => \booleanLiteral(true)
		case \stringLiteral(_) => \stringLiteral("foo")
		case \variable(_, d) => \variable("q", d)
		case \variable(_, d, e) => \variable("q", d, e)
		case \postfix(e, _) => \postfix(e, "+")
		case \prefix(_, e) => \prefix("+", e)
		case \simpleName(_) => \simpleName("q")
		case \memberValuePair(_, e) => \memberValuePair("q", e)
	}
}

/*
* This function remove all key word parameters attributes that refer to the location of a node.
* This function is usefull when comparing nodes, because otherwise they are seen as different.
*/ 
public node removeDeclarationAttributes(node n) {
	return unsetRec(n);
}

public num calculateSimilarity(node first, node second) {
	//Similarity = 2 x S / (2 x S + L + R)
		
	list[node] firstNodes = [];
	list[node] secondNodes = [];
	num s = 0;
	num l = 0;
	num r = 0;
	
	//Remove all keyword parameters attributes that refer to the location of a node.
	a = removeDeclarationAttributes(first);
	b = removeDeclarationAttributes(second);
	
	for(x <- firstNodes) {
 	 	
 	 	// Both contain the subnode
		if(x in secondNodes) {
			s += 1;
		} else {
		
			// Only the first node has the subnode
			l += 1;
		}
	}
	
	for(x <- secondNodes) {
		
		// Only the second node has the subnode
		if(x notin secondNodes) {
			r += 1;
		}
	}	
	
	return (2 * s) / (2 * s + l + r);
}
