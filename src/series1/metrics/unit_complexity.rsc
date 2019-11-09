module series1::metrics::unit_complexity

import IO;
import utils;
import List;
import Tuple;

import util::Math;
import lang::java::m3::AST;

// We determine the unit cc by calculating McCabe cyclomatic complexity of each unit.
// For us the definition of a unit is just the same as SIG Maintainability Modelis, 
// the smallest named piece of executable code.
public list[int] getUnitCCs(list[Declaration] declarations) {
	list[Statement] methods = getStatements(declarations);
	
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
	int amountModerateRisk = filterCCDistribution(unitCCs, 11, 20);
	
	//Amount of complexity units in the simple boundaries (1 - 10)
	int amountHighRisk = filterCCDistribution(unitCCs, 21, 50);
	
	//Amount of complexity units in the simple boundaries (50 - infinite)
	int amountVeryHighRisk = filterCCDistribution(unitCCs, 50);
	
	return <amountSimpleRisk, amountModerateRisk, amountHighRisk, amountVeryHighRisk>;
}

/**
* Lines of code (LOC)
* Function that evaluates the given unit size sig metric percentages and returns a corresponding score back.
* The risks profiles we use and are defined by the SIG are:
* 
* ++ 
* moderate risk: 25% <= of LLOC
* high risk: 0% of LLOC
* very high risk: 0% of LLOC
* 
* + 
* moderate risk: 30% <= of LLOC
* high risk: 5% <= LLOC
* very high risk: 0% of LLOC
* 
* 0
* moderate risk: 40% <= of LLOC
* high risk: 10% <= of LLOC
* very high risk: 0% of LLOC
* 
* - 
* moderate risk: 50% <= of LLOC
* high risk: 15% <= of LLOC
* very high risk: 5% <= of LLOC
*/
public int evaluateUnitComplexitySigMetric(tuple[int amountSimpleRisk, int amountModerateRisk, int amountHighRisk, int amountVeryHighRisk] metrics, int totalLLOCUnits) {
	int moderate = percent(metrics.amountModerateRisk, totalLLOCUnits);
	int high = percent(metrics.amountHighRisk, totalLLOCUnits);
	int veryHigh = percent(metrics.amountVeryHighRisk, totalLLOCUnits);
	
	// Evaluate the risks
	if(moderate <= 25.0 && high <= 0.0 && veryHigh <= 0.0) {
		return 5;
	} else if(moderate <= 30.0 && high <= 5.0 && veryHigh <= 0.0) {
		return 4;
	} else if(moderate <= 40.0 && high <= 10.0 && veryHigh <= 0.0) {
		return 3;
	} else if(moderate <= 50.0 && high <= 15.0 && veryHigh <= 5.0) {
		return 2;
	} else {
		return 1;
	}
}