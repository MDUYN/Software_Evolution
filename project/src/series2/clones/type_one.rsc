module series2::clones::type_one

import List;
import IO;
import Map;

import utils;

map[node, lrel[node, loc]] addToBucketTypeOne(node nodeToAdd, loc projectLocation, map[node, lrel[node, loc]] bucket) {	
	loc location = getLocationOfNode(nodeToAdd);
	
	// The location of the node should not be the project itself
	if(location == projectLocation) {
		return;
	}
	
	// Check if the key is already in the bucket
	if(bucket[nodeToAdd]?) {
		bucket[nodeToAdd] += <nodeToAdd, location>;
	} else {	
		// Create a new entry in the bucket
		bucket[nodeToAdd] = [<nodeToAdd, location>];
	}
	return bucket;
}