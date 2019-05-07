<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);

	String userId = request.getParameter("userId");
	String orgId = request.getParameter("orgId");

	//得到需要授予权限的用户ID或角色ID
	String currRoleId = (String) request.getParameter("currRoleId");

	String isBatch = request.getParameter("isBatch");
	String role_type = request.getParameter("role_type");

	String url = "operList_global.jsp?resTypeId=biztype&currRoleId="
			+ currRoleId + "&currOrgId=" + orgId
			+ "&role_type="+role_type+"&isBatch=" + isBatch;
	String urlleft = "bizTypeSetTree.jsp?resTypeId=biztype&currRoleId="
			+ currRoleId + "&currOrgId=" + orgId
			+ "&role_type="+role_type+"&isBatch=" + isBatch;
%>

<html>
	<head>
		<tab:tabConfig />
		<link rel="stylesheet" type="text/css" href="../css/treeview.css">
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
	</head>

	<%@ include file="/epp/css/cssControl.jsp"%>
	<body>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			align="center">

			<tr>
				<td colspan="2">
					<tab:tabContainer id="bizTypeResFrame"
						selectedTabPaneId="readBizTypeName_res" skin="bluesky">
						<!-- ------------------------------------------------------------------------------------------------------------------------------------------>

						<tab:tabPane id="bizTypeGlog_res" tabTitle="业务类别全局权限"
							lazeload="true">
							<tab:iframe id="bizTypeGlogRes" src="<%=url%>" frameborder="0"
								scrolling="no" width="98%" height="555">
							</tab:iframe>
						</tab:tabPane>

						<tab:tabPane id="readBizTypeName_res" tabTitle="业务类别可访问权限"
							lazeload="true">
							<tab:iframe id="readBizTypeNameRes" src="<%=urlleft%>"
								frameborder="0" scrolling="no" width="98%" height="555">
							</tab:iframe>
						</tab:tabPane>

						<!-------------------------------------------------------------------------------------------------------------------------------->

					</tab:tabContainer>
				</td>
			</tr>
		</table>
	</body>
</html>
