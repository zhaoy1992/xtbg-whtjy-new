<%@ page language="java" contentType="text/html; charset=GBK"%>

<html>
	<head>
		<title>属性容器</title>

		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
	</head>
	
	<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" scroll="no"
		onLoad="">
		<div id="contentborder" align="center">
				<hr width="100%">
				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr>
						<td height='30' class="detailtitle" align="center" colspan="9">
							<b>请选中左边的类别树来查看流程</b>
						</td>
					</tr>	
				</table>
		</div>
	</body>
</html>