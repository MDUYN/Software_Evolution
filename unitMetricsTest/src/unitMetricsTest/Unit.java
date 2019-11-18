package unitMetricsTest;

public class Unit {
	
	// +3 complexity
	public void ifTest() {
		int a = 1;
		int b = 0;
		if (a == 1) {
			int aa = 1;
		} else if (b == 1) {
			int bb = 1;
		}
	}
	
	// +3 complexity
	public void caseTest() {
        int month = 1;
        String monthString;
        switch (month) {
            case 1:  monthString = "January";
                     break;
            case 2:  monthString = "February";
                     break;
            default: monthString = "Invalid month";
                     break;
    	}
	}

    // +3
	public void doWhileTest() {
		// +2
		int count = 1;
	    while (count < 11) {
	        System.out.println("Count is: " + count);
	    count++;
	    }
        int count2 = 1;
        // +1 ?
        do {
            System.out.println("Count is: " + count2);
            count2++;
        } while (count2 < 11);
	}
    
	// +5
	public void shortcircuitTest() {
		// 2 paths possible ?
		if ((1 != 1) && (2 == 2)) {
			int aa = 1;
		}
		// 3 paths possible ?
		if ((1 != 1) || (2 == 2)) {
			int ab = 1;
		}
	}
	
	// +1
	public void forTest() {
		// +1
		for(int i=0 i<10; i++){
			System.out.println("Count is: " + i);
		}
	}
	
	// +3
	public void catchTest() {
		// +3
		try {
		} catch (IndexOutOfBoundsException e) {
		    System.err.println("IndexOutOfBoundsException: " + e.getMessage());
		} catch (IOException e) {
		    System.err.println("Caught IOException: " + e.getMessage());
		}
	}
	
	// +2
	public void conditionalTest() {
		int a, b;
		// + 2
		a = 10;
		b = (a == 1) ? 20: 30;		
	}
}