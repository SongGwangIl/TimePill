package timepill.medication.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import timepill.medication.service.MedicationService;
import timepill.schedule.service.ScheduleVO;

@Controller
public class MedicationController {

	/** medicationService DI */
	@Autowired
	MedicationService medicationService;

	/** 복약 리스트 */
	@GetMapping("/medication")
	public String selectMedInfoList(ScheduleVO vo, ModelMap model, HttpSession session) throws Exception {

		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		vo.setUserId(userId);

		List<ScheduleVO> resultList = medicationService.selectMedList(vo);
		model.addAttribute("medList", resultList);

		return "/medication/medList";
	}

	/** 복약 정보 등록 or 수정 폼 */
	@GetMapping(value = { "/medication/reg", "/medication/{medId}" })
	public String registMedInfo(ScheduleVO vo, ModelMap model, HttpSession session) throws Exception {

		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		vo.setUserId(userId);

		ScheduleVO result = new ScheduleVO();

		// 수정폼 여부 체크
		if (vo.getMedId() != null)
			result = medicationService.selectMedInfo(vo);
		model.addAttribute("result", result);

		return "/medication/registMed";
	}

	/** 복약 정보 등록 */
	@PostMapping("/medication/add")
	public String addMedInfo(ScheduleVO vo, ModelMap model, HttpSession session) throws Exception {

		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		vo.setUserId(userId);

		medicationService.insertMedInfo(vo);

		return "redirect:/medication";
	}

	/** 복약 정보 수정 */
	@PostMapping("/medication/{medId}/edit")
	public String editMedInfo(ScheduleVO vo, ModelMap model) throws Exception {

		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		vo.setUserId(userId);

		medicationService.updateMedInfo(vo);

		return "redirect:/medication";
	} 

	/** 복약 정보 삭제 */
	@PostMapping("/medication/{medId}/del")
	public String delMedInfo(ScheduleVO vo, ModelMap model) throws Exception {

		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		vo.setUserId(userId);
		
		vo.setMedStatus("N");

		medicationService.deleteMedInfo(vo);

		return "redirect:/medication";
	}
}
