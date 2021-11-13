<%@ page import="poly.util.CmmUtil" %><%--
  Created by IntelliJ IDEA.
  User: data31
  Date: 2021-11-12
  Time: 오후 8:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String code = CmmUtil.nvl(request.getParameter("code"));%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<p>
    인증코드를 받았습니다. 이제 토큰을 요청합니다.2
</p>
<%=code%>
<form action="https://www.googleapis.com/oauth2/v4/token" method="post" enctype="application/x-www-form-urlencoded">

    code : <input type="text" name="code" value="<%=code%>"/><br>
    client_id : <input type="text" name="client_id" value="628436835758-t8tve6vlo721pq3g8s8f0add5tg90r03.apps.googleusercontent.com"/><br>
    client_secret : <input type="text" name="client_secret" value="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"/><br>
    redirect_uri : <input type="text" name="redirect_uri" value="http://localhost:8087/google/oauth/authcode.do"/><br>
    grant_type : <input type="text" name="grant_type" value="authorization_code"/><br>
    send : <input type="submit" value="submit">
</form>
<a href="/index.do">처음으로 돌아가기</a>
</body>
</html>
