module series2::clones::tests::clone_type_one_test

import IO;
import List;
import Map;
import lang::java::m3::AST;

import series2::clones::type_one;
import series2::clones::detection;


test bool testAddToBucketTypeOne() {
	int massThreshold = 5;
	loc fileLocation = |project://series2Test/src/series2Test/CloneOne.java|;
	Declaration declaration = createAstFromFile(fileLocation, true);
	
	map[node, lrel[node, loc]] bucket = (); 
	
	visit(declaration) {
		case node subtree: {
			int currentMass = getMassOfNode(subtree);	
			
			if(currentMass >= massThreshold) {
				// Adding the subtree to the bucket
				bucket = addToBucketTypeOne(subtree, fileLocation, bucket); 
			}
		}	
	}
	
	return true;
}