module series1::metrics::unit_complexity

import utils;
import List;
import Tuple;

import util::Math;
import lang::java::m3::AST;

// We determine the unit cc by calculating McCabe cyclomatic complexity of each unit.
// For us the definition of a unit is just the same as SIG Maintainability Modelis, 
// the smallest named piece of executable code.
public list[int] getUnitCCs(list[Declaration] declarations) {
	list[Statement] methods = findMethods(declarations);
	
	return [getCCStatement(method) | method <- methods];
}

// Function to filter a list of declarations on unit size and then filtering it against a specific amount of llocs
public int filterCCDistribution(list[int] unitCCs, int ccLowerBound) {
	// Filter the list against the given bound of lloc
	return size([unit | unit <- unitCCs, unit >= ccLowerBound]);
}

// Function to filter a list of declarations on unit size and then filtering it against a specific amount of llocs
public int filterCCDistribution(list[int] unitCCs, int ccLowerBound, int ccUperBound) {
	// Filter the list against the given bound of lloc
	return size([unit | unit <- unitCCs, unit >= ccLowerBound && unit <= ccUperBound]);
}

public tuple[int, int, int, int] getCCSigMetric(list[Declaration] declarations) {
	list[int] unitCCs = getUnitCCs(declarations);
	
	//Amount of complexity units in the simple boundaries (1 - 10)
	int amountSimpleRisk = filterCCDistribution(unitCCs, 1, 10);
	
	//Amount of complexity units in the medium boundaries (11 - 20)
	int amountMediumRisk = filterCCDistribution(unitCCs, 11, 20);
	
	//Amount of complexity units in the simple boundaries (1 - 10)
	int amountModerateRisk = filterCCDistribution(unitCCs, 21, 50);
	
	//Amount of complexity units in the simple boundaries (50 - infinite)
	int amountHighRisk = filterCCDistribution(unitCCs, 50);
	
	return <amountSimpleRisk, amountMediumRisk, amountModerateRisk, amountHighRisk>;
}

/**
* Lines of code (LOC)
* Function that evaluates the given unit size sig metric percentages and returns a corresponding score back
*/
public int evaluateUnitComplexitySigMetric(tuple[int amountSimpleRisk, int amountMediumRisk, int amountModerateRisk, int amountHighRisk] metrics) {
	return 0;
}
