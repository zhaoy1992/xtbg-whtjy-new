<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@page import="com.chinacreator.cms.documentmanager.*"%>
<%@ page import="com.chinacreator.cms.templatemanager.*"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.cms.customform.*"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", -1);
	response.setDateHeader("max-age", 0);
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
%>
<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
<script src="../inc/js/func.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	function saveTLP(){
	var docTplName = document.all.docTplName.value;
		if(docTplName.replace(/\s/g,"") == ""){
			alert("请输入文档模板名！");
			return;
		}
		if(docTplName.length>30){
		alert("模板文件名过长!");
		return;
		}
		window.dialogArguments.document.all.docTplName.value = document.all.docTplName.value;
		window.dialogArguments.document.all.docTplDescription.value = document.all.docTplDescription.value;
		window.returnValue = "cf";
		window.close();
	}
</SCRIPT>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<title>::文档模板信息:::</title>
</head>
<base target="_self">
<body background="../images/grayline_bg.jpg">
	<form action="doc_extfield_add_do.jsp" method="post"
		name="extfieldForm" target="extfieldexeman" id="extfieldForm">
		<table width="98%" border="0" cellpadding="0" cellspacing="0"
			bgcolor="#FFFFFF" align="center">
			<tr>
				<td width="30%">
					文档模板名称：
				</td>
				<td width="70%" align="left">
					<input name="docTplName" type="text" class="cms_text">
					<font color="red">*</font>
				</td>
			</tr>
			<tr>
				<td>
					文档模板描述：
				</td>
			</tr>
			<tr>
				<td align="center" colspan="2">
					<textarea name="docTplDescription" rows="10" cols="40"></textarea>
				</td>
			</tr>
		</table>
		<br>
		<div style="text-align: center" background="../images/grayline_bg.jpg">
			<INPUT name="button" type="button" class="cms_button"
				onClick="saveTLP()" value="确定">
			&nbsp;
			<INPUT name="button" type="button" class="cms_button"
				onClick="window.close()" value="取消">
		</div>
	</form>
	<iframe name="extfieldexeman" width="0" height="0"
		style="display: none"></iframe>

</body>
</html>