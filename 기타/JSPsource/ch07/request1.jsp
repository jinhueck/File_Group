<h1>Request Example1</h1>
<%@ page contentType="text/html;charset=EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<%
	String name = request.getParameter("name");
	String studentNum = request.getParameter("studentNum");
	String sex = request.getParameter("sex");
	String major = request.getParameter("major");

	if(sex.equals("man")){
	sex = "����";
	}else{
		sex = "����";
	}
%>
<body>
���� : <%=name%><p>
�й� : <%=studentNum%><p>
���� : <%=sex%><p>
�а� : <%=major%>
</body>

