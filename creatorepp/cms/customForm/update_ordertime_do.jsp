<%@ page contentType="text/html;charset=GBK" language="java" import="java.util.*" %>
<%@page import="com.chinacreator.cms.documentmanager.*"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.*"%>
<%
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);
	
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
    
    
    String docId = request.getParameter("docId");
    docId = docId==null?"":docId;
    
    Date ordertime = null;
    java.text.SimpleDateFormat sf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    if(request.getParameter("ordertime") != null)
        ordertime = sf.parse(request.getParameter("ordertime"));
    
    DocumentManagerImpl impl = new DocumentManagerImpl();
    impl.updateDocOrdertime(docId,ordertime);
%>

<script>
    alert("�ĵ�������³ɹ�!");
    window.parent.setReturnValue();
</script>
    
    