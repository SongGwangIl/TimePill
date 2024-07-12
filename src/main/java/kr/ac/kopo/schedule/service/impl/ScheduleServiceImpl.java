package kr.ac.kopo.schedule.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.schedule.service.ScheduleService;
import kr.ac.kopo.schedule.service.ScheduleVO;
import kr.ac.kopo.user.UserVO;

@Service
public class ScheduleServiceImpl implements ScheduleService {
	
	@Autowired
	ScheduleDAO scheduleDAO;
	
	@Override
	public List<ScheduleVO> list(String userId) {
		return scheduleDAO.list(userId);
	}
	@Override
	public int add(ScheduleVO vo) {
		return scheduleDAO.add(vo);
	}
	@Override
	public ScheduleVO findById(String scheId) {
		return scheduleDAO.findById(scheId);
	}
	@Override
	public int delete(String scheId) {
		return scheduleDAO.delete(scheId);
	}

}
