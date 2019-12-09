module series2::clones::tests::type_two_test

import List;
import Map;
import lang::java::m3::AST;
import series2::node_utils;
import series2::clones::type_two;
import series2::clones::detection;
 
test bool testDetection() {
 	map[node, list[node]] clones = detect(|project://clonesTest|, 30, addToBucketTypeTwo, isCloneFunctionTypeTwo, removeSubtreeNodesFunctionTypeTwo);
	
	classes = getCloneClasses(clones);
		
	// There should be 2 clone classes and for each clone class 2 clones
	bool checkOne = (size(clones) == 2);
	bool checkTwo = true;
	
 	// Each clone should atleast contain two clones	
	for(class <- classes) {
			
		if(size(clones[class]) != 2) {
			checkTwo = false;
		}
	}
	
	return (checkOne && checkTwo);
}
