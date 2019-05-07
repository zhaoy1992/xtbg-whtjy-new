<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.User" %>
<%
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
	
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request,response);
	
	String userId = request.getParameter("userId");
	String orgId = request.getParameter("orgId");
	UserManager userManager = SecurityDatabase.getUserManager();
	User user = userManager.getUserById(userId);	
	String userName = user.getUserRealname();
%>
<html>
<head>
	<title>用户【<%=userName%>】权限复制</title>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<tab:tabConfig/>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body   bgcolor="#F7F8FC">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
		<tr>
			<td colspan="2">
				<tab:tabContainer id="purviewCopy" selectedTabPaneId="purview-copy">
					<tab:tabPane id="copy-rest" tabTitle="该用户权限复制给其他用户" >
						<tab:iframe id="copyRest" src="" frameborder="0" scrolling="yes" width="99%" height="540">
						</tab:iframe>
					</tab:tabPane>
					<tab:tabPane id="copy-self" tabTitle="其他用户的权限复制给该用户" >
						<tab:iframe id="copySelf" src="" frameborder="0" scrolling="yes" width="99%" height="540">
						</tab:iframe>
					</tab:tabPane>
				</tab:tabContainer>			
			</td>
		</tr>
  </table>	

<iframe name="exeman" width="0" height="0" style="display:none"></iframe>
</body>
<script>
    window.onload=function init(){
        var path = "org2user.jsp?userId=<%=userId%>&orgId=<%=orgId%>";
        document.all("copyRest").src = path;
        var path = "otherOrg2user.jsp?userId=<%=userId%>&orgId=<%=orgId%>";
        document.all("copySelf").src = path;
    }
</script>
</html>
