module series1::main

import IO;
import utils;
import List;

import lang::java::m3::AST;

import series1::metrics::unit_size;
import series1::metrics::unit_complexity;

void main(){
	list[Declaration] declarations = getDeclarations(|project://smallsql0.21_src|);
	list[Statement] statements = getStatements(declarations);
	
	// Calculate the unit sizes and evaluate them against SIG guidelines
	println("Unit size score according to SIG = <evaluateUnitSizeSigMetric(getUnitSizeSigMetric(declarations), size(getUnitSizes(declarations)))> stars");
	
	// Calculate the unit complexity and rate it according to the SIG metrics
	println("Unit complexity score according to SIG = <evaluateUnitComplexitySigMetric(getCCSigMetric(declarations), sum([getLLOCStatement(statement) | statement <- statements]))> stars");
}
