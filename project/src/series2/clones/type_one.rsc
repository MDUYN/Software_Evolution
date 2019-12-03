module series2::clones::type_one

import List;
import IO;
import Map;

import utils;

/**
* That will add a Node to the bucket
*/
public map[int, lrel[node, loc]] addToBucketTypeOne(node nodeToAdd, map[int, lrel[node, loc]] buckets) {	
	
	loc location = getLocationOfNode(nodeToAdd);
	int mass = getMassOfNode(nodeToAdd);
	
	// Check if the key is already in the bucket
	if(mass in buckets) {
		buckets[mass] += <nodeToAdd, location>;
	} else {	
		// Create a new entry in the bucket
		buckets[mass] = [<nodeToAdd, location>];
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
