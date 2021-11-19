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
		String member_team = "1";
		//int member_team = (int)session.getAttribute("member_team");
		mDTO.setMember_team(member_team);
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
		session.setAttribute("member_team", "1");
		String member_team = (String)session.getAttribute("member_team");
		mDTO.setMember_team(member_team);
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
	@RequestMapping(value = "leader/addBlock")
	public String addBlock(HttpServletRequest req, HttpServletResponse resp) {
		int member_no =Integer.parseInt( req.getParameter("member_no"));
		
		return "/leader/msgToStaffList";
	}
	@RequestMapping(value = "leader/deleteBlock")
	public String deleteBlock(HttpServletRequest req, HttpServletResponse resp) {
		return "/leader/msgToStaffList";
	}
	
}
