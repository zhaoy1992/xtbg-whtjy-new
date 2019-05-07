<%@page contentType="text/html; charset=GBK"%>
<%
	//应用ID
	String app_id = request.getParameter("app_id") != null ? request
			.getParameter("app_id") : "";
	//	是否修改状态	 "true"	可修改
	String isEdit = request.getParameter("isEdit") != null ? request
			.getParameter("isEdit") : "";
	//	取消状态，是否取消时注销应用 "true" 可注销
	String isCancel = request.getParameter("isCancel") != null ? request
			.getParameter("isCancel")
			: "";
	String path = "addapplytab1.jsp?isCancel=" + isCancel + "&&isEdit="
			+ isEdit + "&&app_id=" + app_id;
%>
<html>
<head>
<title>应用操作</title>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body>
<iframe src=<%=path%> width=" 99%" height="100%"></iframe>
</body>
</html>
