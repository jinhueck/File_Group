<%@ page contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("euc-kr");%>
<jsp:useBean id="pMgr" class="ch15.PollMgr"/>
<jsp:useBean id="plBean" class="ch15.PollListBean"/>
<jsp:setProperty property="*" name="plBean"/>
<jsp:useBean id="piBean" class="ch15.PollItemBean"/>
<jsp:setProperty property="*" name="piBean"/>
<%
		String sdate = request.getParameter("sdateY")+"-"+
								request.getParameter("sdateM")+"-"+
								request.getParameter("sdateD");
		String edate = request.getParameter("edateY")+"-"+
								request.getParameter("edateM")+"-"+
								request.getParameter("edateD");
		plBean.setSdate(sdate);
		plBean.setEdate(edate);
		boolean flag = pMgr.insertPoll(plBean,piBean);
		String msg = "���� �߰��� ���� �Ͽ����ϴ�.";
		String url = "pollInsert.jsp";
		if(flag){
			msg = "������ �߰� �Ǿ����ϴ�.";
			url = "pollList.jsp";
		}
%>
<script>
   alert("<%=msg%>");
   location.href="<%=url%>";
</script>