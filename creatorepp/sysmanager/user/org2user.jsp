<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.form.UserOrgManagerForm" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.User" %>
<%@page import="com.frameworkset.common.poolman.DBUtil"%>

<%
	String userId=request.getParameter("userId");
	String orgId = request.getParameter("orgId");
	UserManager userManager = SecurityDatabase.getUserManager();
	User user = userManager.getUserById(userId);	
	String userName = user.getUserRealname();
	
	String sql ="select count(*) from td_sm_userrole where user_id ="+ userId +" and role_id='1'";
	try{
		DBUtil db = new DBUtil();
		db.executeSelect(sql);
		if(db.getInt(0,0)>0){
%>
	<SCRIPT LANGUAGE="JavaScript">
		alert("���û���ϵͳ����Ա�����ܰ�Ȩ�޸��Ƹ������û���"); 
		window.close();
		//getPropertiesContent().location.href="../user/userManager.do?method=getUserList&orgId=<%=orgId%>";
	</script>
<%}else{%>

<html>
<head>
<title>�û���<%=userName%>��Ȩ�޸���</title>
<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">

</head> 
<frameset  name="userId" value="<%=userId%>" cols="30,70,0" frameborder="no" border="0" framespacing="0" >
  <frame src="orgTreecopy.jsp?userId=<%=userId%>&orgId=<%=orgId%>" name="orgTree" id="orgTree" />
  <frame src="noOrg.jsp" name="userList" scrolling="No" noresize="noresize" id="orgList" />
  <frame src="#" name="orgId" value="<%=orgId%>" />
</frameset>

<noframes>
<%@ include file="/epp/css/cssControl.jsp"%><body >
</body>
</noframes>
</html>

<%
		}
	}
	catch(Exception e)
	{}	
%>
