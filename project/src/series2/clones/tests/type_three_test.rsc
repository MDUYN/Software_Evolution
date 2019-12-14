module series2::clones::tests::type_three_test

import IO;
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
	println(size(classes));
		
	// There should be 2 clone classes and for each clone class 2 clones
	bool checkOne = (size(clones) == 2);
	bool checkTwo = true;
	
 	// Each clone should atleast contain two clones	
	for(class <- classes) {
		
		println("class");
		println(class);
		println("=======================================");
		if(size(clones[class]) != 2) {
			checkTwo = false;
		}
		
		println("*******************");				
		for(x <- clones[class]) {
			println(getLocationOfNode(x));
			
		}
		println("*******************");
		
		println("=======================================");
		
	}
	
	return (checkOne && checkTwo);
}
 