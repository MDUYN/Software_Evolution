module series2::clones::type_one

import series2::node_utils;
import List;

/**
* That will add a Node to the bucket
*/
public map[node, list[node]] addToBucketTypeOne(node nodeToAdd, map[node,list[node]] buckets) {	
		
	// Remove attributes refering to location of the source
	node x = removeDeclarationAttributes(nodeToAdd);
		
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
* Function that checks if two given nodes are type one clones
*/
public bool isCloneFunctionTypeOne(node first, node second) {
 
	firstNormalized = removeDeclarationAttributes(first);
	secondNormalized = removeDeclarationAttributes(second);
	
	// Similarity should be 1.0 in order to let it be a type one clone
 	if(calculateSimilarity(firstNormalized, secondNormalized) == 1.0) {
 		return true;
 	} 
 	
	return false;
}

/*
* Function to remove subtree nodes for type one clones
*/ 
public map[node, list[node]] removeSubtreeNodesFunctionTypeOne(map[node, list[node]] clonesRegistry, node n, int massThreshold) {
	map[node, list[node]] newClonesRegistry = ();
	
	visit(n) {
		case node subNode : {
			
			// Skip "child nodes" which are the same as the parent and skip nodes below mass threshold			
			if(n != subNode && getMassOfNode(subNode) >= massThreshold) {
			
				// Remove attributes refering to location of the source
				x = removeDeclarationAttributes(subNode);
	
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

