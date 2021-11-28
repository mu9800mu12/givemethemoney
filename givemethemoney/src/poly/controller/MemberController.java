package poly.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import poly.dto.CertDTO;
import poly.dto.MemberDTO;
import poly.service.ICertService;
import poly.service.IEmailService;
import poly.service.IMemberService;
import poly.util.EncryptUtil;

@Controller
public class MemberController {
	private Logger log = Logger.getLogger(this.getClass());
	@Resource(name="MemberService")
	private IMemberService memberService;
	@Resource(name="EmailService")
	private IEmailService emailService;
	@Resource(name="CertService")
	private ICertService certService;
	
	
	@RequestMapping(value = "home")
	public String home(HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
		// return "/home"은 한 번만리턴해야 한다.
		// 따라서 getCalendarEvents.do에서 /home을 리턴시키고
		// RequestMapping "home"으로 들어온 요청들을 getCalendarEvents.do로 리다이렉트시킨다.
		return "redirect:getCalendarEvents.do";
	}
	
//	@RequestMapping(value = "home")
//	public String home(HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
//		return "/home";
//	}
	
	
	
	@RequestMapping(value = "member/login", method=RequestMethod.GET)
	public String login(HttpServletRequest req, HttpServletResponse resp) {
		return "/member/login";
	}
	@RequestMapping(value = "member/login", method=RequestMethod.POST)
	public String login(HttpServletRequest req, HttpServletResponse resp, HttpSession session,
			ModelMap model) throws Exception {
		if(session.getAttribute("memberinfo") !=null) {
			session.removeAttribute("memberinfo");
		}
		String member_id = req.getParameter("member_id");
		String member_pw = req.getParameter("member_pw");
		log.info("member_id : "+ member_id);
		log.info("member_pw : "+ member_pw);
		MemberDTO mDTO = new MemberDTO();
		mDTO.setMember_pw(EncryptUtil.encHashSHA256(member_pw));
		mDTO.setMember_id(member_id);
		MemberDTO member_info = memberService.login(mDTO);
		String msg = "";
		if(member_info != null) {
			if(member_info.getMember_approve().equals("N") || member_info.getMember_auth().equals("block")) {
				msg = "승인 대기중이거나 블락된 계정입니다.";								
			}else{
				session.setAttribute("memberinfo", member_info);
				msg = "로그인 성공했습니다.";				
			}
			model.addAttribute("msg", msg);
			return "/msgToHome";
		}else {
			return "redirect:login.do?error=error";
		}
	}
	@RequestMapping(value = "member/logout")
	public String logout(HttpServletRequest rep,HttpServletResponse resp, HttpSession session, ModelMap model) {
		session.invalidate();
		String msg = "로그아웃했습니다.";
		model.addAttribute("msg", msg);
		return "/member/login";
	}
	@RequestMapping(value = "member/findPassword", method=RequestMethod.GET)
	public String findPassword(HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
		return "/member/findPassword";
	}
	@RequestMapping(value= "member/findPassword", method=RequestMethod.POST)
	public String findPassword(HttpServletRequest req, HttpServletResponse resp, ModelMap model,
			HttpSession session, RedirectAttributes attr) {
		String member_email = req.getParameter("member_email");
		log.info("member_email(컨트롤러) : " + member_email);
		MemberDTO mDTO = new MemberDTO();
		mDTO.setMember_email(member_email);
		MemberDTO find_email = memberService.find_email(mDTO);
		log.info("member_email : "+find_email );
		String msg = "";
		if(find_email== null) {
			msg = "유효하지 않은 이메일입니다.";
			model.addAttribute("msg", msg);
			return "/member/msgToFindePassword";
		}else {
			log.info("이메일 찾기 컨트롤러 성공");
			String ip = req.getRemoteAddr();
			log.info("이이피(컨트롤러) : "+ip);
			String secret = certService.generateCertification(ip);
			log.info("이이피 : "+ip +"인증번호 : "+secret);
			emailService.sendSimpleMessage(member_email, "일정 관리 시스템 인증번호", "인증번호 : "+ secret);
			int member_no = find_email.getMember_no();
			session.setAttribute("member_no", member_no);
			msg = "이메일로 인증번호를 발송했습니다. 5분 안에 인증 부탁드립니다.";
			model.addAttribute("msg", msg);
			model.addAttribute("member_no", member_no);
			return "/member/certificate";
		}
	}
	@RequestMapping(value = "member/certificate", method=RequestMethod.GET)
	public String certificate(HttpServletRequest req, HttpServletResponse resp) {
		
		return "member/certificate";
	}
	@RequestMapping(value = "member/certificate", method=RequestMethod.POST)
	public String certificate(HttpServletRequest req, 
		HttpServletResponse resp, HttpSession session, ModelMap model) {
		String ip = req.getRemoteAddr();
		String secret = req.getParameter("secret");
		String member_no = req.getParameter("member_no");
		log.info("secret : "+ secret + "member_no : " + member_no);
		CertDTO cDTO = new CertDTO();
		cDTO.setWho(ip);
		log.info("ip : "+ ip);
		cDTO.setSecret(secret);
		CertDTO result = certService.validate(cDTO);
		log.info("result : " + result);
		String msg = "";
		if(result != null) {
			model.addAttribute("member_no", member_no);
			msg = "인증에 성공했습니다. 비밀번호를 바꿔주세요";
			model.addAttribute("msg", msg);
			return "/member/changePassword";
		}else {
			msg = "인증번호가 다르거나 인증시간이 만료되었습니다.";
			model.addAttribute("msg", msg);
			return "/member/certificate";
		}
	}
	@RequestMapping(value = "member/changePassword", method=RequestMethod.GET)
	public String changePassword(HttpServletRequest req, HttpServletResponse resp) {
		return "/member/changePassword";
	}
	@RequestMapping(value = "member/changePassword", method=RequestMethod.POST)
	public String changePassword(HttpServletRequest req, ModelMap model,
			HttpServletResponse resp, HttpSession session) throws Exception {
		int member_no = Integer.parseInt(req.getParameter("member_no"));
		String member_pw = req.getParameter("member_pw");
		MemberDTO mDTO = new MemberDTO();
		mDTO.setMember_no(member_no);
		mDTO.setMember_pw(EncryptUtil.encHashSHA256(member_pw));
		boolean changePassword = memberService.changePassword(mDTO);
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
