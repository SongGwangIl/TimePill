package timepill.customer.service;

import java.util.List;

import timepill.customer.CustomerVO;

public interface CustomerService {

	public List<CustomerVO> getAllnoticeList(CustomerVO cvo);

	public CustomerVO getnoticeList(CustomerVO cvo);

	public int updateWrite(CustomerVO cvo);
	
	public int updateNotice(CustomerVO cvo);

	public int deleteNotice(CustomerVO cvo);


	
}
