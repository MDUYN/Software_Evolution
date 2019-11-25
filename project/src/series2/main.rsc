module series2::main

import IO;
import lang::java::jdt::m3::Core;

import utils;
import series2::clones::detection;

void main(){
	loc project = |project://smallsql0.21_src|;
	M3 model = createM3FromEclipseProject(project);
	detect(getDeclarations(model));
}
