<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.templatemanager.*"%>
<%@ page import="com.chinacreator.cms.container.*"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader ("Expires", -1);
	response.setDateHeader("max-age", 0);
%>
<html>
<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
<script src="../inc/js/func.js"></script>
<style type="text/css">
<!--
.STYLE5 {color: #0000FF}
-->
</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>ģ�嵼��</title>
</head>
<%
	String siteId = request.getParameter("siteId");
	String templateId = request.getParameter("templateId");
	if(siteId==null||siteId.trim().length()==0||templateId==null||templateId.trim().length()==0){
%>
	<script language="javascript">
		alert("���ṩվ��id��ģ��id");
		top.close();
	</script>
<%		
		return;
	}
%>
<%
Template template = null;
try{
	template = new TemplateManagerImpl().getTemplateInfo(templateId);
	if(template==null){
		throw new Exception("����ģ��id["+templateId+"],û���ҵ����ģ����Ϣ!");	
	}
	if(0==template.getPersistType()){
		throw new Exception("ԭģ�����ݱ��������ݿ���,�޷������滻!");	
	}	
}catch(Exception e){
	e.printStackTrace();
%>
	<script language="javascript">
		alert("<%=e.getMessage()%>");
		top.close();
	</script>
<%
	return;
}
%>
<script language="javascript">
function submitForm(){
	var f = document.all.TemplateForm;
	var action = "template_import_replace_do.jsp?siteId=<%=siteId%>";
	action +="&uri=<%=template.getTemplatePath()%>"
	action +="&action=reimport";

	var templateZip = f.templateZip.value;
	if(templateZip.replace(/\s/ig,"")==""){
		alert("��ָ��ѹ�����˵�ģ��.");
		return;
	}

	if(templateZip.search(/\.zip$/img)==-1){
		alert("ֻ����zip��ʽѹ�����ļ���������ʽ���ļ������ᴦ��!");
		return;		
	}
	f.action=action;
	//alert(f.action);
	f.submit();
}
</script>
<body  bottommargin="0"  background="../images/grayline_bg.jpg" rightmargin="0" leftmargin="0" topmargin="0">

<form method="post" enctype="multipart/form-data"  name="TemplateForm" target="hidFrm" id="TemplateFrm">
<table width="99%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	<tr>
		<td height="77" colspan="4" valign="top" background="../images/toolbar_common_func_template.jpg" style="padding-top:6px; padding-left:50px">ģ�嵼��</td>
	</tr>
	<tr >
		<td width="4%">&nbsp;</td>
		<td width="3%" height="20"><img src="../images/ico_point.gif" width="25" height="25"></td>
		<td width="93%" height="20" colspan="2">&nbsp;<span class="cms_title_blue">����ģ�������Ϣ</span></td>
	</tr>
	<tr>
		<td height="8" colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="4">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="140" height="25" align="right" nowrap class="STYLE5">ѡ�����ģ���ļ�:</td>
					<td>
						<input name="templateZip" type="file" class="cms_file" size="27" />
							<span class="red_star">*</span> (zip�ļ�)
						<input name="siteId" type="hidden" id="siteId" value="<%=request.getParameter("siteId")%>" />
					</td>
				</tr>
				<tr>
					<td width="140" height="25" align="right" nowrap class="STYLE5">ģ������:</td>
					<td><%=template.getName()%>&nbsp;</td>
				</tr>
				<tr>
					<td width="140" height="25" align="right" nowrap class="STYLE5">ģ������:</td>
					<td><%=template.getDescription()%>&nbsp;</td>
				</tr>
				<tr>
					<td width="140" height="25" align="right" nowrap class="STYLE5">&nbsp;ģ������:</td>
					<%
					int templateType = template.getType();
					String type = "";
					if(templateType == 0)
						type = "��ҳ";
					if(templateType == 1)
						type = "����";
					if(templateType == 2)
						type = "ϸ��";
					%>
					<td><%=type%>&nbsp;</td>
				</tr>
	
				<tr>
					<td width="140" height="25" align="right" nowrap class="STYLE5">����ģ���ŵ�·��:</td>
					<td><%=template.getTemplatePath()%>&nbsp;</td>
				</tr>
				<tr>
					<td width="140" height="25" align="right" nowrap class="STYLE5">��ģ���ļ�������:</td>
					<td><%=template.getTemplateFileName()%>&nbsp;</td>
				</tr>	
				<tr align="center">
					<td height="22" colspan="2">
						<input name="btn_ok" type="button" class="cms_button"  value="ȷ��" onClick="submitForm()"/>
						<input name="btn_close" type="button" class="cms_button"  onclick="window.close();" value="�ر�" />
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</form>
<iframe id="hidFrm" name="hidFrm" style="display:none"></iframe>
</body>
</html>
