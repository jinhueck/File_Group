<h1>Include Tag Example1</h1>
<%@page contentType="text/html;charset=EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
	String name = "Korea Football";
%>
<html>
<body>
<jsp:include page="includeTagTop1.jsp" />
include ActionTag�� Body�Դϴ�.
</body>
</html>