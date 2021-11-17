package poly.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import poly.dto.CertDTO;
import poly.dto.MemberDTO;
import poly.service.ICertService;
import poly.service.IEmailService;
import poly.service.IMemberService;

@Controller
public class MemberController {
	@Resource(name="MemberService")
	private IMemberService memberService;
	@Resource(name="EmailService")
	private IEmailService emailService;
	@Resource(name="CertService")
	private ICertService certService;
	@RequestMapping(value = "member/login", method=RequestMethod.GET)
	public String login(HttpServletRequest req, HttpServletResponse resp) {
		return "/member/login";
	}
	@RequestMapping(value = "member/login", method=RequestMethod.POST)
	public String login(HttpServletRequest req, HttpServletResponse resp, HttpSession session,
			ModelMap model) {
		String member_id = req.getParameter("member_id");
		String member_pw = req.getParameter("member_pw");
		MemberDTO mDTO = new MemberDTO();
		mDTO.setMember_pw(member_pw);
		mDTO.setMember_id(member_id);
		MemberDTO loginDTO = memberService.login(mDTO);
		int member_no = loginDTO.getMember_no();
		String member_auth = loginDTO.getMember_auth();
		String member_name = loginDTO.getMember_name();
		String team_name = loginDTO.getTeam_name();
		String msg = "";
		if(loginDTO != null) {
			session.setAttribute("member_no", member_no);
			session.setAttribute("member_auth", member_auth);
			session.setAttribute("team_name", team_name);
			session.setAttribute("member_name", member_name);
			msg = "로그인 성공했습니다.";
			model.addAttribute("msg", msg);
			return "/msgToIndex";
		}else {
			msg = "로그인 실패했습니다.";
			model.addAttribute("msg", msg);
			return "/member/login";
		}
	}
	@RequestMapping(value = "member/logout")
	public String logout(HttpServletRequest rep,HttpServletResponse resp, HttpSession session, ModelMap model) {
		session.invalidate();
		String msg = "로그아웃했습니다.";
		model.addAttribute("msg", msg);
		return "/msgToIndex";
	}
	@RequestMapping(value = "member/findPassword", method=RequestMethod.GET)
	public String findPassword(HttpServletRequest req, HttpServletResponse resp) {
		
		
		return "/member/findPassword";
	}
	@RequestMapping(value= "member/findPassword", method=RequestMethod.POST)
	public String findPassword(HttpServletRequest req, HttpServletResponse resp, ModelMap model, HttpSession session) {
		String member_email = req.getParameter("member_email");
		MemberDTO mDTO = new MemberDTO();
		mDTO.setMember_email(member_email);
		String find_email = memberService.find_email(mDTO);
		String msg = "";
		if(find_email != null ) {
			int member_no = emailService.send_code(member_email);
			session.setAttribute("member_no", member_no);
			msg = "이메일로 인증번호를 발송했습니다. 5분 안에 인증 부탁드립니다.";
			model.addAttribute("msg", msg);
			return "/member/certificate";
		}else {
			msg = "유효하지 않은 이메일입니다.";
			model.addAttribute("msg", msg);
			return "/member/findPassword";
		}
	}
	@RequestMapping(value = "member/certificate")
	public String certificate(HttpServletRequest req, 
			HttpServletResponse resp, HttpSession session, ModelMap model) {
		String code = req.getParameter("code");
		CertDTO cDTO = new CertDTO();
		cDTO.setSecret(code);
		boolean cert = certService.validate(cDTO);
		String msg = "";
		if(cert) {
			msg = "인증에 성공했습니다. 비밀번호를 바꿔주세요";
			model.addAttribute("msg", msg);
			return "/member/changePassword";
		}else {
			msg = "인증에 실패햇습니다. 다시 입력해주세요";
			model.addAttribute("msg", msg);
			return "/member/certificate";
		}
	}
	@RequestMapping(value = "member/changePassword")
	public String changePassword(HttpServletRequest req, ModelMap model,
			HttpServletResponse resp, HttpSession session) {
		int member_no = (int)session.getAttribute("member_no");
		boolean changePassword = memberService.changePassword(member_no);
		String msg = "";
		if(changePassword) {
			session.invalidate();
			msg = "비밀번호가 변경되었습니다. 다시 로그인 부탁드립니다.";
			model.addAttribute("msg", msg);
			return "/msgToIndex";
		}else {
			msg = "비밀번호 생성 규정을 벗어났습니다.";
			model.addAttribute("msg", msg);
			return "/member/changePassword";
		}
	}
}
