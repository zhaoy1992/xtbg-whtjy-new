<%
/**
 * 
 * <p>Title: �û���tabҳ��</p>
 *
 * <p>Description: �û���tabҳ�棬�û����Ϊȫ�ֲ�������ϸ����</p>
 *
 * <p>Copyright: Copyright (c) 2007</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2006-9-15
 * @author gao.tang
 * @version 1.0
 */
 %>
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

	String url = "../grantmanager/operList_global.jsp?resTypeId=group&currRoleId="+ roleId + "&role_type=role";
	String groupuseraddRes = "../grantmanager/usergroupsetTree.jsp?resTypeId=group&currRoleId=" + roleId + "&role_type=role";
%>

<html>
<head>
<tab:tabConfig/>
<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">

</head> 
<!-- 
<frameset name="userId" cols="30,70" frameborder="no" border="0" framespacing="0" >
	
  	<frame src="resOrgTree.jsp?resTypeId=orgunit" name="globalOperList" id="globalOperList" scrolling="No" noresize="noresize" />
  	<frame src="user_operdefault.jsp" name="operList" scrolling="No" noresize="noresize" id="orgList" />
</frameset>
<noframes>
</noframes>
-->
<%@ include file="/epp/css/cssControl.jsp"%><body >
	<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">

		<tr>
			<td colspan="2">
				<tab:tabContainer id="orgResFrame" selectedTabPaneId="user-manage" skin="bluesky">
<!-- ------------------------------------------------------------------------------------------------------------------------------------------>
					<tab:tabPane id="groupGlog_res" tabTitle="�û���ȫ��Ȩ��" lazeload="true">
						<tab:iframe id="groupGlogRes" src="<%=url%>" frameborder="0" scrolling="no" width="98%" height="550">
						</tab:iframe>
					</tab:tabPane>
<!-------------------------------------------------------------------------------------------------------------------------------->
					
				</tab:tabContainer>			
			</td>
		</tr>
  </table>	
</body>

</html>