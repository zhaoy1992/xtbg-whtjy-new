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
		<title>��������</title>

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
			
			//ҳ����ת
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
					default:alert('��ѡ��ͬ����!');
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
					<FONT size="2">ͬ��ѡ��</FONT>
				</LEGEND>
				<br />
				<br />
				<table width="20%" class="">
					<tr>
						<td align="left" height="35">
							<input type="radio" name="issueType" value="pttoexcel"
								checked="checked" />
							ƽ̨������Excel
						</td>
					</tr>
					<tr>
						<td align="left" height="35">
							<input type="radio" name="issueType" value="exceltopt" />
							Excel���뵽ƽ̨
						</td>
					</tr>
					<tr>
						<td align="left" height="35">
							<input type="radio" name="issueType" value="pttoxml" />
							ƽ̨������Xml
						</td>
					</tr>
					<tr>
						<td align="left" height="35">
							<input type="radio" name="issueType" value="xmltopt" />
							Xml����ƽ̨
						</td>
					</tr>
					<tr>
						<td align="left" height="35">
							<input type="radio" name="issueType" value="pttortx" />
							ƽ̨ͬ����Rtx
						</td>
					</tr>
					<tr>
						<td align="left" height="35">
							<input type="radio" name="issueType" value="rtxtopt" />
							Rtxͬ����ƽ̨
						</td>
					</tr>
					<tr>
						<td align="left" height="35">
							<input type="radio" name="issueType" value="pttoldap" />
							ƽ̨ͬ����Ldap
						</td>
					</tr>
					<tr>
						<td align="left" height="35">
							<input type="radio" name="issueType" value="ldaptopt" />
							Ldapͬ����ƽ̨
						</td>
					</tr>
					<tr>
						<td align="center" height="35">
							<%
							if (control.isAdmin()) {
							%>
							<input type="button" value="��һ��" class="input"
								onclick="jumpPage();" />&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="button" value="�ر�" class="input"
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
