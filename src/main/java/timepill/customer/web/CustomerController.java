package timepill.customer.web;

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
import timepill.customer.service.CustomerVO;

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
	
}
