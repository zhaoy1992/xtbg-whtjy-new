<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import = "com.chinacreator.sysmgrcore.manager.db.LogManagerImpl"%>

<%
    
    String[] logid = request.getParameterValues("ID");
    String forwardStr = "logList.jsp";
    String queryString = request.getParameter("querystring");
    boolean tag = false;
    if(logid != null && logid.length>0){
		if (logid != null) {
		    LogManagerImpl logMgr=new LogManagerImpl();
			tag = logMgr.deleteLog(logid);
		}
		if(queryString!="")forwardStr = "logList.jsp?" + queryString;
%>

<script language="JavaScript">
    if(<%=tag%> == true)
    {
    	alert('É¾³ý³É¹¦');
    }
    else
    {
     	alert('É¾³ýÊ§°Ü');
    }
    window.parent.location.href = "<%=forwardStr%>";
</script>

<%}%>
</body>
</html>