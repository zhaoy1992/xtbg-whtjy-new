<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%
	//应该由当前的应用id获得对应的菜单文件信息，由模块的id获得对应的菜单项信息
	String moduleId = request.getParameter("moduleId");
%>
<html>
<head>
<title>菜单操作</title>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body>
<iframe name="additem" width="100%" height="100%"></iframe>
<div style="width: 0px;height: 0px;display: none;" >
	<form name="form" method="post">
		<input type="hidden" name="moduleId" value="<%=moduleId%>" />
		<input type="hidden" name="isFill" value="true" />
		<input type="hidden" name="itemdisicon" value="epp/eppTemplate/itemicon/tb_applymanager_disabled.gif" />
		<input type="hidden" name="itemenicon" value="epp/eppTemplate/itemicon/tb_applymanager_enabled.gif" />
	</form>
	<script type="text/javascript">
<!--	
		var i = 0;
		if(i==0){
			additem.src="additemtab1.jsp";
			form.target="additem";
			form.action="additemtab1.jsp";	
			form.submit();
			i++;
		}
//-->
</script>
</div>
</body>
</html>