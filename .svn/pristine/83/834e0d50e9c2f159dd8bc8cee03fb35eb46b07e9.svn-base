<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ include file="../../../sysmanager/include/global1.jsp"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenuTag"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenu"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenuImpl"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.Menu"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.*"%>
<%@ page import="com.chinacreator.cms.*,com.chinacreator.security.AccessControl"%>
<%	
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
	//获取站点id
	CMSManager cmsM = new CMSManager();
	cmsM.init(request,session,response,accesscontroler);
	String siteId = cmsM.getSiteID();
	request.setAttribute("site_id",siteId);
	
	String class_id = request.getParameter("class_id");
	String class_name = request.getParameter("class_name");
	String form_id = request.getParameter("form_id");
	if(form_id==null) form_id = "1";
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<link href="../../../comm/public_info/css/cms.css" rel="stylesheet" type="text/css">
		<title>内容管理主框架</title>
		<script src="<%=request.getContextPath()%>/cms/inc/js/func.js"></script>
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/include/pager.js" type="text/javascript"></script>
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
		<script type="text/javascript">		
			
			
			
			function viewAuditComment(id){
				openWin("audit_comment.jsp?idStr="+id,400,550);
			}
			
			
		</script>
		<script language="javascript">
		var arr = new Array();
		function getArr(){
			var all = document.getElementsByName("ID");
			var docidStr="";
			for(var i=0;i<all.length;i++){
				if(all[i].checked == true){
					if(docidStr=="")
					{
						docidStr = all[i].value;
					}
					else
					{
						docidStr += "," + all[i].value;
					}
				}
			}
			return docidStr;
		}
	</script>
	</head>

	<body topmargin="1" rightmargin="1" scroll=auto leftmargin="1">
		<!-- div id="divProcessing" style="position:absolute;width:40%;height:20px;z-index:1;
			background-color:#F0f0f0;layer-background-color:#F0f0f0;left:22%;top:80%;display:none;"  class="font">   
	    <marquee direction="left" width="250" behavior="alternate"><span class=STYLE1>正在发布中，请稍等……</span></marquee>
    	</div--> 
           
         
		<form name="form1" action="" method="post">
			<table width="100%" border="1" align=center cellpadding="3" cellspacing="0" bordercolor="#B7CBE4"  class="Datalisttable" id="docListTable">
				<pg:listdata dataInfo="com.chinacreator.comm.publicInfo.list.PublicInfoContentList" keyName="PublicInfoContentList" />
				<!--分页显示开始,分页标签初始化-->
				<pg:pager maxPageItems="10" scope="request" data="PublicInfoContentList" isList="false">
					<tr class="cms_report_tr">
						<!--设置分页表头-->

						<td width="2%" align=center style="width:5%">
							<input class="checkbox" type="checkBox" hidefocus=true name="checkBoxAll" onClick="checkAll('checkBoxAll','ID')">
						</td>
						<td width="8%">
							是否置顶
						</td>
						<td width="28%">
						<%
							if(form_id.equals("1")) out.print("信息标题");
							if(form_id.equals("2")) out.print("领导姓名");
							if(form_id.equals("3")) out.print("机构名称");
						%>	
						</td>
						<td width="6%">
							状态
						</td>
						<td width="9%">
							发稿人						
						</td>
						<td width="9%">
							审核人						
						</td>
						<td width="8%">
							作者
						</td>
						<td width="17%">
							发稿日期
						</td>
					</tr>
					<!--检测当前页面是否有记录-->
					<pg:notify>
						<tr  class="labeltable_middle_tr_01">
							<td colspan=100 align='center' height="18px">
								该频道暂时没有文档
							</td>
						</tr>
					</pg:notify>
					<pg:param name="class_id"/>
					<pg:param name="class_name"/>
					<pg:param name="title"/>
					<pg:param name="audtor"/>
					<pg:param name="state"/>
					<pg:param name="author"/>
					<pg:param name="creator"/>
					<pg:param name="form_id"/>
					<!--list标签循环输出每条记录-->
					<pg:list>
                        <tr class="cms_data_tr" id="<pg:cell colName="id" defaultValue=""/>" onMouseOver="high(this)" onMouseOut="unhigh(this)">
							<td class="tablecells" align=center height='30'>
							  <input class="checkbox" hideFocus onClick="checkOne('checkBoxAll','ID')" type="checkbox" name="ID" value="<pg:cell colName="id" defaultValue=""/>">
							  <input type="hidden" name="state_<pg:cell colName="id"/>" value="<pg:cell colName="state" defaultValue=""/>">
							</td>
							<td>
								<pg:equal colName="istop" value="1">
									<font color="#ff0000">置顶</font>
								</pg:equal>
							</td>
							<td class="tablecells" style="cursor:hand" onclick="updateInfo('<pg:cell colName="id"/>','<%=form_id%>');">
								 <pg:cell colName="subtitle" defaultValue="" />
							</td>
							<td class="tablecells">
								<pg:equal colName="state" value="0">
									新稿
								</pg:equal>
								<pg:equal colName="state" value="1">
									待审
								</pg:equal>
								<pg:equal colName="state" value="2">
									待发
								</pg:equal>
								<pg:equal colName="state" value="3">
									已发
								</pg:equal>
								<pg:equal colName="state" value="4">
									返工
								</pg:equal>
							</td>
							<td class="tablecells">
								<pg:cell colName="creator" defaultValue="" />
							</td>
							<td class="tablecells">
								<pg:cell colName="auditor" defaultValue="" />
							</td>
							<td class="tablecells">
							  	<pg:cell colName="author" defaultValue="" />
							</td>
							<td class="tablecells">
							  <pg:cell colName="create_time" defaultValue="" />
							</td>
						</tr>
					</pg:list>
					<pg:contextmenu context="opinfo" enablecontextmenu="true" scope="request"/>
					<tr class="labeltable_middle_tr_01">
						<td colspan=10 ><div class="Data_List_Table_Bottom"> 
							共
							<pg:rowcount />
							条记录
							每页显示15条
							<pg:index />					</div>  </td>
					</tr>
					<input id="queryString" name="queryString" value="<pg:querystring/>" type="hidden">
					<tr></tr>
				</pg:pager>
		  </table>
		</form>
		<iframe height="0" width="0" name="operIframe"></iframe>
        <iframe name="cleanSession" id="cleanSession"  width="0" height="0"  style="display:none" ></iframe>
	</body>
</html>

