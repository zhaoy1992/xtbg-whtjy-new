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
		<title>新增输入类型</title>
		<%}else{%>
		<title>修改输入类型【<%=type.getInputTypeName()%>】</title>
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
		//提交数据
		function SaveData()
		{
		    if(!check())
		    {
		    	alert(message);
		    	return;
		    }
		    //flag    1新增；2修改
		    var flag=2;
		    if(document.all.actiontype.value!="update") {
		        flag=1;
		    }
		    InputTypeForm.target="hiddenframe";
			InputTypeForm.action="inputTypeSubmit.jsp?flag="+flag;
			InputTypeForm.submit();
		}
		
		//对录入信息进行检查
		function check()
		{
		    message="";
		    var allowSubmit=true;
		    var typeDescValue=document.all.typeDesc.value;
		    var sourcePathValue=document.all.sourcePath.value;
		    var typeNameValue=document.all.typeName.value;
		    if(typeNameValue=="")
		    {
		    	message+="带*为必填项\n";
		    	allowSubmit=false;
		    }
		    	    	
		    if(typeDescValue.search(/[\\\/\|:\*\?<>"']/g)!=-1)
			{
				message+="* 描述信息中包含了\\/|:*?<>\"'!等非法字符\n";
				allowSubmit=false;
			}
			if(sourcePathValue.search(/[\\\/\|:\*\?<>"']/g)!=-1)
			{
				message+="* 数据源选择页面地址中包含了\\/|:*?<>\"'!等非法字符\n";
				allowSubmit=false;
			}			
			if(typeDescValue.length>200)
			{
				message+="* 描述信息超出最大字符数\n";
				document.all.typeDesc.value=typeDescValue.substring(0,200);
				allowSubmit=false;
			}
			if(sourcePathValue.length>200)
			{
				message+="* 数据源选择页面地址超出最大字符数\n";
				document.all.sourcePath.value=sourcePathValue.substring(0,200);
				allowSubmit=false;
			}
			return allowSubmit;
		}
		//初始化窗体
		/*
		function loadForm()
		{
			var obj = window.dialogArguments;
			if(obj!=null)
			{
				//对模态窗体传递的参数进行接收
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
			<tr><td class="detailtitle" width="36%" align="right"><strong>输入类型名称*</strong></td><td><input type="text" id="typeName" name="typeName"  /></td></tr>
			<tr><td class="detailtitle" width="36%" align="right"><strong>输入类型脚本</strong></td><td><textarea type="text" id="typeScript" name="typeScript" rows="3" style="width:220" ></textarea></td></tr>
			<tr><td class="detailtitle" width="36%" align="right"><strong>输入类型描述</strong></td><td><textarea type="text" id="typeDesc" name="typeDesc" rows="3" style="width:220" ></textarea></td></tr>
			<tr><td class="detailtitle" width="36%" align="right"><strong>数据源选择页面地址</strong></td><td><input type="text" style="width:220" id="sourcePath" name="sourcePath" /></td></tr>
		</table>
		<%}else{%>
		<table width="100%" border="0"  align="center" cellpadding="0" cellspacing="1" class="thin">
			<tr><td class="detailtitle" width="36%" align="right"><strong>输入类型名称*</strong></td><td><input type="text" id="typeName" name="typeName" value="<%=type.getInputTypeName()%>" /></td></tr>
			<tr><td class="detailtitle" width="36%" align="right"><strong>输入类型脚本</strong></td><td><textarea type="text" id="typeScript" name="typeScript" rows="3" style="width:220" ><%=type.getInputScript()%></textarea></td></tr>
			<tr><td class="detailtitle" width="36%" align="right"><strong>输入类型描述</strong></td><td><textarea type="text" id="typeDesc" name="typeDesc" rows="3" style="width:220" ><%=type.getInputTypeDesc()%></textarea></td></tr>
			<tr><td class="detailtitle" width="36%" align="right"><strong>数据源选择页面地址</strong></td><td><input type="text" style="width:220" id="sourcePath" name="sourcePath" value="<%=type.getDataSourcePath()%>" /></td></tr>
		</table>
		<%}%>
		<input type="hidden" name="inputTypeId" value="<%=id%>"/>
		<input type="hidden" name="actiontype" value="<%=actiontype%>"/>
		<br>
		<div align="center">
			<input name="button" type="button" class="input" onclick="SaveData()" value="保存">
			<input name="button" type="button" class="input" onclick="window.close()" value="取消">
		</div>
		</form>
	<IFRAME name="hiddenframe" width="0" height="0"></IFRAME>
	</body>
</html>
