<%@page contentType="text/html;charset=GBK" language="java"%>
<%@page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
    
    response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);
	
	String fileName = request.getParameter("file");
	
%>
<script>
	
	var fileName = "<%=fileName%>";
	if(fileName == "")
	{
		alert("�ļ�����<%=fileName%>���Ѵ��ڣ�������ָ�����ƣ�");
	}
	else
	{
		var uristr = "<%=fileName%>";
		location.replace("download_exp.jsp?file=" + fileName);
	}

	//window.setTimeout("winClose()", 1500);
</script>