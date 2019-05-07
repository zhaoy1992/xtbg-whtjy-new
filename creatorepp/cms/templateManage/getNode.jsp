<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.util.*"%>
<%
try{ 
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);	
	String pathContext = (String)session.getAttribute("pathContext");
	if(pathContext==null || pathContext.trim().length()==0){
		return;
	}
	String uri = request.getParameter("uri");
	int level = Integer.parseInt(request.getParameter("level"));
	String result = FileUtil.getDirectoryNode(pathContext,uri,level); 
	out.println(result);
}catch(Exception e){
	
}
%>