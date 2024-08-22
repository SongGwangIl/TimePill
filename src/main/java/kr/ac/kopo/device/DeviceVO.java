package kr.ac.kopo.device;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class DeviceVO{

	private String deviceId;
	private String deviceModel;
	private String deviceDate;
	private String deviceFac;
	
	
	private String userId; // 디바이스 등록 시 필요한 유저 아이디

}
