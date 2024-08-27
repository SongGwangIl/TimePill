package kr.ac.kopo.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.ac.kopo.member.service.MemberService;
import kr.ac.kopo.user.UserInfoVO;
import kr.ac.kopo.user.UserVO;


@Controller
public class MemberController{
		
	@Autowired
	private MemberService memberService;
	
	
	//view
	@GetMapping("member/search")
	public String searchUser(UserVO userVO, Model model, HttpSession session) {
		
		//로그인한 유저의 사용자 타입에 대한 조회가 필요함
		//세션객체에 저장된 로그인 정보에서 id를 받아옴
		String userId = ((UserVO) session.getAttribute("loginUser")).getUserId();
		userVO.setUserId(userId);
	
		String userSelect = memberService.userSelect(userVO);
		model.addAttribute("userSelect", userSelect);
		
		return "member/regist";
	}
	
	
	//검색어 입력 후에 요청
	@PostMapping("member/search")
	public String searchUser(UserInfoVO userInfoVO, UserVO userVO, Model model, HttpSession session) {
		
		//로그인한 유저의 사용자 타입에 대한 조회가 필요함
		//세션객체에 저장된 로그인 정보에서 id를 받아옴
		String userId = ((UserVO) session.getAttribute("loginUser")).getUserId();
		userVO.setUserId(userId);
	
		String userSelect = memberService.userSelect(userVO);
		model.addAttribute("userSelect", userSelect);
		System.out.println("검색 키워드" + userInfoVO.getSearchValue());
		
		//상속으로 아래 값을 받을 수 있게 된, 파라미터로 받아온 값 searchValue
		//vo 전달 이후 결과값 id, name을 vo에 담아서 출력
		String searchValue = userInfoVO.getSearchValue();
		
		UserInfoVO result = memberService.deviceSelect(userInfoVO);

		model.addAttribute("searchValue", searchValue);
		model.addAttribute("userInfoVO", result);
		return "member/regist";
	}
	
	
	//관계 신청하기
	@PostMapping("member/regist")
	public String registUser(UserInfoVO userInfoVO, Model model, HttpSession session) {
		
		//파라미터 userId로 넘어온 검색결과 사용자의 ID
		//세션값에 userId로 저장된 보호자의 ID
		
		String userProId = ((UserVO) session.getAttribute("loginUser")).getUserId();
		userInfoVO.setUserProId(userProId);
		
		memberService.registUser(userInfoVO);

		return "member/regist";
	}
	

}