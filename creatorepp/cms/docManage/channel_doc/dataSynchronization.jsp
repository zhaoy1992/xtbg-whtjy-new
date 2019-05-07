<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.documentmanager.DataSynchronizationInfoImpl"%>

<%
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);
	
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
    
    String idStr = request.getParameter("docIds");
    String channelId = request.getParameter("channelId");
    String site_id = request.getParameter("site_id");
	DataSynchronizationInfoImpl impl = new DataSynchronizationInfoImpl();
	boolean ret = impl.dataSynchronizationInfo(request,idStr,channelId,accesscontroler.getUserID(),accesscontroler.getUserAccount(),accesscontroler.getUserName(),request.getRemoteAddr());
	
	if(ret)
	{
		%>
		<SCRIPT LANGUAGE="JavaScript">
			alert("数据同步成功！");
			parent.window.dialogArguments.document.forms[0].submit();
			parent.window.close();
		</script>	
		<%
	}	
	else
	{
	%>
		<SCRIPT LANGUAGE="JavaScript">
			alert("数据同步失败！");
		</script>
	<%
	}
%>