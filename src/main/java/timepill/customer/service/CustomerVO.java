package timepill.customer.service;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class CustomerVO {

	private String userId; 
	
	private String id;
	private String title;
	private String content;
	private Date date;
	
}
