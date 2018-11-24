<h1>Include Tag Example2</h1>
<%@page contentType="text/html;charset=EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
	String siteName = request.getParameter("siteName");
%>
<html>
<body>
<jsp:include page="includeTagTop2.jsp">
<jsp:param name="siteName" value="JSPStudy.co.kr" />
</jsp:include>
include ActionTag의 Body입니다.<p>
<b><%=siteName%></b>
<hr>

</body>
</html>