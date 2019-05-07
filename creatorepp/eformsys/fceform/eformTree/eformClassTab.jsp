<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	String appId = control.getCurrentSystem();
	appId = (appId == null || appId.equals("")) ? "module" : appId;
	String appUrl = "navigator_content.jsp?appId=" + appId;
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
		<tab:tabConfig />
		<title></title>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body
		bgcolor="#F7F8FC">

		<table width="100%" height="100%" border="0" cellpadding="0"
			cellspacing="0" align="center">
			<tr>
				<td>
					<tab:tabContainer id="eform-class-tab"
						selectedTabPaneId="pt-eform-class">
						<tab:tabPane id="pt-eform-class" tabTitle="平台" lazeload="true">
							<tab:iframe id="orgmanage" src="navigator_content.jsp?appId=module"
								frameborder="0" scrolling="no" width="100%" height="95%">
							</tab:iframe>
						</tab:tabPane>
						<%if(!"module".equals(appId)){ %>
						<tab:tabPane id="yy-eform-class" tabTitle="应用" lazeload="true">
							<tab:iframe id="rolemanage" src="<%=appUrl %>"
								frameborder="0" scrolling="no" width="99%" height="95%">
							</tab:iframe>
						</tab:tabPane>
						<%} %>
					</tab:tabContainer>
				</td>
			</tr>
		</table>
	</body>
</html>
