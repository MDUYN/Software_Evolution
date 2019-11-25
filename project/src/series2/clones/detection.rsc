module series2::clones::detection

import List;
import IO;
import Node;
import Map;
import lang::java::m3::AST;

public lrel[node fst, node snd] detect(list[Declaration] declarations) {
	map[node, list[node]] clones = ();
	
	visit(declarations) {
		case node subtree: {
				list[node] sub = subNodes(subtree);
				println(subtree);
				println(size(sub));
		}	
	}
	
	return null;
}

public list[node] subNodes(node x) {
	list[node] nodes = [];
		visit(x) {
			case node subNode: { 
				nodes += subNode; 
			}
		}
	return nodes;
}