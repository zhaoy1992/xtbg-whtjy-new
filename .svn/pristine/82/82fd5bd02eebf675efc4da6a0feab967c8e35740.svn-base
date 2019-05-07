<%@ page language="java" contentType="text/html;charset=GBK"%>

<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	
   accesscontroler.checkAccess(request,response);
   

   	String type = "user";

%>

<html >
      

<head>
		<title>属性容器</title>
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
<tab:tabConfig/>		
<%@ include file="/epp/css/cssControl.jsp"%><body >
		<table width="100%" border="0"  cellpadding="0" cellspacing="1" class="thin">	
			<pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.JobByUserList" keyName="JobByUserList"/> 
			<!--分页显示开始,分页标签初始化-->
			<pg:pager maxPageItems="17" scope="request" data="JobByUserList" isList="false">
			<tr class="labeltable_middle_td">
			<!--设置分页表头-->
				<td height='20' class="headercolor" nowrap width="10%">岗位名称</td>
				<td height='20' class="headercolor" nowrap width="10%">隶属机构</td>
				<td height='20' class="headercolor" nowrap width="15%">岗位职责</td>
				<td height='20' class="headercolor" nowrap width="5%">岗位编制人数</td>
				<td height='20' class="headercolor" nowrap width="15%">任职条件</td>
				<td height='20' class="headercolor" nowrap width="10%">岗位级别</td>
				<td height='20' class="headercolor" nowrap >岗位描述</td>
			</tr>
			<pg:notify>
				<tr height="18px" >
					<td class="detailcontent" colspan=7 align='center'>暂时没有资源</td>
				</tr>
			</pg:notify>
			<!--list标签循环输出每条记录-->			      
			<pg:list>

			<tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'">	      	
				<td class="tablecells" align=left  nowrap title="<pg:cell colName="jobName" defaultValue=""/>"><pg:cell colName="jobName" defaultValue="" maxlength="10" replace="..."/></td>
				<td class="tablecells" align=left nowrap title="<pg:cell colName="jobNumber" defaultValue=""/>"><pg:cell colName="jobNumber" defaultValue="" maxlength="10" replace="..."/></td>					
				<td class="tablecells" align=left nowrap title="<pg:cell colName="jobFunction" defaultValue=""/>"><pg:cell colName="jobFunction" defaultValue="" maxlength="10" replace="..."/></td>
				<td class="tablecells" align=left nowrap title="<pg:cell colName="jobAmount" defaultValue=""/>"><pg:cell colName="jobAmount" defaultValue="" maxlength="10" replace="..."/></td>
				<td class="tablecells" align=left nowrap title="<pg:cell colName="jobCondition" defaultValue=""/>"><pg:cell colName="jobCondition" defaultValue="" maxlength="10" replace="..."/></td>
				<td class="tablecells" align=left nowrap title="<pg:cell colName="jobRank" defaultValue=""/>"><pg:cell colName="jobRank" defaultValue="" maxlength="10" replace="..."/></td>
				<td class="tablecells" align=left nowrap title="<pg:cell colName="jobDesc" defaultValue=""/>"><pg:cell colName="jobDesc" defaultValue="" maxlength="10" replace="..."/></td>
				<!-- <td class="tablecells" align=left nowrap><pg:cell colName="roleId" defaultValue=""/></td> -->
			</tr>
			</pg:list>
			<tr height="18px" >
				<td class="detailcontent" colspan=7 align='center'><pg:index/><input type="hidden" name="queryString" value="<pg:querystring/>"></td>
			</tr> 
			</pg:pager>
		</table>
</body>
</html>
