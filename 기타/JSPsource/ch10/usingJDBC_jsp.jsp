<%@ page contentType="text/html;charset=EUC-KR" import="java.sql.*"%>
<%@ page import="java.util.*, ch10.*"%>

<%
	Class.forName("org.gjt.mm.mysql.Driver");
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;

	String id = "", 
			     passwd = "", 
			     name = "", 
			     num1 = "", 
			     num2 = "", 
			     email = "", 
			     phone = "", 
			     zipcode = "", 
			     address = "", 
			     job = "";
	int counter = 0;
	try {
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myDB", "root", "1111");//Connection ����
		stmt = conn.createStatement();//Statement ����
		rs = stmt.executeQuery("SELECT * FROM tblRegister"); //���ǽ������� ResultSet�� ��´�.
%>
<html>
<head>
<title>JSP���� �����ͺ��̽� ����</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js">
</script>
</head>
<body bgcolor="#FFFFCC">

	<h2>JSP ��ũ��Ʋ������ �����ͺ��̽� ���� �����Դϴ�....</h2>

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
		<%
			if (rs != null) {

					while (rs.next()) {
						id = rs.getString("id");
						passwd = rs.getString("passwd");
						name = rs.getString("name");
						num1 = rs.getString("num1");
						num2 = rs.getString("num2");
						email = rs.getString("email");
						phone = rs.getString("phone");
						zipcode = rs.getString("zipcode");
						address = rs.getString("address");
						job = rs.getString("job");
		%>
		<tr>
			<td><%=id%></td>
			<td><%=passwd%></td>
			<td><%=name%></td>
			<td><%=num1%></td>
			<td><%=num2%></td>
			<td><%=email%></td>
			<td><%=phone%></td>
			<td><%=zipcode%>/<%=address%></td>
			<td><%=job%></td>
			<%
				counter++;
						}//end while

					}//end if
			%>

		</tr>
	</table>
	<br/>
	<br/> total records :
	<%=counter%>
	<%
		} catch (SQLException sqlException) {
			System.out.println("sql exception");
		} catch (Exception exception) {
			System.out.println("exception");
		} finally {
			if (rs != null)
				try {rs.close();} 
				catch (SQLException ex) {}
			if (stmt != null)
				try {stmt.close();} 
				catch (SQLException ex) {}
			if (conn != null)
				try {conn.close();} 
				catch (Exception ex) {}
		}
	%>