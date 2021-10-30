<%@page import="poly.dto.BranchDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="poly.util.CmmUtil" %>
<%
	BranchDTO bDTO = (BranchDTO)request.getAttribute("rDTO");
	if(bDTO ==null){
		bDTO = new BranchDTO();
	}
	int access = 1;
	if(CmmUtil.nvl(String)session.getAttribute("SESSION_MEMBER_ID")).equals(obj)
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>