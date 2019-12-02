module series2::clones::type_one

import List;
import IO;
import Map;

import utils;

map[int, lrel[node, loc]] addToBucketTypeOne(node nodeToAdd, map[int, lrel[node, loc]] buckets) {	
	
	loc location = getLocationOfNode(nodeToAdd);
	int mass = getMassOfNode(nodeToAdd);
	
	// Check if the key is already in the bucket
	if(nodeToAdd in buckets) {
		buckets[mass] += <nodeToAdd, location>;
	} else {
		// Create a new entry in the bucket
		buckets[mass] = [<nodeToAdd, location>];
	}
	return buckets;
}