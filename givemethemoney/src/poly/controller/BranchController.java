package poly.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class BranchController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@RequestMapping(value="branch/branchList")
	public String getLBranchList() {
		return "/branch/branchList";
	}
	@RequestMapping(value="branch/insertBranch")
	public String insertBranch() {
		return "/branch/insertBranch";
	}
	@RequestMapping(value="branch/updateBranch", method=RequestMethod.GET)
	public String updateBranch(HttpServletRequest req, HttpServletResponse resp,
			ModelMap model) {
		return "/branch/updateBranch";
	}
	@RequestMapping(value="branch/updateBranch", method=RequestMethod.POST)
	public String updateBranch(HttpServletRequest req, HttpServletResponse resp,
			ModelMap model, BranchDTO bDTO) {
		return "/branch/detail";
	}
	@RequestMapping(value="branch/deleteBranch")
	public String deleteBranch() {
		return "/branch/deleteBranch";
	}
}
