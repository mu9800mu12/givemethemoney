package poly.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.MemberDTO;
import poly.persistance.mapper.IMemberMapper;
import poly.service.IMemberService;

@Service("MemberService")
public class MemberService implements IMemberService {
	@Resource(name="MemberMapper")
	private IMemberMapper memberMapper;

	@Override
	public String find_email(MemberDTO mDTO) {
		// TODO Auto-generated method stub
		String member_email = memberMapper.find_email(mDTO);
		return member_email;
	}

	@Override
	public MemberDTO login(MemberDTO mDTO) {
		// TODO Auto-generated method stub
		MemberDTO rDTO = memberMapper.login(mDTO);
		return rDTO;
	}

	@Override
	public boolean changePassword(int member_no) {
		// TODO Auto-generated method stub
		return false;
	}
}
