<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.form.UserOrgManagerForm" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.*"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<html>
<head>
<title>用户批量调入机构</title>
<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<%
	String[] id =(String[])request.getAttribute("id");
    UserManager userManager = SecurityDatabase.getUserManager();	
     String idStr = "";
     String usern = "";
     String userna = "";
     for(int i = 0;i < id.length; i++)
     {
     	idStr += id[i]+",";
     	
     	User user = userManager.getUserById(id[i]);
     	usern= user.getUserName();
     	userna += usern + ",";
     }
	 if(idStr.length() > 1)
     idStr = idStr.substring(0,idStr.length()-1);
     if(userna.length() > 1)
     userna = userna.substring(0,userna.length()-1); 
%>
</head> 
<frameset name="frame1" cols="30,70" frameborder="no" border="0" framespacing="0" >
  <frame src="batchOrgTree.jsp?uid=<%=idStr%>&uname=<%=userna%>" name="orgTree" id="orgTree" />
  <frame src="properties_content.jsp" name="orgList" scrolling="No" noresize="noresize" id="orgList" />
</frameset>
<noframes>
<%@ include file="/epp/css/cssControl.jsp"%><body >
</body>
</noframes>
</html>
