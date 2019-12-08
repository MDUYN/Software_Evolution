// Should Detect
package series2.clones.tests.java;

// Should detect
public class Mass {
	
	// Should detect
	public void mass() {
		
		//Should detect the whole block
		
		// Should not detect
		int noMassOne = 10;
		
		// Should not detect
		int noMassTwo = 2;

		// Should not detect
		if(noMassOne == 2) {
			noMassTwo = 4;
		}
		
		// Should not detect
		if(noMassOne == 10 && noMassTwo == 2) {
			noMassTwo = 4;
		}
		
		// Should detect
		if(noMassOne == 10 && noMassTwo == 2) {
			
			if(noMassOne == 2) {
				noMassTwo = 4;
			}
		}
		
		// Should detect
		if(noMassOne == 10 && noMassTwo == 2) {
			
			if(noMassOne == 2) {
				noMassTwo = 4;
			}
			noMassOne = 122;
		}
				
		// Should detect
		if(noMassOne == 10 && noMassTwo == 2) {
			
			if(noMassOne == 2) {
				noMassTwo = 4;
			} else {
				noMassTwo = 4;
			}
		}
		
	}
}
