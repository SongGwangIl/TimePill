package timepill.kakao.service;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import timepill.schedule.service.ScheduleVO;
import timepill.user.service.UserVO;

@Mapper
public interface KakaoDAO {
	/** 계정 체크 */
	public UserVO duplicateCheckUser(UserVO vo) throws Exception;
	
	/** 카카오 회원가입 */
	public int insertUser(UserVO vo) throws Exception;
	
	/** 카카오 메세지 스케줄 조회 */
	public List<ScheduleVO> selectKakaoScheList() throws Exception;
}
