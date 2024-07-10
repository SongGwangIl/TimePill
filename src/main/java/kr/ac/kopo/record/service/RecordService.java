package kr.ac.kopo.record.service;

import java.util.List;

public interface RecordService {
	
	List<RecordVO> selectByToday(String userId);
	
	List<RecordVO> selectByAll(String userId);
	
	List<RecordVO> selectByDate(String takeDate, String userId);

	List<RecordVO> selectAlarmList(String takeDate, String userId);
	
	int addTakeLog(String timeId, String userId);
	
	List<RecordVO> selectAlarmByDate(String timeId, String userId, String takeDate);
	
	List<RecordVO> selectChart(String takeDate, String userId);
}
