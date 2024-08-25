package kr.ac.kopo.record.service;

import java.util.List;

import kr.ac.kopo.com.Pagination;
import kr.ac.kopo.schedule.service.ScheTimeVO;
import kr.ac.kopo.schedule.service.ScheduleVO;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class RecordVO extends Pagination {
	
	private String takeId;
	private String userId;
	private String timeId;
	private String takeDate;
	private char takeSuccess;
	private char takeUseAt;
	
	private List<ScheduleVO> scheduleList;
	private List<ScheTimeVO> scheTimeList;
	
	private int cntTakeLog;
	private int cntAlarm;

}
