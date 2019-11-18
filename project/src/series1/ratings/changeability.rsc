module series1::ratings::changeability

import util::Math;

public int rateChangeAbility(int unitComplexityScore, int duplicationScore) {
	return round ((unitComplexityScore + duplicationScore) / 4.0);
}
