package timepill.schedule.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import timepill.schedule.service.ScheduleService;
import timepill.schedule.service.ScheduleVO;

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
	@Override
	public int edit(ScheduleVO vo) {
		return scheduleDAO.edit(vo);
	}

}
