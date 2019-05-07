<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.cms.sitemanager.*"%>
<%@ page import="com.chinacreator.security.AccessControl,com.chinacreator.sysmgrcore.manager.*,
com.chinacreator.sysmgrcore.entity.Role,com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%
try {
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	String[] id = request.getParameterValues("ID");
	if (id != null && id.length > 0) {
	        RoleManager roleManager = SecurityDatabase.getRoleManager();
	        roleManager.deleteRoles(id);
	        
			
	}
	
%>
<script language="javascript">
	alert("É¾³ý½ÇÉ«³É¹¦!");
	parent.document.location.href ="../userManage/main.jsp";
	//parent.window.returnValue = true;
	//window.close();
</script>
<%
} catch (Exception e) {
	e.printStackTrace();


}
%>
