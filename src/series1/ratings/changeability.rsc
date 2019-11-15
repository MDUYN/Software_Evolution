module series1::ratings::changeability

import Tuple;
import util::Math;

public int rateAnalysability(tuple[int unitComplexityScore, int duplicationScore] scores) {
	return round((toReal(scores.unitComplexityScore) + toReal(scores.duplicationScore)) / 2.0);
}
