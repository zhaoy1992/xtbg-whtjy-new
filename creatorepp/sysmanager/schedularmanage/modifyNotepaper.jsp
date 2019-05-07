<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="java.util.*,com.chinacreator.sysmgrcore.entity.*,com.chinacreator.sysmgrcore.web.struts.form.*"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.OrgManager"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%Date date = new Date();
            String dateStr = StringUtil.getFormatDate(date,
                    "yyyy-MM-dd HH:mm:ss");
            String path = request.getParameter("path");

        %>
<html>
	<head>
		<script language="JavaScript" src="common.js" type="text/javascript"></script>
		<script language="javascript" src="../scripts/selectTime.js"></script>
		<SCRIPT language="JavaScript" SRC="../scripts/validateForm.js"></SCRIPT>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>userInfo4</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
.style2 {
	font-size: medium;
	font-family: Tahoma, Verdana, Arial, Helvetica;
}
-->
        </style>
	</head>

	<script language="JavaScript">

	function modify()
	{		
		document.forms[0].action="<%=rootpath%>/sysmanager/schedularmanage/action/schManager.jsp?method=modifyNotepaper";
		document.forms[0].submit();
	}
	function goback()
	{
		document.location="<%=rootpath%>/sysmanager/schedularmanage/notepaperList.jsp";
	}
</script>

	<%@ include file="/epp/css/cssControl.jsp"%><body  class="info" scrolling="no">

		<form name="schedularForm" method="post" action="">
			<pg:beaninfo requestKey="schedular">
				<input type="hidden" name="schedularID" value="<pg:cell colName="schedularID"  defaultValue=""/>">

				<table width="100%" height="85" border="0" cellpadding="0" cellspacing="2" class="thin">
					<tr>
						<td height="35" align=center colspan=5>
							<P>
								<STRONG><B>便笺修改</B></STRONG>
							</P>
						</td>
					</tr>
					<tr>
						<td class="detailtitle" height="35" align="center" width="10%">
							便笺内容
						</td>
						<td class="detailcontent" width="10%">
							<TEXTAREA cols="100%" rows="6" name="content"><pg:cell colName="content" defaultValue="" /></TEXTAREA>
						</td>
					</tr>
				</table>
				<hr width="98%">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<INPUT type="button" class="input" value="修改" onclick="modify()">
							<INPUT type="button" class="input" value="取消" onclick="goback()">
						</td>
					</tr>
				</table>
			</pg:beaninfo>
		</form>
		<%@include file="sysMsg.jsp"%>
	</body>
</html>
