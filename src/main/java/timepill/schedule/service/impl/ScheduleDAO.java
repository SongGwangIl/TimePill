package timepill.schedule.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import timepill.schedule.service.ScheTimeVO;
import timepill.schedule.service.ScheduleVO;

@Mapper
public interface ScheduleDAO {
	
	List<ScheduleVO> list(String userId);

	int add(ScheduleVO vo);

	ScheduleVO findById(String scheId);
	
	ScheTimeVO findAllByScheId(String scheId);

	int delete(String scheId);

	int edit(ScheduleVO vo);
}
