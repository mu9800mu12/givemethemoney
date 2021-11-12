<!-- calendar list scope
https://www.googleapis.com/auth/calendar.readonly https://www.googleapis.com/auth/calendar
enc: https%3a%2f%2fwww.googleapis.com%2fauth%2fcalendar.readonly+https%3a%2f%2fwww.googleapis.com%2fauth%2fcalendar -->

<%--
{"installed":{
"client_id":"628436835758-t8tve6vlo721pq3g8s8f0add5tg90r03.apps.googleusercontent.com",
"project_id":"my-team-project-331622",
"auth_uri":"https://accounts.google.com/o/oauth2/auth",
"token_uri":"https://oauth2.googleapis.com/token",
"auth_provider_x509_cert_url":"https://www.googleapis.com/oauth2/v1/certs",
"client_secret":"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",
"redirect_uris":["urn:ietf:wg:oauth:2.0:oob","http://localhost"]}}
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>asdasd</title>
</head>
<body>

<a href="https://accounts.google.com/o/oauth2/v2/auth?scope=https%3a%2f%2fwww.googleapis.com%2fauth%2fcalendar.readonly+https%3a%2f%2fwww.googleapis.com%2fauth%2fcalendar&access_type=offline&include_granted_scopes=true&response_type=code&state=state_parameter_passthrough_value&redirect_uri=http%3a%2f%2flocalhost%3a8087%2fgoogle%2foauth%2fauthcode.do&client_id=628436835758-t8tve6vlo721pq3g8s8f0add5tg90r03.apps.googleusercontent.com">
    구글 API를 사용할 수 있도록 권한 허용하로 가기
</a>
</body>
</html>
<%--
http://localhost:8087/google/oauth/authcode.do?state=state_parameter_passthrough_value&code=4/0AX4XfWikRkZvsyI3bwjFC3f-qsSIxAnPH1YQH53283Sr8l3NEFHdJBfCzybdIuomVhC1Pg&scope=https://www.googleapis.com/auth/calendar.readonly%20https://www.googleapis.com/auth/calendar
--%>