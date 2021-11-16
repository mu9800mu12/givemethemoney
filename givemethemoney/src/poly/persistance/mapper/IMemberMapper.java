package poly.persistance.mapper;

import config.Mapper;
import poly.dto.MemberDTO;
@Mapper("MemberMapper")
public interface IMemberMapper {

	MemberDTO login(MemberDTO mDTO);

	String find_email(MemberDTO mDTO);

}
