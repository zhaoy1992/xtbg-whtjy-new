<%@page import="com.chinacreator.pcbase.util.StringUtilForAndroid"%>
<%@page import="com.chinacreator.pcbase.entity.AndroidUpdateBean"%>
<%@page import="com.chinacreator.pcbase.command.impl.UpdateAndroidSynServices"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>版本更新内容</title>
<%
	String id = request.getParameter("id");
	boolean isCaUpLoad = false;
	if(StringUtilForAndroid.isBlank(id)){//如果为空,代表是CA认证下载界面
		isCaUpLoad = true;
	}
	UpdateAndroidSynServices service = new UpdateAndroidSynServices();
	AndroidUpdateBean bean = service.getAndroidUpdateBeanById(id);
%>
</head>
<body>
    <font size="2">
	
	<%if(isCaUpLoad){//CA界面 %>
	提醒：
	<p/>
		必须安装CA认证客户端才能登录系统.
	<%}else{ %>
	版本更新内容：
	<p/>
		<%="".equals(StringUtilForAndroid.deNull(bean.getVersionContent()))?"系统完善及优化":bean.getVersionContent() %>
	<%} %>
	</font>
</body>
</html>