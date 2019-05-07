<%@ page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.sitemanager.*"%>
<%
    AccessControl control = AccessControl.getInstance();
    control.checkAccess(request,response);//

	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);

    SiteManager smi=new SiteManagerImpl();
	//boolean ret = smi.deleteSite(Integer.parseInt(request.getParameter("siteId")),path+"/");
	boolean ret = smi.logDeleteSite(request.getParameter("siteId"),request,response);
	//É¾³ýÕ¾µãÖØÐÂ¼ÓÔØ»º³å
	//SiteCacheManager.getInstance().reset();
%>
 <%if(ret==true){%>
	<script language="javascript">
		alert("¹§Ï²,Õ¾µãÉ¾³ý³É¹¦!");
		parent.window.returnValue = true;
		//parent.window.open("../main.jsp","perspective_content");
		
		close();
	 </script>
  <%}%>
  
  <%if(ret==false){%>
	<script language="javascript">
	   alert("±§Ç¸,Õ¾µãÉ¾³ýÊ§°Ü!");
	      
	 </script>
  <%}%> 