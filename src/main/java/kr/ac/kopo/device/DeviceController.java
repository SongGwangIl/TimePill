package kr.ac.kopo.device;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import kr.ac.kopo.device.service.DeviceService;
import kr.ac.kopo.user.UserVO;

@Controller
public class DeviceController {
	
	@Autowired
	DeviceService deviceService;

	@RequestMapping(path = "/device", method = RequestMethod.GET)
	public String deviceform(DeviceVO vo, HttpSession session, Model model) {
		
		String userId = ((UserVO) session.getAttribute("loginUser")).getUserId();
		model.addAttribute("list1", userId);
		
		String userDeviceID = deviceService.getuserDeviceId(userId);
		model.addAttribute("userDeviceId", userDeviceID);
		
		return userId.equals(userDeviceID) ? "redirect:/main" : "device/deviceInfo";
	}

	@PostMapping("/device")
	public String deviceInfo(DeviceVO vo, HttpSession session, Model model, HttpServletRequest request) {
		
		//등록된 deviceId
		List<String> list1 = deviceService.getdeviceId();
		model.addAttribute("already", list1);
		
		//기존에 있는 deviceId
		List<String> list = deviceService.getAlldeviceId();
		String userId = ((UserVO) session.getAttribute("loginUser")).getUserId();
		vo.setUserId(userId);
		
		model.addAttribute("device", list);
		model.addAttribute("user", vo.getUserId());
		
		boolean idAlreadyExists = list1.contains(vo.getDeviceId());
		
		if (idAlreadyExists) {
			return "device/error1";
		}
		
		boolean found = false;
		
		for (String Id : list) {
	        if (Id.equals(vo.getDeviceId())) {
	            found = true;
	            break; // 일치하는 ID를 찾으면 반복을 종료
	        }
	    }

	    // 결과에 따라 다른 뷰 반환
	    if (found) {
	    	int num = deviceService.deviceRegister(vo);
	    	request.setAttribute("msg", "등록되었습니다!");
	    	request.setAttribute("url", "register");
	        return "user/msg";
	        
	    } else {
	        return "device/error";
	    }
	}
	
	@GetMapping("/register")
	public String register() {
		return "device/register";
	}
	
	@RequestMapping(path = "/mydevice", method = RequestMethod.GET)
	public String mydevice(HttpSession session, Model model, DeviceVO vo, DeviceInfoVO dvo) {
		
		String userId = ((UserVO) session.getAttribute("loginUser")).getUserId();
		model.addAttribute("list1", userId);
		dvo.setUserId(userId);
		
		String userDeviceID = deviceService.getuserDeviceId(userId);
		model.addAttribute("userDeviceId", userDeviceID);
		
		// 기기정보 변경내용
		DeviceInfoVO deviceInfo = deviceService.getdeviceInfo(dvo);
		model.addAttribute("mydeviceInfo", deviceInfo);
		
		if (userId.equals(userDeviceID)) {
			return "device/mydevice";
		} else {
			return "device/mydelete";
		}
		
	}
	
	//기기정보 변경
	@PostMapping("/mydevice")
	public String mydevice(DeviceInfoVO dvo, HttpSession session) {
		
		String userId = ((UserVO) session.getAttribute("loginUser")).getUserId();
		dvo.setUserId(userId);
		
		deviceService.updateMydevice(dvo);
		
		/* String delete = deviceService.deleteMydevice(dvo); */
		
		return "redirect:/mydevice";
		
	}
	
	@GetMapping("/device/delete")
	public String mydelete(DeviceInfoVO dvo, HttpSession session) {
		
		String userId = ((UserVO) session.getAttribute("loginUser")).getUserId(); 
		dvo.setUserId(userId);
		
		deviceService.deleteMydevice(dvo);
		
		return "redirect:/mydevice";
	}
	
	
}
	
