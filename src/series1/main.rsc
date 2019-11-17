module series1::main

import IO;
import utils;
import List;

import lang::java::m3::AST;
import lang::java::jdt::m3::Core;

import series1::metrics::unit_size;
import series1::metrics::unit_complexity;
import series1::metrics::unit_test;
import series1::metrics::volume;

import series1::ratings::analysability;
import series1::ratings::changeability;
import series1::ratings::testability;

void main(){
	loc project = |project://smallsql0.21_src|;
	//loc project = |project://hsqldb-2.3.1|;
	M3 model = createM3FromDirectory(project);
	
	println("Calculating scores for <project>");
	
	println("Determining volume rating for project");	
	

	// Calculate the unit sizes and evaluate them against SIG guidelines
	println("Determining unit size rating for project");	
	list[int] unitSizesLOC = getLOCUnitSizes(model);
	int unitSizeScore = evaluateUnitSizeSigMetric(getUnitSizeDistribution(unitSizesLOC), size(unitSizesLOC));
	println("Unit size score according to SIG <displayRating(unitSizeScore)>");
	
	// Calculate the unit complexity and rate it according to the SIG metrics
	println("Determining unit complexity rating for project");	
	list[int] unitCCs = getUnitCCs(model);
	int complexityScore = evaluateUnitCCSigMetric(getUnitCCDistribution(unitCCs), size(unitCCs));
	println("Unit CC score according to SIG <displayRating(complexityScore)>");
	
	// Calculate the duplications SIG score for the system
	println("Determining duplication rating for project");	
	int duplicationScore = 1;
	println("Duplication score according to SIG <displayRating(duplicationScore)>");
	
	// Calculate the duplications SIG score for the system
	println("Determining unit test rating for project");	
	int unitTestingScore = 1;
	println("Amount of unit test asserts <getAmountOfAsserts(model)>");
	println(unitTestAbility(model));
	println("Unit test score according to SIG <displayRating(unitTestingScore)>");
	
	// Calculate system scores
	println("Calculating system level SIG scores");
	println("Analysability: <displayRating(rateAnalysAbility(<volumeScore, duplicationScore, unitSizeScore, unitTestingScore>))>");
	println("Changeability: <displayRating(rateChangeAbility(<duplicationScore, unitComplexityScore>))>");
	println("stability: <displayRating(unitTestingScore)>");
	println("testability: <displayRating(rateTestAbility(<unitComplexityScore, unitSizeScore, unitTestingScore>))>");	
}

// Helper function to transform score to SIG rating
private str displayRating(int rating) {
	switch(rating) {
		case 1: return "--";
		case 2: return "-";
		case 3: return "o";
		case 4: return "+";
		case 5: return "++";
		default: return "?";
	}
}

