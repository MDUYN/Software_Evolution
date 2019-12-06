module series2::clones::detection

import List;
import IO;
import Map;
import lang::java::m3::AST;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import Node;

import series2::AstHelperFunctions;
import utils;

public map[node, list[tuple[node, loc]]] detect(
	loc project, 
	int nodeMassThreshold, 
	map[node, lrel[node, loc]] (node, map[node, lrel[node, loc]]) addToBucketFunction, 
	bool (tuple[node,loc], tuple[node,loc]) isCloneFunction
	) {
	map[node, lrel[node, loc]] buckets = (); 
	lrel[tuple[node,loc],tuple[node,loc]] clones = [];
	map[node, list[tuple[node, loc]]] cloneClasses = ();
	
	
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
	
	for(key <- buckets) {
		
		lrel[node x, loc location] nodes = buckets[key];
		
		// Atleast two nodes in a bucket
		if(size(nodes) >= 2) {
		
			// Create a list of nodes by pairing them 
		 	lrel[tuple[node x, loc location] first, tuple[node x, loc location] second] nodePairsList = [<a, b> | a <- nodes, b <- nodes, a.location != b.location];
			
			// Remove all symmetric pairs, because otherwise we will duplicate clone pairs
			nodePairsList = removeSymmetricPairs(nodePairsList);
						
			for(pair <- nodePairsList) {
				if(isCloneFunction(pair.first, pair.second)) {
				
					if(key in cloneClasses) {
						cloneClasses[key] += [pair.first, pair.second];
					} else {
						cloneClasses[key] = [pair.first, pair.second];
					}
				}
			}	
		}
	}
	return cloneClasses;
}


/*
* Function that remove symmetric pairs of nodes e.g. [(a,b), (b,a)] = [(a,b)]
*/
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


public void printCloneClasses(map[node, list[tuple[node, loc]]] clones) {
	
	for(class <- clones) {	
		println("====================================");
		println(class);
		println("====================================");
	}
}
