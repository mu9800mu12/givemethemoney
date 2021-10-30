package poly.service;

import java.util.List;

import poly.dto.BranchDTO;

public interface IBranchService {

	List<BranchDTO> getBranchList() throws Exception;

	BranchDTO detailBranch(BranchDTO bDTO) throws Exception;

	void insertBranch(BranchDTO bDTO);

	void updateBranch(BranchDTO bDTO);

	void deleteBranch(BranchDTO bDTO);
	
}
