<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="poly.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%	session.setAttribute("member_team", 2);
	List<MemberDTO> mList = (List<MemberDTO>)request.getAttribute("mList");
	if (mList ==null){
		mList = new ArrayList<MemberDTO>();
	}
%>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/resource/js/bootstrap.js"></script>
<link rel="stylesheet" href="/resource/css/sb-admin-2.css">
<link rel="stylesheet" href="/resource/css/sb-admin-2.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resource/css/bootstrap.css">
<script type="text/javascript">
	function doAdd(member_no){
		location.href="/leader/addStaff.do?member_no="+member_no;
	}
</script>
</head>
<body>
<script type="text/javascript" src="/resource/css/sb-admin-2.css"></script>
	<table border="1">
		<tr>
			<td>직원번호</td>
			<td>이름</td>
			<td>아이디</td>
			<td>이메일</td>
			<td>팀이름</td>
			<td>추가</td>
		</tr>
	<%
		for(int i=0; i<mList.size();i++){
			MemberDTO mDTO = mList.get(i);
			if(mDTO==null){
				mDTO = new MemberDTO();
			}
			
	%>
		<tr>
			<td><%=mDTO.getMember_no() %></td>
			<td><%=mDTO.getMember_name() %></td>
			<td><%=mDTO.getMember_id() %></td>
			<td><%=mDTO.getMember_email() %></td>
			<td><%=mDTO.getTeam_name() %></td>
			<td><a href="javascript:doAdd('<%=mDTO.getMember_no()%>');">추가</a></td>
	<%
	}
	%>
	</table>
</body>
</html>
