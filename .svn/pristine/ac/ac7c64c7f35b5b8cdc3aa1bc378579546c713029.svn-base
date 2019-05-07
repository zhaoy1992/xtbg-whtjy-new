<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%@ page import="java.util.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%@ page import="com.chinacreator.cms.channelmanager.*"%>
<%@ page import="com.chinacreator.cms.documentmanager.*"%>





<%
			AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkAccess(request, response);

			response.setHeader("Cache-Control", "no-cache");
			response.setHeader("Pragma", "no-cache");
			response.setDateHeader("Expires", -1);
			response.setDateHeader("max-age", 0);

			//当前的时间
			String riqi;

			java.text.SimpleDateFormat df = new java.text.SimpleDateFormat(
					"yyyy-MM-dd");

			Date currentDate = new Date();
			/**当前时间*/
			riqi = df.format(currentDate);

			String maxPageItems = request.getParameter("maxPageItems");
			
			if (maxPageItems == null || maxPageItems == "")
			{
				maxPageItems = "10";
			}
			
			int maxPageItems_int = Integer.parseInt(maxPageItems);
			
			String startDate = request.getParameter("startDate");
			
			String endDate = request.getParameter("endDate");
			
			if (startDate == null)
			{
				startDate = riqi;
			}
			if (endDate == null)
			{
				endDate = riqi;
			}
%>
<html>
	<head>
		<title>CMS:::统计功能</title>
		<link href="../../inc/css/cms.css" rel="stylesheet" type="text/css"></link>
		<script language="javascript" src="../../inc/js/func.js"></script>
		<script language="javascript" src="../../../sysmanager/include/pager.js" type="text/javascript"></script>
		
		<style type="text/css">
			body 
			{
				background-color: #ffffff;
				scrollbar-face-color: #C9D1E4; 
				scrollbar-shadow-color: #6B74B7; 
				scrollbar-highlight-color: white; 
				scrollbar-3dlight-color: #E100E1; 
				scrollbar-darkshadow-color:#E100E1; 
				scrollbar-arrow-color:#003492; 
				scrollbar-base-color: #E100E1; 
				scrollbar-track-color: #E9EDF3; 
			}
		</style>
	</head>
	<body topmargin="2" rightmargin="0" leftmargin="1" righttmargin="1">
		<base target="_self">
		<form name="form1" action="" method="post">
			<table width="95%" border="0" align="center" cellpadding="3" cellspacing="0" bordercolor="#B7CBE4" class="Datalisttable" id="docListTable">
				
				<pg:listdata dataInfo="com.chinacreator.cms.documentmanager.crawl.EDocStatisticList" keyName="EDocStatisticList" />
				
				<pg:pager maxPageItems="<%=maxPageItems_int%>" 
								scope="request" data="EDocStatisticList" isList="false" sortKey="status" desc="true">
								
					<pg:param name="startDate" value="<%=startDate%>" />
					<pg:param name="endDate" value="<%=endDate%>" />
					<pg:param name="channelId"/>
					<pg:param name="maxPageItems" value="<%=maxPageItems%>"/>
			
			

					<tr class="cms_report_tr">
						<td width="25%">
							文档来源
						</td>
						<td width="25%">
							未使用文档数
						</td>
						<td width="25%">
							选送文档数
						</td>
						<td width="25%">
							采集文档总数
						</td>
					</tr>

					<pg:notify>
						<tr height="18px" class="labeltable_middle_tr_01">
							<td colspan=100 align='center'>
								没有找到记录
							</td>
						</tr>
					</pg:notify>

					<!--list标签循环输出每条记录-->
					<pg:list>
						<tr>

							<td>
								<pg:cell colName="extendSource" defaultValue="" />
							</td>
							<td>
								<pg:cell colName="collectionCount" defaultValue="" />
							</td>
							<td>
								<pg:cell colName="sendCount" defaultValue="" />
							</td>
							
							<td>
								<pg:cell colName="crawlCount" defaultValue="" />
							</td>
						</tr>
					</pg:list>
			</table>
			<table align=center width="100%">
				<tr height="18px" class="labeltable_middle_tr_01">
					<td colspan=4 align='center'>
						每页<font color="blue"><%=maxPageItems_int%></font>条记录 共
						<pg:rowcount />
						条记录&nbsp;&nbsp;
						<pg:index />
					</td>
				</tr>
			</table>
			</pg:pager>
		</form>
		<iframe height="0" width="0" name="operIframe"></iframe>
	</body>

</html>
