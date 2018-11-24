<h1>Forward Tag Example1</h1>
<%@page contentType="text/html;charset=EUC-KR"%>
<%
	String id = request.getParameter("id");
	String password = request.getParameter("password");
%>
당신의 아이디는<b><%=id%></b>이고<p>
패스워드는 <b><%=password%></b> 입니다.