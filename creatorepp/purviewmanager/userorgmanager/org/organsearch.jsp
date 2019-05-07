<%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>
<%
/**
 * <p>Title: 机构查询</p>
 * <p>Description: 机构查询页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-17
 * @author da.wei
 * @version 1.0
 **/
 %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl" %>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	String orgId = request.getParameter("orgId");
	String remark5 = request.getParameter("remark5");
	String orgcreator = request.getParameter("orgcreator");
	String orgnumber = request.getParameter("orgnumber");
	if (remark5 == null)
		remark5 = "";
	if (orgnumber == null)
		orgnumber = "";
	if (orgcreator == null)
		orgcreator = "";
%>
<html>
	<head>
		<title>机构查询</title>
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
		<script language="JavaScript">
			function resetSearch()
			{
				document.all.remark5.value = "";
				document.all.orgnumber.value = "";
				//document.all.orgcreator.value="";
			}
			function orgSearch()
			{
				document.all.orgList.src="organsearchlist.jsp?remark5="+document.all.remark5.value+"&orgnumber="+document.all.orgnumber.value;//+"&orgcreator="+document.all.orgcreator.value;
			}
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
		<div id="contentborder" align="center">
			<form name="Org" action="" method="post">
				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr>
						<td align=center>
							机构名称：
							<input type="text" name="remark5" value="<%=remark5%>">
						</td>
						<td align=center>
							机构编号：
							<input type="text" name="orgnumber" value="<%=orgnumber%>">
						</td>
						<%--<td align=center>
							机构创建人：
							<input type="text" name="orgcreator" value="<%=orgcreator%>">
						</td>--%>
						<td>
							<div align="center">
								<input name="Submit44" type="button" class="input" value="查询" onclick="orgSearch()">
								<input name="Submit22" type="button" class="input" value="清空" onclick="resetSearch()">
								<input name="Submit26" type="button" class="input" value="返回" onclick="window.close();">
							</div>
						</td>
					</tr>
				</table>
				<hr width="100%">
				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
					<iframe width="100%" height=410px frameborder=0 noResize scrolling="false" marginWidth=0 name="orgList" src="organsearchlist.jsp"></iframe>
				</table>
			</form>
		</div>
	</body>
</html>
