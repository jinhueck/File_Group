<%@ page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="bean" class="ch17.ELBean"/>
<jsp:setProperty name="bean" property="siteName"/>
<html>
<head>
<title>Expression Language</title>
</head>
<body>
<h2>EL�� Beans</h2>
����׼� �±�<br/> 
SITEBEAN : <jsp:getProperty name="bean"  property="siteName"/><p/>
EL Beans <br/>
SITEBEAN : ${bean.siteName}
</body>
</html>