<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%
    out.println(request.getRemoteAddr());
    out.println(request.getRemoteHost());
    java.util.Enumeration e = request.getHeaderNames();
	while(e.hasMoreElements())
	{
		String name = (String)e.nextElement();
		out.println(name + "=" + request.getHeader(name));
	}
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>数据库连接池使用情况</title>
		
		</head>

	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" onload="loadPage();" scroll="no">
	
	<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr class="tr">
						<td width="16%" height="25" class="detailtitle" align="right">空闲连接：</td>
						<td height="25">
						<%=DBUtil.getNumIdle()%>
						</td>
						</tr>
						
						<tr class="tr">
						<td width="16%" height="25" class="detailtitle" align="right">正在使用连接：</td>
						<td height="25">
						<%=DBUtil.getNumActive()%>
						</td>
						</tr>
						
			
			  </table>
				</body>
</html>