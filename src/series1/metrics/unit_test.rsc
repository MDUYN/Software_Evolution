module series1::metrics::unit_test

import lang::java::m3::AST;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import analysis::m3::AST;


import utils;
import IO;
import List;

public int getAmountOfAsserts(M3 model) {
	int amount = 0;
	list[loc] locations = getFileLocations(model);
	for(location <- locations) {
		amount += getAmountOfAsserts(location);
	}
	
	return amount;
}

public int getAmountOfAsserts(loc location) {
	int amount = 0;
	Declaration declaration = createAstFromFile(location, true);
	list[Statement] statements = [];
	
	visit(declaration) {
		case \method(_, _, _, _, statement) : statements += statement;
	}
	
	for(statement <- statements) {
		visit (statement) {
			case \assert(_) : amount += 1;
			case \assert(_, _) : amount += 1;
		}
	}
	
	return amount;
}
