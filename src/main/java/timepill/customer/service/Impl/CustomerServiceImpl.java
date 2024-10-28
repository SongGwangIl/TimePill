package timepill.customer.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import timepill.customer.service.CustomerService;
import timepill.customer.service.CustomerVO;

@Service
public class CustomerServiceImpl implements CustomerService {

	@Autowired
	CustomerDAO customerDAO;
	
	@Override
	public List<CustomerVO> getAllnoticeList(CustomerVO cvo) {
		return customerDAO.getAllnoticeList(cvo);
	}

	@Override
	public CustomerVO getnoticeList(CustomerVO cvo) {
		return customerDAO.getnoticeList(cvo);
	}
	
	@Override
	public int updateWrite(CustomerVO cvo) {
		return customerDAO.updateWrite(cvo);
	}

	@Override
	public int updateNotice(CustomerVO cvo) {
		return customerDAO.updateNotice(cvo);
		
	}

	@Override
	public int deleteNotice(CustomerVO cvo) {
		return customerDAO.deleteNotice(cvo);
		
	}	
}
