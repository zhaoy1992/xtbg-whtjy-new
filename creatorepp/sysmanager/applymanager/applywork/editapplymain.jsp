<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	//应用ID
	String app_id = request.getParameter("app_id") != null ? request
			.getParameter("app_id") : "";
	//是否修改状态	 "true"	可修改
	String isEdit = request.getParameter("isEdit") != null ? request
			.getParameter("isEdit") : "";
	//取消状态，是否取消时注销应用 "true" 可注销
	String isCancel = request.getParameter("isCancel") != null ? request
			.getParameter("isCancel")
			: "";

	boolean isCMS = "cms".equals(app_id.trim().toLowerCase())?false:true;
	
	boolean isModule = "module".equals(app_id.trim().toLowerCase())?false:true;

	String pathtab1 = "addapplytab1.jsp?app_id=" + app_id
			+ "&&isCancel=" + isCancel + "&&isEdit=" + isEdit;
	String pathtab2 = "addapplytab2.jsp?app_id=" + app_id
			+ "&&isCancel=" + isCancel + "&&isEdit=" + isEdit;
	String pathtab3 = "addapplytab3.jsp?app_id=" + app_id
			+ "&&isCancel=" + isCancel + "&&isEdit=" + isEdit;
	String pathtab4 = "addapplytab4.jsp?app_id=" + app_id
			+ "&&isCancel=" + isCancel + "&&isEdit=" + isEdit;
	String pathtab5 = "addapplytab5.jsp?app_id=" + app_id
			+ "&&isCancel=" + isCancel + "&&isEdit=" + isEdit;
	String pathtab6 = "addapplytab6.jsp?app_id=" + app_id
			+ "&&isCancel=" + isCancel + "&&isEdit=" + isEdit;
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<tab:tabConfig />
		<title>应用修改</title>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body bgcolor="#F7F8FC">
	
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			align="center">
			<tr>
				<td colspan="2">

					<tab:tabContainer id="addapply-tab"
						selectedTabPaneId="addapply-tab1">

						<tab:tabPane id="addapply-tab1" tabTitle="基本属性" lazeload="true">
							<tab:iframe id="addapplytab1" src="<%=pathtab1%>"
								frameborder="0" scrolling="no" width="99%" height="460">
							</tab:iframe>
						</tab:tabPane>
						<%if(isModule){ %>
						<%if(isCMS){ %>
						<tab:tabPane id="addapply-tab2" tabTitle="菜单生成" lazeload="true">
							<tab:iframe id="addapplytab2" src="<%=pathtab2%>"
								frameborder="0" scrolling="no" width="99%" height="460">
							</tab:iframe>
						</tab:tabPane>
						<%} %>
						<tab:tabPane id="addapply-tab3" tabTitle="机构用户" lazeload="true">
							<tab:iframe id="addapplytab3" src="<%=pathtab3%>"
								frameborder="0" scrolling="no" width="99%" height="460">
							</tab:iframe>
						</tab:tabPane>

						<%--<tab:tabPane id="addapply-tab4" tabTitle="管理员设置" lazeload="true">
							<tab:iframe id="addapplytab4" src="<%=pathtab4%>"
								frameborder="0" scrolling="no" width="100%" height="540">
							</tab:iframe>
						</tab:tabPane>--%>
						<%}if(isCMS){ %>
						<tab:tabPane id="addapply-tab5" tabTitle="高级" lazeload="true">
							<tab:iframe id="addapplytab5" src="<%=pathtab5%>"
								frameborder="0" scrolling="no" width="99%" height="460">
							</tab:iframe>
						</tab:tabPane>
						<%} %>
						<%--<tab:tabPane id="addapply-tab6" tabTitle="数据清理" lazeload="true">
							<tab:iframe id="addapplytab6" src="<%=pathtab6%>"
								frameborder="0" scrolling="no" width="100%" height="460">
							</tab:iframe>
						</tab:tabPane>

					--%></tab:tabContainer>					
				</td>
			</tr>
		</table>
	</body>
</html>
