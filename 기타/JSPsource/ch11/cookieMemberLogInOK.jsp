<%@ page contentType="text/html; charset=euc-kr" %>
<jsp:useBean id="memMgr" class="ch11.MemberMgr" />
<%
    String memberId = "";
	String memberPw = "";
	if(request.getParameter("memberid") != null)  
	   memberId  = request.getParameter("memberid");
	if(request.getParameter("memberpw") != null) 
	   memberPw  = request.getParameter("memberpw");
	if(memMgr.passCheck(memberId, memberPw)){
		Cookie cookie = new Cookie("memID", memberId);
		response.addCookie(cookie);
%>
	<script> 
	  alert("�α��� �Ǿ����ϴ�.");
      location.href="cookieLogInConfirm.jsp";
	</script>
<%	}else{ %>
	<script>
	  alert("�α��� ���� �ʾҽ��ϴ�.");
      location.href="cookieMemberLogIn.jsp";
	</script>
<%	}	%>