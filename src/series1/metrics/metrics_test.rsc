module series1::metrics::metrics_test

import series1::metrics::unit_size;
import series1::metrics::unit_complexity;
import lang::java::jdt::m3::Core;

import List;
import IO;


test bool testUnitSize() {
	loc fileLocation = |project://unitMetricsTest|;
	M3 model = createM3FromEclipseProject(fileLocation);
	
	list[int] unitSizes = (getLOCUnitSizes(model));
	println(unitSizes);
	return (1 == 1);
}

test bool testUnitComplexity() {
	loc fileLocation = |project://unitMetricsTest|;
	M3 model = createM3FromEclipseProject(fileLocation);
	
	list[int] unitCCs = (getUnitCCs(model));
	println(unitCCs);
	return (1 == 1);
}