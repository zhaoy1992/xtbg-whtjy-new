<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.List,java.util.ArrayList"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.db.UserManagerImpl"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Organization"%>
<html>
	<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	UserManagerImpl impl = new UserManagerImpl();
		List list = new ArrayList();
		String orgId = accesscontroler.getChargeOrgId();
		Organization org = new Organization();
		org.setOrgId(orgId);
		System.out.println("orgId->"+orgId);
		String userId = "admin";
		System.out.println(userId);
		try{
			list = impl.getUserList(org);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
		}
		
	%>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
		<meta http-equiv="expires" content="Mon, 23 Jan 1978 20:52:30 GMT">
		<title>◎请选择◎</title>
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
	</head>
	<base target="_self">
	<%@ include file="/epp/css/cssControl.jsp"%><body scroll=no>
		<form action="" >
			<div  style="width:100%;height:420;overflow:auto">
			<table width="100%" border="1" cellpadding="2" cellspacing="0"
				bordercolorlight="#3B4D61" bordercolordark="#ffffff">
				<%
				for (int i = 0; i < list.size(); i++) {
					User user = (User) list.get(i);
					String userName = user.getUserName();
					String userRealname = user.getUserRealname();
				%>
				<tr>
					<td align="LEFT">
						
						<INPUT type=radio name="user" value="<%=userName %>"  ><%=userRealname%>
					</td>
				</tr>
				<%
				}
				%>
			</table>
			</div>
			<table width="100%" border="1" cellpadding="2" cellspacing="0"
				bordercolorlight="#3B4D61" bordercolordark="#ffffff">
				<tr>
					<td align="center" bgcolor="#415A76">
						<input name="Submit" type="button" class="black_menu" value="确定"
							onClick="return sel()">
						<input name="Close" type="button" class="black_menu" value="关闭窗口"
							onClick="return window.close()">
					</td>
				</tr>
			</table>
		</form>
<script language="JavaScript">
function sel(){
	
	
	var ret = "";
	var o = document.all.item("user");
	for(var i=0;i<document.all.user.length;i++)
	{
	    if (document.all.user[i].checked)
	    {
	     ret = document.all.user[i].value;
	    }
	}
    if(ret == null){
    	alert("请选择用户!");
    }else {
    	window.returnValue=ret;
		window.close();
	}
}

</script>
</body>
</base>
</html>