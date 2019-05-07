<%@ page session="false" language="java" pageEncoding="GBK"%>
<%@page import="com.frameworkset.util.StringUtil"%><%
	/**
	* 用户推出系统时，可以退出到用户指定的页面地址，如果没有指定就退出到缺省的登录页面
	* 即login.jsp
	* 同时用户还可指定退出的目的窗口，如果没有指定就退出到top窗口
	*/
	String redirect = request.getParameter("_redirectPath");
	if(redirect == null || redirect.trim().equals(""))
		redirect = request.getContextPath() + "/login.jsp";
	String target = request.getParameter("_redirecttarget");
	if(target == null || target.trim().equals(""))
		target = "top";
	String alertMsg = request.getParameter("_alertMsg");
	
	
%>
<script language="javascript">

<%
if(alertMsg != null )
{
	%>
	alert("对不起，当前用户在其他地方登陆，您将退出系统，请重新登录！")
	<%
}
if(target.equals("location")){%>
	window.location = "<%=redirect%>";
	<%}
	else
	{%>
		//alert(top);
		window.<%=target%>.location = "<%=redirect%>";
	<%}%>
</script>

