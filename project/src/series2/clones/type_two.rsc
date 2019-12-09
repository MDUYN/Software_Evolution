module series2::clones::type_two

import series2::node_utils;
import List;
 
/**
* That will add a Node to the bucket, based on the type two clone definition
*/
public map[node, list[node]] addToBucketTypeTwo(node nodeToAdd, map[node, list[node]] buckets) {	
	
	// Remove attributes refering to location of the source
	x = removeDeclarationAttributes(nodeToAdd);
	
	// Normalize node
	x = normalizeNode(x);
	 
	// Check if the key is already in the bucket
	if(x in buckets) {
		buckets[x] += nodeToAdd;
	} else {	
		// Create a new entry in the bucket
		buckets[x] = [nodeToAdd];		
	}
	return buckets;
}

/*
* Function that checks if two given nodes are type two clones
*/
public bool isCloneFunctionTypeTwo(node first, node second) {
	
	firstNormalized = removeDeclarationAttributes(first);
	secondNormalized = removeDeclarationAttributes(second);
	firstNormalized = normalizeNode(firstNormalized);
	secondNormalized = normalizeNode(secondNormalized);
	
 	if(calculateSimilarity(firstNormalized, secondNormalized) == 1.0) {
 		return true;
 	} 
 	
	return false;
}

/*
* Function to remove subtree nodes for type two clones
*/ 
public map[node, list[node]] removeSubtreeNodesFunctionTypeTwo(map[node, list[node]] clonesRegistry, node n, int massThreshold) {
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
