<%@ page contentType="text/html;charset=EUC-KR"
         isErrorPage="true"
%>
<%
   String message = exception.getMessage();
   String objectMessage = exception.toString();
%>
<h1>Exception Example1</h1>
���� �޼��� : <b><%=message%></b><p>
���� ��ü�� Ŭ������� ���� �޼���  : <b><%=objectMessage%></b><p>
