module series2::clones::tests::AstHelperFunctionTests

import series2::clones::tests::TestFunctions;
import series2::AstHelperFunctions;

import lang::java::m3::AST;
import lang::java::jdt::m3::Core;

test bool normalisationTest() {
	Expression a = \simpleName("a");
	Expression b = \simpleName("b");
	Expression q = \simpleName("q");
	
	Expression ab = \infix(a, "+", b);
	Expression ba = \infix(b, "+", a);
	Expression expected = \infix(q, "+", q);
	
	for(ex <- [ab,ba]) {
		node actual = normaliseLeaf(ex);
		assertion(actual,expected);
	}
	
	return true; 
}