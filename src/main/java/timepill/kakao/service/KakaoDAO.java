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
	int updateRefreshToken(UserVO vo) throws Exception;
	
	/** 카카오 리프레시 토큰 조회 */
	List<UserVO> selectKakaoRefreshTokenList() throws Exception;
}
