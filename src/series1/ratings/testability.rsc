module series1::ratings::testability

import util::Math;

public int rateTestAbility(tuple[int unitComplexityScore, int unitSizeScore, int unitTestingScore] scores) {
	return round((toReal(scores.unitComplexityScore) + toReal(scores.unitSizeScore) + toReal(scores.unitTestingScore) ) / 3.0);
}
