package kr.ac.kopo.device.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.device.DeviceVO;
import kr.ac.kopo.device.service.DeviceService;

@Service
public class DeviceServiceImpl implements DeviceService {

	@Autowired
	DeviceDAO deviceDAO;

	@Override
	public List<String> getAlldeviceId() {
		return deviceDAO.getAlldeviceId();
	}

	@Override
	public List<String> getdeviceId() {
		return deviceDAO.getdeviceId();
	}

	@Override
	public int deviceRegister(DeviceVO vo) {
		return deviceDAO.deviceRegister(vo);
	}
	

}
