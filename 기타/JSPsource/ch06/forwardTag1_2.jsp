<h1>Forward Tag Example1</h1>
<%@page contentType="text/html;charset=EUC-KR"%>
<%
	String id = request.getParameter("id");
	String password = request.getParameter("password");
%>
����� ���̵��<b><%=id%></b>�̰�<p>
�н������ <b><%=password%></b> �Դϴ�.