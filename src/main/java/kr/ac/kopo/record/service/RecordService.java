package kr.ac.kopo.record.service;

import java.util.List;

public interface RecordService {
	
	List<RecordVO> selectLogByAll(RecordVO recordVO);
	
	List<RecordVO> selectLogByDate(String takeDate, String userId);

	List<RecordVO> selectAlarmByDate(String takeDate, String userId);
	
	List<RecordVO> selectChart(String takeDate, String userId);
	
	int addTakeLog(String timeId, String userId);

	int off(String takeId);
	
	int selectLogToday(String takeDate, String timeId);

	int updateTakeLog(String takeDateTime, String timeId);
	
}
