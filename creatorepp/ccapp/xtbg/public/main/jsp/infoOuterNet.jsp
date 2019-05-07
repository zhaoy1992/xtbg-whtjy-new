
<%@page import="com.chinacreator.xtbg.core.sysparam.util.SysParamUitl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<html>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	boolean success = accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String userid = accesscontroler.getUserID();
	String username = accesscontroler.getUserName();//获得当前登录用户姓名
	String loginName =  accesscontroler.getUserAccount(); //登录名
	String report_url = SysParamUitl.getSysParamValue("report_url");
	if(report_url.equals("")){
		report_url = "";
	}
%>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>湘特检简报</title>
<script type="text/javascript">

</script>
</head>
<body style="height: 100%;width: 100%;">
<iframe style="width: 100%;height: 580px;" src="<%=report_url%>" id="loginMessges"></iframe>
</body>
</html>