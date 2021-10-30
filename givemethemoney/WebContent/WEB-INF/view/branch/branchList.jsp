<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="poly.dto.BranchDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "poly.util.CmmUtil" %>
<%
	session.setAttribute("SESSION_MEMBER_ID", "MEMBER01");
	List<BranchDTO> bList = (List<BranchDTO>)request.getAttribute("bList");
	if(bList ==null){
		bList = new ArrayList<BranchDTO>();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function doDetail(branch_no){
	location.href="/branch/detailBranch.do?branch_no="+branch_no;
}
</script>
</head>
<body>
	<h2>지점 리스트</h2>
	<hr>
	<br>
	<table border="1">
		<tr align="center">
			<td width="100">지점번호</td>
			<td width="200">지점명</td>
			<td width="400">지점기본주소</td>
			<td width="400">지점상세주소</td>
		</tr>
	<%
	for(int i = 0; i<bList.size(); i++){
		BranchDTO bDTO = bList.get(i);
		if(bDTO ==null){
			bDTO = new BranchDTO();
		}
	
	%>
		<tr align="center">
			<td>
				<%=CmmUtil.nvl(Integer.toString(bDTO.getBranch_no()))%>
			</td>
			<td>
				<a href="javascripot:doDetail('<%=CmmUtil.nvl(Integer.toString(bDTO.getBranch_no())) %>');">
				<%=CmmUtil.nvl(bDTO.getBranch_name()) %>
				</a>
			</td>
			<td>
				<%=CmmUtil.nvl(bDTO.getBranch_addr1()) %>
			</td>
			<td>
				<%=CmmUtil.nvl(bDTO.getBranch_addr2()) %>
			</td>
	<%} %>
	</table>
	<a href="/branch/insertBranch.do">[지점 등록]</a>
</body>
</html>