module series2::clones::type_two

import series2::node_utils;

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
	firstNormalized = normalize(first);
	secondNormalized = normalize(second);
	
 	if(calculateSimilarity(firstNormalized, secondNormalized) == 1.0) {
 		return true;
 	} 
 	
	return false;
}
