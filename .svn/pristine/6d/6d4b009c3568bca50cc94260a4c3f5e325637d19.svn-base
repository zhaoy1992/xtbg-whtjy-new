<%@ page language="java" contentType="text/html; charset=GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>绑定用户</title>
		<script language="JavaScript" src="../scripts/selectTime.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<%@page import="com.chinacreator.security.AccessControl"%>
		<%@page import="com.frameworkset.util.StringUtil,java.util.Date"%>
		<%AccessControl accesscontroler = AccessControl.getInstance();
            accesscontroler.checkAccess(request, response);
			String procDefName = request.getParameter("procDefName");
			String procDefId = request.getParameter("procDefId");
			String pkgId = request.getParameter("pkgId");
			String actorId = request.getParameter("actorId");
			System.out.println("------------------------binduser------------------------");
			System.out.println("procDefId:"+procDefId);
			System.out.println("pkgId:"+pkgId);
			System.out.println("actorId:"+actorId);
			System.out.println("procDefName:"+procDefName);
        %>
		<script language="JavaScript">
		function bind()
		{
			if(document.all("userId").value.length<1)
			{
   				alert("请选择人员！");
   				return;
   			}
   			
   			document.BindUserForm.action="../workflowmanager/Usermapping.do?method=bindUser";
   			document.BindUserForm.submit();
		}
		
		function adduser()
		{
	    	window.open('selectuser.jsp?displayNameInput=username&displayValueInput=userId','newWin','scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250')
		}
</script>

	</head>

	<%@ include file="/epp/css/cssControl.jsp"%><body >
		<form name="BindUserForm" method="post">
			<table width="100%" border="0">
				<tr>
					<input name="pkgId" type="hidden" value="<%=pkgId%>">
					<input name="procDefId" type="hidden" value="<%=procDefId%>">
					<input name="actorId" type="hidden" value="<%=actorId%>">
					<input name="userId" type="hidden">
					<textarea name="username" cols="30" rows="6" readonly="true"></textarea>
					</td>
				</tr>
				<tr align="center">
					<td colspan="4">
						<INPUT type="button" value="选择人员" onclick="adduser()">
						<input type="button" name="Submit" value="绑定" onclick="bind()">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
