<%@ page contentType="text/html;charset=EUC-KR"
         session="true"
%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<%
	String id = request.getParameter("id");
	String password = request.getParameter("password");

    session.setAttribute("idKey",id);
	session.setMaxInactiveInterval(60*5);
%>
<h1>Session Example1</h1>
<FORM METHOD=POST ACTION="session1_1.jsp">
    1.가장 좋아하는 계절은?<br>
	<INPUT TYPE="radio" NAME="season" VALUE="봄">봄
	<INPUT TYPE="radio" NAME="season" VALUE="여름">여름
	<INPUT TYPE="radio" NAME="season" VALUE="가을">가을
	<INPUT TYPE="radio" NAME="season" VALUE="겨울">겨울<p>

	2.가장 좋아하는 과일은?<br>
	<INPUT TYPE="radio" NAME="fruit" VALUE="watermelon">수박
	<INPUT TYPE="radio" NAME="fruit" VALUE="melon">멜론
	<INPUT TYPE="radio" NAME="fruit" VALUE="apple">사과
	<INPUT TYPE="radio" NAME="fruit" VALUE="orange">오렌지<p>
	<INPUT TYPE="submit" VALUE="결과보기">
</FORM>