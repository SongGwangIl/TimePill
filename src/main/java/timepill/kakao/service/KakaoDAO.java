package timepill.kakao.service;

import org.apache.ibatis.annotations.Mapper;

import timepill.user.service.UserVO;

@Mapper
public interface KakaoDAO {
	/** 계정 체크 */
	public UserVO duplicateCheckUser(UserVO vo) throws Exception;
	
	/** 카카오 회원가입 */
	public int insertUser(UserVO vo) throws Exception;
}
