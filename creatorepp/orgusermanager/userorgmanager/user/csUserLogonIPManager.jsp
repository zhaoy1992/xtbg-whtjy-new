<%
/*
 * <p>Title: CS�û���¼����</p>
 * <p>Description: CS�û���¼����</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-4-12
 * @author peng.yang
 * @version 1.0
 */
 %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../../sysmanager/include/global1.jsp"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request,response);
	
	String userId = request.getParameter("userId");
	String action = request.getParameter("clear");
	String logonIp = "";
	try{
		DBUtil db = new DBUtil();
		String sql = "";
		if("yes".equals(action)){
			sql = "update td_sm_user set LOGON_IP='' where USER_ID = "+userId;
			db.executeUpdate(sql);
		}else{
			sql = " select LOGON_IP from td_sm_user where USER_ID = "+userId;
			db.executeSelect(sql);
			if(db.size() > 0){
				logonIp = db.getString(0,"LOGON_IP");
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	
	if("yes".equals(action)){
%>
		<script>
			alert("��ճɹ���");
			window.close();
		</script>
<%  }
%>
<html>
	<head>
		<title>CS�û���¼����</title>
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../css/contentpage.css">
		<script language="JavaScript">
			function clearIp(){
				document.subClearIpForm.action ="csUserLogonIPManager.jsp";
				document.subClearIpForm.target="subClearIp";
				document.subClearIpForm.submit();
			}
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body ><center><br/><br/><br/>
		<form action="" id="subClearIpForm" name="subClearIpForm" target="subClearIp">
			<input type="hidden" name="userId" id="userId" value="<%=userId %>" />
			<input type="hidden" name="clear" id="clear" value="yes" />
			<span style="font:10pt" >CS�û���¼IP:</span>
			<input type="text" name="csip" id="csip" size="30" readOnly value="<%=logonIp %>"/>
			<br/><br/>
			<input type="button" value="���" nam="btn" class="input" onclick="clearIp()"/>
		</form>
	</center>
	</body>
	<iframe name="subClearIp" height="0" width="0"></iframe>
</html>