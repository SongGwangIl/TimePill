package kr.ac.kopo.record.service;

import java.util.List;

public interface RecordService {
	
	List<RecordVO> selectLogByAll(String userId);
	
	List<RecordVO> selectLogByDate(String takeDate, String userId);

	List<RecordVO> selectAlarmToday(String takeDate, String userId);
	
	List<RecordVO> selectAlarmByDate(String timeId, String userId, String takeDate);
	
	List<RecordVO> selectChart(String takeDate, String userId);
	
	int addTakeLog(String timeId, String userId);
	
}
