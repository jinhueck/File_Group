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
		session.setAttribute("memID",memberId);
%>
	<script> 
	  alert("�α��� �Ǿ����ϴ�.");
      location.href="sessionLogInConfirm.jsp";
	</script>
<%	}else{ %>
	<script>
	  alert("�α��� ���� �ʾҽ��ϴ�.");
      location.href="sessionMemberLogIn.jsp";
	</script>
<%	}	%>