function inputCheck(){
	if(document.regForm.mem_id.value==""){
		alert("���̵� �Է��� �ּ���");
		document.regForm.mem_id.focus();
		return;
	}
	if(document.regForm.mem_passwd.value==""){
		alert("��й�ȣ�� �Է��� �ּ���");
		document.regForm.mem_passwd.focus();
		return;
	}
	if(document.regForm.mem_repasswd.value==""){
		alert("��й�ȣ�� �Է��� �ּ���");
		document.regForm.mem_repasswd.focus();
		return;
	}
	if(document.regForm.mem_name.value==""){
		alert("�̸��� �Է��� �ּ���");
		document.regForm.mem_name.focus();
		return;
	}
	if(document.regForm.mem_email.value==""){
		alert("�̸����� �Է��� �ּ���");
		document.regForm.mem_email.focus();
		return;
	}
	if(document.regForm.mem_phone.value==""){
		alert("����ó�� �Է��� �ּ���");
		document.regForm.mem_phone.focus();
		return;
	}
	
	if(document.regForm.mem_passwd.value != document.regForm.mem_repasswd.value){
		alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�");
		document.regForm.mem_repasswd.focus();
		return;
	}
	document.regForm.submit();
}