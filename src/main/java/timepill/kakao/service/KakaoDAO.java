package timepill.kakao.service;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import timepill.user.service.UserVO;

@Mapper
public interface KakaoDAO {
	/** 계정 체크 */
	UserVO duplicateCheckUser(UserVO vo) throws Exception;
	
	/** 카카오 회원가입 */
	int insertUser(UserVO vo) throws Exception;
	
	/** 카카오 토큰 설정 */
	int updateAccessToken(UserVO vo) throws Exception;
	
	/** 카카오 메세지 스케줄 조회 */
	List<UserVO> selectKakaoScheList() throws Exception;
}
