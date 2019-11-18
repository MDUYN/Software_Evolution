module series1::ratings::analysability

import util::Math;

public int rateAnalysAbility(tuple[int volumeScore, int DuplicationScore, int unitSizeScore, int unitTestingScore] scores) {
	return round((toReal(scores.volumeScore) + toReal(scores.DuplicationScore) + toReal(scores.unitSizeScore) + toReal(scores.unitTestingScore)) / 4.0);
}
