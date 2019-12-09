package clonesTest;

public class TypeThree {
	
	public void foo(double a, double b, int c) {
		a = b;
 	}
	
	public void foo(double a, double b) {
		a = b;
	}
	
	public void foo(double a) {
		a = 10.0;
	}
	
	public class Copy {
	    void sumProd(int n) {
	    	double sum=0.0; //C1
	    	double prod =1.0;
	    	for (int i=1; i<=n; i++)
		    	{sum=sum + i;
		    	prod = prod * i;
		    	foo(sum, prod, n); }}
	}
	
	public class CopyOne {
	    void sumProd(int n) {
	    	double sum=0.0; //C1
	    	double prod =1.0;
	    	for (int i=1; i<=n; i++)
		    	{sum=sum + i;
		    	prod = prod * i;
		    	foo(prod); }}
	}
	
	public class CopyThree {
	    void sumProd(int n) {
	    	double sum=0.0; //C1
	    	double prod =1.0;
	    	for (int i=1; i<=n; i++)
		    	{sum=sum + i;
		    	prod = prod * i;
		    	if ((n - 2) == 0) {
		    		foo(sum, prod);} }}
	}
	
	public class CopyFour {
	    void sumProd(int n) {
	    	double sum=0.0; //C1
	    	double prod =1.0;
	    	for (int i=1; i<=n; i++)
		    	{sum=sum + i;
		    	//line deleted 
		    	foo(sum, prod); }}
	}
	
	public class CopyFive {
	    void sumProd(int n) {
	    	double sum=0.0; //C1
	    	double prod =1.0;
	    	for (int i=1; i<=n; i++)
				{ if (i - 2 == 0) sum+= i;
				prod = prod * i;
				foo(sum, prod); }}
	}

}
