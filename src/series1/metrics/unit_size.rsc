module series1::metrics::unit_size

import utils;
import List;
import Tuple;

import util::Math;
import lang::java::m3::AST;

// We determine the unit size by counting the number of lines of code within each unit.
// For us the definition of a unit is just the same as SIG Maintainability Modelis, 
// the smallest named piece of executable code.
public list[int] getUnitSizes(list[Declaration] declarations) {
	list[Statement] methods = getStatements(declarations);
	
	// We need to add one line for the method declaration
	return [getLLOCStatement(method) + 1 | method <- methods];
}

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
public tuple[int, int, int, int] getUnitSizeSigMetric(list[Declaration] declarations) {
	list[int] unitSizes = getUnitSizes(declarations);
	
	//Amount of units between 0 and 15 LLOC
	int amountSimpleRisk = filterUnitDistribution(unitSizes, 0, 15);
	
	//Amount of units between 15 and 30 LLOC
	int amountModerateRisk = filterUnitDistribution(unitSizes, 15, 30);
	
	//Amount of units between 30 and 60 LLOC
	int amountHighRisk = filterUnitDistribution(unitSizes, 30, 60);
	
	//Amount of units equal or above 60 lines of code
	int amountVeryHighRisk = filterUnitDistribution(unitSizes, 60);
	
	
	return <amountSimpleRisk, amountModerateRisk, amountHighRisk, amountVeryHighRisk>;
}

// This function returns the amount of stars evaluated from the unit size defined by SIG
// Ref: https://www.softwareimprovementgroup.com/wp-content/uploads/2019/08/20180509-SIG-TUViT-Evaluation-Criteria-Trusted-Product-Maintainability-Guidance-for-producers-1.pdf 
// Function that evaluates the given unit size sig metric percentages and returns a corresponding score back
public int evaluateUnitSizeSigMetric(tuple[int amountSimpleRisk, int amountModerateRisk, int amountHighRisk, int amountVeryHighRisk] metrics, amountOfUnits) {
	
	int moderate = percent(metrics.amountModerateRisk, amountOfUnits);
	int high = percent(metrics.amountHighRisk, amountOfUnits);
	int veryHigh = percent(metrics.amountVeryHighRisk, amountOfUnits); 
	
	if(moderate <= 15.0 && high <= 5.0 && veryHigh <= 0.0) {
		return 5;
	} else if(moderate <= 20.0 && high <= 15.0 && veryHigh <= 5.0) {
		return 4;
	} else if(moderate <= 30.0 && high <= 20.0 && veryHigh <= 5.0) {
		return 3;
	} else if(moderate <= 40.0 && high <= 25.0 && veryHigh <= 10.0) {
		return 2;
	} else {
		return 1;
	}
}