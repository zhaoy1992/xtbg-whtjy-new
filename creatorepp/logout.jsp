<%@page contentType="text/html;charset=GBK"%>
<%@page
	import="com.chinacreator.security.AccessControl,com.chinacreator.security.authorization.AccessException"%>
<%@page import="com.chinacreator.config.ConfigManager"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	boolean success = accesscontroler.checkAccess(request, response);
	boolean isCasServer = ConfigManager.getInstance()
			.getConfigBooleanValue("isCasServer", false);
	if (isCasServer) {
		String logoutUrl = (String) session
		.getAttribute("edu.yale.its.tp.cas.client.filter.logout");
		response.sendRedirect(logoutUrl);
		accesscontroler.logout(false);
	} else {

		//if(success)
		accesscontroler.logout();
	}
%>
<script language="javascript">
	if(window.sessionStorage)
	{
		sessionStorage.clear();
	}
</script>

