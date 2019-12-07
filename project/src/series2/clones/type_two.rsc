module series2::clones::type_two

import series2::AstHelperFunctions;
import utils;

/**
* That will add a Node to the bucket, based on the type two clone definition
*/
public map[node, lrel[node, loc]] addToBucketTypeTwo(node nodeToAdd, map[node, lrel[node, loc]] buckets) {	
	
	loc location = getLocationOfNode(nodeToAdd);
	
	// Remove attributes refering to location of the source
	x = removeDeclarationAttributes(nodeToAdd);
	
	// Normalize node
	x = normalizeNode(x);
		
	// Check if the key is already in the bucket
	if(x in buckets) {
		buckets[x] += <x, location>;
	} else {		
		// Create a new entry in the bucket
		buckets[x] = [<x, location>];		
	}
	return buckets;
}

/*
* Function that checks if two given nodes are type two clones
*/
public bool isCloneFunctionTypeTwo(tuple[node x, loc location] first, tuple[node x, loc location] second) {
	
 	if(calculateSimilarity(first.x, second.x) == 1.0) {
 		return true;
 	} 
 	
	return false;
}
