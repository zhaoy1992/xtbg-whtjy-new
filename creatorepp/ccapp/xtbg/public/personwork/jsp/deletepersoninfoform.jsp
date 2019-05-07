<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.pub.personwork.service.PersonInfoServiceIfc"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.service.impl.PersonInfoServiceImpl"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>删除人员信息form</title>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
	String userid = request.getParameter("userid");
	String personids = request.getParameter("personids");
	String directoryids = request.getParameter("directoryids");
	boolean flag = true;
	
	try{
		PersonInfoServiceIfc personInfoService = new PersonInfoServiceImpl();
		personInfoService.deletePersonInfo(personids,userid,directoryids);
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
	parent.refreshGrid4WfactionInfo();
	bool = false;
}else{
	mes = "操作失败"	;
	bool = false;
}
window.parent.JqueryDialog.SubmitCompleted(mes, true, bool);
</script>
</body>
</html>