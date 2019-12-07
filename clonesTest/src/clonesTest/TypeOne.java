package clonesTest;

public class TypeOne {
	
	public void functionOne () {
		int a = 10;
		int b = 10;
		int c = 10;
		int d = 10;
		boolean finished = false;
		
		if(a == 10) {
			b = 10;
		}

		if(finished) {
			b = 10;
		}
		
		if(a == 10 && b == 10) {
			a = d;
		}
		
		if((2 * a) == (2 * c)) {
			b = d;
		}
		
		int e = 10;
		int f = 10;
		int g = 10;
		
		if((2 * 5) == a) {
			a = 20;
		}
	}
	
	public void functionOneClone () {
		int a = 10;
		int b = 10;
		int c = 10;
		int d = 10;
		boolean finished = false;
		
		if(a == 10) {
			b = 10;
		}

		if(finished) {
			b = 10;
		}
		
		if(a == 10 && b == 10) {
			a = d;
		}
		
		if((2 * d) == (2 * c)) {
			b = d;
		}
		
		int e = 10;
		int f = 10;
		int g = 10;
	}
}
