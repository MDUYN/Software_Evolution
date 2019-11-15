module series1::ratings::changeability

import Tuple;
import util::Math;

public int rateChangeAbility(tuple[int unitComplexityScore, int duplicationScore] scores) {
	return round((toReal(scores.unitComplexityScore) + toReal(scores.duplicationScore)) / 2.0);
}
