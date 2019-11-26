module series2::main

import IO;

import series2::clones::detection;
import series2::clones::type_one;

void main(){
	loc project = |project://smallsql0.21_src|;
	detect(project, addToBucketTypeOne);
}
