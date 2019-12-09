module series2::clones::tests::simularity_test

import series2::node_utils;
import Node;

public test bool testSimilarity() {
	node node1 = makeNode("node1", "321");
	node node2 = makeNode("node2", "123");
	
	if (calculateSimilarity(node1, node2) == 0) {
		return true;
	}
	
	return false;
}

public test bool testSimilarityTwo() {
	node theOnlyNode = makeNode("theOnlyNode", "1337");
	
	if (calculateSimilarity(theOnlyNode, theOnlyNode) == 1) {
		return true;
	}
	
	return false;
}
