package timepill.kakao.service;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import timepill.user.service.UserVO;

@Mapper
public interface KakaoDAO {
	/** 카카오 유저정보 가져오기 */
	UserVO selectKakaoUserInfo(UserVO vo) throws Exception;
	
	/** 카카오 회원가입 */
	int insertKakaoUser(UserVO vo) throws Exception;
	
	/** 카카오 유저 상태 변경 */
	int updateKakaoUserStatus(UserVO vo) throws Exception;
	
	/** 카카오 액세스 토큰 설정 */
	int updateAccessToken(UserVO vo) throws Exception;
	
	/** 카카오 리프레시 토큰 설정 */
	int updateRefreshToken(UserVO vo) throws Exception;
	
	/** 카카오 토큰 조회 */
	List<UserVO> selectKakaoTokenList() throws Exception;
}
