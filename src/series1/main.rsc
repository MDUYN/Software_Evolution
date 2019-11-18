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

import series1::ratings::analysability;
import series1::ratings::changeability;
import series1::ratings::testability;

void main(){
	loc project = |project://smallsql0.21_src|;
	//loc project = |project://hsqldb-2.3.1|;
	M3 model = createM3FromEclipseProject(project);
	list[loc] files = getFileLocations(model);
	
	println("Calculating scores for <project>");
	int volume = calcSLOC(files);
	int volumeScore = evaluateJavaVolumeScore(volume);
	
	list[int] unitSizesLOC = getLOCUnitSizes(model);
	tuple[int,int,int,int] unitSize = getUnitSizeDistribution(unitSizesLOC);
	int unitSizeScore = evaluateUnitSizeSigMetric(unitSize, size(unitSizesLOC));
	
	println("Determining unit complexity rating for project");	
	list[int] unitCCs = getUnitCCs(model);
	tuple[int,int,int,int] complexity = getUnitCCDistribution(unitCCs);
	int complexityScore = evaluateUnitCCSigMetric(getUnitCCDistribution(unitCCs), size(unitCCs));
	
	real duplicationPercentage = calcDuplicationPercentage(files);
	int duplicationScore = evaluateDuplication(duplicationPercentage);
	
	// Calculate the duplications SIG score for the system
	//println("Determining unit test rating for project");	
	int unitTestingScore = 1;
	//println("Amount of unit test asserts <getAmountOfAsserts(model)>");
	//println(unitTestAbility(model));
	//println("Unit test score according to SIG <displayRating(unitTestingScore)>");
	
	// Calculate system scores
	println("Calculating system level SIG scores");
	println("Analysability: <displayRating(rateAnalysAbility(<volumeScore, duplicationScore, unitSizeScore, unitTestingScore>))>");
	println("Changeability: <displayRating(rateChangeAbility(<duplicationScore, complexityScore>))>");
	println("Stability: <displayRating(unitTestingScore)>");
	
	printHeader();
	printBlankLine();
	printMetrics(volume, complexity, round(duplicationPercentage), unitSize);
	printBlankLine();
	printBlankLine();
	printAnalysability(displayRating(rateAnalysAbility(volumeScore, duplicationScore, unitSizeScore)));
	printBlankLine();
	printChangeability(displayRating(rateChangeAbility(duplicationScore, complexityScore)));
	printBlankLine();
	printTestability(displayRating(rateChangeAbility(complexityScore, unitSizeScore)));
	
	//printFoo(int volumeMetric, int ccMetric, int dupMetric, int sizeMetric, int testMetric)
}

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

