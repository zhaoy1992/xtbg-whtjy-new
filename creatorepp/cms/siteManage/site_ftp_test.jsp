<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.cms.util.FtpUpfile"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);

	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);
	
	String ftpUser = request.getParameter("ftpUser");
	String ftpPassword = request.getParameter("ftpPassword");
	int ftpPort = Integer.parseInt(request.getParameter("ftpPort"));
	String ftpIp = request.getParameter("ftpIp");
	
	boolean ftpOk=false;
	String errorMessage="";
	try
	{
		FtpUpfile ftpTest = new FtpUpfile(ftpIp,ftpPort,ftpUser,ftpPassword);
		ftpOk = ftpTest.testftp();
	}catch(Exception ex)
	{
		ftpOk = false;
		errorMessage = ex.getMessage();
	}	
	if(ftpOk)
	{
	%>
	<div align="center">���Գɹ���<br>
	
	  <%
	}else{
	%>
	����ʧ�ܡ�<br />
	������Ϣ:<%=errorMessage%>
	<%
	}
%>
    <input type="button" onClick="window.close()" value="�ر�">	
    </div>
