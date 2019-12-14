module series2::clones::tests::simularity_test

import Node;
import IO;
import Map;
import List;
import series2::node_utils;
import lang::java::m3::AST;

import series2::node_utils;


public test bool testSimilarityOne() {
	node node1 = makeNode("node1", "321");
	node node2 = makeNode("node2", "123");
	
	if (calculateSimilarity(node1, node2) == 0) {
		return true;
	}
	
	return false;
}

public test bool testSimilarityTwo() {
	node theOnlyNode = makeNode("theOnlyNode", "1337");
	
	if (calculateSimilarity(theOnlyNode, theOnlyNode) == 1) {
		return true;
	}
	
	return false;
}

public bool testSimilarityThree() {
	Declaration declaration = createAstFromFile(|project://clonesTest/src/clonesTest/TypeThree.java|, true);
	list[node] nodes = [];
	map[node, list[node]] buckets = (); 
	map[node, list[node]] clonesRegistry = ();
	
	visit(declaration) {
		
		case node x: {		
			
			if(getMassOfNode(x) > 30) {
				nodes += x;	
				
				buckets = addToBucketTypeThree(x, buckets);
			}
		}	
	}
	
	for(key <- buckets) {
		
		list[node] nodes = buckets[key];
		
		// Atleast two nodes in a bucket
		if(size(nodes) >= 2) {
		
			// Create a list of nodes by pairing them 
		 	lrel[node first, node second] nodePairsList = [<a, b> | a <- nodes, b <- nodes, getLocationOfNode(a) != getLocationOfNode(b)];
			
			// Remove all symmetric pairs, because otherwise we will duplicate clone pairs
			nodePairsList = removeSymmetricPairs(nodePairsList);			
									
			for(pair <- nodePairsList) {
				
				if(isCloneFunctionTypeThree(pair.first, pair.second)) {
					
					// Make new entry in the clones registry if needed
					if(!(key in clonesRegistry)) {
						clonesRegistry[key] = [];
					}
					
					// Add the clones
					clonesRegistry[key] = addToClones(pair.first, clonesRegistry[key]);
					clonesRegistry[key] = addToClones(pair.second, clonesRegistry[key]);
				}
			}
		}
	}
	
	//Sort all the keys for the removal of subclones, otherwise the sorting doesn't work
	//Larger nodes need to be on front
	cloneClasses = getCloneClasses(clonesRegistry);
	
	sortedCloneClasses = sort(cloneClasses, bool(node a, node b){ 
			return getMassOfNode(b) > getMassOfNode(a); 
		}
	);
	
	// Remove smaller subnodes
	for(class <- sortedCloneClasses) {
		
		// Get all the nodes in the entry
		nodes = clonesRegistry[class];
	
		for(x <- nodes) {
			clonesRegistry = removeSubtreeNodesFunctionTypeThree(clonesRegistry, x, 30);
		}
	}
	
	clonesRegistry = removeEmptyClasses(clonesRegistry);
	
	for(class <- clonesRegistry) {
		
		println("Clone class: <class>");
		println("Clones:");
		
		for(x <- clonesRegistry[class]) {
			
			println(getLocationOfNode(x));	
		}
	
	}
		
	return true;
}

public map[node, list[node]] addToBucketTypeThree(node nodeToAdd, map[node, list[node]] buckets) {	
	
	// Remove attributes refering to location of the source
	x = removeDeclarationAttributes(nodeToAdd);
	
	// Normalize node
	x = normalizeNode(x);

	list[node] matches = [];
	
	for(class <- buckets) {
		
		// Check if the node matches with the class
		if(calculateSimilarity(class, x) >= 0.7) {		
			matches += class;
		}
	}
	
	// Make new entry
	if(size(matches) == 0) {
		buckets[x] = [nodeToAdd];
	} else {
		
		// Add the clone to the biggest entry
		sortedCloneClasses = sort(matches, bool(node a, node b){ 
			return getMassOfNode(b) < getMassOfNode(a); 
		});
		 
		buckets[sortedCloneClasses[0]] += nodeToAdd;
	}
	
	// Reorganize buckets 
	return buckets;
}

/*
* Function that remove symmetric pairs of nodes e.g. [(a,b), (b,a)] = [(a,b)]
*/
private lrel[node first, node second] removeSymmetricPairs(lrel[node first, node second] nodes) {
	lrel[node, node] filteredPairs = [];
	
	for (pair <- nodes) {
		tuple[node, node] reverse = <pair.second, pair.first>;
		
		if (reverse notin filteredPairs) {		
			filteredPairs += pair;
		}
	}
	
	return filteredPairs;
}

/*
* Function to remove subtree nodes for type two clones
*/ 
public map[node, list[node]] removeSubtreeNodesFunctionTypeThree(map[node, list[node]] clonesRegistry, node n, int massThreshold) {
	
	visit(n) {
		case node subNode : {
		
 			list[node] matches = [];
			
			// Skip "child nodes" which are the same as the parent and skip nodes below mass threshold			
			if(n != subNode && getMassOfNode(subNode) >= massThreshold) {
								
				// Remove attributes refering to location of the source
				x = removeDeclarationAttributes(subNode);
	
				// Normalize node
				x = normalizeNode(x);
	 			
	
				for(class <- clonesRegistry) {
					
					// Check if the node matches with the class
					if(calculateSimilarity(class, x) >= 0.7) {		
						matches += class;
					}
				}
				
				
				// Check if subnode is already in list
				for(class <- matches) {
				
					nodes = clonesRegistry[class];
					if(subNode in nodes) {
						nodes = delete(nodes, indexOf(nodes, subNode));
						clonesRegistry[class] = nodes;
					}					
				}
			}
		}
	}
	
	return clonesRegistry;
}

/*
* Function that checks if two given nodes are type two clones
*/
public bool isCloneFunctionTypeThree(node first, node second) {
	
	if(first notin getSubNodes(second) && second notin getSubNodes(first)) {
		firstNormalized = removeDeclarationAttributes(first);
		secondNormalized = removeDeclarationAttributes(second);
		firstNormalized = normalizeNode(firstNormalized);
		secondNormalized = normalizeNode(secondNormalized);
		
	 	if(calculateSimilarity(firstNormalized, secondNormalized) >= 0.7) {
	 		return true;
	 	} 
	 }
	
	return false;
}

public list[node] getCloneClasses(map[node, list[node]] clonesRegistry) {
	list[node] classes = [];
	
	for(class <- clonesRegistry) {
		classes += class;
	}
	
	return classes;
}

public list[node] addToClones(node n, list[node] clones) {
	
	if(n in clones) {
		return clones;	
	}
	else {
		clones += n;
		return clones; 
	}
}

//Function to remove empty classes in a clone register
private map[node, list[node]] removeEmptyClasses(map[node, list[node]] clonesRegistry) {
	map[node, list[node]] newClonesRegistry = ();
	
	for(class <- clonesRegistry) {
		
		// Check if less then two nodes are in class
		if(size(clonesRegistry[class]) >= 2) {
			newClonesRegistry[class] = clonesRegistry[class];
		} 
	}
	
	return newClonesRegistry; 
} 

private map[node, list[node]] reorganizeBuckets(map[node, list[node]] buckets) {


	
}