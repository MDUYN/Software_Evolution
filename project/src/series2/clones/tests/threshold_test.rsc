module series2::clones::tests::threshold_test

import List;
import utils;
import lang::java::m3::AST;

test bool testMassThreshold() {
	int massThreshold = 30;
	list[loc] locations = [];	
	loc fileLocation = |project://clonesTest/src/clonesTest/Mass.java|;
	
	visit (createAstFromFile(fileLocation, true)) {
		case node x: {
 			
			if(getMassOfNode(x) >= massThreshold) {
				loc location = getLocationOfNode(x);
	
				// The location of the node should not be the project itself
				if(location == fileLocation) {
					return;
				}
				
				locations += location;
				
			}			
		}
	}
	
	return (size(locations) == 7);
}
