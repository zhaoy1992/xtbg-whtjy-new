<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
    AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
%>
<html>
	<head>
		<title>操作容器工具栏</title>
		<link rel="stylesheet" type="text/css" href="../../css/toolbar.css">
		<script language="javascript" src="../../scripts/toolbar.js"></script>
		<style type="text/css">
		<!--
		.style1 {color: #000000}
		-->
		</style>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="toolbarbodymargin">
		<div id="toolbarborder">
			<div id="toolbar" >
				<table width="100%" cellpadding=0 cellspacing=0 border=0>
					<tr>
						<td valign="middle" align="center" width=25 >
						    <img class="normal" src="../../images/actions.gif">
						</td>
						<td align="left" valign="middle" nowrap class="text">级次分配方案明细</td>
					</tr>
				</table>
			</div>
		</div>
	</body>
</html>
