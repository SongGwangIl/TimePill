package timepill.customer;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class CustomerVO {

	private String userId; 
	
	private String id;
	private String title;
	private String content;
	private String date;
	
}
