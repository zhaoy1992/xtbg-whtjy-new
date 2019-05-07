<%@ page contentType="text/html; charset=gb2312" %>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl,com.chinacreator.sysmgrcore.manager.db.OrgManagerImpl" %>
<%
    AccessControl control = AccessControl.getInstance();
    control.checkAccess(request,response);

	String curOrgID = request.getParameter("orgID"); 
	String curOrgName = request.getParameter("orgName"); 
	String initRecordID = (String)request.getParameter("recordID");
	String initFileName = (String)request.getParameter("fileName");
	String initFileType = (String)request.getParameter("fileType");
	
	if(curOrgName == null && curOrgID != null)  //若机构名称没有通过参数方式传过来，则根据机构ID查询得到
	{
	    curOrgName = new OrgManagerImpl().getOrgById(curOrgID).getOrgName();
	}
	
	if(initRecordID == null || "null".equalsIgnoreCase(initRecordID))
    {
	   	initRecordID = "";
	}
	
	if(initFileName == null || "null".equalsIgnoreCase(initFileName))
    {
	   	initFileName = "";
	}
%>      
<jsp:include page="/eformsys/fceformext/public/public.jsp"></jsp:include>           
<html>
<head>
<title>模板管理</title>
<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
<script src="./js/fcpub.js"></script>
<script language="javascript">
function queryForm()
{	
	var userId = getSysElement('userid');
    if(userId.length == 0)
    {
       	alert("会话过期，请重新登录！");
       	window.location.reload();
    }
	var recordID = trim(document.all("recordID").value);
	var fileName = trim(document.all("fileName").value);
	var sUrl="./WebOffice_content_taoHong.jsp?recordID="+recordID+"&fileName="+fileName+"&orgID=<%= curOrgID%>&orgName=<%= curOrgName%>&fileType=<%= initFileType%>";
	ApplyForm.action=sUrl;
	//ApplyForm.submit();
}
</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%>
<body class="contentbodymargin">
	<div id="contentborder" align="center">
	   <form name="ApplyForm" action="" method="post">
		<table width="100%" border="0" cellpadding="1" cellspacing="1" class="thin">
			<tr>
				<td class="detailtitle" width="10%" align=right>
					模板编号：
				</td>
				<td class="detailcontent" width="90%">
					<input type="text" name="recordID" style="width:70%" value="<%= initRecordID%>">
				</td>
			</tr>
			<tr>
				<td class="detailtitle" width="10%" align=right>
					模板名称：
				</td>
				<td class="detailcontent" width="90%">
					<input type="text" name="fileName" style="width:70%" value="<%= initFileName%>">
				</td>
			</tr>
			<tr>
				<td width="16%">
				</td>
				<td class="detailcontent" width="30%" align="right">                             
					<input name="Submit4" type="submit" class="input" value="查询" onClick="queryForm()">
					<input name="Submit22" type="button" class="input" value="清空" onClick='document.all("recordID").value="";document.all("fileName").value=""'>
				</td>
			</tr>
        </table>
        
		<hr width="100%">
		
		<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
		
		<%
		  if(curOrgID==null)
		  {
		%>
		   <tr>
			  <td height='30' class="detailtitle" align="center" colspan="9">
				<b>请选择左边的类别查看模板</b>				        
			  </td>
		    </tr>
		<%}
		  else
		  {
		%>
					<tr>
						<td height='30' class="detailtitle" align="center" colspan="10">
							<b>模板列表<% if(!("null".equals(curOrgName))) out.print("("+curOrgName+")"); %></b>
						</td>
					</tr>
					<pg:listdata dataInfo="com.chinacreator.eform.formmanage.dbmanager.WebOfficeTemplateManagerTaoHong" keyName="TemplateListTaoHong" />
					<!--分页显示开始,分页标签初始化-->
					<pg:pager maxPageItems="10" scope="request" data="TemplateListTaoHong"	isList="false" >
					<tr>
						<td nowrap align=center class="headercolor" height="20">编号</td>
						<td nowrap align=center class="headercolor">模板名称</td>
						<td nowrap align=center class="headercolor">模板类型</td>
						<td nowrap align=center class="headercolor">模板说明</td>
						<td nowrap align=center class="headercolor">操作</td>
					</tr>

					<pg:param name="orgID"/>
					<pg:param name="recordID"/>
					<pg:param name="fileName"/>
					<pg:param name="fileType"/>

					<!--检测当前页面是否有记录-->
					<pg:notify>
						<tr height='25' class="labeltable_middle_tr_01">
							<td colspan=100 align='center'>
								暂时没有模板
							</td>
						</tr>
					</pg:notify>

					<!--list标签循环输出每条记录-->
					<pg:list>
						<tr class="labeltable_middle_tr_01"	onMouseOver="this.className='mousestyle1'"	onMouseOut="this.className= 'mousestyle2'">
							<td height='20' align=center class="tablecells" >
								<pg:cell colName="recordID" defaultValue="" />
							</td>
							<td height='20' align="center" class="tablecells">
								<pg:cell colName="fileName" defaultValue="" />
							</td>
							<td height='20' align="center" class="tablecells">
								<pg:cell colName="fileType" defaultValue="" />
							</td>
							<td height='20' align="center" class="tablecells">
								<pg:cell colName="descript" defaultValue="" />
							</td>
							<td height='20' align=center class="tablecells">
								<input type=button value="模板套红" size="20" onclick="window.returnValue=<pg:cell colName="recordID" />; window.close();"/>
							</td>
						</pg:list>
						<tr height="30" class="labeltable_middle_tr_01">
							<td colspan=100 align='right'>
								共
								<pg:rowcount />
								条记录
								<pg:index />
							</td>
						</tr>
					</pg:pager>
		  <%
		   }
		  %>
       </table>
      </form>
     </div>  
</body>
</html>
