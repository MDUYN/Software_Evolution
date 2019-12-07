module series2::clones::detection

import List;
import Map;
import lang::java::m3::AST;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

import series2::AstHelperFunctions;
import utils;

public map[node, list[node]] detect(loc project, int nodeMassThreshold, map[node, list[node]] (node, map[node, list[node]]) addToBucketFunction, bool (node, node) isCloneFunction){
	map[node, list[node]] buckets = (); 
	map[node, list[node]] cloneClasses = ();
	
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
					
					if(key in cloneClasses) {
						cloneClasses[key] += [pair.first, pair.second];
					} else {
						cloneClasses[key] = [pair.first, pair.second];
					}
					
					cloneClasses = removeSubtreeClones(cloneClasses, pair.first, nodeMassThreshold);
					cloneClasses = removeSubtreeClones(cloneClasses, pair.second, nodeMassThreshold);
				}
			}	
		}
	}
	return cloneClasses;
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

public list[node] getCloneClasses(map[node, list[node]] clones) {
	list[node] classes = [];
	
	for(class <- clones) {
		classes += class;
	}
	
	return classes;
}

// Function to remove subnodes in de clones, because you only want the biggest clones
private map[node, list[node]] removeSubtreeClones(map[node, list[node]] clones, node n, int massThreshold){
	
	map[node, list[node]] newCloneClasses = ();
	
	visit(n) {
		case node subNode : {
			
			// Skip "child nodes" which are the same as the parent and skip nodes below mass threshold
			// second statement is to disable optimisation for testing purposes.
			
			if(getMassOfNode(subNode) >= massThreshold && n != subNode) {
				
				for(class <- clones) {
					
					nodes = clones[class];
					
					if(subNode in nodes) {
						nodes = delete(nodes, indexOf(nodes, subNode));
					}						
					clones[class] = nodes;
				}
			}
		}
	}
	
	// Removing empty keys	
	for(class <- clones) {
		
		if(size(clones[class]) >= 2) {
			newCloneClasses[class] = clones[class];
		}
	}
	
	return newCloneClasses;
}