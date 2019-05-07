<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl,com.chinacreator.message.util.*"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld"%>
<%
    AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request,response);
	String app_id =	accesscontroler.getCurrentSystemID();
	String pathtab1 = "sendmessagetab_2.jsp";
	String pathtab2 = "websiteMessage/messageMain.jsp";
	//String pathtab3 = "startrtxtab.jsp";

   	// 平台开关
	boolean switchRtx = MessageTools.MessageisExistFromXML("rtx");
	boolean switchSms = MessageTools.MessageisExistFromXML("sms");
	boolean switchSys = MessageTools.MessageisExistFromXML("sys");

	boolean switchMsgCenter = true;
	boolean sRtx = false;
	boolean sSms = false;
	boolean sSys = false;

	// 应用开关
	
		switchMsgCenter = MessageTools.MessageisShow(app_id);
		boolean appSwitchRtx = MessageTools.MessageisExistFromDB(
		app_id, "rtx");
		boolean appSwitchSms = MessageTools.MessageisExistFromDB(
		app_id, "sms");
		boolean appSwitchSys = MessageTools.MessageisExistFromDB(
		app_id, "sys");

		// 根据平台开关、应用开关最后判定是否使用
		sRtx = switchRtx && appSwitchRtx;
		sSms = switchSms && appSwitchSms;
		sSys = switchSys && appSwitchSys;
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<tab:tabConfig />
		<title>消息中心</title>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body bgcolor="#F7F8FC" style="width:800px;">
		<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td colspan="2">
					<tab:tabContainer id="messagecenter-tab"
						selectedTabPaneId="messagecenter-tab1">
						<%if(switchMsgCenter && sRtx || sSms) { %>
						<tab:tabPane id="messagecenter-tab1" tabTitle="发送消息" lazeload="true">
							<tab:iframe id="messagecentertab1" src="<%=pathtab1%>"
								frameborder="0" scrolling="auto" width="98%" height="550">
							</tab:iframe>
						</tab:tabPane>
						<%} %>
						<%if(switchMsgCenter && sSys ) { %>
						<tab:tabPane id="messagecenter-tab2" tabTitle="站内邮箱" lazeload="true">
							<tab:iframe id="messagecentertab2" src="<%=pathtab2%>"
								frameborder="0" scrolling="auto" width="98%" height="550">
							</tab:iframe>
						</tab:tabPane>
						<%} %>
						<%--
						<tab:tabPane id="messagecenter-tab3" tabTitle="启动RTX" lazeload="true">
							<tab:iframe id="messagecentertab3" src="<%=pathtab3%>"
								frameborder="0" scrolling="no" width="100%" height="540">
							</tab:iframe>
						</tab:tabPane>
						--%>
					</tab:tabContainer>
				</td>
			</tr>
		</table>
	</body>
</html>