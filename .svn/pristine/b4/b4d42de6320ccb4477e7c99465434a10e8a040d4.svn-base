<%@page contentType="text/html; charset=GBK" %>
<%@page import="java.util.*, com.chinacreator.sysmgrcore.entity.*"%>
<HTML><HEAD></HEAD> 
<%
	String groupId = (String)request.getParameter("groupId");
%>
<FRAMESET border=0 frameSpacing=1 cols=""   frameborder="1" rows="30%,55%,15%">
<FRAME id=opergroupInfo name=opergroupInfo src="<%=request.getContextPath()%>/sysmanager/opermanager/operManager.do?method=getGroupInfo&groupId=<%=groupId%>"; bordercolor='#7F7F7F' frameborder="0">
<FRAME id=operList name=operList src="operList.jsp?groupId=<%=groupId%>">
<FRAME id=operInfo name=operInfo src="operInfo.jsp"; bordercolor='#7F7F7F' frameborder="0">
</FRAMESET>
</HTML>
