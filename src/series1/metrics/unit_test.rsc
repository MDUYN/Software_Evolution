module series1::metrics::unit_test

import IO;
import lang::java::m3::Core;
import lang::java::jdt::m3::AST;

import lang::java::m3::AST;
import lang::java::jdt::m3::Core;
import lang::java::m3::Core;
import lang::java::m3::AST;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import analysis::m3::AST;

import utils;

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

public int unitTestAbility(M3 project) {
	int results = 0;
	for (file <- files(project)){
		results += fileAssert(file);
	}
	return results;
}

public int fileAssert(loc class){
	result = 0;
	visit(createAstFromFile(class, false)) {
		case method:\method(_, _, _, _, _) : result += findAsserts(method);
	}
	return result;
}

public int findAsserts(method) {
	int result = 0;
	visit (method) {
		case \assert(_) : result += 1;
		case \assert(_, _) : result += 1;
	}
	return result;
}