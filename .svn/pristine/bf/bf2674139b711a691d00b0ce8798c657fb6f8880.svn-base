<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK" import="com.chinacreator.security.AccessControl
    						,com.chinacreator.spi.impl.local.WorkflowManagerImpl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request,response);
    String account = accesscontroler.getUserAccount();
    boolean flag = false;
    
    String isStart = request.getParameter("isStrat")!=null?request.getParameter("isStrat"):"false";

	if("true".equals(isStart)) {
		WorkflowManagerImpl workflow = new WorkflowManagerImpl();
		String delFlag = request.getParameter("flag");
		if ("true".equals(delFlag)) {			
			flag = workflow.deleteAllOldVersionPackage(true);
		} else {
			flag = workflow.deleteAllOldVersionPackage(false);
		}
	}
	
	
%>
<html>
<head>
</head>
<%@ include file="/epp/css/cssControl.jsp"%>
<body>
<div align="center" id="divv">
此页面是进行流程历史版本清理
<br/>
<%
	if("admin".equals(account)){
%>
<form action="" method="post">
<input type="hidden" name="isStrat" value="true">
<input type="checkbox" name="flag" value="true">是否强制删除
<input type="submit" value="开始" class="input">
</form>
<%}else{%>
<br/>
请用系统管理员身份登录后再进行此操作
<%} %>
</div>
</body>
</html>
<%
	if("true".equals(isStart)){
	if(flag){
%>
<script type="text/javascript">
<!--
	alert("删除成功！");
//-->
</script>
<%}else{%>
<script type="text/javascript">
<!--
	alert("删除失败，请稍后再试！");
//-->
</script>
<%}}%>