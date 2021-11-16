package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.MemberDTO;
import poly.persistance.mapper.ILeaderMapper;
import poly.service.ILeaderService;
@Service("LeaderService")
public class LeaderService implements ILeaderService{
	@Resource(name="LeaderMapper")
	private ILeaderMapper leaderMapper;
	@Override
	public List<MemberDTO> staffList() throws Exception {
		// TODO Auto-generated method stub
		
		return leaderMapper.staffList();
	}

	@Override
	public List<MemberDTO> myStaffList(MemberDTO mDTO) throws Exception {
		// TODO Auto-generated method stub
		return leaderMapper.myStaffList(mDTO);
	}

	@Override
	public int addStaff(MemberDTO mDTO) throws Exception {
		// TODO Auto-generated method stub
		int res = 0;
		res = leaderMapper.addStaff(mDTO);
		return res;
	}

	@Override
	public int deleteStaff(MemberDTO mDTO) throws Exception {
		// TODO Auto-generated method stub
		int res = 0;
		res = leaderMapper.deleteStaff(mDTO);
		return res;
	}

}
