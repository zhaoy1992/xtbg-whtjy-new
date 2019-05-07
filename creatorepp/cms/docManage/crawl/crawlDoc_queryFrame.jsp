<%@ page contentType="text/html; charset=GBK"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.sitemanager.SiteCacheManager"%>
<%@ page import="com.chinacreator.cms.sitemanager.SiteManager"%>
<%@ page import="com.chinacreator.cms.sitemanager.SiteManagerImpl"%>
<%@ page import="com.chinacreator.cms.channelmanager.ChannelCacheManager"%>
<%@ page import="com.chinacreator.cms.documentmanager.crawl.EDocumentManagerImpl"%>
<%@ page import="com.chinacreator.cms.documentmanager.crawl.EDocumentManager"%>
<%@ page import="java.util.List"%>
<%@ page import="com.chinacreator.cms.CMSManager"%>
<%@ page import="com.chinacreator.cms.sitemanager.*,com.chinacreator.cms.documentmanager.*"%>

<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", -1);
	response.setDateHeader("max-age", 0);

	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	
	String channelname = request.getParameter("channelName");
	CMSManager cmsManager = new CMSManager();
	cmsManager.init(request,session,accesscontroler);
	Site site = cmsManager.getCurrentSite();

	//String channelName = request.getParameter("channelName");
	String siteid = site.getSiteId() + "";;
	String channelId = request.getParameter("channelId");
	
	SiteManager siteManager = new SiteManagerImpl();
	String sitename = siteManager.getSiteInfo(siteid).getName();
	ChannelCacheManager cm = (ChannelCacheManager) SiteCacheManager.getInstance().getChannelCacheManager(siteid);
			
	String rootpath = request.getContextPath() ;
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<link href="../../inc/css/cms.css" rel="stylesheet" type="text/css">
		<title>内容管理主框架</title>
		<script type="text/javascript"
			src="../../../public/datetime/calender_date.js" language="javascript"></script>
		<script language="javascript">
			function queryDoc()
			{	
				//查询
				form1.action="sitecrawlDoc_list.jsp?flag=query&siteid=<%=siteid%>&channelName=<%=channelname%>&channelId=<%=channelId%>"
				form1.target="forDocList";
				form1.submit();	
			}
		</script>
		<style type="text/css">
			body {
				background-color: #ffffff;
			}
			
			.STYLE1 {
				color: #0000FF
			}
			
			.STYLE2 {
				color: #000099
			}
			
			.style3 {
				font-size: 14px;
				font-weight: bold;
				color: #3300FF;
			}
			
			.operStyle {
				width: 17;
				height: 16;
			}
			</style>
	</head>
	<body topmargin="1" rightmargin="1" scroll=no leftmargin="1">
		<form id="form1" name="form1" method="post" action="">
			<table width="100%" height="100%" border="0" cellpadding="0"
				cellspacing="0">
				<tr>
					<td width="5" valign="top">
						<img src="../images/querybox_left.gif" width="5" height="62">
					</td>
					<td style="background: url(../images/querybox_bg.gif) repeat-x top">
						<table width="100%" height="100%" border="0" cellpadding="0"
							align="center" cellspacing="0" class="query_box">
							
							<tr>
								<td>
									<table width="100%" border="0" align="center" cellpadding="3"
										cellspacing="0" class="query_table">
										<tr>
											<td height='30' align="right">
												文档标题：
											</td>
											<td height='30' align="center" valign='middle'>
												<div align="left">
													<input name="title" type="text" size="16" class="cms_text">
												</div>
											</td>
											
											
											<td width="8%" height='30' align="right">
												采集状态:
											</td>
											<td width="16%" height='30' align="center" valign='middle'>
												<div align="left">
													<select name="importstatus" class="cms_select"
														style="width: 120">
														<option value="">
															--请选择状态--
														</option>
														<option value="0">
															未处理
														</option>
														<option value="1">
															已处理
														</option>
													</select>
												</div>
											</td>
											<td height='30' align="right">
												显示条数：
											</td>
											<td height='30' align="left" valign='middle'>
			<input name="maxPageItems" type="text" size="16" class="cms_text" value="15">									
											</td>
										</tr>

										<tr>
											<td width="8%" height='30' align="right" nowrap>
												撰写开始时刻:
											</td>
											<td width="16%" height='30' align="center" valign='middle' nowrap>
												<div align="left">
													<input name="createTimeBegin" type="text" size="16"
														class="cms_text">
													<input name="button" type="button"
														onClick="showdate(document.all('createTimeBegin'))"
													value="..." />
												</div>
											</td>
											
											<td width="8%" height='30' align="right" nowrap>
												撰写结束时刻:
											</td>
											<td width="16%" height='30' align="center" valign='middle' nowrap>
												<div align="left">
													<input name="createTimeEnd" type="text" size="18"
														class="cms_text">
													<input name="button" type="button"
														onClick="showdate(document.all('createTimeEnd'))" value="..." />
												</div>
											</td>
											<td colspan="2">
												<div align="center">
													<input name="search" type="button" class="cms_button"
														value="查询" onClick="queryDoc()">&nbsp;&nbsp;
													<input name="reset" type="reset" class="cms_button"
														value="重置">&nbsp;&nbsp;
													<input name="reset" type="button" class="cms_button" onclick="window.close()"
														value="返回">
												</div>
											</td>
											
											

										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
					<td width="6" valign="top">
						<img src="../images/querybox_right.gif" width="6" height="62">
					</td>
				</tr>
			</table>

		</form>
	</body>
</html>
