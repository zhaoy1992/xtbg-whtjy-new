<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@page import="org.apache.commons.fileupload.*"%>
<%@ page import="java.util.*" %>

<%AccessControl accesscontroler = AccessControl.getInstance();
            accesscontroler.checkAccess(request, response);

            %>
<script language="JavaScript">
function upload()
   {
    	document.fileform.submit();
   }
   </script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>包管理</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
		<script language="JavaScript" src="../scripts/common.js" type="text/javascript"></script>
		<script language="JavaScript">
   			
   		</script>

		<!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
	</head>

	<%@ include file="/epp/css/cssControl.jsp"%><body >
		<form name="fileform" action="uploadPkgAction.jsp?"" method="post" enctype="multipart/form-data">
			<tr class="labeltable_middle_tr_01">
				<td class="tablecells" width="50%" nowrap="nowrap">
					<input type="file" name="filePath">
					<br>
					<input type="submit" name="Submit" value="增加包" onclick="upload()">
				</td>
			</tr>
		</form>
	</body>
</html>
