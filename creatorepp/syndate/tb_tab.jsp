<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<tab:tabConfig />
		<title>机构用户同步选项卡页面</title>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body bgcolor="#F7F8FC">
	
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			align="center">
			<tr>
				<td colspan="2">

					<tab:tabContainer id="tb-tab"
						selectedTabPaneId="tb-tab1">

						<tab:tabPane id="tb-tab1" tabTitle="平台与RTX同步" lazeload="true">
							<tab:iframe id="manualmove" src="EGP_RTX/egp2rtx_tab.jsp"
								frameborder="0" scrolling="no" width="100%" height="520">
							</tab:iframe>
						</tab:tabPane>
	
			</tab:tabContainer>
				</td>
			</tr>
		</table>
	</body>
</html>
