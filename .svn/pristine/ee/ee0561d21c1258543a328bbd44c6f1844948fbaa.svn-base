<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.chinacreator.security.AccessControl
				,com.chinacreator.message.impl.RtxImpl" %>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request,response);
    String account = accesscontroler.getUserAccount();
	String isStart = request.getParameter("isStrat")!=null?request.getParameter("isStrat"):"false";
	boolean bl = false;
	if("true".equals(isStart)){
		//bl = RtxImpl.rtxDataSynchronization();
	}
%>
<html>
<head>
</head>
<%@ include file="/epp/css/cssControl.jsp"%>
<body>
<div align="center" id="divv">
此页面是进行RTX数据同步页
<br/>
<%
	if("admin".equals(account)){
%>
<form action="" method="post">
<input type="hidden" name="isStrat" value="true">
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
		if(bl){
%>
<script type="text/javascript">
<!--
	alert("数据同步成功！");
//-->
</script>
<%}else{%>
<script type="text/javascript">
<!--
	alert("数据同步失败！");
//-->
</script>
<%}}%>