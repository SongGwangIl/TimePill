package timepill.com;

import java.security.SecureRandom;

public class RandomCharacterGenerator {
	
	private final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	
	private final String NUMBERS = "0123456789";
	
	private final SecureRandom random = new SecureRandom();
	
	public char getRandomCharacter() {
		
		int index = random.nextInt(CHARACTERS.length());
		
		return CHARACTERS.charAt(index);
	}
	
	public char getRandomNumber() {
		
		int index = random.nextInt(NUMBERS.length());
		
		return NUMBERS.charAt(index);
	}

}
