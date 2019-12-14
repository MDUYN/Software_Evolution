module series2::clones::tests::type_one_test

import List;
import Map;
import lang::java::m3::AST;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

import series2::node_utils;
import series2::clones::type_one;
import series2::clones::detection;

test bool testDetection() {
	set[Declaration] asts = createAstsFromEclipseProject(|project://clonesTest|, true);

 	map[node, list[node]] clones = detect(|project://clonesTest|, asts, 30, addToBucketTypeOne, isCloneFunctionTypeOne, removeSubtreeNodesFunctionTypeOne);
	
	list[node] classes = getCloneClasses(clones);
	
	// There should be 3 clone classes and for each clone class 2 clones
	bool checkOne = (size(clones) == 1);
	bool checkTwo = true;
	
	// Each clone should atleast contain two clones
	for(class <- classes) {
		
		if(size(clones[class]) != 2) {
			checkTwo = false;
		}
	}
	
	return (checkOne && checkTwo);
}

