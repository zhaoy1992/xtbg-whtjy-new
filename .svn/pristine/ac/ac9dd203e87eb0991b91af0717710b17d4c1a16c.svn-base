<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.portal.PortalUtil"%>
<%@page import="com.chinacreator.portal.PortalIssueManager"%>
<%@page import="com.chinacreator.portal.PortalIssueManagerImpl"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%
AccessControl control = AccessControl.getInstance();
control.checkAccess(request,response);
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

//发布的模块数
int moduleCount = Integer.parseInt(request.getParameter("indexCount"))+1;


String msg = null;
try{
	PortalIssueManager manager = new PortalIssueManagerImpl();
	manager.definedIssueIframePlugin(moduleCount,request);
}catch(Exception e){
	msg = PortalUtil.formatErrorMsg(e.getMessage());
}

if(msg == null){
%>
<script type="text/javascript">
<!--
	alert("发布成功!请进入“发布文件管理”列表中下载");
//-->
</script>
<%}else{%>
<script type="text/javascript">
<!--
	alert("发布失败!\n<%=msg%>");
//-->
</script>
<%} %>