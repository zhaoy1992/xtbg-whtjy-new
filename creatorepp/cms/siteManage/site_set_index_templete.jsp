<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.util.*"%>
<%@page import="com.chinacreator.cms.container.Template"%>
<%@ page import="java.util.List"%>
<%@page import="com.chinacreator.cms.templatemanager.*"%>
<%@page import="com.chinacreator.cms.flowmanager.*"%>
<%@page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="com.chinacreator.cms.sitemanager.*"%>
<%@page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>


<%
			AccessControl control = AccessControl.getInstance();
			control.checkAccess(request, response);

			response.setHeader("Cache-Control", "no-cache");
			response.setHeader("Pragma", "no-cache");
			response.setDateHeader("Expires", -1);
			response.setDateHeader("max-age", 0);

			String siteId = request.getParameter("siteId");
			if (siteId == null || siteId.trim().length() == 0) 
			{

%>

	<script language="javascript" type="text/javascript">
				alert("վ��idΪ��,�޷��༭վ��.");
				self.location.href = "about:blank";
	</script>
<%
				return;
			}
			SiteManager sm = new SiteManagerImpl();
			Site site = sm.getSiteInfo(siteId);
			TemplateManager tpltMng = new TemplateManagerImpl();
			String siteName = site.getName();
			String stId = site.getIndexTemplateId()+"";
			
			//�ж��Ƿ����ģ��ҳ��
			//liangbing.tao 2008-5-20
			Template t = sm.getIndexTemplate(siteId);
			String stName = "��ǰû��ѡ��ģ��";		
			if(t != null)
			{
				stName = t.getName() ;
			}
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
		<script src="../inc/js/func.js"></script>
		<title>վ��ģ������</title>
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
var flag = false;
//վ�㴰���������У��
function checkForm(){
	var siteForm = document.all.siteForm;
	document.all.siteForm.submit();	
}
function save()
{
	siteForm.action="../channelManage/channel_templateSet_do.jsp?type=0&tId="
						+siteForm.siteTemplateId.value+"&tName="
						+siteForm.siteTemplateName.value
						+"&siteId=<%=siteId%>";
	siteForm.submit();
	if(flag)window.close();

}
function preview()
{
	var siteForm = document.all.siteForm;
	var siteId = "<%=siteId%>";
	var templateId = siteForm.siteTemplateId.value;
	//alert("Ԥ��վ��idΪ:"+siteId+",ģ��idΪ"+templateId+"��ģ��!");
	if(templateId == 0)
	{
		alert("����ѡ����ҳģ��!");
		return false ;
	}
	window.open("../templateManage/template_previewbyid.jsp?tplId=" + templateId + "&siteId=<%=siteId%>");
}
function setSiteTemplate()
{
 		var w = showModalDialog("../channelManage/channel_templateSet_frameset.jsp?siteId=<%=siteId%>&type=0&action=search&isSite=is&stId="+siteForm.siteTemplateId.value+"&stName="+siteForm.siteTemplateName.value,"setChannelOutlineTemplateId","dialogWidth:800px;dialogHeight:505px;help:no;scroll:yes;status:no");
		if(w!=null && w.length>0)
		{
			siteForm.siteTemplateId.value = w[0];
			siteForm.siteTemplateName.value = w[1];
		}

}
</script>
	</head>
	<body bgcolor="#F7F8FC" leftmargin="0" topmargin="0">
		<form id="siteForm" name="siteForm" target="exeman"  action="" method="post">
			<input name="siteId" type="hidden" id="siteId" value="<%=siteId%>">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" bordercolorlight="#FFFFFF">
				<tr>
					<td colspan="2" class="topDIV" align="left" valign="top">
						&nbsp;
						<div class="siteCTitle">
							վ��ģ������
						</div>
					</td>
				</tr>
				<tr>
					<td width="100" height="24" align="right" nowrap bgcolor="#EDEFF6">
						վ����������:
					</td>
					<td height="24">
						&nbsp;&nbsp;<%=(siteName == null ? "&nbsp;" : siteName)%>
					</td>
				</tr>
				<tr><td colspan="2"></td></tr>
				<tr>
					<td width="25%" height="24" align="right" nowrap>
						��ҳģ��:
					</td>
					<td height="24">
						<input name="siteTemplateId" id="siteTemplateId" type="hidden" value="<%=stId%>" />
						<input name="siteTemplateName" id="siteTemplateName" type="text" style="width:110px" ��class="cms_text" disabled value="<%=stName%>" />
						<input class="Channel_5wordsBtn" type="button" value="ѡ ��" id="btsetSiteTemplate" name="btsetSiteTemplate" onClick="setSiteTemplate()" />
						<input class="Channel_5wordsBtn" type="button" value="Ԥ ��" id="siteTemplatePreview" name="siteTemplatePreview" onClick="preview()">
					</td>
				</tr>
				<tr>
				</tr>
			</table>
			<br>
			<div style="text-align:center">
				<INPUT name="button" type="button" class="cms_button" onClick="save()" value="����">
				&nbsp;&nbsp;&nbsp;
				<INPUT name="button" type="button" class="cms_button" onClick="window.returnValue = 'false';window.close()" value="�ر�">
			</div>
		</form>
		<iframe name="exeman" width="0" height="0" style="display:none"></iframe>
	</body>
</html>
