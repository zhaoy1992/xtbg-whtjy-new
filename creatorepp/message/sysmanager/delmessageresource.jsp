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
   	alert("ɾ���ɹ���");
   	getPropertiesContent().location.reload();
</script>
<% } else { %>
<script type="text/javascript" language="javascript">
	alert("ɾ��ʧ�ܣ����Ժ����ԣ�");
	getPropertiesContent().location.reload();
</script>
<% } %>