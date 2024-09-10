package timepill.record.service;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import timepill.com.Pagination;
import timepill.schedule.service.ScheTimeVO;
import timepill.schedule.service.Schedule2VO;

@Getter @Setter
public class RecordVO extends Pagination {
	
	private String takeId;
	private String userId;
	private String timeId;
	private String takeDate;
	private char takeSuccess;
	private char takeUseAt;
	
	private List<Schedule2VO> scheduleList;
	private List<ScheTimeVO> scheTimeList;
	
	private int cntTakeLog;
	private int cntAlarm;

}
