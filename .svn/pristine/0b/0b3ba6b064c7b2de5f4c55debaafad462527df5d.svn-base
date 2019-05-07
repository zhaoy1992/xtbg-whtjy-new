<%
	/**
	  * Õ¾ÄÚÎÄµµ²éÑ¯
	  */
%>
<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.*"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);

	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);

	String channelName = request.getParameter("channelName");
	String siteid = request.getParameter("siteid");
	String channelId = request.getParameter("channelId");
	
%>
<html>
	<frameset rows="145,*" border=0>
	<frame frameborder=0  noResize scrolling="auto" marginWidth=0 name="sitedocQuery" src="<%=rootpath%>/cms/docManage/crawl/crawlDoc_queryFrame.jsp?channelName=<%=channelName%>&siteid=<%=siteid%>&channelId=<%=channelId%>"></frame>	
	<frame frameborder=0  noResize scrolling="auto" marginWidth=0 name="forDocList" src="<%=rootpath %>/cms/docManage/crawl/sitecrawlDoc_list.jsp?channelName=<%=channelName%>&siteid=<%=siteid%>&channelId=<%=channelId%>"></frame>
	</frameset><noframes></noframes>
</html>
