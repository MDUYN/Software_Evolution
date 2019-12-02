module series2::clones::tests::clone_type_one_test

import IO;
import List;
import Map;
import Node;
import lang::java::m3::AST;

import series2::clones::type_one;
import utils;

test bool testAddToBucketFunctions() {
	int massThreshold = 10;
	map[int, lrel[node, loc]] buckets = (); 	
	loc fileLocation = |project://clonesTest/src/clonesTest/TypeOne.java|;
	
	Declaration ast = createAstFromFile(fileLocation, true);

	visit (ast) {
		case node x: {
			int currentMass = getMassOfNode(x);
			
			loc location = getLocationOfNode(x);

			// The location of the node should not be the project itself
			if(location == fileLocation) {
				return;
			}
			
			if (currentMass >= massThreshold) {
				buckets = addToBucketTypeOne(x, buckets);
			}
		}
	}
	
	// There should be 14 entries in the bucket
	return (size(buckets) == 14);
}

