module series1::main

import IO;
import utils;
import List;

import lang::java::m3::AST;
import lang::java::jdt::m3::Core;
import util::Math;

import series1::metrics::unit_size;
import series1::metrics::unit_complexity;
import series1::metrics::unit_test;
import series1::metrics::volume;
import series1::metrics::duplication;

void main(){
	//loc project = |project://smallsql0.21_src|;
	loc project = |project://hsqldb-2.3.1|;
	M3 model = createM3FromEclipseProject(project);
	list[loc] files = getFileLocations(model);
	
	println("Calculating scores for <project>");
	int volume = calcSLOC(files);
	int volumeScore = evaluateJavaVolumeScore(volume);
	
	list[int] unitSizesLOC = getLOCUnitSizes(model);
	tuple[int,int,int,int] unitSize = getUnitSizeDistribution(unitSizesLOC);
	int unitSizeScore = evaluateUnitSizeSigMetric(unitSize, size(unitSizesLOC));
	
	list[int] unitCCs = getUnitCCs(model);
	tuple[int,int,int,int] complexity = getUnitCCDistribution(unitCCs);
	int complexityScore = evaluateUnitCCSigMetric(getUnitCCDistribution(unitCCs), size(unitCCs));
	
	real duplicationPercentage = calcDuplicationPercentage(files);
	int duplicationScore = evaluateDuplication(duplicationPercentage);
	
	int aRating = average([volumeScore, duplicationScore, unitSizeScore]);
	int cRating = average([duplicationScore, complexityScore]);
	int mRating = average([aRating, cRating]);

	printSuperBlankLine();
	printHeader();
	printBlankLine();
	printMetrics(volume, complexity, round(duplicationPercentage), unitSize);
	printSuperBlankLine();
	printSuperBlankLine();
	printAnalysability(displayRating(aRating));
	printBlankLine();
	printChangeability(displayRating(cRating));
	printBlankLine();
	printBlankLine();
	printMaintainability(displayRating(mRating));
	printBlankLine();
	printSuperBlankLine();
}

private int average(list[int] l) = round(sum(l) / toReal(size(l)));

// Helper function to transform score to SIG rating
private str displayRating(int rating) {
	switch(rating) {
		case 1: return "- -";
		case 2: return "-";
		case 3: return "o";
		case 4: return "+";
		case 5: return "+ +";
		default: return "?";
	}
}

