<%-- 
	描述：用户管理机构列表查询页面
	作者：黄艺平
	版本：1.0
	日期：2013-05-31
 --%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
			AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkManagerAccess(request,response);

			String userId = request.getParameter("userId");
			String userRealName = "";
			String userName = "";
			if (userId != null) {
				userId = request.getParameter("userId");
				UserManager userManager = SecurityDatabase.getUserManager();
				User user = userManager.getUserById(userId);
				userRealName = user.getUserRealname();
				userName = user.getUserName();
			}

			String remark5 = request.getParameter("remark5");
			String orgnumber = request.getParameter("orgnumber");
			if (remark5 == null) {
				remark5 = "";
			}

			if (orgnumber == null) {
				orgnumber = "";
			}
%>
<html>
	<head>
		<title>用户【<%=userRealName%>】可管理的部门列表</title>
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../css/contentpage.css">
		<script language="JavaScript" src="../../../../../purviewmanager/scripts/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../../../../../include/pager.js" type="text/javascript"></script>
		<script language="JavaScript">
		function resetSearch()
		{
			document.all.remark5.value = "";
			document.all.orgnumber.value = "";
		}
		
		function sub(){
			var orgName = document.all.remark5.value;
			var orgnumber = document.all.orgnumber.value;
			var tablesFrame= document.getElementsByName("orgList");
			tablesFrame[0].src = "managerorg_list_iframe.jsp?userId=<%=userId%>&orgName=" + orgName + "&orgnumber=" + orgnumber;
		}
	</script>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
		<div id="contentborder" align="center">
			<form name="Org" action="" method="post">
				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr>
						<td>
							机构名称
						</td>
						<td class="detailcontent">
							<input type="text" name="remark5" value="<%=remark5%>" size="35">
						</td>
						<td>
							机构编号
						</td>
						<td class="detailcontent">
							<input type="text" name="orgnumber" value="<%=orgnumber%>" size="35">
						</td>
						<td>
							<div align="center">
								<input name="Submit4" type="button" class="input" value="查询" onclick="sub()">
								<input name="Submit22" type="button" class="input" value="重置" onclick="resetSearch()">
								<input name="Submitc" type="button" class="input" value="关闭" onclick="window.close();">
							</div>
						</td>
					</tr>
				</table>
				<hr width="100%">
				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin" height="100%">

					<tr>
						<td height='30' align=center colspan=4>
							<b>机构列表
							<%
								if (accesscontroler.isAdmin(userName)) 
								{
							%>
								<font color="red">(该用户拥有administrator角色，可管理所有的部门)</font>
							<%
								}%>
							</b>
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<iframe name="orgList" src="managerorg_list_iframe.jsp?userId=<%=userId%>" style="width:100%" height="100%" scrolling="no" frameborder="0" marginwidth="1" marginheight="1">
							</iframe>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>

</html>
