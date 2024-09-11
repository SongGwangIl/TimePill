package timepill.record.service;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import timepill.com.Pagination;
import timepill.schedule.service.ScheduleVO;

@Getter @Setter
public class RecordVO extends Pagination {
	
	private String takeId;
	private String userId;
	private String timeId;
	private String takeDate;
	private char takeSuccess;
	private char takeUseAt;
	
	private List<ScheduleVO> scheduleList;
	private List<ScheduleVO> scheTimeList;
	
	private int cntTakeLog;
	private int cntAlarm;

}
