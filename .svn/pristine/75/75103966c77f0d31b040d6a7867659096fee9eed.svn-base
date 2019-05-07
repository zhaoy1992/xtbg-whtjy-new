<%@ page contentType="text/html; charset=GBK"%>

<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>

<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.documentmanager.crawl.EDocumentManager"%>
<%@ page import="com.chinacreator.cms.documentmanager.crawl.EDocumentManagerImpl"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	String subtitle = request.getParameter("compare_title");
	String channelId = request.getParameter("channelId");
	
	
	boolean flag = false ;

	EDocumentManagerImpl manager = new EDocumentManagerImpl();
	flag = manager.comTitle(subtitle,channelId);
%>

<<script type="text/javascript">
<!--
	if(<%=flag%>)
	{
		alert("ÒÑÖØ¸´!");
	}else
	{
		alert("Î´ÖØ¸´!");
	}
//-->
</script>
