<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.container.Template"%>
<%@ page import="com.chinacreator.cms.sitemanager.*"%>
<%@ page import="com.chinacreator.cms.templatemanager.*"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="com.chinacreator.cms.channelmanager.*"%>
<%@ page import="com.chinacreator.cms.flowmanager.*"%>
<%@ page import="com.chinacreator.util.*"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);

	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);

	String siteName = request.getParameter("siteName");
	String siteId   = request.getParameter("siteId");
	String channelId = request.getParameter("channelId");
	String channelName = request.getParameter("channelName");
	if(siteId == null || siteId.trim().length()==0){
	%>
		<script language="javascript" type="text/javascript">
			alert("Ƶ��idΪ��,�޷��༭Ƶ��.");
			self.location.href = "about:blank";
		</script>
	<%
		return;
	}

	ChannelManager cm = new ChannelManagerImpl();
	Channel chnl = cm.getChannelInfo(channelId);
	if (chnl == null) {
	%>
		<script language="javascript" type="text/javascript">
			alert("û���ҵ���Ƶ��,�޷��༭Ƶ��.");
			self.location.href = "about:blank";
		</script>
	<%
		return;
	}
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
	<script src="../inc/js/func.js"></script>
	<title>����Ƶ����ҳģ��</title>
<style type="text/css">
	.topDIV {
		background-image: url(../images/toolbar_common_func_site.jpg);
		height: 82px;
		padding-top: 7px;
		padding-left: 55px;

	body {
		margin-left: 0px;
		margin-top: 0px;
		margin-right: 0px;
		margin-bottom: 0px;
	}
</style>
<script language="javascript">

//վ�㴰���������У��
function checkForm(){
	var siteForm = document.all.siteForm;
	document.all.siteForm.submit();	
}
function updateParentForm()
{
	window.returnValue = siteForm.detailTemplateId.options[siteForm.detailTemplateId.selectedIndex].text;
}
function preview(){
	var siteForm = document.all.siteForm;
	var siteId = "<%=siteId%>";
	var templateId = siteForm.detailTemplateId[siteForm.detailTemplateId.selectedIndex].value;
	//alert("Ԥ��Ƶ��idΪ:"+siteId+",ģ��idΪ"+templateId+"��ģ��!");
	window.open("../templateManage/template_previewbyid.jsp?tplId=" + templateId + "&siteId=<%=siteId%>");
}
function templatePreview(obj){
	for(var i=0;i<obj.options.length;i++){
		if(obj.options[i].selected == true){
			var templatePath = obj.options[i].templatePath; 
			var templateFileName = obj.options[i].templateFileName;
			if(templatePath==undefined){
				alert("δѡ��ģ���ļ�������Ԥ��");
				break;
			}
			pubPreviewFile(templateFileName,templatePath,<%=siteId%>)
		}
	}
}
function pubPreviewFile(filename,uri,siteId) {
		var u = uri.replace("\\", "/").replace(/\s+/img,"");
		if(u.charAt(u.length - 1)!="/")
		{
			u = u+"/";
		}
		if(u=="/")
		{
			u = "";
		} 
		exeman.location.href = "../templateManage/template_pub_preview.jsp?uri="+(u+filename)+"&siteId="+siteId+"&action=preview";
	}
</script>
</head>
<body background="../images/grayline_bg.jpg">
<form id="siteForm" name="siteForm"  target="exeman" action="channel_edit_detailTemplate_do.jsp" method="post">
	<input name="siteName" type="hidden" id="siteName" value="<%=siteName%>">
	<input name="siteId" type="hidden" id="siteId" value="<%=siteId%>">
	<input name="channelId" type="hidden" id="channelId" value="<%=channelId%>">
	<input name="channelName" type="hidden" id="channelName" value="<%=channelName%>">
	<table width="98%" border="1" cellpadding="0" cellspacing="0" align="center" bordercolorlight="#FFFFFF" >
		<tr>
			<td colspan="2" class="topDIV"  align="left" valign="top">����Ƶ��ϸ��ģ��:</td>
		</tr>
		<tr>
			<td width="100" height="24" align="right" nowrap>Ƶ����������:</td>
			<td height="24">
				<%=channelName%>			</td>
		</tr>
		<tr>
			<td height="24"  align="right" nowrap>��ѡ��ģ��:</td>
			<td height="24"><select name="detailTemplateId" id="detailTemplateId" style="width:130px">
									<%
										int dtp = chnl.getDetailTemplateId();
										TemplateManager tpltMng = new TemplateManagerImpl();
									
										List templateList2 = tpltMng.getTemplateInfoListofSite(Integer.parseInt(siteId), 2);
										for (int i = 0; templateList2 != null && i < templateList2.size(); i++) {
											Template t = (Template) templateList2.get(i);
											out.println("<option value=\"" + t.getTemplateId() + "\" " +
												(dtp==t.getTemplateId()?"selected":"") +
												" templatePath=\"" + t.getTemplatePath() + "\"  templateFileName=\"" + t.getTemplateFileName() + "\" >" + 
												t.getName() + "</option>");
										}
									%>
								</select><input type="button" value="Ԥ��" onClick="templatePreview(detailTemplateId)"></td>
		</tr>
		<tr>			
		</tr>
	</table>
	<br>
	<div style="text-align:center">

					<INPUT name="button" type="button" class="cms_button" onClick="checkForm()"  value="����">

		&nbsp;&nbsp;&nbsp;
		<INPUT name="button" type="button" class="cms_button" onClick="window.returnValue = 'false';window.close()"  value="�ر�">
	</div>
	
</form>
<iframe name="exeman" width="0" height="0" style="display:none"></iframe>
</body>
</html>