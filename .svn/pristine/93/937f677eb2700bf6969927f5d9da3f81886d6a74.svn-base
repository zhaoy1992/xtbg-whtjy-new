<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"
    import="com.chinacreator.security.AccessControl,
    		com.chinacreator.message.dbmanager.MessageResourceManager"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	String ids = request.getParameter("ids");
	MessageResourceManager messageResourceManager = new MessageResourceManager();
	boolean flag = messageResourceManager.deleteMessageResource(ids);
%>
<% if (flag) { %>
<script type="text/javascript" language="javascript">
   	alert("删除成功！");
   	getPropertiesContent().location.reload();
</script>
<% } else { %>
<script type="text/javascript" language="javascript">
	alert("删除失败，请稍后再试！");
	getPropertiesContent().location.reload();
</script>
<% } %>