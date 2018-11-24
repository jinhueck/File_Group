<h1>Forward Tag Example2</h1>
<%@page contentType="text/html;charset=EUC-KR"%>
<%
 	String name = "JSPStudy";
 	String bloodType = request.getParameter("bloodType");
 %>
<jsp:forward page='<%=bloodType + ".jsp"%>'>
 	<jsp:param name="name" value="<%=name%>"/>
</jsp:forward>