<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.*, ch10.*"%>
<html>
<head>
<title>JSP���� �����ͺ��̽� ����</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFCC">

<h2>Bean�� ����� �����ͺ��̽� ���� �����Դϴ�....</h2>

<br>
<br>
<h3>ȸ������</h3>
<table bordercolor="#0000ff" border="1">
<tr>
   <td><strong>ID</strong></td>
   <td><strong>PASSWD</strong></td>
   <td><strong>NAME</strong></td>
   <td><strong>NUM1</strong></td>
   <td><strong>NUM2</strong></td>
   <td><strong>EMAIL</strong></td>
   <td><strong>PHONE</strong></td>
   <td><strong>ZIPCODE/ADDRESS</strong></td>
   <td><strong>JOB</strong></td>	
</tr>

<jsp:useBean id="regMgr" class="ch10.RegisterMgr" scope="page" />
<%
   Vector vlist = regMgr.getMemberList();
	int counter = vlist.size();
	for(int i=0; i<vlist.size(); i++){
   		RegisterBean regBean = (RegisterBean)vlist.get(i);
%>
<tr>
<td><%=regBean.getId()%></td>
<td><%=regBean.getPasswd()%></td>
<td><%=regBean.getName()%></td>
<td><%=regBean.getNum1()%></td>
<td><%=regBean.getNum2()%></td>
<td><%=regBean.getEmail()%></td>
<td><%=regBean.getPhone()%></td>
<td><%=regBean.getZipcode()%>/<%=regBean.getAddress()%></td>
<td><%=regBean.getJob()%></td>
<%
   }
%>
</tr>
</table>
<br/>
<br/>
total records : <%= counter %> 
</body>
</html>