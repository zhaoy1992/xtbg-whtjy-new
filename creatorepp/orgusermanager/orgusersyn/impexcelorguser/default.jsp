<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<html>
	<head>
		<title>excel�����û�����</title>
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css"><!-- �ύ��ҳ���� -->
		<script language="javascript" type="text/javascript"
			src="<%=request.getContextPath()%>/orgusermanager/orgusersyn/impexcelorguser/pageGrey.js">
		</script>
		<script type="text/javascript">
			function impExcelOrgUser(){
				var excelUrl = document.getElementById('excelUrl').value;
				if(excelUrl==''){
					alert("��ѡ����Ҫ����Excel�ļ�");
					return false;
				}
				document.getElementById("impButton").disabled=true;
				document.ExcelForm.submit();
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
			function jumpPage(){
			  	document.location.assign("../orgusersyninfo.jsp");
			  }
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body>
		<form name="ExcelForm" action="imp_do.jsp" target="impIfr"
			method="post" enctype="multipart/form-data">
			<div id="contentborder" align="center">
			<br />
			<br />
			<fieldset style="width: 90%;">
				<LEGEND align=center>
					<FONT size="2">EXCEL����ƽ̨</FONT>
				</LEGEND>
				<br />
				<br />
				<input type="file" style="width:80%" name="excelUrl"
							onchange="
							if(this.value.indexOf('.xls')<=0){
								clearFileInput(this);
								alert('��ѡ����ļ���ʽ����ȷ��������ѡ��');
							}
						" />
			</fieldset>
			<div align="right">
			<input type=button name=bt1 value="��һ��" class="input" onclick="jumpPage();"/>
			<input type="button" class="input" name="impButton" value="����"
							onclick="impExcelOrgUser()" />
			<input type="button" value="�ر�" class="input"	onclick="window.close();" />
			</div>			
		</form>
	</body>
	<iframe id="impIfr" name="impIfr" width="0" height="0"></iframe>
</html>
