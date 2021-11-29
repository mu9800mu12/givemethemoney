package poly.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import poly.dto.MemberDTO;
import poly.service.ILeaderService;

@Controller
public class LeaderController {
	private Logger log = Logger.getLogger(this.getClass());
	@Resource(name="LeaderService")
	private ILeaderService leaderService;
	@RequestMapping(value="leader/staffList")
	public String staffList(HttpServletRequest req, HttpServletResponse resp, HttpSession session, ModelMap model ) throws Exception {
		List<MemberDTO> mList = leaderService.staffList();
		model.addAttribute("mList", mList);
		log.info("mList :" + mList);
		return "/leader/staffList";
	}
	@RequestMapping(value="leader/myStaffList")
	public String myStaffList(HttpServletRequest req, HttpServletResponse resp, HttpSession session, 
			ModelMap model) throws Exception {
		MemberDTO mDTO = new MemberDTO();
		MemberDTO member_info = (MemberDTO)session.getAttribute("memberinfo");
		mDTO.setMember_team(member_info.getMember_team());
		List<MemberDTO> mList = leaderService.myStaffList(mDTO);
		model.addAttribute("mList", mList);
		return "leader/myStaffList";
	}
	@RequestMapping(value="leader/addStaff")
	public String addStaff(HttpServletRequest req, HttpServletResponse resp,
			HttpSession session, ModelMap model) throws Exception {
		MemberDTO mDTO = new MemberDTO();
		int member_no = Integer.parseInt(req.getParameter("member_no"));
		mDTO.setMember_no(member_no);
		MemberDTO member_info = (MemberDTO)session.getAttribute("memberinfo");
		mDTO.setMember_team(member_info.getMember_team());
		mDTO.setStored_cred(member_info.getStored_cred());
		int res = leaderService.addStaff(mDTO);
		String msg = "";
		if(res > 0) {
			msg = "성공했습니다.";


		}else{
			msg = "실패했습니다.";
		}
		model.addAttribute("msg", msg);
		return "/leader/msgToStaffList";
	}
	@RequestMapping(value="leader/deleteStaff")
	public String deleteStaff(HttpServletRequest req, HttpServletResponse resp, ModelMap model) throws Exception {
		MemberDTO mDTO = new MemberDTO();
		int member_no = Integer.parseInt(req.getParameter("member_no"));
		mDTO.setMember_no(member_no);
		int res = leaderService.deleteStaff(mDTO);
		String msg = "";
		if(res >0) {
			msg = "성공했습니다.";
		}else {
			msg = "실패했습니다.";
		}
		model.addAttribute("msg", msg);
		return "/leader/msgToMyStaffList";
	}
	@RequestMapping(value = "leader/blockList")
	public String blockList(HttpServletRequest req, HttpServletResponse resp, ModelMap model) throws Exception{
		List<MemberDTO> mList = leaderService.blockList();
		model.addAttribute("mList", mList);
		return "/leader/blockList";
	}
	@RequestMapping(value = "leader/addBlock")
	public String addBlock(HttpServletRequest req, HttpServletResponse resp, ModelMap model) {
		int member_no =Integer.parseInt(req.getParameter("member_no"));
		MemberDTO mDTO = new MemberDTO();
		mDTO.setMember_no(member_no);
		int result = leaderService.addBlock(mDTO);
		String msg = "";
		if(result >0) {
			msg = "등록을 완료햇습니다.";
		}else {
			msg = "등록에 실패했습니다.";
		}
		model.addAttribute("msg", msg);
		return "/leader/msgToMyStaffList";			
	}
	@RequestMapping(value = "leader/deleteBlock")
	public String deleteBlock(HttpServletRequest req, HttpServletResponse resp, ModelMap model) {
		int member_no = Integer.parseInt(req.getParameter("member_no"));
		MemberDTO mDTO = new MemberDTO();
		mDTO.setMember_no(member_no);
		int result = leaderService.deleteBlock(mDTO);
		String msg = "";
		if(result >0) {
			msg = "블락취소를 완료햇습니다.";
		}else {
			msg = "등록에실패했습니다.";
		}
		model.addAttribute("msg", msg);
		return "/leader/msgToBlockList";
	}
	
}
