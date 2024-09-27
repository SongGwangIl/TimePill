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
	
	/** 복약 정보 조회 */
	@Override
	public ScheduleVO selectMedInfo(ScheduleVO vo) throws Exception {
		
		ScheduleVO resultMedInfo = scheduleDAO.selectMedInfo(vo);
		
		List<String> resultMedAlarmTypes = scheduleDAO.selectMedAlarmTypes(vo); // 복약 알람 가져오기
		resultMedInfo.setAlarmTypes(resultMedAlarmTypes);
		
		return resultMedInfo;
	}

	/** 복약 정보 등록 */
	@Override
	public void insertMedInfo(ScheduleVO vo) throws Exception {
		// 복약 아이디 생성 로직
		String lastMedId = scheduleDAO.selectLastMedId(vo); // 마지막 복약아이디 조회
		int nextIdNum = 1;
		if (lastMedId != null && lastMedId.startsWith("MED_")) {
			nextIdNum = Integer.parseInt(lastMedId.substring("MED_".length())) + 1;
		}
		String nextId = String.format("MED_%010d", nextIdNum);
		vo.setMedId(nextId); // 생성 아이디

		scheduleDAO.insertMedInfo(vo);

		handleSchedule(vo); // 복약 스케줄 등록
	}

	/** 복약 정보 수정 */
	@Override
	public void updateMedInfo(ScheduleVO vo) throws Exception {
		
		scheduleDAO.updateMedInfo(vo);

		handleSchedule(vo); // 스케줄 등록 or 삭제
	}

	/** 알람 리스트 */
	@Override
	public List<ScheduleVO> selectAlarmList(ScheduleVO vo) throws Exception {
		return scheduleDAO.selectAlarmList(vo);
	}

	/** 알람 생성(회원가입) */
	@Override
	public void insertAlarm(ScheduleVO vo) throws Exception {
		// 알람 아이디 생성 로직
		String lastAlarmId = scheduleDAO.selectLastAlarmId(); // 마지막 알람 아이디 조회
		int nextIdNum = 1;
		if (lastAlarmId != null && lastAlarmId.startsWith("ALARM_")) {
			nextIdNum = Integer.parseInt(lastAlarmId.substring("ALARM_".length())) + 1;
		}
		String nextId = String.format("ALARM_%011d", nextIdNum);
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

	/** 스케줄 등록, 수정, 삭제 */
	@Override
	public void handleSchedule(ScheduleVO vo) throws Exception {
		for (String resultAlarmType : vo.getAlarmTypes()) {
			vo.setAlarmType(Integer.parseInt(resultAlarmType));
			ScheduleVO resultSchedule = scheduleDAO.selectSchedule(vo); 

			// 복약 알람 등록여부 확인
			if (resultSchedule == null) {
				String selectAlarm = scheduleDAO.selectAlarm(vo);
				vo.setAlarmId(selectAlarm);
				scheduleDAO.insertSchedule(vo);
			}

			scheduleDAO.deleteSchedule(vo); // 등록알람을 제외하고 삭제
		}
	}
}
