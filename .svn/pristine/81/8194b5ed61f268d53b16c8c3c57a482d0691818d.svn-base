<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
%>
<html>
	<head>
		<title>属性容器</title>

		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/sysmanager/applymanager/common.js"
			type="text/javascript"></script>

		<script language="JavaScript" type="text/javascript">
			function getIssueType(){
				var issueType = document.getElementsByName("issueType");
				for(var i=0;i<issueType.length;i++){
					if(issueType[i].checked){
						return issueType[i].value;
					}
				}
				return 0;
			}
			
			//页面跳转
			function jumpPage(){
				switch(getIssueType()){					
					case 'pttoexcel':document.location.assign("impexcelorguser/expexecl.jsp");
					break;
					case 'exceltopt':document.location.assign("impexcelorguser/default.jsp");
					break;
					case 'pttoxml':document.location.assign("xml/pt2xml.jsp");
					break;
					case 'xmltopt':document.location.assign("xml/xmlupload.jsp");
					break;
					case 'pttortx':document.location.assign("ptrtx/pt2rtx.jsp");
					break;
					case 'rtxtopt':document.location.assign("ptrtx/rtx2pt.jsp");
					break;
					case 'pttoldap':document.location.assign("ptldap/pt2ldap.jsp");
					break;
					case 'ldaptopt':document.location.assign("ptldap/ldap2pt.jsp");
					break;
					default:alert('请选择同步项!');
				}
			}
		</script>

	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no">
		<div id="contentborder" align="center">
			<br />
			<br />
			<fieldset style="width: 90%;">
				<LEGEND align=center>
					<FONT size="2">同步选择</FONT>
				</LEGEND>
				<br />
				<br />
				<table width="20%" class="">
					<tr>
						<td align="left" height="35">
							<input type="radio" name="issueType" value="pttoexcel"
								checked="checked" />
							平台导出到Excel
						</td>
					</tr>
					<tr>
						<td align="left" height="35">
							<input type="radio" name="issueType" value="exceltopt" />
							Excel导入到平台
						</td>
					</tr>
					<tr>
						<td align="left" height="35">
							<input type="radio" name="issueType" value="pttoxml" />
							平台导出到Xml
						</td>
					</tr>
					<tr>
						<td align="left" height="35">
							<input type="radio" name="issueType" value="xmltopt" />
							Xml导入平台
						</td>
					</tr>
					<tr>
						<td align="left" height="35">
							<input type="radio" name="issueType" value="pttortx" />
							平台同步到Rtx
						</td>
					</tr>
					<tr>
						<td align="left" height="35">
							<input type="radio" name="issueType" value="rtxtopt" />
							Rtx同步到平台
						</td>
					</tr>
					<tr>
						<td align="left" height="35">
							<input type="radio" name="issueType" value="pttoldap" />
							平台同步到Ldap
						</td>
					</tr>
					<tr>
						<td align="left" height="35">
							<input type="radio" name="issueType" value="ldaptopt" />
							Ldap同步到平台
						</td>
					</tr>
					<tr>
						<td align="center" height="35">
							<%
							if (control.isAdmin()) {
							%>
							<input type="button" value="下一步" class="input"
								onclick="jumpPage();" />&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="button" value="关闭" class="input"
								onclick="window.close();" />
							<%
							}
							%>
						</td>
					</tr>
				</table>
			</fieldset>
		</div>

	</body>
</html>
