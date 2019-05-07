<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="com.chinacreator.cms.documentmanager.*"%>
<html>
<head><title>нд╣╣╣Ц╩В</title></head>

<%
	String docId = request.getParameter("docId");
	DocumentManagerImpl imp = new DocumentManagerImpl();
	imp.addCount(docId);
%>
</html>