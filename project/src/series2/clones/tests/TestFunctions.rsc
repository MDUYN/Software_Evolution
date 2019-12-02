module series2::clones::tests::TestFunctions

public bool assertion(&T actual, &T expected) {
	return assert (actual == expected) : "Expected <expected> but got <actual>";
}