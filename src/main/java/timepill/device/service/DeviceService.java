package timepill.device.service;

import java.util.List;

import timepill.device.DeviceInfoVO;
import timepill.device.DeviceVO;
  
public interface DeviceService {

	String getuserDeviceId(String userId);
	
	List <String> getAlldeviceId(); //device 에 있는 정보들 가져오기
	
	int deviceRegister(DeviceVO vo); 

	List<String> getdeviceId(); //device_info 에 있는 정보들 가져오기

	DeviceInfoVO getdeviceInfo(DeviceInfoVO dvo);

	int updateMydevice(DeviceInfoVO dvo);

	int deleteMydevice(DeviceInfoVO dvo);



}
