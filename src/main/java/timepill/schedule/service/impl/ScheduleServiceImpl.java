package timepill.schedule.service.impl;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	/** 한달 일정 카운트 가져오기 */
	@Override
	public Map<String, String> getTodoCntList(ScheduleVO vo) throws Exception {

		Map<String, String> mthScheList = new HashMap<String, String>();

		// 한달 총 스케줄
		List<ScheduleVO> selectMthScheList = scheduleDAO.selectMthScheList(vo);

		// 한달 완료된 스케줄
		List<ScheduleVO> selectMthComplScheList = scheduleDAO.selectMthComplScheList(vo);

		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		calendar.setTime(vo.getMthStartDate()); // 달 시작일
		Date mthEndDate = vo.getMthEndDate(); // 달 마지막일

		// 선택된 달의 날짜 꺼내기
		while (calendar.getTime().before(mthEndDate) || calendar.getTime().equals(mthEndDate)) {
			Date currentDate = calendar.getTime();
			Integer uncompletedTodo = 0;
			

			// 한달 총 스케줄에서 일정 꺼내기
			for (ScheduleVO result : selectMthScheList) {
				if (currentDate.compareTo(result.getStartDate()) >= 0 && currentDate.compareTo(result.getEndDate()) <= 0) { // 복약날짜가 선택된 달의 범위 안에 있는 경우
					uncompletedTodo += result.getTotalDayTodo();
					// 완료 일정 꺼내기
					for (ScheduleVO result2 : selectMthComplScheList) {
						// 일정 완료 날짜가 현재날짜와 같고, 복약 아이디가 같은지 체크
						if (result2.getScheDate().compareTo(currentDate) == 0 && result2.getMedId().equals(result.getMedId()))
							uncompletedTodo -= result2.getCompletedDayTodo(); // 완료된 일정 카운트 빼기
					}
					// 맵에 추가
					mthScheList.put(dateFormat.format(currentDate), uncompletedTodo.toString());
				}
			}
			
			// 하루를 더함
			calendar.add(Calendar.DATE, 1);
		}

		return mthScheList;
	}
	
	/** 하루 스케줄 */
	@Override
	public List<ScheduleVO> selectDayScheList(ScheduleVO vo) throws Exception {
		return scheduleDAO.selectDayScheList(vo);
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
