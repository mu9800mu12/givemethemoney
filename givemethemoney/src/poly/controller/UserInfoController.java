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

import poly.dto.CHWDTO;
import poly.dto.MemberDTO;
import poly.dto.UserInfoDTO;
import poly.service.IUserInfoService;
import poly.service.impl.CHWService;
import poly.util.CmmUtil;
import poly.util.EncryptUtil;

@Controller
public class UserInfoController {

	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "UserInfoService")
	private IUserInfoService userInfoService;


	// 회원가입 화면으로 이동
	@RequestMapping(value = "user/userRegForm")
	public String userRegForm() {
		log.info(this.getClass().getName() + ".user/userRegForm ok !");

		return "/user/userRegForm";
	}

	@RequestMapping(value = "user/insertUserInfo")
	public String insertUserInfo(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".insertUserInfo start !");

		UserInfoDTO pDTO =null;
		String msg = "";

		try {
			String MEMBER_ID = CmmUtil.nvl(request.getParameter("member_id"));
			String MEMBER_NAME = CmmUtil.nvl(request.getParameter("member_name"));
			String MEMBER_PW = CmmUtil.nvl(request.getParameter("member_pw"));
			String MEMBER_EMAIL = CmmUtil.nvl(request.getParameter("member_email"));
			String MEMBER_ADDR1 = CmmUtil.nvl(request.getParameter("addr1"));
			String MEMBER_ADDR2 = CmmUtil.nvl(request.getParameter("addr2"));
			String MEMBER_PHONE = CmmUtil.nvl(request.getParameter("member_phone"));
			String MEMBER_AUTH = CmmUtil.nvl(request.getParameter("member_auth"));
			log.info("MEMBER_ID : " + MEMBER_ID);
			log.info("MEMBER_NAME : " + MEMBER_NAME);
			log.info("MEMBER__PW : " + MEMBER_PW);
			log.info("MEMBER_EMAIL : " + MEMBER_EMAIL);
			log.info("MEMBER_ADDR1 : " + MEMBER_ADDR1);
			log.info("MEMBER_ADDR2 : " + MEMBER_ADDR2);
			log.info("MEMBER_PHONE : " + MEMBER_PHONE);

			pDTO = new UserInfoDTO();
			pDTO.setMember_id(MEMBER_ID);
			pDTO.setMember_name(MEMBER_NAME);
			pDTO.setMember_pw(EncryptUtil.encHashSHA256(MEMBER_PW));
			pDTO.setMember_email(MEMBER_EMAIL);
			pDTO.setMember_addr1(MEMBER_ADDR1);
			pDTO.setMember_addr2(MEMBER_ADDR2);
			pDTO.setMember_phone(MEMBER_PHONE);
			pDTO.setMember_auth(MEMBER_AUTH);
			// 회원가입
			int res = userInfoService.insertUserInfo(pDTO);

			if (res == 1) {
				msg = "회원가입되었습니다. 승인까지 최대 3일까지 기다려주세요. ";
				userInfoService.clearMember();
				/*
				보규:
				<delete id="clearMember">
					<![CDATA[
						DELETE FROM member WHERE member_approve='N' and member_auth in('staff','leader')
						and member_sysdate < TO_CHAR(sysdate - 3, 'yyyy-mm-dd')  <--이 부분에서
						걸리는 부분이 3일 이상 회원 가입을 안 하면 계속 Data가 남아 있은 문제가..
						만약 하루하루 날자를 비교해서 3일 지나면 삭제하는 기능을 다른 방법 더 찾아보거나
						차선으로 index나 home 쪽에서 박아버리는게 좋을 것 같습니다
					]]>
				</delete>
				 */
			} else if (res == 2) {
				msg = "이미 가입된 이메일 주소입니다.";
			} else {
				msg = "오류로 인해 회원가입이 실패하였습니다.";
			}

		} catch (Exception e) {
			msg = "실패하였습니다. : " + e.toString();
			log.info(e.toString());
			e.printStackTrace();
		} finally {
			log.info(this.getClass().getName() + ".insetUserInfo end ! ");

			model.addAttribute("msg", msg);

		}

		return "/msgToHome";
	}
	
	//로그인을 위한 입력 화면으로 이동
	
	@RequestMapping(value="user/loginForm")
	public String lgoinForm() {
		log.info(this.getClass().getName() + ".user/loginForm ok !");
		return "/user/LoginForm";
	}

	// 로그인 처리 및 결과 알려주는 화면으로 이동
	@RequestMapping(value = "user/getUserLoginCheck")
	public String getUserLoginCheck(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			ModelMap model) throws Exception {

		log.info(this.getClass().getName() + ".getUserLoginCheck start !!");

		// 로그인 처리 결과를 저장할 변수
		int res = 0;

		// 웹에서 받는 정보를 저장할 변수
		UserInfoDTO pDTO = null;

		try {

			String MEMBER_ID = CmmUtil.nvl(request.getParameter("user_id"));
			String MEMBER__PW = CmmUtil.nvl(request.getParameter("password"));

			// 웹에서 받는 정보를 String 변수에 저장 시작 !!
			// 무조건 웹으로 받은 정보는 DTO에 저장히기 위해 임시로 String 변수에 저장.

			log.info("user_id : " + MEMBER_ID);
			log.info("password : " + MEMBER__PW);

			// 웹에서 받는 정보를 저장할 변수를 메모리에 올리기
			pDTO = new UserInfoDTO();

			pDTO.setMember_id(MEMBER_ID);
			pDTO.setMember_pw(EncryptUtil.encHashSHA256(MEMBER__PW));

			res = userInfoService.getUserLoginCheck(pDTO);

			if (res == 1) { // 로그인 성공
				session.setAttribute("SS_USER_ID", MEMBER_ID);
			}

		} catch (Exception e) {
			// 저장이 실패하면 사용자에게 보여줄 메시지
			res = 2;
			log.info(e.toString());
			e.printStackTrace();
		} finally {
			log.info(this.getClass().getName() + ".insertUserInfo end !");

			model.addAttribute("res", String.valueOf(res));

			pDTO = null;

		}

		return "user/LoginResult";
	}
	
	@RequestMapping(value="user/userInfo", method=RequestMethod.GET)
	public String userInfo(HttpServletRequest req, HttpServletResponse resp, HttpSession session, ModelMap model) throws Exception{
		
		log.info(this.getClass().getName()+" CHWUpdateInfo 페이지 띄움");
		MemberDTO memberinfo = (MemberDTO) session.getAttribute("memberinfo");
		model.addAttribute("memberinfo", memberinfo);
		return "/user/userInfo";
	}

	@RequestMapping(value="user/userUpdate", method=RequestMethod.GET)
	public String userUpdate(HttpServletRequest req, HttpServletResponse resp, HttpSession session, ModelMap model) {
		MemberDTO memberinfo = (MemberDTO)session.getAttribute("memberinfo");
		model.addAttribute("memberinfo", memberinfo);
		return "/user/userUpdate";
	}
	@RequestMapping(value="user/userUpdate", method=RequestMethod.POST)
	public String userUpdate(HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
		int member_no = Integer.parseInt(req.getParameter("member_no"));
		String member_name = req.getParameter("member_name");
		return "/user/userInfo";
	}
	/**
	 * 멤버 회원정보 수정 문
	 */
	@RequestMapping(value = "CHW/CHWUpdate", method = RequestMethod.GET)
	public String NoticeUpdate(HttpSession session, HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {

		log.info(this.getClass().getName() + "CHWUpdate start!");

		String msg = "";

		try {
			//세션이 자료형이 스트링이 아니라 강제로 스트링으로 넣어주는거야
			//http 세션
			//리퀘스트는 강제로 안 바꿔도 됨
			//로그인할 떄 다른페이지갈 때 저장
	/*int*/	String member_no = ((String) session.getAttribute("member_no")); // 팀 번호 pk
			//자료가 
			String member_name = CmmUtil.nvl(request.getParameter("member_name")); // 직원 이름
			String member_addr1 = CmmUtil.nvl(request.getParameter("member_addr1")); // 리더 이름
			String member_addr2 = CmmUtil.nvl(request.getParameter("member_addr2")); // 리더 이름
			String member_pw = CmmUtil.nvl(request.getParameter("member_pw")); // 리더 이름
			String member_phone = CmmUtil.nvl(request.getParameter("member_phone")); // 리더 이름

			log.info("member_no : " + member_no);
			log.info("member_name : " + member_name);
			log.info("ember_addr1 : " + member_addr1);
			log.info("ember_addr2 : " + member_addr2);
			log.info("ember_pw : " + member_pw);
			log.info("ember_phone : " + member_phone);

			CHWDTO rDTO = new CHWDTO();

			rDTO.setMember_no(Integer.parseInt(member_no));
			rDTO.setMember_name(member_name);
			rDTO.setMember_addr1(member_addr1);
			rDTO.setMember_addr2(member_addr2);
			rDTO.setMember_pw(member_pw);
			rDTO.setMember_phone(member_phone);

			// 게시글 수정하기 DB
			CHWService.CHWUpdate(rDTO);

			msg = "수정되었습니다.";

			// 변수 초기화(메모리 효율화 시키기 위해 사용함)
			rDTO = null;

		} catch (Exception e) {
			msg = "실패하였습니다. : " + e.toString();
			log.info(e.toString());
			e.printStackTrace();

		} finally {
			log.info(this.getClass().getName() + ".CHWUpdate end!");

			// 결과 메시지 전달하기
			model.addAttribute("msg", msg);

		}

		return "/CHW/CHWUpdate";
	}	
}
