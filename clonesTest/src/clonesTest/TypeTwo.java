package clonesTest;

public class TypeTwo {
	
	public void foo(int a, int b) {
		a = b;
	}
	
	public void functionTwo () {
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
		
		for(int i = 1; i <= a; i++) {
			foo(b, c);
		}
	}
	
	
	public void functionTwoClone () {
		int u = 10;
		int x = 10;
		int y = 10;
		int z = 10;
		 
		if(x == 10 && z == 10) {
			z = y;
			
			if((2 * x) == (2 * z)) {
				u = y;
			}
		}
		
		for(int i = 1; i <= y; i++) {
			foo(x, y);
		}
	}
}
