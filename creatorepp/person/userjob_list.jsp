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
		<title>��������</title>
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
<tab:tabConfig/>		
<%@ include file="/epp/css/cssControl.jsp"%><body >
		<table width="100%" border="0"  cellpadding="0" cellspacing="1" class="thin">	
			<pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.JobByUserList" keyName="JobByUserList"/> 
			<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
			<pg:pager maxPageItems="17" scope="request" data="JobByUserList" isList="false">
			<tr class="labeltable_middle_td">
			<!--���÷�ҳ��ͷ-->
				<td height='20' class="headercolor" nowrap width="10%">��λ����</td>
				<td height='20' class="headercolor" nowrap width="10%">��������</td>
				<td height='20' class="headercolor" nowrap width="15%">��λְ��</td>
				<td height='20' class="headercolor" nowrap width="5%">��λ��������</td>
				<td height='20' class="headercolor" nowrap width="15%">��ְ����</td>
				<td height='20' class="headercolor" nowrap width="10%">��λ����</td>
				<td height='20' class="headercolor" nowrap >��λ����</td>
			</tr>
			<pg:notify>
				<tr height="18px" >
					<td class="detailcontent" colspan=7 align='center'>��ʱû����Դ</td>
				</tr>
			</pg:notify>
			<!--list��ǩѭ�����ÿ����¼-->			      
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
