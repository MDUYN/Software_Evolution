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