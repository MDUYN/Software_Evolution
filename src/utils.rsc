module utils

import IO;
import Set;
import List;
import Map;
import util::FileSystem;
import String;

import lang::java::m3::Core;
import lang::java::m3::AST;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

// Function to find all file locations matched against a set of extensions
set[loc] extractFileLocations(set[str] extensions, loc project) {
	
	// Make sure that you convert all the file extensions to lower case
	set[str] extensionsLowerCase = { toLowerCase(e) | e <- extensions};
	
	// Create a set of all the locations
	return { location | /file(location) <- crawl(project), !startsWith(location.file, "."), (toLowerCase(location.extension) in extensionsLowerCase) || location.extension in extensions};
}

// Function to create a list of Declarations with a given java file location
list[Declaration] getASTs(loc location){
	M3 model = createM3FromEclipseProject(location);
	list[Declaration] asts = [];
	for (m <- model.containment, m[0].scheme == "java+compilationUnit"){
		asts += createAstFromFile(m[0], true);
	}
	return asts;
}

// Function that parses the contents of a loc of a file to txt
public str fileContent(loc file) {
	return readFile(file);
}



