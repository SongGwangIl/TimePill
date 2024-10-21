package timepill.medication.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import timepill.medication.service.MedicationService;
import timepill.schedule.service.ScheduleService;
import timepill.schedule.service.ScheduleVO;
import timepill.schedule.service.impl.ScheduleDAO;

@Service
public class MedicationServiceImpl implements MedicationService {

	/** medicationDAO DI */
	@Autowired
	MedicationDAO medicationDAO;
	
	/** scheduleDAO DI */
	@Autowired
	ScheduleDAO scheduleDAO;
	
	/** scheduleService DI */
	@Autowired
	ScheduleService scheduleService;
	
	
	/** 복약 리스트 */
	public List<ScheduleVO> selectMedList(ScheduleVO vo) throws Exception {
		return medicationDAO.selectMedList(vo);
	}
	
	/** 복약 정보 조회 */
	@Override
	public ScheduleVO selectMedInfo(ScheduleVO vo) throws Exception {
		
		ScheduleVO resultMedInfo = medicationDAO.selectMedInfo(vo);
		
		List<String> resultMedAlarmTypes = medicationDAO.selectMedAlarmTypes(vo); // 복약 알람 가져오기
		resultMedInfo.setAlarmTypes(resultMedAlarmTypes);
		
		return resultMedInfo;
	}

	/** 복약 정보 등록 */
	@Override
	public void insertMedInfo(ScheduleVO vo) throws Exception {
		// 복약 아이디 생성 로직
		String lastMedId = medicationDAO.selectLastMedId(); // 마지막 복약아이디 조회
		int nextIdNum = 1;
		if (lastMedId != null && lastMedId.startsWith("MED_")) {
			nextIdNum = Integer.parseInt(lastMedId.substring("MED_".length())) + 1;
		}
		String nextId = String.format("MED_%010d", nextIdNum);
		vo.setMedId(nextId); // 생성 아이디

		medicationDAO.insertMedInfo(vo);

		scheduleService.handleSchedule(vo); // 복약 스케줄 등록
	}

	/** 복약 정보 수정 */
	@Override
	public void updateMedInfo(ScheduleVO vo) throws Exception {
		
		medicationDAO.updateMedInfo(vo);

		scheduleService.handleSchedule(vo); // 복약 스케줄 수정(등록 or 삭제)
	}

	/** 복약 정보 삭제 */
	public void deleteMedInfo(ScheduleVO vo) throws Exception {
		medicationDAO.deleteMedInfo(vo);
		
		scheduleService.handleSchedule(vo); // 복약 스케줄 삭제
	}

}
