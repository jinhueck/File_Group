<%@ page contentType="text/html; charset=euc-kr" %>
<jsp:useBean id="test" class="ch08.SimpleBean" scope="page" />
<jsp:setProperty name="test" property="message" value="���� ���� ��������!" />

<html>
<body>

<h1>������ �� ���α׷���</h1>
<br>
Message: <jsp:getProperty name="test" property="message" />

</body>
</html>