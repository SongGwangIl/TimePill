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
	
	//검색 및 조회를 위한 접속
	@GetMapping("member/search")
	public String searchUser(UserVO userVO, Model model, HttpSession session) {
		
		//로그인한 유저의 사용자 타입에 대한 조회가 필요함
		//세션객체에 저장된 로그인 정보에서 id를 받아옴
		userVO.setUserId(((UserVO) session.getAttribute("loginUser")).getUserId());
	
		//객체에 저장된 로그인userId로 타입 select
		String userSelect = memberService.userSelect(userVO);
		
		//타입이 사용자일 때에만 
		if (userSelect.equals("user")) {
			
			UserInfoVO result = memberService.userInfoSelect(userVO);
			System.out.println("아이디 값 " + result.getUserProId());
			
			model.addAttribute("userInfoSelect", result);
			model.addAttribute("userProRegist", String.valueOf(result.getUserProRegist()));				
		}
		
		//결과값 view 출력 전달
		model.addAttribute("userSelect", userSelect);
		
		return "member/regist";
	}
	
	
	//검색어 입력 후에 요청
	@PostMapping("member/search")
	public String searchUser(UserInfoVO userInfoVO, UserVO userVO, Model model, HttpSession session) {
		
		//로그인한 유저의 사용자 타입에 대한 조회가 필요함
		//세션객체에 저장된 로그인 정보에서 id를 받아옴
		userVO.setUserId(((UserVO) session.getAttribute("loginUser")).getUserId());
		
		//객체에 저장된 로그인userId로 타입 select
		String userSelect = memberService.userSelect(userVO);
		model.addAttribute("userSelect", userSelect);
		
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
		
		//파라미터 (UserInfoVO) userId로 넘어온 검색결과 사용자의 ID
		//세션값에 (UserVO) userId로 저장된 보호자의 ID
		
		String userProId = ((UserVO) session.getAttribute("loginUser")).getUserId();
		userInfoVO.setUserProId(userProId);
		
		int num = memberService.registUser(userInfoVO);
		System.out.println(num + "개의 신청 완료!");

		return "redirect:/member/search";
	}
	
	//관계 요청 승낙/거절하기
	@PostMapping("member/choice")
	public String choice(UserInfoVO userInfoVO, UserVO userVO, Model model, HttpSession session) {
		
		//세션에서의 useId 값을 userInfoVO의 userId로 
		userInfoVO.setUserId(((UserVO) session.getAttribute("loginUser")).getUserId());
		
		String result = userInfoVO.getChoice();
		
		System.out.println("파라미터 값 :" + result);
		
		if (result.equals("T")) {
			//승낙, DB에 USER_PRO_REGIST값을 T로
			memberService.accept(userInfoVO);
		} else {
			//거절, DB에 USER_PRO_ID 값을 F로 
			memberService.deny(userInfoVO);
		}

		return "redirect:/member/search";
	}
	

}