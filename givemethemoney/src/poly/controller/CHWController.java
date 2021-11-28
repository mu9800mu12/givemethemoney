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
import poly.service.ICHWService;
import poly.util.CmmUtil;

@Controller
public class CHWController {

	private Logger log = Logger.getLogger(this.getClass());

	// 비지니스 로직

	@Resource(name = "CHWService")
	private ICHWService CHWService;
	
	@RequestMapping(value="abcd")
	public String abcd() throws Exception{
		log.info(this.getClass().getName()+" CHWUpdateInfo 페이지 띄움");
		return "/CHW/CHWUpdateInfo";
	}

	/*
	 * 게시판 수정 화면 보기
	 */
	@RequestMapping(value = "CHW/CHWUpdateInfo", method = RequestMethod.GET)						//HttpSession session
	public String CHWUpdate(HttpServletRequest request, HttpServletResponse response, ModelMap model, HttpSession session) throws Exception {
		
		log.info(this.getClass().getName() + "UpdateInfo start");
		
		//HttpSession httpSession = request.getSession(true);
		//CHWDTO member_NO = (CHWDTO) httpSession.getAttribute("null");
		
		//int member_no = 1;
		//int member_no = (int)session.getAttribute("member_no");
		String member_no = CmmUtil.nvl((String)(request.getParameter("member_no"))); //pk
		//String member_no = (String)request.getAttribute("member_no");
		// 이 함수가 실행됐는지 로그 찍기
		log.info(123);
		/*
		 * 게시판 글 등록되기 위해 사용되는 form객체의 하위 input 객체 등을 받아오기 위해 사용함
		 */
		//int member_no = CmmUtil.nvl(request.getParameter("member_no")); // 공지글번호(PK)
		//int member_no = ((int) session.getAttribute("member_no"));
		
		
		
		log.info("member_no : " + member_no);

		/*
		 * 값 전달은 반드시 DTO 객체를 이용해서 처리함 전달 받은 값을 DTO 객체에 넣는다.
		 */
		
		CHWDTO rDTO = new CHWDTO();

		
		
		rDTO.setMember_no(Integer.parseInt(member_no));
		

		
		log.info("UpdateInfo member_no success!!!");
		
		// 회원정보 상세정보 가져오기
		//서비스를 통해 매퍼에서 sql문 가져오기
		CHWDTO pDTO = CHWService.CHWUpdateInfo(rDTO);

		
		log.info(1);
		
		if (pDTO == null) {
			pDTO = new CHWDTO();
			log.info(2);
		}
		log.info(3);
		log.info("CHWUpdateInfo2 success!!!");

		// 조회된 리스트 결과값 넣어주기
		model.addAttribute("pDTO", pDTO);

		// 변수 초기화(메모리 효율화 시키기 위해 사용함)
		rDTO = null;
		pDTO = null;
		
		
				
		log.info(this.getClass().getName() + "Update end");
	
		return "/CHW/CHWUpdate";
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
