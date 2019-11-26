module series2::clones::type_one

import List;
import IO;
import Map;
import Loc;

map[node, lrel[node, loc]] addToBucket(node d, loc projectLocation, map[node, lrel[node, loc]] bucket) {	
	loc location = getLocationOfNode(subTree);
	
	// The location of the node should not be the project itself
	if(location == projectLocation) {
		return;
	}

}