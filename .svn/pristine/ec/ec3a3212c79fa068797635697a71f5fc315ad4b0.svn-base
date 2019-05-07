<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
%>
<html>
	<head>
		<title>文档模板导出</title>

		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
		<base target="_self">
	
	<%@ include file="/epp/css/cssControl.jsp"%>
	<script type="text/javascript">
	function checkup(){
		if(!/\.zip$/.test(document.ApplyForm.filepath.value)){
			alert('文件格式不对，只允许上传zip文件');
			return;
		}
		ApplyForm.submit();
	}
	</script>
	<body class="contentbodymargin" scroll="no">
		<div id="contentborder" align="center">
			<form name="ApplyForm" action="<%=request.getContextPath()%>/servlet/CreatorPTServlet?key=importDocTmp" method="post" enctype="multipart/form-data">
				<br />
				<br />
				<fieldset style="width: 90%;">
					<LEGEND align=center>
						<FONT size="2">上传模板文件ZIP包</FONT>
					</LEGEND>
					<br />
					<table width="95%" border="0" cellpadding="0" cellspacing="1"
						class="">
					<tr><td>
					选择文件：<input type="file" id='filepath' name="filepath" value="" size="70">
					</td></tr>
					</table>
					
				</fieldset>
				<div align="center">
					<table width="15%" border="0" align="right" cellpadding="0"
						cellspacing="0">
						<tr>
							<td>
								<div align="left">
									<input name="upbutton" type="button" class="input" onclick="checkup()" value="上传">
								</div>
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</body>
</html>
