<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.chinacreator.security.AccessControl,java.util.List"%>
<%@ page import="com.chinacreator.cms.sitemanager.SiteManager,
com.chinacreator.cms.sitemanager.SiteManagerImpl,com.chinacreator.cms.sitemanager.Site"%>
<%
	 AccessControl accesscontroler = AccessControl.getInstance();
     accesscontroler.checkAccess(request,response);
	 String siteid = request.getParameter("siteid");
	 //System.out.println("============"+siteid);
	 SiteManager sitemanager = new SiteManagerImpl();
	 Site site = sitemanager.getSiteInfo(siteid);
	 session.setAttribute("siteid",siteid);
	 com.chinacreator.cms.CMSManager cmsManager  = new com.chinacreator.cms.CMSManager();
	 cmsManager.init(request,session,response,accesscontroler);
	 cmsManager.updateCurrentSite(site);

	 
%>
    <script language="javascript">   
    //alert(window.parent.document.all.item("modulepath").options[window.parent.document.all.item("modulepath").selectedIndex].value)		
    	window.open(window.parent.document.all.item("modulepath").options[window.parent.document.all.item("modulepath").selectedIndex].value,'perspective_main');
    </script>

