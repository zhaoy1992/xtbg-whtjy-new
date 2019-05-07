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
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenuTag"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenu"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenuImpl"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.Menu"%>
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
	
	String channelName = request.getParameter("channelName");
	//String siteid = request.getParameter("siteid");
	String channelId = request.getParameter("channelId");
	
	String title = request.getParameter("title");
	String userId = request.getParameter("userid");
	String importstatus = request.getParameter("importstatus");
	String createTimeBegin = request.getParameter("createTimeBegin");
	String createTimeEnd = request.getParameter("createTimeEnd");
	String maxPageItems_str = request.getParameter("maxPageItems");
	if(maxPageItems_str==null||maxPageItems_str.equals(""))
		maxPageItems_str = "15";
	
	String orderByTitle = request.getParameter("orderByTitle");
	if(orderByTitle==null||orderByTitle.equals(""))
		orderByTitle = "0";
		
	String orderByDocsource = request.getParameter("orderByDocsource");
	if(orderByDocsource==null||orderByDocsource.equals(""))
		orderByDocsource = "0";
	
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
	//查看文档
		function viewDoc(docId,docType)
		{
			if(docType == 0) //普通
			{
				openWin("doc_view.jsp?docId=" + docId,1000,900);
			}else  // 其它文档暂时不处理
			{
				alert("HTML文档才能查看!");
			}
		}
		
		//删除文档
		function delDocs()
		{
			
			var all = document.getElementsByName("ID");
			var docIds = "";
			
			for(var i=0; i<all.length; i++)
			{
				if(all[i].checked == true)
				{
					docIds += all[i].value + ",";
				}
			}
			
			if(haveSelect('ID'))
			{
				if(confirm('您确定要删除所选文档吗？'))
				{
					form1.action = "crawlDocOp.jsp?action=delete&docIds=" + docIds ;
					form1.method = "post" ;
					form1.target = "operIframe" ;
					form1.submit() ;
				}
				else
				{
				  return false;
				}
			}
			else
			{
		    	alert("请选择要求删除的文档！");
		    	return false;
		   	}
		}
		
		function orderByTitles(flag)
		{
			if(flag==0)
				flag = 1;
			else
				flag = 0;
			document.form1.orderByTitle.value = flag;
			document.form1.orderByDocsource.value = "";
			subforms();
		}
		function orderByDocsources(flag)
		{
			if(flag==0)
				flag = 1;
			else
				flag = 0;
			document.form1.orderByDocsource.value = flag;
			document.form1.orderByTitle.value = "";
			subforms();
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
		<form name="form1" action="" method="post">
			<input type="hidden" name="orderByTitle"/>
			<input type="hidden" name="orderByDocsource"/>
			<input type="hidden" name="maxPageItems" value="<%=maxPageItems_str%>"/>
			<input type="hidden" name="title" value="<%=title!=null?title:""%>"/>
			<input type="hidden" name="importstatus" value="<%=importstatus!=null?importstatus:""%>"/>
			<input type="hidden" name="createTimeBegin" value="<%=createTimeBegin!=null?createTimeBegin:""%>"/>
			<input type="hidden" name="createTimeEnd" value="<%=createTimeEnd!=null?createTimeEnd:""%>"/>
			<table width="100%" border="1" align=center cellpadding="3" cellspacing="0" bordercolor="#B7CBE4"  class="Datalisttable" id="docListTable">
				<tr>
					<td height='25' colspan="11" background="<%=request.getContextPath()%>/cms/images/data_list_tHeadbg.jpg" style="text-align:left; background:url(<%=request.getContextPath()%>/cms/images/data_list_tHeadbg.jpg) repeat-y center #B7BDD7">
					<div  class="DocumentOperT">文档操作：</div>		
						<a style="cursor:hand" onClick="delDocs()"><div class="DocumentOper"><img 
									src="../images/new_doc.gif" class="operStyle">删除</div></a>
					</td>
				</tr>
				<pg:listdata dataInfo="com.chinacreator.cms.documentmanager.crawl.siteEDocumentList" keyName="siteEDocumentList" />
				<!--分页显示开始,分页标签初始化-->
				<pg:pager maxPageItems="<%=Integer.parseInt(maxPageItems_str)%>" scope="request" data="siteEDocumentList" isList="false">
					<tr class="cms_report_tr">
						<td width="2%" align=center style="width:5%">
							<input class="checkbox" type="checkBox" hidefocus=true 
									name="checkBoxAll" onClick="checkAll('checkBoxAll','ID')">
						</td>
						<td width="8%">文档类型</td>
						<td width="28%" style="cursor:hand" onclick="orderByTitles(<%=orderByTitle%>)">文档标题</td>
						<td width="6%">状态</td>
						<td width="9%">发稿人</td>
						<td width="8%" style="cursor:hand" onclick="orderByDocsources(<%=orderByDocsource%>)">来源</td>
						<td width="17%" style="cursor:hand">采集日期</td>
						<td width="10%" height='30' nowrap="nowrap">流程</td>
						 <td width="10%" height='30' nowrap="nowrap">频道</td>
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
					<pg:param name="importstatus"/>
					<pg:param name="maxPageItems" />
					<pg:param name="orderByTitle" />
					<pg:param name="orderByDocsource" />
					
					
					
					<pg:notify>
						<tr  class="labeltable_middle_tr_01">
							<td colspan=100 align='center' height="18px">
								暂无最新雷达采集文档							</td>
						</tr>
					</pg:notify>

					
					<%
						ContextMenu contextmenu = new ContextMenuImpl();
					%>
					<pg:list>
					<%
						int docId = dataSet.getInt("docId");	
						int docType = dataSet.getInt("docType");
						int importStatus = dataSet.getInt("importStatus") ;
						
						ChannelManager cm = new ChannelManagerImpl();
						Map docOpers = docManager.getDocOpers(docId,accesscontroler);

						Menu menu = new Menu();
						menu.setIdentity("opdoc_" + docId);
                        
						Menu.ContextMenuItem menuitem01 = new Menu.ContextMenuItem();
						menuitem01.setName("文档查看");
						menuitem01.setLink("javascript:viewDoc('" + docId +"','" + docType +"')");
						
						menuitem01.setIcon(request.getContextPath() +"/sysmanager/images/rightMemu/zoom.png");
						menu.addContextMenuItem(menuitem01);
						
						Menu.ContextMenuItem menuitem02 = new Menu.ContextMenuItem();
						menuitem02.setName("文档选送");
						menuitem02.setLink("javascript:sendSingleDoc('" + docId + "','" + importStatus + "')");
						menuitem02.setIcon(request.getContextPath() +"/sysmanager/images/rightMemu/send.png");
						menu.addContextMenuItem(menuitem02);

						
						
						contextmenu.addContextMenu(menu);
                       
					%>
						
                        <tr class="cms_data_tr" 
                        		id="<pg:cell colName="docId" defaultValue=""/>" 
                        			onMouseOver="high(this)" onMouseOut="unhigh(this)">
							<td class="tablecells" align=center height='30'>
							  <input class="checkbox" hideFocus 
							  	onClick="checkOne('checkBoxAll','ID')" 
							  	type="checkbox" 
							  	name="ID" 
							  	value="<pg:cell colName="docId" defaultValue=""/>"
							  	doctitle="<pg:cell colName="subtitle" defaultValue=""/>"
							 	docstatus="<pg:cell colName="importStatus" defaultValue=""/>">							
							 </td>

							<td class="tablecells" align=center height='30'>
								<pg:equal colName="docType" value="0">
									<div align="center">
										<img title="HTML文档" src="<%=request.getContextPath()%>/cms/images/doc_html.gif" width="20" height="20">									</div>
								</pg:equal>
								
								<pg:equal colName="docType" value="1">
									<div align="center">
										<img title="外部链接类型文档" src="<%=request.getContextPath()%>/cms/images/doc_link.gif" width="20" height="20">									</div>
								</pg:equal>
								
								<pg:equal colName="docType" value="2">
									<div align="center">
										<img title="下载文件类型" src="<%=request.getContextPath()%>/cms/images/doc_downloadfile.gif" width="15" height="16">									</div>
								</pg:equal>
								<pg:equal colName="docType" value="3">
									<div align="center">
										<img title="聚合文件类型" src="<%=request.getContextPath()%>/cms/images/doc_aggr.gif" width="15" height="16">									</div>
								</pg:equal>							
							</td>
						
								<pg:equal colName="docType" value="0">
									<td id="opdoc_<%=docId%>" class="tablecells" style="cursor:hand" onclick="viewDoc('<%=docId%>','<%=docType%>')">
										<pg:cell colName="subtitle" defaultValue="" />
								</pg:equal>
							
								<pg:equal colName="docType" value="1">
									<td id="opdoc_<%=docId%>" class="tablecells" style="cursor:hand" onclick="viewDoc('<%=docId%>','<%=docType%>')">
										<pg:cell colName="subtitle" defaultValue="" />
								</pg:equal>
							
							
								<pg:equal colName="docType" value="2">
									<td id="opdoc_<%=docId%>" class="tablecells" style="cursor:hand" onclick="viewDoc('<%=docId%>','<%=docType%>')">
										<pg:cell colName="subtitle" defaultValue="" />
								</pg:equal>
							
							
								<pg:equal colName="docType" value="3">
									<td id="opdoc_<%=docId%>" class="tablecells" style="cursor:hand" onclick="viewDoc('<%=docId%>','<%=docType%>')">
										<pg:cell colName="subtitle" defaultValue="" />
								</pg:equal>
								
							</td>
							
							<td class="tablecells">
								<pg:equal colName="importStatus" value="0">
									未处理
								</pg:equal>
								<pg:equal colName="importStatus" value="1">
									已处理
								</pg:equal>
							</td>
							
							<td class="tablecells">
							  <pg:cell colName="userName" defaultValue="" />
							</td>
							<td class="tablecells">
							  <pg:cell colName="extendSite" defaultValue="" />
							</td>
							<td class="tablecells">
							  <pg:cell colName="docwtime1" defaultValue="" />							
							</td>
							<td class="tablecells"  width="10%">
								<pg:cell colName="flowName" defaultValue="未知流程"/>
							</td>
							<td class="tablecells">
							  <pg:cell colName="channelName" defaultValue="" />
							</td>
						</tr>
					</pg:list>
					<%
							request.setAttribute("opdoc",contextmenu);
					%>
					<pg:contextmenu context="opdoc" enablecontextmenu="true" scope="request"/>
					<tr class="labeltable_middle_tr_01">
						<td colspan=11 >
							<div class="Data_List_Table_Bottom"> 
								共<pg:rowcount />条记录每页显示<%=maxPageItems_str%>条<pg:index />
							</div>  
						</td>
					</tr>
						<input id="queryString" name="queryString" value="<pg:querystring/>" type="hidden">
					<tr></tr>
				</pg:pager>
				  </table>
		</form>
		<iframe height="0" width="0" name="operIframe"></iframe>
	</body>
</html>


