module series2::clones::detection

import List;
import Map;
import lang::java::m3::AST;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

import series2::node_utils;
import utils;

public map[node, list[node]] detect(loc project, int nodeMassThreshold, map[node, list[node]] (node, map[node, list[node]]) addToBucketFunction, bool (node, node) isCloneFunction, map[node, list[node]] (map[node, list[node]] clonesRegistry, node n, int massThreshold) removeSubtreeNodesFunction){
 
	map[node, list[node]] buckets = (); 
	map[node, list[node]] clonesRegistry = ();
	
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
		
		list[node] nodes = buckets[key];
		
		// Atleast two nodes in a bucket
		if(size(nodes) >= 2) {
			
			// Create a list of nodes by pairing them 
		 	lrel[node first, node second] nodePairsList = [<a, b> | a <- nodes, b <- nodes, getLocationOfNode(a) != getLocationOfNode(b)];
			
			// Remove all symmetric pairs, because otherwise we will duplicate clone pairs
			nodePairsList = removeSymmetricPairs(nodePairsList);			
									
			for(pair <- nodePairsList) {
				
				if(isCloneFunction(pair.first, pair.second)) {
					
					// Make new entry in the clones registry if needed
					if(!(key in clonesRegistry)) {
						clonesRegistry[key] = [];
					}
					
					// Add the clones
					clonesRegistry[key] = addToClones(pair.first, clonesRegistry[key]);
					clonesRegistry[key] = addToClones(pair.second, clonesRegistry[key]);
				}
			}	
		}
	}
	
	//Sort all the keys for the removal of subclones, otherwise the sorting doesn't work
	//Larger nodes need to be on front
	cloneClasses = getCloneClasses(clonesRegistry);
	
	sortedCloneClasses = sort(cloneClasses, bool(node a, node b){ 
			return getMassOfNode(b) > getMassOfNode(a); 
		}
	);
	
	
	for(class <- sortedCloneClasses) {
		
		// Get all the nodes in the entry
		nodes = clonesRegistry[class];
	
		for(x <- nodes) {
			clonesRegistry = removeSubtreeNodesFunction(clonesRegistry, x, nodeMassThreshold);
		}
	}
	
	return clonesRegistry;
}


/*
* Function that remove symmetric pairs of nodes e.g. [(a,b), (b,a)] = [(a,b)]
*/
private lrel[node first, node second] removeSymmetricPairs(lrel[node first, node second] nodes) {
	lrel[node, node] filteredPairs = [];
	
	for (pair <- nodes) {
		tuple[node, node] reverse = <pair.second, pair.first>;
		
		if (reverse notin filteredPairs) {		
			filteredPairs += pair;
		}
	}
	
	return filteredPairs;
}

public list[node] addToClones(node n, list[node] clones) {
	
	if(n in clones) {
		return clones;	
	}
	else {
		clones += n;
		return clones; 
	}
}

public list[node] getCloneClasses(map[node, list[node]] clonesRegistry) {
	list[node] classes = [];
	
	for(class <- clonesRegistry) {
		classes += class;
	}
	
	return classes;
}