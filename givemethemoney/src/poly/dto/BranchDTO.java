package poly.dto;

public class BranchDTO {
	private int branch_no;
	private String branch_addr1, branch_addr2, branch_name, member_id;
	public int getBranch_no() {
		return branch_no;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public void setBranch_no(int branch_no) {
		this.branch_no = branch_no;
	}
	public String getBranch_addr1() {
		return branch_addr1;
	}
	public void setBranch_addr1(String branch_addr1) {
		this.branch_addr1 = branch_addr1;
	}
	public String getBranch_addr2() {
		return branch_addr2;
	}
	public void setBranch_addr2(String branch_addr2) {
		this.branch_addr2 = branch_addr2;
	}
	public String getBranch_name() {
		return branch_name;
	}
	public void setBranch_name(String branch_name) {
		this.branch_name = branch_name;
	}
	
}
