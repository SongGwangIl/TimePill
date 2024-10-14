package timepill.customer.service.Impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import timepill.customer.service.CustomerVO;

@Mapper
public interface CustomerDAO{

	List<CustomerVO> getAllnoticeList(CustomerVO cvo);

	CustomerVO getnoticeList(CustomerVO cvo);

	int updateWrite(CustomerVO cvo);
	
	int updateNotice(CustomerVO cvo);

	int deleteNotice(CustomerVO cvo);


}