<%@ page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mMgr" class="ch13.MemberMgr"/>
<%
	  request.setCharacterEncoding("euc-kr");
	  String cPath = request.getContextPath();
	  String id = request.getParameter("id");
	  String pass = request.getParameter("pass");
	  String url = cPath+"/ch16/left.jsp";
	  String msg = "로그인에 실패 하였습니다.";
	  
	  boolean result = mMgr.loginMember(id,pass);
	  if(result){
	    session.setAttribute("idKey",id);
	    msg = "로그인에 성공 하였습니다.";
	  }
%>
<script>
	alert("<%=msg%>");
	top.document.location.reload(); 
	location.href="<%=url%>";
</script>