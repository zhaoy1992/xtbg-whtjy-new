<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.chinacreator.xtbg.pub.flowinfoconif.dao.FlowInfoDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%><html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>删除环节用户信息form</title>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String userids = request.getParameter("userids");
	boolean flag = true;
	FlowInfoDao flowInfodao = (FlowInfoDao)DaoImplClassUtil.getDaoImplClass("flowInfoDaoImpl");
	try{
		flowInfodao.deleteFlowWfactionUserInfoById(userids);
	}catch(Exception e){
		flag = false;
	}
%>
</head>
<body>
<script type="text/javascript">
var mes = "";
var bool = true;
if(<%=flag%>){
	mes = "操作成功";
	window.parent.refreshGrid();
}else{
	mes = "操作失败"	;
	bool = false;
}
window.parent.JqueryDialog.SubmitCompleted(mes, true, bool);
</script>
</body>
</html>