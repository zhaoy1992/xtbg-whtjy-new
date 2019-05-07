<%
/**
 * 
 * <p>Title: 菜单授权页面</p>
 *
 * <p>Description: 菜单授权页面</p>
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
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	
	String resTypeId = "column";
	String currRoleId = request.getParameter("currRoleId");
	String role_type = request.getParameter("role_type");
	String isBatch = request.getParameter("isBatch");
	String currOrgId = request.getParameter("orgId");

	String resMenuUrl = "columnSetVisible.jsp?resTypeId=" + resTypeId
			+ "&currRoleId=" + currRoleId + "&role_type=" + role_type
			+ "&currOrgId=" + currOrgId + "&isBatch=" + isBatch;
	String resShortcut_MenuUrl = "resShortcut_menu.jsp?resTypeId="
			+ resTypeId
			+ "&currRoleId="
			+ currRoleId
			+ "&role_type="
			+ role_type
			+ "&currOrgId=" 
			+ currOrgId
			+"&isBatch=" 
			+ isBatch;
	System.out.println("resMenuUrl==" + resMenuUrl);
	System.out.println("resShortcut_MenuUrl==" + resShortcut_MenuUrl);
%>
<!-- 
<html>
<frameset name="dictFrame" cols="100" frameborder="no" border="0" framespacing="0" >
  	<frame src="columnSetVisible.jsp?resTypeId=<%=resTypeId%>&currRoleId=<%=currRoleId%>&role_type=<%=role_type%>&currOrgId=<%=currOrgId%>&isBatch=<%=isBatch %>" name="globalOperList" id="globalOperList" scrolling="No" noresize="noresize" />
</frameset>
<noframes>
<body >
</body>
</noframes>
</html>
 -->
 <html>
	<head>
		<tab:tabConfig />
		<link rel="stylesheet" type="text/css" href="../css/treeview.css">
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
	</head>

	<%@ include file="/epp/css/cssControl.jsp"%><body>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			align="center">

			<tr>
				<td colspan="2">
					<tab:tabContainer id="resColumn"
						selectedTabPaneId="resColumn_res" skin="bluesky">
						<!-- ------------------------------------------------------------------------------------------------------------------------------------------>

						<tab:tabPane id="resColumn_tree" tabTitle="菜单资源"
							lazeload="true">
							<tab:iframe id="resColumnTree" src="<%=resMenuUrl%>" frameborder="0"
								scrolling="no" width="98%" height="555">
							</tab:iframe>
						</tab:tabPane>
						
						<%if(isBatch.equals("false")){ %>
						<tab:tabPane id="readBizTypeName_res" tabTitle="快捷菜单"
							lazeload="true">
							<tab:iframe id="resColumnTree_aa" src="<%=resShortcut_MenuUrl%>"
								frameborder="0" scrolling="no" width="98%" height="555">
							</tab:iframe>
						</tab:tabPane>
						<%} %>
						<!-------------------------------------------------------------------------------------------------------------------------------->

					</tab:tabContainer>
				</td>
			</tr>
		</table>
	</body>
</html>
 
 
 
 
 