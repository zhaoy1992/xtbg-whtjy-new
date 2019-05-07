<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.form.UserOrgManagerForm" %>
<%
  String groupId=request.getParameter("groupId");
  request.getSession().setAttribute("curGroupId", groupId);
%>
<html>
<head>
<title>系统管理</title>

</head> 
<frameset name="frame1" cols="40%,60%" frameborder="no" border="0" framespacing="0" >
  <frame src="orgTree.jsp" name="orgTree" id="orgTree" />
  <frame src="userList_ajax.jsp" name="userList" scrolling="No" noresize="noresize" id="orgList" />
</frameset>
<noframes>
<%@ include file="/epp/css/cssControl.jsp"%><body >
</body>
</noframes>
</html>
