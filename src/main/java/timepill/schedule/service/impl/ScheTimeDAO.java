package timepill.schedule.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import timepill.schedule.service.ScheTimeVO;
import timepill.schedule.service.ScheduleVO;

@Mapper
public interface ScheTimeDAO {
	
	List<ScheTimeVO> list(ScheduleVO vo);

	int add(ScheTimeVO vo);

	int delete(String timeId);

	ScheTimeVO findById(String timeId);

	int edit(ScheTimeVO vo);
}
