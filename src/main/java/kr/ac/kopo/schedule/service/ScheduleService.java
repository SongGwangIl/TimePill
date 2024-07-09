package kr.ac.kopo.schedule.service;

import java.util.List;

import kr.ac.kopo.user.UserVO;

public interface ScheduleService {

	List<ScheduleVO> list(String userId);

	int add(ScheduleVO vo);

	ScheduleVO findById(String scheId);
}
