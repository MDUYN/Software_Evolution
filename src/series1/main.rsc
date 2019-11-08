module series1::main

import IO;
import utils;
import series1::metrics::unit_size;
import lang::java::m3::AST;

void main(){
	list[Declaration] asts = getASTs(|project://smallsql0.21_src|);
	
	// Calculate the unit sizes and evaluate them against SIG guidelines
	println("Unit size score according to SIG = <evaluateUnitSizeSigMetric(getUnitSizeSigMetric(asts))> stars");
}

