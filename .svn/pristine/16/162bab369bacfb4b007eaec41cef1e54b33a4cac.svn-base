<%
	/**
	  * 站内文档查询
	  */
%>
<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.*"%>
<%@ page import="com.chinacreator.cms.sitemanager.*,com.chinacreator.cms.documentmanager.*"%>
<%@ page import="com.chinacreator.cms.channelmanager.*"%>
<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>
<%@page import="com.chinacreator.cms.util.CMSUtil"%>
<%@ page import="com.chinacreator.cms.CMSManager"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@page import="com.chinacreator.security.*"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);

	CMSManager cmsManager = new CMSManager();
	cmsManager.init(request,session,accesscontroler);
	Site site = cmsManager.getCurrentSite();

	//String channelName = request.getParameter("channelName");
	String siteid = site.getSiteId() + "";//request.getParameter("siteid");
	request.setAttribute("siteid",siteid);
	//String channelId = request.getParameter("channelId");
	String flag = request.getParameter("flag");
	//SiteManager siteManager = new SiteManagerImpl();
	String sitename = site.getName();;//siteManager.getSiteInfo(siteid).getName();

	DocumentManager docManager = new DocumentManagerImpl();
	
	String docsorid = request.getParameter("docsorid");
	String title = request.getParameter("title");
	String status = request.getParameter("status");
	String userid = request.getParameter("userid");
	String doctype = request.getParameter("doctype");
	String docLevel = request.getParameter("docLevel");
	String author = request.getParameter("author");
	String docAbstract = request.getParameter("docAbstract");
	String keyword = request.getParameter("keyword");
	String createTimeBegin = request.getParameter("createTimeBegin");
	String createTimeEnd = request.getParameter("createTimeEnd");
	String content = request.getParameter("content");

	
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<link href="<%=request.getContextPath()%>/cms/inc/css/cms.css" rel="stylesheet" type="text/css">
		<title>内容管理主框架</title>
		<script src="<%=request.getContextPath()%>/cms/inc/js/func.js"></script>
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/include/pager.js" type="text/javascript"></script>
		<script language="javascript"> 	
	
	
	
	function subforms()
	{
		form1.submit();
	}
	
	//文档查看
	function viewDocInfo(docId,doctype)
	{
		if(doctype == 0)//普通
			openWin("<%=rootpath%>/cms/docManage/doc_view.jsp?docid=" + docId,screen.availWidth-20,screen.availHeight-50);
		if(doctype == 1)//链接文档
			openWin("<%=rootpath%>/cms/docManage/doc_view_links.jsp?docid=" + docId,screen.availWidth-20,screen.availHeight-50);
		if(doctype == 2)//下载文档
			openWin("<%=rootpath%>/cms/docManage/doc_view.jsp?docid=" + docId,screen.availWidth-20,screen.availHeight-50);
		if(doctype == 3)//聚合文档
			openWin("<%=rootpath%>/cms/docManage/doc_view_aggr.jsp?docid=" + docId,screen.availWidth-20,screen.availHeight-50);
	}
	
</script>
		<style type="text/css">
		body {
			background-color: #ffffff;
		}
		.STYLE1 {color: #0000FF}
		.STYLE2 {color: #000099}
		.style3 {
			font-size: 14px;
			font-weight: bold;
			color: #3300FF;
		}
		.operStyle{ display:none;
		width:17;
		height:16;
		}

</style>
	</head>

	<body topmargin="1" rightmargin="1" scroll=auto leftmargin="1">
		<div id="divProcessing" style="position:absolute;width:40%;height:20px;z-index:1;
			background-color:#F0f0f0;layer-background-color:#F0f0f0;left:22%;top:80%;display:none;"  class="font">   
	    <marquee direction="left" width="250" behavior="alternate"><span class=STYLE1>正在发布中，请稍等……</span></marquee>
    	</div>
		<form name="form1" action="" method="post">
			<table width="100%" border="1" align=center cellpadding="3" cellspacing="0" bordercolor="#B7CBE4"  class="Datalisttable" id="docListTable">
				<pg:listdata dataInfo="SiteDocumentList" keyName="SiteDocumentList" />
				<!--分页显示开始,分页标签初始化-->
				<pg:pager maxPageItems="20" scope="request" data="SiteDocumentList" isList="false">
					<tr class="cms_report_tr">
						<!--设置分页表头-->

						<td width="2%" align=center style="width:5%"><input class="checkbox" type="checkBox" hidefocus=true name="checkBoxAll" onClick="checkAll('checkBoxAll','ID')"></td>
						<td width="8%">
							文档类型						</td>
						<td width="34%">
							文档标题</td>
						<td width="12%">
							所属频道</td>
						<td width="6%">
							查看</td>
						<td width="6%">
							状态						</td>
						<td width="9%">
							发稿人						</td>
						<td width="8%">
							作者						</td>
						<td width="19%">
							发稿日期						</td>
						<!--<td width="10%" height='30' nowrap="nowrap">
							操作
						</td>-->
					</tr>
				
					<pg:param name="channelId" />
					<pg:param name="channelName" />
					<pg:param name="siteid" />
					<pg:param name="flag" />
					<pg:param name="title" />
					<pg:param name="status" />
					<pg:param name="userid" />
					<pg:param name="doctype" />
					<pg:param name="createTimeBegin" />
					<pg:param name="createTimeEnd" />
					<pg:param name="docsorid" />
					<pg:param name="keyword" />
					<pg:param name="author" />
					<pg:param name="docAbstract" />
					<pg:param name="content" />
					<pg:param name="docLevel" />
					<!--检测当前页面是否有记录-->
					<pg:notify>
						<tr  class="labeltable_middle_tr_01">
							<td colspan=100 align='center' height="18px">
								请输入相关条件进行查询							</td>
						</tr>
					</pg:notify>

					<!--list标签循环输出每条记录-->
					
					<pg:list>
					<%
						int docTypeFlag = dataSet.getInt("doctype");
						int docStatusFlag = dataSet.getInt("status");
						int docId = dataSet.getInt("document_id");
						
					%>
						
                        <tr class="cms_data_tr" id="<pg:cell colName="document_id" defaultValue=""/>" onMouseOver="high(this)" onMouseOut="unhigh(this)">
							<input name="docid" value="<pg:cell colName="document_id" defaultValue=""/>" type=hidden>
							<td class="tablecells" align=center height='30'>
							  <input class="checkbox" hideFocus onClick="checkOne('checkBoxAll','ID')" type="checkbox" name="ID" value="<pg:cell colName="document_id" defaultValue=""/>">							</td>

							<td class="tablecells" align=center height='30'>
								<pg:equal colName="doctype" value="0">
									<div align="center">
										<img title="HTML文档" src="<%=request.getContextPath()%>/cms/images/doc_html.gif" width="20" height="20">									</div>
								</pg:equal>
								<pg:equal colName="doctype" value="1">
									<div align="center">
										<img title="外部链接类型文档" src="<%=request.getContextPath()%>/cms/images/doc_link.gif" width="20" height="20">									</div>
								</pg:equal>
								<pg:equal colName="doctype" value="2">
									<div align="center">
										<img title="下载文件类型" src="<%=request.getContextPath()%>/cms/images/doc_downloadfile.gif" width="15" height="16">									</div>
								</pg:equal>
								<pg:equal colName="doctype" value="3">
									<div align="center">
										<img title="聚合文件类型" src="<%=request.getContextPath()%>/cms/images/doc_aggr.gif" width="15" height="16">									</div>
								</pg:equal>							</td>
							<td id="opdoc_<%=docId%>" class="tablecells" >
								<pg:cell colName="subtitle" defaultValue="" />
							
							</td>
							<td class="tablecells">
								<pg:cell colName="channelName" defaultValue="" />
							</td>
							<td class="tablecells">
								<%
								if(accesscontroler.checkPermission(dataSet.getString("chanel_id"),AccessControl.CHANNEL_VIEWDOC_PERMISSION,AccessControl.CHANNELDOC_RESOURCE)|| accesscontroler.checkPermission(siteid,AccessControl.CHANNEL_VIEWDOC_PERMISSION,AccessControl.SITEDOC_RESOURCE))
								{
								%>
								<a href="#" onclick="viewDocInfo(<%=docId%>,<pg:cell colName="doctype" defaultValue=""/>);" ><u>查看</u></a>
								<%
								}
								else
								{
								%>
								<a href="#" onclick="alert('对不起，您没有权限查看文档！');" ><u>查看</u></a>
								<%
								}
								%>
							</td>
							<td class="tablecells">

							  <pg:cell colName="statusname" defaultValue="" />							</td>

							<td class="tablecells">
							  <pg:cell colName="username" defaultValue="" />							</td>
							<td class="tablecells">
							  <pg:cell colName="author" defaultValue="" />							</td>
							<td class="tablecells">
							  <pg:cell colName="docwtime1" defaultValue="" />							</td>
							<!--<td class="tablecells"  width="10%">
								
							</td>-->
						</tr>
					</pg:list>
					
					<tr class="labeltable_middle_tr_01">
						<td colspan=10 ><div class="Data_List_Table_Bottom"> 
							共
							<pg:rowcount />
							条记录 
							每页显示20条
							<pg:index />					</div>  </td>
					</tr>
					<input id="queryString" name="queryString" value="<pg:querystring/>" type="hidden">
					<tr></tr>
				</pg:pager>
		  </table>
		</form>
		<iframe height="0" width="0" name="operIframe"></iframe>
	</body>
</html>


