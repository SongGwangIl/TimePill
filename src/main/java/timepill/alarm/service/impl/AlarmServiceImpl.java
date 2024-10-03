package timepill.alarm.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import timepill.alarm.service.AlarmService;
import timepill.schedule.service.ScheduleVO;

@Service
public class AlarmServiceImpl implements AlarmService {

	/** alarmDAO DI */
	@Autowired
	AlarmDAO alarmDAO;

	/** 알람 생성(회원가입) */
	@Override
	public void insertAlarm(ScheduleVO vo) throws Exception {
		// 알람 아이디 생성 로직
		String lastAlarmId = alarmDAO.selectLastAlarmId(); // 마지막 알람 아이디 조회
		int nextIdNum = 1;
		if (lastAlarmId != null && lastAlarmId.startsWith("ALARM_")) {
			nextIdNum = Integer.parseInt(lastAlarmId.substring("ALARM_".length())) + 1;
		}
		String nextId = String.format("ALARM_%010d", nextIdNum);
		vo.setAlarmId(nextId); // 생성 아이디

		alarmDAO.insertAlarmSet(vo);
	}

	/** 알람 시간 변경 */
	@Override
	public void updateAlarm(ScheduleVO vo) throws Exception {
		alarmDAO.updateAlarm(vo);
	}

}
