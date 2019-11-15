module series1::main

import IO;
import utils;
import List;

import lang::java::m3::AST;
import lang::java::jdt::m3::Core;

import series1::metrics::unit_size;
import series1::metrics::unit_complexity;
import series1::metrics::volume;

void main(){
	loc project = |project://smallsql0.21_src|;
	//loc project = |project://hsqldb-2.3.1|;
	M3 model = createM3FromEclipseProject(project);
	
	
	//println("Calculating scores for <project>");
	//println("LLOC size = <evaluateJavaVolumeScore(calcLLOC(declarations))>");


	// Calculate the unit sizes and evaluate them against SIG guidelines
	println("Calculating unit sizes with LOC");	
	
	list[int] unitSizesLOC = getLOCUnitSizes(model);
	println("Unit size score according to SIG = <evaluateUnitSizeSigMetric(getUnitSizeDistribution(unitSizesLOC), size(unitSizesLOC))> stars");
	
	println("Calculating unit sizes with LLOC");	
	
	list[int] unitSizesLLOC = getLLOCUnitSizes(model);
	println("Unit size score according to SIG = <evaluateUnitSizeSigMetric(getUnitSizeDistribution(unitSizesLLOC), size(unitSizesLLOC))> stars");
	
	// Calculate the unit complexity and rate it according to the SIG metrics
	//println("Unit complexity score according to SIG = <evaluateUnitComplexitySigMetric(getCCSigMetric(declarations), sum([getLLOCStatement(statement) | statement <- statements]))> stars");
}
