module series1::metrics::metrics_test

import series1::metrics::unit_size;
import series1::metrics::unit_complexity;
import series1::metrics::duplication;
import series1::metrics::volume;

import lang::java::m3::Core;
import lang::java::m3::AST;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

import util::FileSystem;

import List;
import IO;


test bool testUnitSize() {
	list[int] correctOutput = [9, 12, 12, 8, 5, 8, 5];
	loc fileLocation = |project://unitMetricsTest/src/unitMetricsTest/Unit.java|;
	M3 model = createM3FromEclipseProject(fileLocation);
	
	list[int] unitSizes = (getLOCUnitSizes(model));
	println(unitSizes);
	return (sort(unitSizes) == sort(correctOutput));
}

test bool testUnitComplexity() {
	list[int] correctOutput = [3, 3, 3, 5, 1, 3, 2];
	loc fileLocation = |project://unitMetricsTest/src/unitMetricsTest/Unit.java|;
	M3 model = createM3FromEclipseProject(fileLocation);
	
	list[int] unitCCs = (getUnitCCs(model));
	return (sort(unitCCs) == sort(correctOutput));
}

test bool testDuplication() {
	list[loc] files = [|project://unitMetricsTest/src/unitMetricsTest/Duplication1.java|,|project://unitMetricsTest/src/unitMetricsTest/Duplication2.java|];
	real percentage = calcDuplicationPercentage(files);
	println(percentage);
	real expected = 100 * (12 / 24.0);
	
	return(percentage == expected);
}

test bool testVolume() {
	list[loc] files = [ location | /file(location) <- crawl(|project://unitMetricsTest/src/unitMetricsTest|)];
	int sloc = calcSLOC(files);
	return (sloc == 91);
}