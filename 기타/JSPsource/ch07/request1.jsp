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
	sex = "남자";
	}else{
		sex = "여자";
	}
%>
<body>
성명 : <%=name%><p>
학번 : <%=studentNum%><p>
성별 : <%=sex%><p>
학과 : <%=major%>
</body>

