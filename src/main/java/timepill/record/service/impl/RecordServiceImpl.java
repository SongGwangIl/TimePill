package timepill.record.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import timepill.record.service.RecordService;
import timepill.record.service.RecordVO;

@Service
public class RecordServiceImpl implements RecordService{

	@Autowired
	private RecordDAO recordDAO;

	@Override //복용 기록 전체 조회
	public List<RecordVO> selectLogByAll(RecordVO recordVO) {
		
		System.out.println(recordVO.getUserId());
		int total = recordDAO.total(recordVO);
		recordVO.setTotal(total);
		
		return recordDAO.selectLogByAll(recordVO);
	}

	@Override //선택 날짜 조회
	public List<RecordVO> selectLogByDate(String takeDate, String userId) {
		return recordDAO.selectLogByDate(takeDate, userId);
	}

	@Override //복용 로그 등록
	public int addTakeLog(String timeId, String userId) {
		return recordDAO.addTakeLog(timeId, userId);
	}

	@Override //날짜별 알림 조회
	public List<RecordVO> selectAlarmByDate(String takeDate, String userId) {
		return recordDAO.selectAlarmByDate(takeDate, userId);
	}

	@Override //날짜별 차트 수치 반환
	public List<RecordVO> selectChart(String takeDate, String userId) {
		return recordDAO.selectChart(takeDate, userId);
	}

	@Override //등록된 복용 기록 off
	public int off(String takeId) {
		return recordDAO.off(takeId);
	}

	@Override 
	public int selectLogToday(String takeDate, String timeId) {
		return recordDAO.selectLogToday(takeDate, timeId);
	}

	@Override
	public int updateTakeLog(String takeDateTime, String timeId) {
		return recordDAO.updateTakeLog(takeDateTime, timeId);
	}


}
