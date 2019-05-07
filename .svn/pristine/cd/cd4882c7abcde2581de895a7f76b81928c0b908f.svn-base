<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.cms.util.FileUtil"%>
<%@page import="com.chinacreator.portal.PortalUtil"%>
<%@page import="com.chinacreator.portal.PortalProperties"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%
AccessControl control = AccessControl.getInstance();
control.checkAccess(request,response);
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String name = request.getParameter("name");
String msg = null;
try{
	FileUtil.deleteFileOnly(PortalProperties.PORTAL_ISSUEPATH_WAR+"/"+name);
}catch(Exception e){
	msg = PortalUtil.formatErrorMsg(e.getMessage());
}
if(msg == null){
%>
<script type="text/javascript">
<!--
	alert("操作成功!");
	parent.document.location = parent.document.location;
//-->
</script>
<%}else{%>
<script type="text/javascript">
<!--
	alert("操作失败!\n<%=msg%>");
//-->
</script>
<%} %>
