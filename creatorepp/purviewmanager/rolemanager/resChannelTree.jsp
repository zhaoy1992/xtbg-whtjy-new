<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.User" %>
<%@page import="com.frameworkset.common.poolman.DBUtil,
				com.chinacreator.security.AccessControl"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	
	
	String roleId = request.getParameter("roleId");
	
	String channelUrl = "../grantmanager/resChannelFrame.jsp?resTypeId=channel&currRoleId="+roleId+"&role_type=role";
	String channeldocUrl  = "../grantmanager/resChannelFrame.jsp?resTypeId=channeldoc&currRoleId="+roleId+"&role_type=role";
	
%>

<html>
<head>
<tab:tabConfig/>
<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">

</head> 
<%@ include file="/epp/css/cssControl.jsp"%><body >
	<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">

		<tr>
			<td colspan="2">
				<tab:tabContainer id="channelResFrame" selectedTabPaneId="channel_res" skin="bluesky">
<!-- ------------------------------------------------------------------------------------------------------------------------------------------>
					<tab:tabPane id="channel_res" tabTitle="频道资源" lazeload="true">
						<tab:iframe id="channelRes" src="<%=channelUrl%>" frameborder="0" 
								scrolling="no" width="98%" height="550">
						</tab:iframe>
					</tab:tabPane>
					
					<tab:tabPane id="channeldoc_res" tabTitle="频道文档资源" lazeload="true">
						<tab:iframe id="channeldocRes" src="<%=channeldocUrl%>" frameborder="0" 
								scrolling="no" width="98%" height="550">
						</tab:iframe>
					</tab:tabPane>
					
<!-------------------------------------------------------------------------------------------------------------------------------->
					
				</tab:tabContainer>			
			</td>
		</tr>
  </table>	
</body>

</html>