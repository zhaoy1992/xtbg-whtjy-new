<%@ page contentType="text/html; charset=GBK" %>
<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", -1);
	//prevents caching at the proxy server
	response.setDateHeader("max-age", 0); 
%>

<html>
<head>
<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
<script language="javascript">
var mainForm = parent.parent.document.all.addTpltForm;
function setMainForm(){
	var localeForm = document.all.form1;
	mainForm.templateName.value = localeForm.templateName.value;
	mainForm.templateType.value = localeForm.templateType[localeForm.templateType.selectedIndex].value;
	mainForm.templateDesc.value = localeForm.templateDesc.value;
	mainForm.tb_templateHead.value = localeForm.tb_templateHead.value;
}

function OnTemplateName(){
	var localeForm = document.all.form1;
	mainForm.templateName.value = localeForm.templateName.value;
	
}

function OnTemplateType(){
	var localeForm = document.all.form1;
	mainForm.templateType.value = localeForm.templateType[localeForm.templateType.selectedIndex].value;
}

function OntemplateDesc(){
	var localeForm = document.all.form1;
	mainForm.templateDesc.value = localeForm.templateDesc.value;
}

function setMainFormHead(){
	var localeForm = document.all.form1;
	mainForm.tb_templateHead.value = localeForm.tb_templateHead.value;
}

</script>
</head>
  
<body bottommargin="0"  rightmargin="0" leftmargin="5" topmargin="0" background="../images/grayline_bg.jpg" onLoad="setMainForm()">

<form name="form1" id="form1" action="">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			ģ������:
			<input name="templateName" type="text" class="cms_text" id="templateName" size="20" maxlength="40" onpropertychange="OnTemplateName()">
				<span class="red_star">*</span>
		</td>
	</tr>
	<tr>
		<td>
			ģ�����:
			<select name="templateType" class="cms_select" id="templateType" onChange="OnTemplateType()">
				<option value="0">��ҳ</option>
				<option value="1" selected>����</option>
				<option value="2">ϸ��</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>
			ģ������:
			<input name="templateDesc" type="text" class="cms_text" id="templateDesc" size="20" maxlength="100" onpropertychange="OntemplateDesc()">
			<span class="red_star">*</span>
		</td>
	</tr>
	<tr>
		<td>ģ��ͷ:</td>
	</tr>
	<tr>
		<td>
			<textarea id = "tb_templateHead" name="tb_templateHead" cols="33" rows="20" class="cms_textarea" onpropertychange="setMainFormHead()"><html><head><meta http-equiv="Content-Type" content="text/html;charset=gb2312"></head><body></textarea>
		</td>
	</tr>
</table>
</form>
</body>
</html>
