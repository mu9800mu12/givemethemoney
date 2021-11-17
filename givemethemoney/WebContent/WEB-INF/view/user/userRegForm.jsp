<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 화면</title>

<script type="text/javascript">
   //회원가입 정보의 유효성 체크하기
   function doRegUserCheck(f){
      
      if (f.MEMBER_ID.value==""){
         alert("아이디를 입력하세요.");
         f.user_id.focus();
         return false;
      }
      
      if (f.MEMBER_NAME.value==""){
         alert("이름을 입력하세요.");
         f.user_name.focus();
         return false;
      }
      
      if (f.MEMBER__PW.value==""){
         alert("비밀번호를 입력하세요.");
         f.password.focus();
         return false;
      }
      
      if (f.MEMBER_PW2.value==""){
         alert("비밀번호확인을 입력하세요.");
         f.password2.focus();
         return false;
      }
      
      if (f.MEMBER_EMAIL.value==""){
         alert("이메일을 입력하세요.");
         f.email.focus();
         return false;
      }
      
      if (f.MEMBER_ADDR1.value==""){
         alert("주소를 입력하세요.");
         f.addr1.focus();
         return false;
      }
      
      if (f.MEMBER_ADDR2.value==""){
         alert("상세주소를 입력하세요.");
         f.addr2.focus();
         return false;
      }
   }
</script>


</head>
<body>

<h1>회원가입 화면</h1>
<br/>
<br/>
<form name="f" method="post" action="/user/insertUserInfo.do" onsubmit="return doRegUserCheck(this);">
<table border="1">
<col width="150px">
<col width="150px">
<col width="150px">
<col width="150px">
<tr>
   <td>아이디</td>
   <td><input type="text" name="MEMBER_ID" style="width:150px"/></td>
   <td>이름</td>
   <td><input type="text" name="MEMBER_NAME" style="width:150px"/></td>
</tr>
<tr>
   <td>비밀번호</td>
   <td><input type="password" name="MEMBER__PW" style="width:150px"/></td>
   <td>비밀번호 확인</td>
   <td><input type="password" name="MEMBER_PW2" style="width:150px"/></td>
</tr>
<tr>
   <td>이메일</td>
   <td colspan="3"><input type="text" name="MEMBER_EMAIL" style="width:450px"/></td>
</tr>
<tr>
   <td>주소</td>
   <td colspan="3"><input type="text" name="MEMBER_ADDR1" style="width:450px"/></td>
</tr>
<tr>
   <td>상세</td>
   <td colspan="3"><input type="text" name="MEMBER_ADDR2" style="width:450px"/></td>
</tr>
</table>
<input type="submit" value="회원가입" />
</form>
</body>
</html>