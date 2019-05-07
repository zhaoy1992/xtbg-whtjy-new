<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.workflow.shark.SharkEngine"%>
<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userId = accesscontroler.getUserAccount();
	ServletOutputStream outs = null;
	SharkEngine flow = SharkEngine.getInstance();
	flow.loginWorkflowServer(userId, "");
	try {
		//获取流程实例图形
		String proID = request.getParameter("procInsId");

		byte[] proGraph = flow.getMonitorPicForProcess(proID);
		outs = response.getOutputStream();
		outs.write(proGraph);
		outs.flush();
		outs.close();
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		flow.logoutWorkflowServer();
	}
%>


