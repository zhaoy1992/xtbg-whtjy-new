<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"
    import="com.chinacreator.epp.message.dbmanager.UserMessageResourceManager
	    	,com.chinacreator.security.AccessControl"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	String user_id = control.getUserID();
	String ids = request.getParameter("ids");
	UserMessageResourceManager userMessageResourceManager = new UserMessageResourceManager();
	boolean flag = userMessageResourceManager.deleteMessageResourceMapping(ids, user_id);
%>
<% if (flag) { %>
<script type="text/javascript" language="javascript">
   	alert("���óɹ���");
   	getPropertiesContent().location.reload();
</script>
<% } else { %>
<script type="text/javascript" language="javascript">
	alert("����ʧ�ܣ����Ժ����ԣ�");
	getPropertiesContent().location.reload();
</script>
<% } %>