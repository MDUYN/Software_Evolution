module series2::clones::tests::type_three_test

import List;
import Map;
import lang::java::m3::AST;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import series2::node_utils;
import series2::clones::type_three;
import series2::clones::detection;
 
test bool testDetection() {
	set[Declaration] asts = createAstsFromEclipseProject(|project://clonesTest|, true);

 	map[node, list[node]] clones = detect(|project://clonesTest|, asts, 30, addToBucketTypeThree, isCloneFunctionTypeThree, removeSubtreeNodesFunctionTypeThree);

	list[node] classes = getCloneClasses(clones);
		
	// There should be 2 clone classes and for each clone class 2 clones
	bool checkOne = (size(clones) == 3);
	bool checkTwo = true;
	
 	// Each clone should atleast contain two clones	
	for(class <- classes) {
		
		if(size(clones[class]) != 2) {
			checkTwo = false;
		}
	}
	
	return (checkOne && checkTwo);
}
 