module series2::clones::tests::clone_type_one_test

import List;
import Map;
import lang::java::m3::AST;

import series2::clones::type_one;
import series2::clones::detection;
import utils;

test bool testAddToBucketFunctions() {
 	map[node, list[node]] clones = detect(|project://clonesTest/src/clonesTest/TypeOne.java|, 30, addToBucketTypeOne, isCloneFunctionTypeOne);
	
	classes = getCloneClasses(clones);
	
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

