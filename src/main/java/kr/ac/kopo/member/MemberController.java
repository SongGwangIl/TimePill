package kr.ac.kopo.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.ac.kopo.member.service.MemberService;
import kr.ac.kopo.user.UserVO;


@Controller
public class MemberController{
		
	@Autowired
	private MemberService memberService;
	
	
	//view
	@GetMapping("member/regist")
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
	@PostMapping("member/regist")
	public String registUser(UserVO userVO, Model model, HttpSession session) {
		
		//UserVO 상속으로 아래 값을 받을 수 있게 되었음 
		//파라미터로 받아온 값 type, searchKey, searchValue 
		

		return "member/regist";
	}
	

}