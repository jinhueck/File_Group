<h1>Forward Tag Example1</h1>
<%@page contentType="text/html;charset=EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<html>
<body>
Forward Tag�� ������ �Ǳ� ���� �������Դϴ�.
	<jsp:forward page="forwardTag1_2.jsp" />
</body>
</html>