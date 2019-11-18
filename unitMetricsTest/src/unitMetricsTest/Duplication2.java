package unitMetricsTest;

public class Duplication2 {
	public int fib(int n) throws IllegalArgumentException {
		if(n < 0) throw new IllegalArgumentException("Fib needs zero or a positive integer");
		if(n == 0) return 0; if(n == 1) return 1;
		else 
			return fib(n-1) + fib(n-2);
	}
	
	public int someOtherFunction() {
		return 4;
	}
	
}