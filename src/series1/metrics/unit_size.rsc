module series1::metrics::unit_size

import utils;
import parser;
import List;

import util::Math;
import lang::java::m3::Core;
import lang::java::m3::AST;

// Function to filter a list of declarations on unit size and then filtering it against a specific amount of llocs
public int filterUnitDistribution(list[int] unitSizes, int llocBound) {
	// Filter the list against the given bound of lloc
	return size([unit | unit <- unitSizes, unit >= llocBound]);
}

public int filterUnitDistribution(list[int] unitSizes, int llocLowerBound, int llocUperBound) {
	// Filter the list against the given lower and uperbound of lloc
	return size([unit | unit <- unitSizes, unit >= llocLowerBound, unit <= llocUperBound]);
}

// Function to get the SIG metrics of unit sizes
public tuple[int, int, int, int] getUnitSizeDistribution(list[int] unitSizes) {
	
	//Amount of units between 0 and 15 LLOC
	int amountSimpleRisk = filterUnitDistribution(unitSizes, 0, 15);
	
	//Amount of units between 15 and 30 LLOC
	int amountModerateRisk = filterUnitDistribution(unitSizes, 16, 30);
	
	//Amount of units between 30 and 60 LLOC
	int amountHighRisk = filterUnitDistribution(unitSizes, 31, 60);
	
	//Amount of units equal or above 60 lines of code
	int amountVeryHighRisk = filterUnitDistribution(unitSizes, 61);
	
	return <amountSimpleRisk, amountModerateRisk, amountHighRisk, amountVeryHighRisk>;
}

// This function returns the amount of stars evaluated from the unit size defined by SIG
// Ref: https://www.softwareimprovementgroup.com/wp-content/uploads/2019/08/20180509-SIG-TUViT-Evaluation-Criteria-Trusted-Product-Maintainability-Guidance-for-producers-1.pdf 
// Function that evaluates the given unit size sig metric percentages and returns a corresponding score back
public int evaluateUnitSizeSigMetric(tuple[int amountSimpleRisk, int amountModerateRisk, int amountHighRisk, int amountVeryHighRisk] metrics, int amountOfUnits) {
	
	int moderate = percent(metrics.amountModerateRisk, amountOfUnits);
	int high = percent(metrics.amountHighRisk, amountOfUnits);
	int veryHigh = percent(metrics.amountVeryHighRisk, amountOfUnits); 
	
	if(moderate <= 19.5 && high <= 10.9 && veryHigh <= 3.9) {
		return 5;
	} else if(moderate <= 26.0 && high <= 15.5 && veryHigh <= 6.5) {
		return 4;
	} else if(moderate <= 34.1 && high <= 22.2 && veryHigh <= 11.0) {
		return 3;
	} else if(moderate <= 45.9 && high <= 31.4 && veryHigh <= 18.1) {
		return 2;
	} else {
		return 1;
	}
}

// Function to get of every unit the unit size according to lines of code.
public list[int] getLOCUnitSizes(M3 model) {	
	
	// Clean each unit and count the amount of lines
	return [ size(clean(location)) | location <- getMethods(model) ]; 	
}

public list[int] getLLOCUnitSizes(M3 model) {
	list[Declaration] declarations = getDeclarations(model);
	list[Statement] statements = getStatements(declarations);
	
	// We need to add one line for the method declaration
	return [getLLOCStatement(statement) + 1 | statement <- statements];
}



