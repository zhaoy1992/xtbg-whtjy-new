<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.chinacreator.security.AccessControl,java.util.List"%>
<%@ page import="com.chinacreator.cms.sitemanager.SiteManager,
com.chinacreator.cms.sitemanager.SiteManagerImpl,com.chinacreator.cms.sitemanager.Site"%>
<%
	 AccessControl accesscontroler = AccessControl.getInstance();
     accesscontroler.checkAccess(request,response);
	 String modulePath = request.getParameter("path");
	 String temp[]=modulePath.split("=");
	
	 request.setAttribute("modulePath",temp[1]);
%>
    <script language="javascript">
   		window.parent.location.reload();
     </script>

