package timepill.customer.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import timepill.customer.CustomerVO;
import timepill.customer.service.CustomerService;

@Service
public class CustomerServiceImpl implements CustomerService {

	@Autowired
	CustomerDAO customerDAO;
	
	@Override
	public List<CustomerVO> getAllnoticeList(CustomerVO cvo) {
		return customerDAO.getAllnoticeList(cvo);
	}

}
