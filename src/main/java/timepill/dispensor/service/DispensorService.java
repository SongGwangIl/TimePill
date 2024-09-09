package timepill.dispensor.service;

import java.util.List;

import timepill.dispensor.AlarmInfoVO;

public interface DispensorService {

	List<AlarmInfoVO> getAlarms(String userId);

}
