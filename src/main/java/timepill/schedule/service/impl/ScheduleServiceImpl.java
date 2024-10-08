package timepill.schedule.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import timepill.alarm.service.impl.AlarmDAO;
import timepill.schedule.service.ScheduleService;
import timepill.schedule.service.ScheduleVO;

@Service
public class ScheduleServiceImpl implements ScheduleService {

	/** scheduleDAO DI */
	@Autowired
	ScheduleDAO scheduleDAO;

	/** alarmDAO DI */
	@Autowired
	AlarmDAO alarmDAO;
	
	/** 한달 총 스케줄 리스트 */
	@Override
	public List<ScheduleVO> selectMthScheList(ScheduleVO vo) throws Exception {
		return scheduleDAO.selectMthScheList(vo);
	}
	
	/** 한달 완료된 스케줄 리스트 */
	@Override
	public List<ScheduleVO> selectMthComplScheList(ScheduleVO vo) throws Exception {
		return scheduleDAO.selectMthComplScheList(vo);
	}

	/** 스케줄 리스트 */
	@Override
	public List<ScheduleVO> selectScheduleList(ScheduleVO vo) throws Exception {
		return scheduleDAO.selectScheduleList(vo);
	}

	/** 스케줄 등록, 삭제 */
	@Override
	public void handleSchedule(ScheduleVO vo) throws Exception {
		if (!"N".equals(vo.getMedStatus()) && vo.getAlarmTypes() != null) { // 복약정보 삭제 여부 및 체크된 알람타입 여부 확인
			for (String resultAlarmType : vo.getAlarmTypes()) {
				vo.setAlarmType(Integer.parseInt(resultAlarmType));
				
				// 스케줄 등록여부 확인
				ScheduleVO resultSchedule = scheduleDAO.selectSchedule(vo);
				if (resultSchedule == null) {
					
					vo.setAlarmId(alarmDAO.selectAlarm(vo)); // 스케줄에 등록할 알람 아이디
					scheduleDAO.insertSchedule(vo); // 스케줄 등록
				}
			}
		}
		scheduleDAO.deleteSchedule(vo); // 등록 스케줄을 제외하고 삭제
	}

	/** 스케줄 로그 생성, 수정 */
	@Override
	public void handleScheduleLog(ScheduleVO vo) throws Exception {

		ScheduleVO resultLog = scheduleDAO.selectScheduleLog(vo);
		
		// 스케줄 로그 생성, 수정여부 체크
		if (resultLog != null) {
			scheduleDAO.updateScheduleLog(vo);
		} else {
			scheduleDAO.insertScheduleLog(vo);
		}

	}
}
