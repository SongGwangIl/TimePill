package timepill.schedule.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import timepill.schedule.service.ScheduleService;
import timepill.schedule.service.ScheduleVO;

@Service
public class ScheduleServiceImpl implements ScheduleService {

	/** scheduleDAO DI */
	@Autowired
	ScheduleDAO scheduleDAO;
	
	/** 알람 생성(회원가입) */
	@Override
	public void insertAlarm(ScheduleVO vo) throws Exception {
		// 알람 아이디 생성 로직
		String lastAlarmId = scheduleDAO.selectLastAlarmId(); // 마지막 알람 아이디 조회
		int nextIdNum = 1;
		if (lastAlarmId != null && lastAlarmId.startsWith("ALARM_")) {
			nextIdNum = Integer.parseInt(lastAlarmId.substring("ALARM_".length())) + 1;
		}
		String nextId = String.format("ALARM_%010d", nextIdNum);
		vo.setAlarmId(nextId); // 생성 아이디
		
		scheduleDAO.insertAlarmSet(vo);
	}

	/** 알람 시간 변경 */
	@Override
	public void updateAlarm(ScheduleVO vo) throws Exception {
		scheduleDAO.updateAlarm(vo);
	}
	
	/** 스케줄 리스트 */
	@Override
	public List<ScheduleVO> selectScheduleList(ScheduleVO vo) throws Exception {
		return scheduleDAO.selectScheduleList(vo);
	}

	/** 스케줄 등록, 삭제 */
	@Override
	public void handleSchedule(ScheduleVO vo) throws Exception {
		if (!"N".equals(vo.getMedStatus())) { // 복약정보 삭제여부 확인
			// 체크된 알람타입 꺼내기
			if (vo.getAlarmTypes() != null) {
				for (String resultAlarmType : vo.getAlarmTypes()) {
					// 스케줄 등록여부 확인
					vo.setAlarmType(Integer.parseInt(resultAlarmType));
					ScheduleVO resultSchedule = scheduleDAO.selectSchedule(vo);
					if (resultSchedule == null) {
						String selectAlarm = scheduleDAO.selectAlarm(vo); // 스케줄에 등록할 알람 아이디 가져오기
						vo.setAlarmId(selectAlarm);
						scheduleDAO.insertSchedule(vo); // 스케줄 등록
					}
				}
			}
		}
		scheduleDAO.deleteSchedule(vo); // 등록 스케줄을 제외하고 삭제
	}
}
