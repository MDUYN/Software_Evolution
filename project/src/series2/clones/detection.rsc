module series2::clones::detection

import List;
import IO;
import Map;
import lang::java::m3::AST;
import lang::java::jdt::m3::Core;

import utils;

public lrel[node fst, node snd] detect(loc project, map[int, lrel[node, loc]] (node, map[int, lrel[node, loc]]) addToBucketFunction) {
	int massThreshold = 10;
	
	M3 model = createM3FromEclipseProject(project);
	map[int, lrel[node, loc]] buckets = (); 
	list[Declaration] declarations = getDeclarations(model);
	
	visit(declarations) {
		case node x: {			
	
			// The location of the node should not be the project itself
			if(getLocationOfNode(x) == project) {
				return;
			}
			
			int mass = getMassOfNode(x);
			
			if (mass > massThreshold) {	
				// Adding the subtree to the bucket
				buckets = addToBucketFunction(x, buckets); 
			}
		}	
	}
	return null;
}