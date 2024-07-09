package kr.ac.kopo.schedule.service;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class ScheduleVO {
	
	private String scheId;
	private String userId;
	private String scheTitle;
	private int scheSelect;
	private int scheTakeNum;
	private String scheStartDate;
	private String scheEndDate;
	private char scheDateExpires;
	
	private List<ScheTimeVO> timeList;
}