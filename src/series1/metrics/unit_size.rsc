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
	list[Statement] methods = findMethods(declarations);
	
	// We need to add one line for the method declaration
	return [getLLOCStatement(method) + 1 | method <- methods];
}

// Function to filter a list of declarations on unit size and then filtering it against a specific amount of llocs
public int filterUnitDistribution(list[int] unitSizes, int llocBound) {
	// Filter the list against the given bound of lloc
	return size([unit | unit <- unitSizes, unit >= lloc]);
}

// This function returns the amount of stars evaluated from the unit size defined by Software Improvement Group

// To be eligible for certification at the level of 4 stars, for each programming 
// language used the percentage of lines of code residing in units with more than 15 
// lines of code should not exceed 42.0%. The percentage in units with more than 30 lines of code 
// should not exceed 19.1%. The percentage in units with more than 60 lines should not exceed 5.6%.
// Ref: https://www.softwareimprovementgroup.com/wp-content/uploads/2019/08/20180509-SIG-TUViT-Evaluation-Criteria-Trusted-Product-Maintainability-Guidance-for-producers-1.pdf 

public tuple[int,int,int] getUnitSizeSigMetric(list[Declaration] declarations) {
	list[int] unitSizes = getUnitSizes(declarations);
	
	//Amount of units equal or above 15 lines of code
	int amountLlocFifteen = filterUnitDistribution(unitSizes, 15);
	
	//Amount of units equal or above 30 lines of code
	int amountLlocThirty = filterUnitDistribution(unitSizes, 30);
	
	//Amount of units equal or above 60 lines of code
	int amountLlocSixty = filterUnitDistribution(unitSizes, 60);
	
	return <percent(amountLlocFifteen, size(unitSizes)), percent(amountLlocThirty, size(unitSizes)), percent(amountLlocSixty, size(unitSizes))>;
}

// Function that evaluates the given unit size sig metric percentages and returns a corresponding score back
public int evaluateUnitSizeSigMetric(tuple[int fifteenLlocPercentage, int thirtyLlocPercentage, int sixtyLlocPercentage] metrics) {
	
	// Return 4 stars if condition is true
	if(metrics.fifteenLlocPercentage <= 42, metrics.thirtyLlocPercentage <= 19, metrics.sixtyLlocPercentage <= 5) {
		return 4;
	}
	return 0;
}