<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="java.io.*" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.sitemanager.*"%>
<%@ page import="com.chinacreator.cms.util.*"%>
<%@ page import="com.chinacreator.cms.*"%>
<%@page import="com.chinacreator.cms.driver.htmlconverter.*"%>
<%@page import="com.chinacreator.cms.driver.i18n.*"%>
<%
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader ("Expires", -1);
	response.setDateHeader("max-age", 0);

	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	CMSManager cmsmanager = new CMSManager();
	cmsmanager.init(request,session,response,control);

	String siteId =  cmsmanager.getSiteID();

	SiteManager siteManager = new SiteManagerImpl();

	String sitedir = siteManager.getSiteInfo(siteId).getSiteDir();//վ�����·��
	String fileName = request.getParameter("fileName");
	String uri = request.getParameter("uri");
	
	String relatePath = "";
	
	
	if(uri !=null)
	{
		if(uri.startsWith("/"))
			relatePath = uri.substring(1);
		else
			relatePath = uri;
		if(relatePath.endsWith("/"))
		{
			relatePath = relatePath.substring(0,relatePath.length() - 1);
		}
	}

%>
<html>
<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
<script src="../inc/js/func.js"></script>
<style type="text/css">
<!--
.fileContent {
	font-family: Verdana, "����";
	width: 100%;
}
-->
</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�ļ����ݱ༭</title>
</head>
<body  bottommargin="0"  background="../images/grayline_bg.jpg" rightmargin="0" leftmargin="0" topmargin="0">
<%
	if(fileName==null||fileName.trim().length()==0){
%>
	<script language="javascript">
		alert("���ṩ�ļ���!");
		top.close();
	</script>
<%		
		return;
	}
	String pathContext = (String)session.getAttribute("pathContext");
	if(pathContext==null || pathContext.trim().length()==0){
%>
		<script type="text/javascript">
			alert("û���ṩ��Դ��������·��,�޷�������Դ.");
			top.close();
		</script>
<%		
		return;
	}	
%>
<form method="post" name="TemplateForm" target="hidFrm" id="TemplateFrm" action="editFileContent_do.jsp">
	<div align="center">
	<input name="uri" type="hidden" id="uri" value="<%=uri%>">
	<input name="fileName" type="hidden" id="fileName" value="<%=fileName%>">
	<textarea name="fileContent" rows="45" class="fileContent" id="fileContent" type="_moz"><%
File tpltFolder = new File(pathContext,uri);
String content = FileUtil.getFileContent(new File(tpltFolder.getAbsolutePath(),fileName).getAbsolutePath());
//�����ĵ�����
CmsLinkProcessor processor = new CmsLinkProcessor(request,relatePath,sitedir);
processor.setHandletype(CmsLinkProcessor.PROCESS_READTEMPLATE);
try {
	content = processor.process(content,CmsEncoder.ENCODING_US_GBK);
} catch (Exception e) {
	e.printStackTrace();
}

out.print(content);
%></textarea>
	<input class="cms_button" name="�ύ" type="submit" value="ȷ��">
	<input type="button" class="cms_button" name="Submit" value="ȡ��" onclick="top.close()">
	</div>
</form>
<iframe id="hidFrm" name="hidFrm" style="display:none"></iframe>
</body>
</html>
