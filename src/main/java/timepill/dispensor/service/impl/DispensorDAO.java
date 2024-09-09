package timepill.dispensor.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import timepill.dispensor.AlarmInfoVO;

@Mapper
public interface DispensorDAO {

	List<AlarmInfoVO> getSchedules(String userId);
	
	List<AlarmInfoVO> getAlarmsInfo(String scheId);



	

}
