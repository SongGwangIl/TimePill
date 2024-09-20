package timepill.customer.service.Impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import timepill.customer.CustomerVO;

@Mapper
public interface CustomerDAO{

	List<CustomerVO> getAllnoticeList(CustomerVO cvo);
	
}