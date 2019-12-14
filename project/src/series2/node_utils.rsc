module series2::node_utils

import List;
import lang::java::m3::AST;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
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

//public node normalizeNode(node n) {
//	return visit (n) {
//		case \method(x, _, y, z, q) => \method(lang::java::jdt::m3::AST::short(), "methodName", y, z, q)
//		case \method(x, _, y, z) => \method(lang::java::jdt::m3::AST::short(), "methodName", y, z)
//		case \parameter(x, _, z) => \parameter(x, "paramName", z)
//		case \vararg(x, _) => \vararg(x, "varArgName")
//		case \annotationType(_, list[Declaration] body) => \annotationType("at", body) 
//		case \annotationTypeMember(x, _) => \annotationTypeMember(x, "annonName")
//		case \annotationTypeMember(x, _, y) => \annotationTypeMember(x, "annonName", y)
//		case \typeParameter(_, x) => \typeParameter("typeParaName", x)
//		case \constructor(_, x, y, z) => \constructor("constructorName", x, y, z)
//		case \interface(_, x, y, z) => \interface("interfaceName", x, y, z)
//		case \class(_, x, y, z) => \class("className", x, y, z)
//		case \enumConstant(_, y) => \enumConstant("enumName", y) 
//		case \enumConstant(_, y, z) => \enumConstant("enumName", y, z)
//		case \methodCall(x, _, z) => \methodCall(x, "methodCall", z)
//		case \methodCall(x, y, _, z) => \methodCall(x, y, "methodCall", z) 
//		case Type _ => lang::java::jdt::m3::AST::short()
//		case Modifier _ => lang::java::jdt::m3::AST::\private()
//		case \simpleName(_) => \simpleName("simpleName")
//		case \number(_) => \number("1337")
//		case \variable(x,y) => \variable("variableName",y) 
//		case \variable(x,y,z) => \variable("variableName",y,z) 
//		case \booleanLiteral(_) => \booleanLiteral(true)
//		case \stringLiteral(_) => \stringLiteral("StringLiteralThingy")
//		case \characterLiteral(_) => \characterLiteral("q")
//		case \fieldAccess(bool isSuper, Expression expression, _) => \fieldAccess(isSuper, expression, "fac")
//		case \fieldAccess(bool isSuper, _) => \fieldAccess(isSuper, "fac")
//		case \markerAnnotation(_) => \markerAnnotation("markerAnnotation")
//		case \normalAnnotation(_,  memberValuePairs) => \normalAnnotation("normalAnnotation",  memberValuePairs)
//		case \memberValuePair(_, Expression \value) => \memberValuePair("membervp", \value)            
//		case \singleMemberAnnotation(_, Expression \value) => \singleMemberAnnotation("singlema", \value)
//		case \break(_) => \break("brexit")
//		case \continue(_) => \continue("continue")
//		case \label(_, Statement body) => \label("labelname", body)
//		case \simpleName(_) => simpleName("simpleName")
//    	case \int() => double()
//    	case short() => double()
//    	case long() => double()
//    	case float() => double()
//    	case double() => double()
//    	case char() => double()
//    	case string() => double()
//    	case byte() => double()
//    	case \boolean() => double()
//	}
//}


/* 
* Funtion that normalizes node, make sure you remove all the declarations before passing it to this function
*/ 
public node normalizeNode(node n) {

	return visit(n) {
		case \method(x, _, y, z, q) => \method(lang::java::jdt::m3::AST::short(), "methodName", y, z, q)
		case \method(x, _, y, z) => \method(lang::java::jdt::m3::AST::short(), "methodName", y, z)
		case \parameter(x, _, z) => \parameter(x, "paramName", z)
		case \vararg(x, _) => \vararg(x, "varArgName") 
		case \annotationTypeMember(x, _) => \annotationTypeMember(x, "annonName")
		case \annotationTypeMember(x, _, y) => \annotationTypeMember(x, "annonName", y)
		case \typeParameter(_, x) => \typeParameter("typeParaName", x)
		case \constructor(_, x, y, z) => \constructor("constructorName", x, y, z)
		case \interface(_, x, y, z) => \interface("interfaceName", x, y, z)
		case \class(_, x, y, z) => \class("className", x, y, z)
		case \enumConstant(_, y) => \enumConstant("enumName", y) 
		case \enumConstant(_, y, z) => \enumConstant("enumName", y, z)
		case \methodCall(x, _, z) => \methodCall(x, "methodCall", z)
		case \methodCall(x, y, _, z) => \methodCall(x, y, "methodCall", z) 
		case Type _ => lang::java::jdt::m3::AST::short()
		case Modifier _ => lang::java::jdt::m3::AST::\private()
		case \simpleName(_) => \simpleName("simpleName")
		case \number(_) => \number("1337")
		case \variable(x,y) => \variable("variableName",y) 
		case \variable(x,y,z) => \variable("variableName",y,z) 
		case \booleanLiteral(_) => \booleanLiteral(true)
		case \stringLiteral(_) => \stringLiteral("StringLiteralThingy")
		case \characterLiteral(_) => \characterLiteral("q")
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
	
 	firstNodes = getSubNodes(first);
 	secondNodes = getSubNodes(second);
		
	for(x <- firstNodes) {
 	 	
 	 	// Both contain the subnode
		if(x in secondNodes) {
			s += 1;
		} 
	}
	
	l = size(firstNodes) - s;
	r = size(secondNodes) - s;

	return (2 * s) / (2 * (s + l + r));
}


/*
* Get subnodes returns all the sub nodes from a given root node
*/
public list[node] getSubNodes(node n) {
	list[node] nodes = [];

	visit(n) {
		case node subNode: { 
			nodes += subNode; 
		}
	}
	return nodes;	
}

public int getMassOfNode(node x) {
	return size(getSubNodes(x));
}

public loc getLocationOfNode(node n) {
	
	if (Declaration d := n) {
		return d.src;
	} else if (Expression e := n) {
		return e.src;
	} else if (Statement s := n) {
		return s.src;
	}
	return |unknown:///|;
}


