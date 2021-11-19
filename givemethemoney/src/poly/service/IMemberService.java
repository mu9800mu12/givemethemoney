package poly.service;

import poly.dto.MemberDTO;

public interface IMemberService{

	String find_email(MemberDTO mDTO);

	MemberDTO login(MemberDTO mDTO);

	boolean changePassword(int member_no);

}
