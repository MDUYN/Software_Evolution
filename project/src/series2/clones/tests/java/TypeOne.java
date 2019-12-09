package series2.clones.tests.java;

public class TypeOne {
	
	// Clone one
	public void functionOne () {
		int a = 10;
		int b = 10;
		int c = 10;
		int d = 10;
		 
		// Clone two
		if(a == 10 && b == 10) {
			// Clone three
			a = d;
			
			if((2 * d) == (2 * c)) {
				b = d;
			}
		}
	}
	
	// Clone one
	public void functionOneClone () {
		int a = 10;
		int b = 10;
		int c = 10;
		int d = 10;
		 
		// Clone two
		if(a == 10 && b == 10) {
			// Clone three
			a = d;
			
			if((2 * d) == (2 * c)) {
				b = d;
			}
		}
	}
}
