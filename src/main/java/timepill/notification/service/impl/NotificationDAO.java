package timepill.notification.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import timepill.notification.service.NotificationVO;

@Mapper
public interface NotificationDAO {
	
	/** 구독정보 등록 */
	int insertSub(NotificationVO vo) throws Exception;

	/** 구독정보 리스트 조회 */
	List<NotificationVO> selectListSub() throws Exception;
	
}
