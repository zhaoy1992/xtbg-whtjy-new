<%@ page contentType="text/html;charset=GBK" language="java" import="java.util.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.documentmanager.*"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
%>
<html>
<frameset rows="24%,*" border=0>
	<frame marginwidth="0" frameborder=0 scrolling="auto" noresize name="pubDocQueryF" src="<%=rootpath%>/cms/docManage/doc_publish_query.jsp"></frame>
	<frame marginwidth="0" frameborder=0 scrolling="auto" noresize name="pubDocListF" src="<%=rootpath%>/cms/docManage/doc_publish_list.jsp"></frame>		
</frameset><noframes></noframes>
</html>