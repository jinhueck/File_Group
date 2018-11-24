<%@ page contentType="text/html; charset=euc-kr" %>
<html>
<head>
	<title>세션사용예제(세션생성)</title>
</head>
<body>
<%
	String strId = "mistarry";
	String strPw = "hello";

	session.setAttribute("logID", strId);
	session.setAttribute("logPW", strPw);
%>
세션이 생성되었습니다.<br/>

<a href="viewSessionInfo.jsp">세션정보를 확인하는 페이지로 이동</a>
</body>
</html>


