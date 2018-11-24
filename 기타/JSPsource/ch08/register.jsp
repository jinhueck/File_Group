<%@ page contentType="text/html; charset=euc-kr" %>
<html>
<head>
<title>회원가입</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>
</head>

<body bgcolor="#996600">
<table width="80%" align="center" border="0" cellspacing="0" cellpadding="5" >
  <tr> 
    <td align="center" valign="middle" bgcolor="#FFFFCC"> 
      <table width="90%" border="1" cellspacing="0" cellpadding="2"  align="center">
        <form name="regForm" method="post" action="registerProc.jsp">
          <tr align="center" bgcolor="#996600"> 
            <td colspan="3"><font color="#FFFFFF"><b>회원 가입</b></font></td>
          </tr>
          <tr> 
            <td width="24%">아이디</td>
            <td width="35%"> <input type="text" name="mem_id" size="15"> </td>
            <td width="41%">아이디를 적어 주세요.</td>
          </tr>
          <tr> 
            <td>패스워드</td> 
            <td> <input type="password" name="mem_passwd" size="15"> </td>
            <td>패스워드를 적어주세요.</td>
          </tr>
          <tr> 
            <td>패스워드 확인</td>
            <td> <input type="password" name="mem_repasswd" size="15"> </td>
            <td>패스워드를 확인합니다.</td>
          </tr>
          <tr>  
            <td>이름</td>
            <td> <input type="text" name="mem_name" size="15"> </td>
            <td>고객실명을 적어주세요.</td>
          </tr>
          <tr> 
            <td>이메일</td>
            <td> <input type="text" name="mem_email" size="27"> </td>
            <td>이메일을 적어주세요</td>
          </tr>
          <tr>  
            <td>전화번호</td>
            <td> <input type="text" name="mem_phone" size="20"> </td>
            <td>연락처를 적어주세요</td>
          </tr>
          <tr> 
            <td colspan="3" align="center"> 
             <input type="button" value="회원가입" onclick="inputCheck()"> 
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
             <input type="reset" value="다시쓰기"> 
            </td>
          </tr>
        </form>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
