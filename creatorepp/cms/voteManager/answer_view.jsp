<%@ page language="java" contentType="text/html; charset=gb2312"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.*"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head> 
 
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<title>查看网上调查</title>
		<link href="<%=request.getContextPath() %>/cms/inc/css/cms.css" rel="stylesheet" type="text/css">
		<META HTTP-EQUIV="pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
		<META HTTP-EQUIV="expires" CONTENT="Mon, 23 Jan 1978 20:52:30 GMT">
		
	<tab:tabConfig/>
	<script src="<%=request.getContextPath() %>/public/datetime/Calendar.js" language="javascript"></script>

	</head>
	<body style="background-color: #F3F4F9">
	<%
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);
	
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkAccess(request,response);
	CMSManager cmsM = new CMSManager();
	cmsM.init(request,session,response,accessControl);
	int siteID = Integer.parseInt(cmsM.getSiteID());
	%>
	<base target="_self">
		<form name="form1" method="post" action="modify_do.jsp" target="biaoge">
			
			<input name="ipStartString" type="hidden" value="">
			<input name="id" type="hidden" value="">
			<input name="ipEndString" type="hidden" value="">
			<input name="actionType" type="hidden" value="">
			<input name="origQidString" type="hidden" value="">
			<input name="channelid" type="hidden" value="">
	
			<table width="100%">
				<tr>
					<td>
						<div align="right">
							<input name="timeStartString" type="hidden" value="">
						
							<input type="button" name="关闭" value="关闭" onClick="return window.close()"  class="cms_button">
					  </div>
					</td>
				</tr>
			</table>
		<tab:tabContainer id="foo-survey-add" selectedTabPaneId="foo-survey">
			
		<tab:tabPane id="bar-question" tabTitle="网上调查信息">
		<table>
			<tr>
				<td align="center">
					<%
						String cid = request.getParameter("id");
					%>
					<iframe src='answerlist.jsp?id=<%=cid%>' width='760' height='400' scrolling='yes'>网上调查</iframe>
				</td>
			</tr> 
		</table>
		
		</tab:tabPane>
		
		</tab:tabContainer>
		</form>
		</base>
	</body>
</html>
