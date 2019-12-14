module series2::clones::type_three

import IO;
import series2::node_utils;
import List;
 
/**
* That will add a Node to the bucket, based on the type two clone definition
*/
public map[node, list[node]] addToBucketTypeThree(node nodeToAdd, map[node, list[node]] buckets) {	
	
	// Remove attributes refering to location of the source
	x = removeDeclarationAttributes(nodeToAdd);
	
	// Normalize node
	x = normalizeNode(x);

	println(getLocationOfNode(nodeToAdd));
	println(x);
	
	list[node] matches = [];
	
	for(class <- buckets) {
		
		// Check if the node matches with the class
		if(calculateSimilarity(class, x) >= 0.8) {		
			matches += class;
		}
	}
	
	println("matches");
	println(size(matches));
	
	if(size(matches) == 0) {
		buckets[x] = [nodeToAdd];
	} else {
		
		sortedCloneClasses = sort(matches, bool(node a, node b){ 
			return getMassOfNode(b) < getMassOfNode(a); 
		});
		 
		buckets[sortedCloneClasses[0]] += nodeToAdd;
	}
	return buckets;
}


/*
* Function that checks if two given nodes are type two clones
*/
public bool isCloneFunctionTypeThree(node first, node second) {
	
	firstNormalized = removeDeclarationAttributes(first);
	secondNormalized = removeDeclarationAttributes(second);
	firstNormalized = normalizeNode(firstNormalized);
	secondNormalized = normalizeNode(secondNormalized);
	
 	if(calculateSimilarity(firstNormalized, secondNormalized) >= 0.8) {
 		return true;
 	} 
	
	return false;
}

/*
* Function to remove subtree nodes for type two clones
*/ 
public map[node, list[node]] removeSubtreeNodesFunctionTypeThree(map[node, list[node]] clonesRegistry, node n, int massThreshold) {
	map[node, list[node]] newClonesRegistry = ();
	
	visit(n) {
		case node subNode : {
			
			// Skip "child nodes" which are the same as the parent and skip nodes below mass threshold			
			if(n != subNode && getMassOfNode(subNode) >= massThreshold) {
			
				// Remove attributes refering to location of the source
				x = removeDeclarationAttributes(subNode);
	
				// Normalize node
				x = normalizeNode(x);
	 
	 			// Check if subnode is already in list
				if(x in clonesRegistry) {
					nodes = clonesRegistry[x];
					
					// Remove subnode
					if(subNode in nodes) {
						nodes = delete(nodes, indexOf(nodes, subNode));
					}	
					clonesRegistry[x] = nodes;
				}
			}
		}
	}
	
	// Removing empty keys	
	for(class <- clonesRegistry) {
		
		if(size(clonesRegistry[class]) >= 2) {
			newClonesRegistry[class] = clonesRegistry[class];
		}
	}
	
	return newClonesRegistry;
}
