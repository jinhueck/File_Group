<%@ page contentType="text/html; charset=euc-kr" %>
<html>
<head>
	<title>���ǻ�뿹��(���ǻ���)</title>
</head>
<body>
<%
	String strId = "mistarry";
	String strPw = "hello";

	session.setAttribute("logID", strId);
	session.setAttribute("logPW", strPw);
%>
������ �����Ǿ����ϴ�.<br/>

<a href="viewSessionInfo.jsp">���������� Ȯ���ϴ� �������� �̵�</a>
</body>
</html>


