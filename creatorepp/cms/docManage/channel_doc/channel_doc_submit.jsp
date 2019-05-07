<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@ include file="../../../sysmanager/include/global1.jsp"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.*"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);

	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);
	
	String siteid = request.getParameter("siteid");
	String channelId = request.getParameter("channelId");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../css/cms.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=rootpath%>/sysmanager/css/windows.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/public/datetime/calender.js" language="javascript"></script>
<title>::::::文档选择::::::::::::::::::::::.</title>
<style type="text/css">
	.STYLE1 {color: #0000FF}
	.STYLE2 {color: #000099}
	.operStyle{
	width:17;
	height:16;
	}
.style7 {font-size: 5px}
</style>
<SCRIPT LANGUAGE="JavaScript">
	function subform(){
		if(confirm("您确定同步?"))
		{
			var arr = window.parent.chn_doc_top.chn_doc_list.getArr();
			document.myform.action = "dataSynchronization.jsp?channelId=<%=channelId%>&site_id=<%=siteid%>&docIds="+arr;
			document.myform.target = "handleFrame";
			document.myform.submit();
		}
	}
</SCRIPT>
</head>
<body>
	<form name="myform" method="post">
		<table align="center">
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>
					<input type="button" name="sub" class="cms_button" value="数据同步" onclick="subform();">
					<input type="button" name="winclose" class="cms_button" value="取消" onclick="window.close()">
				</td>
			</tr>
		</table>
	</form>
	<div heigth=0 width=0 style="display:none">
		<iframe name="handleFrame" width="0" height="0">
		</iframe>
	</div>
</body>
</html>