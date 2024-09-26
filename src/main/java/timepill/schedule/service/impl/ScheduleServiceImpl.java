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
	

	/** 스케줄 리스트 */
	@Override
	public List<ScheduleVO> selectScheduleList(ScheduleVO vo) throws Exception {
		return scheduleDAO.selectScheduleList(vo);
	}

	/** 알람 리스트 */
	@Override
	public List<ScheduleVO> selectAlarmList(ScheduleVO vo) throws Exception {
		return scheduleDAO.selectAlarmList(vo);
	}
	
	/** 알람 생성(회원가입) */
	@Override
	public int insertAlarm(ScheduleVO vo) throws Exception {
		// 알람 아이디 생성 로직
		String lastAlarmId = scheduleDAO.selectLastAlarmId();
		int nextIdNum = 1;
		if (lastAlarmId != null && lastAlarmId.startsWith("ALARM_")) {
			nextIdNum = Integer.parseInt(lastAlarmId.substring("ALARM_".length())) + 1;
		}
		String nextId = String.format("ALARM_%011d", nextIdNum);
		vo.setAlarmId(nextId);
		return scheduleDAO.insertAlarmSet(vo);
	}
	
	/** 알람 정보 설정 */
	@Override
	public int updateAlarm(ScheduleVO vo) throws Exception {
		return scheduleDAO.updateAlarm(vo);
	}

	/** 처방약 정보 */
	@Override
	public ScheduleVO selectMedInfo(ScheduleVO vo) throws Exception {
		return scheduleDAO.selectMedInfo(vo);
	}

	/** 처방약 정보 등록 */
	@Override
	public int insertMedInfo(ScheduleVO vo) throws Exception {
		return scheduleDAO.insertMedInfo(vo);
	}
	
	/** 처방약 정보 수정 */
	public int updateMedInfo(ScheduleVO vo) throws Exception {
		return scheduleDAO.updateMedInfo(vo);
	}
}
