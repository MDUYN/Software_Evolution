module series2::clones::detection

import List;
import IO;
import Map;
import lang::java::m3::AST;


public lrel[node fst, node snd] detect(list[Declaration] declarations, map[node, list[node]] (Node) addToBucketFunction) {
	int massThreshold = 25;
	
	map[node, list[node]] bucket = ();
	
	visit(declarations) {
		case node subtree: {			
			int mass = getMassOfNode(subtree);
			
			if (mass > massThreshold) {
				
				// Adding the subtree to the bucket
				
			}
		}	
	}
	return null;
}

public int getMassOfNode(node x) {
	int mass = 0;
	
	visit(x) {
		case node subNode: { 
			mass += 1; 
		}
	}
	return mass;
}
