package kr.ac.kopo.record.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.ac.kopo.record.service.RecordVO;

@Mapper
public interface RecordDAO {
	
	List<RecordVO> selectLogByAll(String userId);

	List<RecordVO> selectLogByDate(@Param("takeDate") String takeDate, @Param("userId") String userId);

	List<RecordVO> selectAlarmToday(@Param("takeDate") String takeDate, @Param("userId") String userId);

	List<RecordVO> selectAlarmByDate(@Param("timeId") String timeId, @Param("userId") String userId, @Param("takeDate") String takeDate);

	List<RecordVO> selectChart(@Param("takeDate") String takeDate, @Param("userId") String userId);

	int addTakeLog(@Param("timeId") String timeId, @Param("userId") String userId);

}