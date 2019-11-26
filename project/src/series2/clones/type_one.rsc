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
	if(nodeToAdd in bucket) {
		println("=============================================================================================");
		println("Node already in subtree");
		println(location);
		println("=============================================================================================");
		bucket[nodeToAdd] += <nodeToAdd, location>;
	} else {
		println("=============================================================================================");	
		println("Node not yet in subtree");
		println(location);	
		// Create a new entry in the bucket
		bucket[nodeToAdd] = [<nodeToAdd, location>];
		println("=============================================================================================");		
	}
	return bucket;
}