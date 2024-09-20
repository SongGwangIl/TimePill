package timepill.customer;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import timepill.customer.service.CustomerService;
import timepill.user.UserVO;

@Controller
public class CustomerController {
	
	@Autowired
	CustomerService customerService;
	
	@RequestMapping("/notice")
	public String notice(HttpSession session, CustomerVO cvo, Model model) {
		
		String userId = ((UserVO) session.getAttribute("loginUser")).getUserId();
		cvo.setUserId(userId);
		
		List<CustomerVO> noticeList = customerService.getAllnoticeList(cvo);
		model.addAttribute("noticeList", noticeList);
		
		return "customer/notice";
	}
}
