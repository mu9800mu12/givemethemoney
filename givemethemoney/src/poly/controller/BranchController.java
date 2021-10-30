package poly.controller;

import java.util.ArrayList;
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

import poly.dto.BranchDTO;
import poly.service.IBranchService;
import poly.util.CmmUtil;

@Controller
public class BranchController {
	private Logger log = Logger.getLogger(this.getClass());
	@Resource(name = "BranchService")
	private IBranchService branchService;
	@RequestMapping(value="branch/branchList")
	public String getLBranchList(HttpServletRequest req, HttpServletResponse reps, 
			ModelMap model) throws Exception {
		List<BranchDTO> bList = branchService.getBranchList();
		if(bList ==null) {
			bList = new ArrayList<BranchDTO>();
		}
		model.addAttribute("bList", bList);
		bList = null;
		log.info(this.getClass().getName() + ".BranchLIst end");
		return "/branch/branchList";
	}
	@RequestMapping(value="branch/detailBranch", method=RequestMethod.GET)
	public String detailBranch(HttpServletRequest req, HttpServletResponse resp, ModelMap model) throws Exception {
		String branch_no = CmmUtil.nvl(req.getParameter("branch_no"));
		BranchDTO bDTO = new BranchDTO();
		bDTO.setBranch_no(Integer.parseInt(branch_no));
		BranchDTO rDTO = branchService.detailBranch(bDTO);
		if(rDTO==null) {
			rDTO = new BranchDTO();
		}
		model.addAttribute("rDTO", rDTO);
		bDTO = null;
		rDTO = null;
	
		
		return "/branch/detailBranch";
	}
	@RequestMapping(value="branch/insertBranch", method=RequestMethod.GET)
	public String insertBranch(HttpServletRequest req, HttpServletResponse resp) {
		
		return "/branch/insertBranch";
	}
	@RequestMapping(value="branch/insertBranch", method=RequestMethod.POST)
	public String insertBranch(HttpServletRequest req, HttpServletResponse resp, ModelMap model,
			HttpSession session) {
		String msg= "";
		try {
			String member_id = CmmUtil.nvl((String)session.getAttribute("SESSION_MEMBER_ID"));
			String branch_name = CmmUtil.nvl(req.getParameter("branch_name"));
			String branch_addr1 = CmmUtil.nvl(req.getParameter("branch_addr1"));
			String branch_addr2 = CmmUtil.nvl(req.getParameter("branch_addr2"));
			BranchDTO bDTO = new BranchDTO();
			bDTO.setMember_id(member_id);
			bDTO.setBranch_name(branch_name);
			bDTO.setBranch_addr1(branch_addr1);
			bDTO.setBranch_addr2(branch_addr2);
			branchService.insertBranch(bDTO);
			msg = "등록되었습니다.";
			bDTO =null;
		}catch(Exception e) {
			msg = "실패하였습니다. :" + e.toString();
			e.printStackTrace();
		}finally {
			model.addAttribute("msg", msg);
		}
		return "/branch/detailBranch";
	}
	@RequestMapping(value="branch/updateBranch", method=RequestMethod.GET)
	public String updateBranch(HttpServletRequest req, HttpServletResponse resp,
			ModelMap model) throws Exception {
		String branch_no = CmmUtil.nvl(req.getParameter("branch_no"));
		BranchDTO bDTO = new BranchDTO();
		bDTO.setBranch_no(Integer.parseInt(branch_no));
		BranchDTO rDTO = branchService.detailBranch(bDTO);
		if(rDTO ==null) {
			rDTO = new BranchDTO();
		}
		model.addAttribute("rDTO", rDTO);
		rDTO =null;
		bDTO =null;
		return "/branch/updateBranch";
	}
	@RequestMapping(value="branch/updateBranch", method=RequestMethod.POST)
	public String updateBranch(HttpServletRequest req, HttpServletResponse resp,
			ModelMap model, HttpSession session) {
		String msg = "";
		try {
			String member_id = CmmUtil.nvl((String)session.getAttribute("member_id"));
			String branch_no = CmmUtil.nvl(req.getParameter("branch_no"));
			String branch_name = CmmUtil.nvl(req.getParameter("branch_name"));
			String branch_addr1 = CmmUtil.nvl(req.getParameter("branch_addr1"));
			String branch_addr2 = CmmUtil.nvl(req.getParameter("branch_addr2"));
			BranchDTO bDTO = new BranchDTO();
			bDTO.setMember_id(member_id);
			bDTO.setBranch_no(Integer.parseInt(branch_no));
			bDTO.setBranch_name(branch_name);
			bDTO.setBranch_addr2(branch_addr2);
			bDTO.setBranch_addr1(branch_addr1);
			branchService.updateBranch(bDTO);
			msg = "수정되었습니다.";
			bDTO = null;
			
		}catch(Exception e) {
			msg = "실패하였습니다. : " + e.toString();
			e.printStackTrace();
		}finally {
			model.addAttribute("msg", msg);
		}
		return "/branch/detailBranch";
	}
	@RequestMapping(value="branch/deleteBranch")
	public String deleteBranch(HttpServletRequest req, HttpServletResponse resp, ModelMap model) {
		String msg = "";
		try {
			String branch_no = CmmUtil.nvl(req.getParameter("branch_no"));
			BranchDTO bDTO = new BranchDTO();
			bDTO.setBranch_no(Integer.parseInt(branch_no));
			branchService.deleteBranch(bDTO);
			msg = "삭제했습니다.";
			bDTO = null;
		}catch(Exception e) {
			msg = "실패했습니다."+ e.toString();
		}finally {
			model.addAttribute("msg", msg);
		}
		return "/branch/branchList";
	}
}
