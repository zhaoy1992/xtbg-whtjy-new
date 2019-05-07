<%response.setHeader("Pragma","No-cache");response.setHeader("Cache-Control","no-cache");response.setDateHeader("Expires", 0);%>
<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.dictionary.input.*"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%
    String id = (String)request.getParameter("id");
    String actiontype = request.getParameter("actiontype");
    InputTypeManager inputImpl = new InputTypeManagerImpl();
    InputType type = inputImpl.getInputTypeInfoById(id);
%>
<html>
	<head>
		<%
			if("add".equals(actiontype)){
		%>
		<title>������������</title>
		<%}else{%>
		<title>�޸��������͡�<%=type.getInputTypeName()%>��</title>
		<%}%>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
		<script language="JavaScript">
		var message="";
		//�ύ����
		function SaveData()
		{
		    if(!check())
		    {
		    	alert(message);
		    	return;
		    }
		    //flag    1������2�޸�
		    var flag=2;
		    if(document.all.actiontype.value!="update") {
		        flag=1;
		    }
		    InputTypeForm.target="hiddenframe";
			InputTypeForm.action="inputTypeSubmit.jsp?flag="+flag;
			InputTypeForm.submit();
		}
		
		//��¼����Ϣ���м��
		function check()
		{
		    message="";
		    var allowSubmit=true;
		    var typeDescValue=document.all.typeDesc.value;
		    var sourcePathValue=document.all.sourcePath.value;
		    var typeNameValue=document.all.typeName.value;
		    if(typeNameValue=="")
		    {
		    	message+="��*Ϊ������\n";
		    	allowSubmit=false;
		    }
		    	    	
		    if(typeDescValue.search(/[\\\/\|:\*\?<>"']/g)!=-1)
			{
				message+="* ������Ϣ�а�����\\/|:*?<>\"'!�ȷǷ��ַ�\n";
				allowSubmit=false;
			}
			if(sourcePathValue.search(/[\\\/\|:\*\?<>"']/g)!=-1)
			{
				message+="* ����Դѡ��ҳ���ַ�а�����\\/|:*?<>\"'!�ȷǷ��ַ�\n";
				allowSubmit=false;
			}			
			if(typeDescValue.length>200)
			{
				message+="* ������Ϣ��������ַ���\n";
				document.all.typeDesc.value=typeDescValue.substring(0,200);
				allowSubmit=false;
			}
			if(sourcePathValue.length>200)
			{
				message+="* ����Դѡ��ҳ���ַ��������ַ���\n";
				document.all.sourcePath.value=sourcePathValue.substring(0,200);
				allowSubmit=false;
			}
			return allowSubmit;
		}
		//��ʼ������
		/*
		function loadForm()
		{
			var obj = window.dialogArguments;
			if(obj!=null)
			{
				//��ģ̬���崫�ݵĲ������н���
				document.all.inputTypeId.value=obj.inputTypeId;
				document.all.typeDesc.value=obj.typeDesc;
				document.all.sourcePath.value=obj.sourcePath;
				document.all.typeName.value=obj.typeName
			}
		}*/
		</script>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
		<form name="InputTypeForm" action="" method="post">
		<br>
		<%
			if("add".equals(actiontype)){
		%>
		<table width="100%" border="0"  align="center" cellpadding="0" cellspacing="1" class="thin">
			<tr><td class="detailtitle" width="36%" align="right"><strong>������������*</strong></td><td><input type="text" id="typeName" name="typeName"  /></td></tr>
			<tr><td class="detailtitle" width="36%" align="right"><strong>�������ͽű�</strong></td><td><textarea type="text" id="typeScript" name="typeScript" rows="3" style="width:220" ></textarea></td></tr>
			<tr><td class="detailtitle" width="36%" align="right"><strong>������������</strong></td><td><textarea type="text" id="typeDesc" name="typeDesc" rows="3" style="width:220" ></textarea></td></tr>
			<tr><td class="detailtitle" width="36%" align="right"><strong>����Դѡ��ҳ���ַ</strong></td><td><input type="text" style="width:220" id="sourcePath" name="sourcePath" /></td></tr>
		</table>
		<%}else{%>
		<table width="100%" border="0"  align="center" cellpadding="0" cellspacing="1" class="thin">
			<tr><td class="detailtitle" width="36%" align="right"><strong>������������*</strong></td><td><input type="text" id="typeName" name="typeName" value="<%=type.getInputTypeName()%>" /></td></tr>
			<tr><td class="detailtitle" width="36%" align="right"><strong>�������ͽű�</strong></td><td><textarea type="text" id="typeScript" name="typeScript" rows="3" style="width:220" ><%=type.getInputScript()%></textarea></td></tr>
			<tr><td class="detailtitle" width="36%" align="right"><strong>������������</strong></td><td><textarea type="text" id="typeDesc" name="typeDesc" rows="3" style="width:220" ><%=type.getInputTypeDesc()%></textarea></td></tr>
			<tr><td class="detailtitle" width="36%" align="right"><strong>����Դѡ��ҳ���ַ</strong></td><td><input type="text" style="width:220" id="sourcePath" name="sourcePath" value="<%=type.getDataSourcePath()%>" /></td></tr>
		</table>
		<%}%>
		<input type="hidden" name="inputTypeId" value="<%=id%>"/>
		<input type="hidden" name="actiontype" value="<%=actiontype%>"/>
		<br>
		<div align="center">
			<input name="button" type="button" class="input" onclick="SaveData()" value="����">
			<input name="button" type="button" class="input" onclick="window.close()" value="ȡ��">
		</div>
		</form>
	<IFRAME name="hiddenframe" width="0" height="0"></IFRAME>
	</body>
</html>
