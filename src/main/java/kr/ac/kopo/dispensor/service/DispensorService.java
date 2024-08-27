package kr.ac.kopo.dispensor.service;

import java.util.List;

import kr.ac.kopo.dispensor.AlarmInfoVO;

public interface DispensorService {

	List<AlarmInfoVO> getAlarms(String userId);

}
