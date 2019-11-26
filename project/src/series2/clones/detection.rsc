module series2::clones::detection

import List;
import IO;
import Map;
import lang::java::m3::AST;
import lang::java::jdt::m3::Core;

import utils;

public lrel[node fst, node snd] detect(loc project, map[node, lrel[node, loc]] (node, loc, map[node, lrel[node, loc]]) addToBucketFunction) {
	int massThreshold = 25;
	
	M3 model = createM3FromEclipseProject(project);
	map[node, lrel[node, loc]] bucket = (); 
	
	list[Declaration] declarations = getDeclarations(model);
	
	visit(declarations) {
		case node subtree: {			
			int mass = getMassOfNode(subtree);
			
			if (mass > massThreshold) {
				
				// Adding the subtree to the bucket
				bucket = addToBucketFunction(subtree, project, bucket); 
			}
		}	
	}
	println(size(bucket));
	return null;
}

public int getMassOfNode(node x) {
	int mass = 0;
	
	visit(x) {
		case node subNode: { 
			mass += 1; 
		}
	}
	return mass;
}
