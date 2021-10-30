<%@page import="poly.dto.BranchDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="poly.util.CmmUtil" %>
<%
	BranchDTO bDTO = (BranchDTO)request.getAttribute("rDTO");
	if(bDTO == null){
		bDTO = new BranchDTO();
	}
	String ss_member_id =CmmUtil.nvl((String)session.getAttribute("SESSION_MEMBER_ID"));
	int edit = 1;
	if(ss_member_id.equals("")){
		edit =3;
	}else if(ss_member_id.equals(CmmUtil.nvl(bDTO.getMember_id()))){
		edit=2;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function doEdit(){
		if("<%=edit%>"==2){
			location.href="/branch/updateBranch.do?branch_no=<%=CmmUtil.nvl(Integer.toString((bDTO.getBranch_no())))%>";
		}else if("<%=edit%>"==3){
			alert("로그인하시길 바랍니다.")
		}else{
			alert("본인이 등록한 지점만 수정가능합니다.")
		}
	}
	//삭제하기
	function doDelete(){
		if("<%=edit%>"==2){
			if(confirm("작성한 글을 삭제하시겠습니까?")){				
			location.href="branch/deleteBranch.do?branch_no=<%=CmmUtil.nvl(Integer.toString(bDTO.getBranch_no()))%>";
			}
		}else if("<%=edit%>"==3){
			alert("로그인 하시길 바랍니다.")
		}else{
			alert("본인이 등록한 지점만 수정가능합니다.")
		}
	}
	function doList(){
		location.href="/branch/branchList.do";
	}
</script>
</head>
<body>
	<table border="1">
		<tr>
			<td>
				지점명
			</td>
			<td>
				<%=CmmUtil.nvl(bDTO.getBranch_name()) %>	
			</td>
		</tr>
		<tr>
			<td>
				지점기본주소
			</td>
			<td>
				<%=CmmUtil.nvl(bDTO.getBranch_addr1()) %>
			</td>
		</tr>
		<tr>
			<td>
				지점상세주소
			</td>
			<td>
				<%=CmmUtil.nvl(bDTO.getBranch_addr2()) %>
			</td>
		</tr>
		<tr>
			<td>
				<a href="javascript:doEdit();">[수정]</a>
				<a href="javascript:doDelete();">[삭제]</a>
				<a href="javascript:doList();">[목록]</a>
			</td>
		</tr>
	</table>
</body>
</html>