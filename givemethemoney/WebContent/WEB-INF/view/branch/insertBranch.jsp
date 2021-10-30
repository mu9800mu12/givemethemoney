<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="poly.util.CmmUtil" %>
<%
String SESSION_MEMBER_ID = CmmUtil.nvl((String)session.getAttribute("SESSION_MEMBER_ID"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지점 등록</title>
</head>
<script type="text/javascript">
	function doOnload(){
		var member_id = "<%=SESSION_MEMBER_ID%>";
		if(member_id==""){
			alert("로그인된 사용자만 등록 가능합니다.")
		}
	}
	function doSumbit(f){
		if(f.branch_name == ""){
			alert("이름을 입력하시기 바랍니다");
			f.branch_name.focus();
			return false;
		}
		if(calBytes(f.branch_name.value) > 200){
			alert("최대 200Bytes까지 입력가능합니다.");
			f.branch_name.focus();
			return false;
		}
		if(f.branch_addr1 == ""){
			alert("기본주소를 입력하시기 바랍니다.");
			f.branch_addr1.focus();
			return false;
		}
		if(f.branch_addr2 == ""){
			alert("상세주소를 입력하시기 바랍니다.");
			f.branch_addr2.focus();
			return false;
		}
		if(calBytes(f.branch_addr1.value) > 600){
			alert("최대 600Bytes까지 입력가능합니다.");
			f.branch_addr1.focus();
			return false;
		}
		if(calBytes(f.branch_addr2.value) > 600){
			alert("최대 600Bytes까지 입력가능합니다.");
			f.branch_addr2.focus();
			return false;
		}
	}
function calBytes(str){
	var tcount =0;
	var tmpStr = new String(str);
	var strCnt = tmpStr.length;
	var onechar;
	for(i=0; i<strCnt;i++){
		onechar = tmpStr.charAt(i);
		if(escape(onechar).length > 4){
			tcount += 2;
		}else{
			tcount += 1;
		}
	}
		return tcount;
}
</script>
<body onload="doOnload();">
<form name="f" method="post" action="/branch/insertBranch.do" target="ifrPrc" onsubmit="return doSumbit(this);">
	<table border="1">
		<tr>
			<td>지점 이름</td>
			<td><input type="text" name="branch_name" maxlength="100" ></td>
		</tr>
		<tr>
			<td>지점 기본주소</td>
			<td><input type="text" name="branch_addr1"></td>
		</tr>
		<tr>
			<td>지점 상세주소</td>
			<td><input type="text" name="branch_addr2"></td>
		</tr>
		<tr>
			<td><input type="submit" value="등록"></td>
			<td><input type="reset" value="다시 작성"></td>
		</tr>
	</table>
</form>
<iframe name="ifrPrc" style="display:none"></iframe>
</body>
</html>