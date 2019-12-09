package clonesTest;

public class TypeOne {
	
	public void functionOne () {
		int a = 10;
		int b = 10;
		int c = 10;
		int d = 10;
		 
		if(a == 10 && b == 10) {
			a = d;
			
			if((2 * d) == (2 * c)) {
				b = d;
			}
		}
	}
	
	public void functionOneClone () {
		int a = 10;
		int b = 10;
		int c = 10;
		int d = 10;
		 
		if(a == 10 && b == 10) {
			a = d;
			
			if((2 * d) == (2 * c)) {
				b = d;
			}
		}
	}
}