package kr.ac.kopo.schedule.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.schedule.service.ScheTimeService;
import kr.ac.kopo.schedule.service.ScheTimeVO;
import kr.ac.kopo.schedule.service.ScheduleVO;

@Service
public class ScheTimeServiceImpl implements ScheTimeService {

	@Autowired
	ScheTimeDAO scheTimeDAO;

	@Override
	public List<ScheTimeVO> list(ScheduleVO vo) {
		return scheTimeDAO.list(vo);
	}

	@Override
	public int add(ScheTimeVO vo) {
		return scheTimeDAO.add(vo);
	}

	@Override
	public int delTime(String timeId) {
		return scheTimeDAO.delete(timeId);
	}

	@Override
	public ScheTimeVO findById(String timeId) {
		return scheTimeDAO.findById(timeId);
	}

	@Override
	public int edit(ScheTimeVO vo) {
		return scheTimeDAO.edit(vo);
	}
	


}
