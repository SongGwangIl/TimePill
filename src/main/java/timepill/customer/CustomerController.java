package timepill.customer;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import timepill.customer.service.CustomerService;

@Controller
public class CustomerController {

	@Autowired
	CustomerService customerService;

	// 공지사항 목록
	@RequestMapping("/notice")
	public String notice(HttpSession session, CustomerVO cvo, Model model) {

		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		cvo.setUserId(userId);

		List<CustomerVO> noticeList = customerService.getAllnoticeList(cvo);
		model.addAttribute("noticeList", noticeList);

		return "customer/Notice";
	}

	//공지사항 글쓰기
	@GetMapping("/notice/write")
	public String write(CustomerVO cvo) {
		return "customer/Write";
	}
	
	@PostMapping("/notice/write")
	public String updatewrite(CustomerVO cvo) {
		
		customerService.updateWrite(cvo);
		
		return "redirect: /notice";
	}
	
	
	// 공지사항 내용
	@GetMapping("/notice/detail/{id}")
	public String detail(Model model, CustomerVO cvo) {

		CustomerVO notice = customerService.getnoticeList(cvo);
		model.addAttribute("notice", notice);

		return "customer/Detail";
	}
	
	// 공지사항 변경
	@PostMapping("/notice/detail/{id}")
	public String updateNotice(CustomerVO cvo) {

		customerService.updateNotice(cvo);

		return "redirect:/detail/" + cvo.getId();
	}
	
	// 공지사항 삭제
	@GetMapping("/notice/delete/{id}")
	public String delete(CustomerVO cvo) {
		
		customerService.deleteNotice(cvo);
		System.out.println("공지사항 삭제");
		
		return "redirect: /notice";
	}
}
