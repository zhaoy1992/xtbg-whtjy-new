<%@ page language="java" contentType="text/html; charset=GBK"%>
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

<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	
	String currRoleId = request.getParameter("currRoleId");
	String role_type = request.getParameter("role_type");
	String orgId = "";
	if(role_type.equals("user")){
		orgId = request.getParameter("orgId");
	}
	String isBatch = request.getParameter("isBatch");
	StringBuffer url = new StringBuffer()
		.append("operList_global.jsp?resTypeId=group&currRoleId=").append(currRoleId)
		.append("&currOrgId=").append(orgId)
		.append("&role_type=").append(role_type)
		.append("&isBatch=").append(isBatch);
	//String url = "operList_global.jsp?resTypeId=group&currRoleId="+currRoleId+"&currOrgId="+orgId+"&role_type=user";
	//String lefturl = "usergroupsetTree.jsp?resTypeId=group&currRoleId="+currRoleId+"&currOrgId="+orgId+"&role_type=user";
	StringBuffer lefturl = new StringBuffer()
		.append("usergroupsetTree.jsp?resTypeId=group&currRoleId=").append(currRoleId)
		.append("&currOrgId=").append(orgId)
		.append("&role_type=").append(role_type)
		.append("&isBatch=").append(isBatch);
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
				<tab:tabContainer id="groupResFrame" selectedTabPaneId="groupGlog_res" skin="bluesky">
<!-- ------------------------------------------------------------------------------------------------------------------------------------------>
					<tab:tabPane id="groupGlog_res" tabTitle="�û���ȫ��Ȩ��" lazeload="true">
						<tab:iframe id="groupGlogRes" src="<%=url.toString()%>" frameborder="0" scrolling="no" width="98%" height="550">
						</tab:iframe>
					</tab:tabPane>
<!-------------------------------------------------------------------------------------------------------------------------------->
					
				</tab:tabContainer>			
			</td>
		</tr>
  </table>	
</body>

</html>