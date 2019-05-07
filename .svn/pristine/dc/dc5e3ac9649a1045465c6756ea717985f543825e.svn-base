<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.chinacreator.ireport.server.IreportUtil"%>
<%@page import="com.chinacreator.ireport.rmi.ClientRmiServer"%>
<%@page import="com.chinacreator.ireport.rmi.ClientRmiServerInterface"%>
<%@page import="com.chinacreator.ireport.rmi.IreportFile"%>
<%@page import="com.chinacreator.epp.reportmanage.ReportUtil"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	//ID
	String repid = request.getParameter("rep_id");
	String reptype = request.getParameter("rep_type");
	
	//判断是否被锁定
	if (StringUtils.isBlank(repid)) {
		out.print("<script type='text/javascript'>");
		out.print("alert('报表ID为空');");
		out.print("window.close();");
		out.print("</script>");
		return;
	}

	String islock = IreportUtil.checkLock(repid,reptype);
	if (islock != null) {
		out.print("<script type='text/javascript'>");
		out.print("alert('该报表已经被打开');");
		out.print("window.close();");
		out.print("</script>");
		return;
	}

	//判断客户端是否打开了设计器
	String ip = ReportUtil.getIpAddr(request);
	ClientRmiServerInterface cs = ClientRmiServer
			.getClientRmiRemoteInterface(ip);
	if (cs != null && cs.linkCheck()) {
		//已经打开应用
		//IreportFile ife = new IreportFile();
		//ife.setFileName(repid + ".jrxml");
		IreportFile i= IreportUtil.searchReportFile(repid);
		System.out.println(i.getFileName());
		System.out.println(i.getId());
		cs.openFile(null,i);
	} else {
		response.sendRedirect(path
				+ "/report/ireportRemoteDesigner/jnlp.jsp?rep_id="
				+ repid);
	}
		out.print("<script type='text/javascript'>");
		out.print("window.close();");
		out.print("</script>");
%>
<html>
<script type="text/javascript">
window.close();
</script>
</html>