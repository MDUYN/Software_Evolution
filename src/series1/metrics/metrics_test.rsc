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
	return (sort(unitSizes) == sort([9, 12, 12, 8, 5, 8, 5]));
}

test bool testUnitComplexity() {
	loc fileLocation = |project://unitMetricsTest|;
	M3 model = createM3FromEclipseProject(fileLocation);
	
	list[int] unitCCs = (getUnitCCs(model));
	return (sort(unitCCs) == sort([3, 3, 3, 5, 1, 3, 2]));
}