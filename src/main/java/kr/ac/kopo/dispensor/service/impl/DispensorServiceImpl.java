package kr.ac.kopo.dispensor.service.impl;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.dispensor.AlarmInfoVO;
import kr.ac.kopo.dispensor.service.DispensorService;

@Service
public class DispensorServiceImpl implements DispensorService {
	
	@Autowired
	DispensorDAO dispensorDAO;

	//알림정보얻기
	@Override
	public List<AlarmInfoVO> getAlarms(String userId) {
		List<AlarmInfoVO> alarms = new ArrayList<AlarmInfoVO>();
		
		List<AlarmInfoVO> schedules = dispensorDAO.getSchedules(userId);
		
		if(!schedules.isEmpty()) {
			
			for(int i=0; i<schedules.size(); i++) {
				
				List<AlarmInfoVO> alarmsInfo = dispensorDAO.getAlarmsInfo(schedules.get(i).getScheId());
				
				for (AlarmInfoVO vo : alarmsInfo) {					
					
					if(vo.getScheId().equals(schedules.get(i).getScheId())) {
						vo.setUserId(schedules.get(i).getUserId());
						vo.setScheStartDate(schedules.get(i).getScheStartDate());
						vo.setScheEndDate(schedules.get(i).getScheEndDate());
						vo.setScheSelect(schedules.get(i).getScheSelect());
					}						
					alarms.add(vo);
				}				
			}
		}
		// 대기시간 계산
		if(!alarms.isEmpty()) {
			
			for (AlarmInfoVO vo : alarms) {
				
				long waitingTime;
				int totalCount;
				Date today = null;
				Date startDay = null;
				Date endDay = null;
				
				DateFormat format = new SimpleDateFormat("yyyyMMdd");
				Calendar c = Calendar.getInstance();
				String day = format.format(c.getTime());
				try {
					today = format.parse(day);
					startDay = format.parse(vo.getScheStartDate().replace("-", ""));
					endDay = format.parse(vo.getScheEndDate().replace("-", ""));
				} catch (ParseException e) {}
				
				waitingTime = startDay.getTime()-today.getTime();
				if(waitingTime < 0)
					waitingTime = 0;
				vo.setStartTime(waitingTime);				
				
				if(today.getTime() > startDay.getTime())
					totalCount = (int)((endDay.getTime()-today.getTime())/(24*60*60*1000));
				else
					totalCount = (int)((endDay.getTime()-startDay.getTime())/(24*60*60*1000));
				vo.setTotalCount(totalCount);
			}		
		}
		
		return alarms;
	}
}
