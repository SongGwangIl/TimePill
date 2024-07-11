package kr.ac.kopo.record.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.record.service.RecordService;
import kr.ac.kopo.record.service.RecordVO;

@Service
public class RecordServiceImpl implements RecordService{

	@Autowired
	private RecordDAO recordDAO;

	@Override //전체 조회
	public List<RecordVO> selectByAll(String userId) {
		return recordDAO.selectByAll(userId);
	}

	@Override //선택 날짜 조회
	public List<RecordVO> selectByDate(String takeDate, String userId) {
		return recordDAO.selectByDate(takeDate, userId);
	}

	@Override //오늘의 알람 조회
	public List<RecordVO> selectAlarmList(String takeDate, String userId) {
		return recordDAO.selectAlarmList(takeDate, userId);
	}

	@Override //복용 로그 등록
	public int addTakeLog(String timeId, String userId) {
		return recordDAO.addTakeLog(timeId, userId);
	}

	@Override //날짜별 알람 조회
	public List<RecordVO> selectAlarmByDate(String timeId, String userId, String takeDate) {
		return recordDAO.selectAlarmByDate(timeId, userId, takeDate);
	}

	@Override //날짜별 차트 수치 반환
	public List<RecordVO> selectChart(String takeDate, String userId) {
		return recordDAO.selectChart(takeDate, userId);
	}
	
	
	
}
