module series2::clones::type_one

import List;
import IO;
import Map;

import series2::AstHelperFunctions;
import utils;

/**
* That will add a Node to the bucket
*/
public map[node, lrel[node, loc]] addToBucketTypeOne(node nodeToAdd, map[node, lrel[node, loc]] buckets) {	
	
	loc location = getLocationOfNode(nodeToAdd);
	
	// Remove attributes refering to location of the source
	node x = removeDeclarationAttributes(nodeToAdd);
		
	// Check if the key is already in the bucket
	if(x in buckets) {
		buckets[x] += <nodeToAdd, location>;
	} else {		
		// Create a new entry in the bucket
		buckets[x] = [<nodeToAdd, location>];
	}
	return buckets;
}

/*
* Function that checks if two given nodes are type one clones
*/
public bool isCloneFunctionTypeOne(tuple[node x, loc location] first, tuple[node x, loc location] second) {
	
 	if(calculateSimilarity(first.x, second.x) == 1.0) {
 		return true;
 	} 
 	
	return false;
}
