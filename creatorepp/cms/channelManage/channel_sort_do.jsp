<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.cms.channelmanager.ChannelManagerImpl"%>
<%
	String idsStr = request.getParameter("channelIds");//机构orgName
	String[] ids = idsStr.split(",");

	boolean flag = false;//System.out.println(orgIds.length);
	ChannelManagerImpl imp = new ChannelManagerImpl();
	flag = imp.sortChannel(ids);
	if(flag)
	{
%>
<SCRIPT LANGUAGE="JavaScript">
	alert("操作成功！");
	parent.window.returnValue = true;
	window.close();
</SCRIPT>
<%
	}
	else
	{
%>
<SCRIPT LANGUAGE="JavaScript">
	alert("操作失败！");
</SCRIPT>
<%
	}
%>
