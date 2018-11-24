<h1>Forward Tag Example1</h1>
<%@page contentType="text/html;charset=EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<html>
<body>
Forward Tag의 포워딩 되기 전의 페이지입니다.
	<jsp:forward page="forwardTag1_2.jsp" />
</body>
</html>