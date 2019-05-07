<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
%>
<html>
	<head>
		<title>属性容器</title>

		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no">
		<div id="contentborder" align="center">
			<br />
			<br />
			<fieldset style="width: 90%;">
				<LEGEND align=center>
					<FONT size="2">模块更新导入注意事项</FONT>
				</LEGEND>
				<br />
				<table width="85%">
					<tr>
						<td align="center" height="20" colspan="2">
							该功能暂未提供回滚的功能，请在更新前备份如下数据：
						</td>
					</tr>
					<tr>
						<td width="10%">
						</td>
						<td align="left" height="35">
							<ul>
								<li>
									平台数据库
								<li>
									需更新的应用数据库									
								<li>
									表单jsp文件：工程目录/eformsys/jxc/dj/
								<li>
									流程xqdl文件：工程目录/WEB-INF/repository/external/
								<li>
									报表raq文件：工程目录/report/reportFiles/
								<li>
									应用菜单文件：工程目录/WEB-INF/menuconfig/module-{应用ID}.xml
								<li>
									应用文件夹：工程目录/ccapp/app_{应用ID}/
							</ul>
						</td>
					</tr>
				</table>
			</fieldset>
			<div align="center">
				<table width="15%" border="0" align="right" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<div align="left">
								<input type="button" value="下一步" class="input" onclick="document.location.assign('impmenuload.jsp');">
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</body>
</html>

