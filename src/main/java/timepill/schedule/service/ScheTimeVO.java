package timepill.schedule.service;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class ScheTimeVO {

	private String timeId;
	private String scheId;
	private String timeName;
	private String timeAlarm;
	private String timeLimit;
	private int reAlarmCount;
	private int reAlarmTime;
	private int medLocation;
	private char timeHide;
}
