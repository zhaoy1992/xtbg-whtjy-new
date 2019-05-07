<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.cms.sitemanager.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);

	String copyBySiteId = request.getParameter("copyBySiteId");
	String copyToSiteId = request.getParameter("copyToSiteId");

	SiteManager smi = new SiteManagerImpl();
	String ret = smi.CopySiteAllInfo(copyBySiteId,copyToSiteId,request,response);
%>
	<script language="javascript">
	
		alert("<%=ret%>");
		parent.close();
	</script>
