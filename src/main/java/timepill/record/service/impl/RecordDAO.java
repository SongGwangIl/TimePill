package timepill.record.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import timepill.record.service.RecordVO;

@Mapper
public interface RecordDAO {
	
	List<RecordVO> selectLogByAll(RecordVO recordVO);
	
	int total(RecordVO recordVO);
	

	List<RecordVO> selectLogByDate(@Param("takeDate") String takeDate, @Param("userId") String userId);

	List<RecordVO> selectAlarmByDate(@Param("takeDate") String takeDate, @Param("userId") String userId);

	List<RecordVO> selectChart(@Param("takeDate") String takeDate, @Param("userId") String userId);

	int addTakeLog(@Param("timeId") String timeId, @Param("userId") String userId);

	int off(String takeId);

	int selectLogToday(@Param("takeDate") String takeDate, @Param("timeId") String timeId);

	int updateTakeLog(@Param("takeDateTime") String takeDateTime, @Param("timeId") String timeId);
	

}