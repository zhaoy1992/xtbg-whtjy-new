<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
%>
<html>
<head>
<%@ include file="/epp/css/cssControl.jsp"%>
<script type="text/javascript">
		
function xml2pt(){
	var userFileUrl = document.getElementById("userFileUrl").value;
	var orgFileUrl = document.getElementById("orgFileUrl").value;
	var orgUserFileUrl = document.getElementById("orgUserFileUrl").value;
	if(userFileUrl==""){
		alert("��ѡ���û����ļ�");
		return false;
	}
	if(orgFileUrl==""){
		alert("��ѡ��������ļ�");
		return false;
	}
	if(orgUserFileUrl==""){
		alert("��ѡ������û��������ļ�");
		return false;
	}
	document.getElementById("type").value = "imp";
	if(confirm("ͬ��������ƽ̨�����û����ݣ�ȷ��ͬ����")){
		document.xmlForm.submit();
	}
}		
function pt2xml(){
	var savePath = document.getElementById("savePath").value;
	if(savePath==""){
		alert("��ѡ�񵼳�Ŀ¼");
		return false;
	}
	//if(verify(tt)
		document.getElementById("type").value = "exp";
		if(confirm("ȷ��������")){
			document.xmlForm.submit();
		}
	//}
}
function check(sb){
	//var userFileUrl = document.getElementById('userFileUrl').value;
	//var orgFileUrl = document.getElementById('orgFileUrl').value;
	//var orgUserFileUrl = document.getElementById('orgUserFileUrl').value;
	//var userJobFileUrl = document.getElementById('userJobFileUrl').value;
	//if(sb=='td_sm_user'){
	//	var file = document.getElementById('userFileUrl');
	//	if(userFileUrl.indexOf('.xml')<=0){
	//		clearFileInput(file);
	//		alert('��ѡ����ļ���ʽ���ԣ�������ѡ��');
	//		return false;
	//	}
	//	if(userFileUrl.indexOf(sb)<0){
	//		clearFileInput(file);
	//		alert('��ѡ��Ĳ����û����ļ���������ѡ��');
	//		return false;
	//	}
	//	if(userFileUrl.indexOf(sb+"job")>0){
	//		clearFileInput(file);
	//		alert('��ѡ��Ĳ����û����ļ���������ѡ��');
	//		return false;
	//	}
	//}
//	if(sb=='td_sm_organization'){
//		var file = document.getElementById('orgFileUrl');
//		if(orgFileUrl.indexOf('.xml')<=0){
//			clearFileInput(file);
//			alert('��ѡ����ļ���ʽ���ԣ�������ѡ��');
//			return false;
//		}
//		if(orgFileUrl.indexOf(sb)<0){
//			clearFileInput(file);
//			alert('��ѡ��Ĳ��ǻ������ļ���������ѡ��');
//			return false;
//		}
//	}
//	if(sb=='td_sm_orguser'){
//		var file = document.getElementById('orgUserFileUrl');
//		if(orgUserFileUrl.indexOf('.xml')<=0){
//			clearFileInput(file);
//			alert('��ѡ����ļ���ʽ���ԣ�������ѡ��');
//			return false;
//		}
//		if(orgUserFileUrl.indexOf(sb)<0){
//			clearFileInput(file);
//			alert('��ѡ��Ĳ��ǻ����û���ϵ���ļ���������ѡ��');
//			return false;
//		}
//	}

	var xmlfile = document.getElementById('xmlfile');
	if(sb=='xmlfile'){
		if(xmlfile.value.indexOf('.zip')<=0){
			clearFileInput(xmlfile);
			alert('��ѡ����ļ���ʽ���ԣ�������ѡ��!');
			return false;
		}
	}
}
//���fileԪ�ص�ֵ
function clearFileInput(file){
    var form=document.createElement('form');
    document.body.appendChild(form);
    //��סfile�ھɱ��еĵ�λ��
    var pos=file.nextSibling;
    form.appendChild(file);
    form.reset();
    pos.parentNode.insertBefore(file,pos);
    document.body.removeChild(form);
}
//function verify(tt){         
//����	var pattern =/^([a-zA-Z]){1}:(\\[a-zA-Z])*(\\)?$/;
//	flag = pattern.test(tt);     
//	if(flag){
//		return true;  
//	}else{     
//		alert("��ʽ����!"); 
//		return false;    
//	}     
//}    
function onsub(){
	document.getElementById("sub").disabled=true;
} 
</script>
</head>
<body class="contentbodymargin" >
<form name="uploadForm" method="post" action="xmlupload_do.jsp" enctype="multipart/form-data" target="uploadframe" onsubmit="onsub();">
		<input type="hidden" name="type" value=""/>
			<table cellspacing="0" cellpadding="0" border="0" bordercolor="#EEEEEE" align="center" width=100% class="thin">
				<tr>
					<td align="center" colspan=3><b>�����û�XML�ļ�</b></td>
				</tr>
				<tr align="center">
					<td nowrap width="33%">
					XML�ļ�ѹ������<input name="xmlfile" type="file" value="" onchange="check('xmlfile')" size="80"/>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input id="sub" name="sub" type="submit" value="�ϴ�xmlѹ����" class="input">
					</td>
					<%--<td nowrap width="33%">
					�û����ļ���<input name="userFileUrl" type="file" value="" onchange="check('td_sm_user')"/>
					</td><td nowrap width="33%">
					�������ļ���<input name="orgFileUrl" type="file" value="" onchange="check('td_sm_organization')"/>
					</td>
					<td nowrap width="33%">
					�������ļ���<input name="orgUserFileUrl" type="file" value="" onchange="check('td_sm_orguser')"/>
					</td>--%><%--<td nowrap width="33%">
					��λ���ļ���<input name="userJobFileUrl" type="file" value="" onchange="check('td_sm_userjoborg')"/>
					</td>
				--%></tr>
				<%--<tr>
					<td nowrap>
					�����ļ�Ŀ¼��<input name="savePath" type="text" value="D:\"/>
					<font color=red>������ƽ̨(�û����������û�����������)3��xml�ļ��������Ŀ¼�£��ļ����ݡ�����+��ǰʱ�䡿����</font>
					<input id="imp_bt" type="button" value="����" class="input" onclick="pt2xml()"/>
					</td>
				</tr>
					
			--%></table>
	</form>
	<iframe name="uploadframe" width="0" height="0" style="display: none;"></iframe>
</body>
</html>