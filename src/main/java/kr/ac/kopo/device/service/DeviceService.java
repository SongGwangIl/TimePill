package kr.ac.kopo.device.service;

import java.util.List;

import kr.ac.kopo.device.DeviceVO;

public interface DeviceService {

	List <String> getAlldeviceId();
	
	int deviceRegister(DeviceVO vo);

	List<String> getdeviceId();


	

}
