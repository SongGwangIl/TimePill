package timepill.kakao.service;

import org.apache.ibatis.annotations.Mapper;

import timepill.user.UserVO;

@Mapper
public interface KakaoDAO {
	/** 계정 중복체크 */
	public UserVO duplicateCheckUser(UserVO vo) throws Exception;
	
	/** 카카오 회원가입 */
	public int insertUser(UserVO vo) throws Exception;
}
