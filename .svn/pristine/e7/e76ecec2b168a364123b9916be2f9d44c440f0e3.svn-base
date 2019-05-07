<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="com.chinacreator.cms.templatemanager.*"%>
<%@ page import="com.chinacreator.cms.container.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.*"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<title></title>
</head>
<body>
<%
try{
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	Template tplt = new Template();
 	
 	tplt.setCreateUserId(Long.parseLong(control.getUserID()));
 	CMSManager cmsmanager = new CMSManager();
	cmsmanager.init(request,session,response,control);

	String siteId =  cmsmanager.getSiteID();
	if(siteId != null){
		tplt.setSiteId(Integer.parseInt(siteId));		
	}

	String uri = request.getParameter("uri");
	tplt.setTemplatePath(uri);
	
	String templateName = request.getParameter("templateName");
	tplt.setName(templateName);
	
	String templateDesc = request.getParameter("templateDesc");
	tplt.setDescription(templateDesc);
	
	String templateType = request.getParameter("templateType");
	if(templateType!=null){
		tplt.setType(Integer.parseInt(templateType));
	}
	
	tplt.setCreateUserId(Long.parseLong(control.getUserID()));
	
	tplt.setHeader("null");
	tplt.setText("null");
	
	tplt.setPersistType(Template.PERSISTINFILE);
		
	String fileName = request.getParameter("fileName");
	if(fileName!=null && fileName.trim().length()!=0){
		tplt.setTemplateFileName(fileName);
	}
	
	//模板风格编号
	int style = Integer.parseInt(request.getParameter("templateStyle"));
	tplt.setStyle(style);
	
	new TemplateManagerImpl().createTemplateofSite(tplt,Integer.parseInt(siteId));
	%>
	<script language="javascript">
		alert('设置<%=fileName%>为模板成功!');
		window.dialogArguments.document.forms[0].submit();
		top.close();
	</script>
<%}catch(Exception e){
	out.println("<script language=\"javascript\">");
	out.println("alert('"+e.getMessage()+"');");
	out.println("</script>");
	e.printStackTrace();
}
%>
</body>
</html>
