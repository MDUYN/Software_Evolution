module series2::clones::detection

import List;
import IO;
import Map;
import lang::java::m3::AST;
import lang::java::jdt::m3::Core;

import series2::AstHelperFunctions;
import utils;

public lrel[node fst, node snd] detect(
	loc project, 
	int nodeMassThreshold, 
	map[int, lrel[node, loc]] (node, map[int, lrel[node, loc]]) addToBucketFunction, 
	bool (tuple[node,loc], tuple[node,loc]) isCloneFunction
	) {
	map[int, lrel[node, loc]] buckets = (); 
	lrel[tuple[node,loc],tuple[node,loc]] clones = [];
	
	visit(getDeclarations(createM3FromEclipseProject(project))) {
		
		case node x: {			
	
			// The location of the node should not be the project itself
			if(getLocationOfNode(x) == project) {
				return;
			}
			
			// Check the mass of the node
			if (getMassOfNode(x) > nodeMassThreshold) {	
			
				// Adding the node to the bucket
				buckets = addToBucketFunction(x, buckets); 
			}
		}	
	}
	
	for(bucket <- buckets) {
		
		lrel[node x, loc location] nodes = buckets[bucket];
		
		if(size(nodes) >= 2) {
		
			// Create a list of nodes by pairing them 
		 	lrel[tuple[node x, loc location] first, tuple[node x, loc location] second] nodePairsList = [<a, b> | a <- nodes, b <- nodes, a.location != b.location];
			
			// Remove all symmetric pairs
			nodePairsList = removeSymmetricPairs(nodePairsList);
			
			for(pair <- nodePairsList) {
				if(isCloneFunction(pair.first, pair.second)) {
					println("found a clone");
				}
			}	
		}
	}
	return null;
}

private lrel[tuple[node,loc], tuple[node,loc]] removeSymmetricPairs(lrel[tuple[node, loc] first, tuple[node ,loc] second] nodes) {
	lrel[tuple[node,loc],tuple[node,loc]] filteredPairs = [];
	
	
	for (pair <- nodes) {
		tuple[tuple[node,loc],tuple[node,loc]] reverse = <<pair[1][0],pair[1][1]>,<pair[0][0],pair[0][1]>>;
		
		if (reverse notin filteredPairs) {		
			filteredPairs += pair;
		}
	}
	
	return filteredPairs;
}
 
