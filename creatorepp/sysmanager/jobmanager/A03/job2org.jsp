<%@ include file="../../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../base/scripts/panes.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.form.UserOrgManagerForm" %>
<html>
<head>
<title>ϵͳ����</title>
<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../../css/windows.css">
<%
	String jobId=request.getParameter("jobId");
	
	/*UserOrgManagerForm s = (UserOrgManagerForm)request.getAttribute("userOrgForm");	
	String oid = "";
	String uid = "";
	if(s != null){
    	oid =  s.getOrgId();
    	uid = s.getUserId();
    }   
    session.setAttribute("roleTabId", "6"); */
      
%>
</head> 
<frameset name="frame1" cols="30,70" frameborder="no" border="0" framespacing="0" >
  <frame src="orgTree1.jsp?jobId=<%=jobId%>" name="orgTree" id="orgTree" />
  <frame src="selectorg.jsp" name="orgList" scrolling="No" noresize="noresize" id="orgList" />
</frameset>
<input type="hidden" name="jobId" value ="<%=jobId%>">
<%@ include file="/epp/css/cssControl.jsp"%><body >
</body>

</html>
