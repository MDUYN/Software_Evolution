module series1::ratings::changeability

import util::Math;

public int rateChangeAbility(tuple[int unitComplexityScore, int duplicationScore] scores) {
	return round((toReal(scores.unitComplexityScore) + toReal(scores.duplicationScore)) / 2.0);
}
