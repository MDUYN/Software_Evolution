module series1::ratings::analysability

import util::Math;

public int rateAnalysAbility(int volumeScore, int duplicationScore, int unitSizeScore) {
	return round(volumeScore + duplicationScore + unitSizeScore / 4.0);
}
