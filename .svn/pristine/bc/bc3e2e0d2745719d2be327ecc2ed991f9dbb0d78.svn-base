<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.security.AccessControl,
			com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl" %>
<%
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkAccess(pageContext);
	String QueryresName = null;
	String QueryroleName = null;
	if(request.getParameter("resName")==null){
		QueryresName = "";
	}else{
		QueryresName = request.getParameter("resName");
	}
	if(request.getParameter("roleName")==null){
		QueryroleName = "";
	}else{
		QueryroleName = request.getParameter("roleName");
	}
	//当前用户是否拥有超级管理员权限与部门管理员权限
	boolean isAdminOrOrgManager = false;
	//是否是管理员
	boolean isOrgManager = new OrgAdministratorImpl().isOrgManager(accessControl.getUserID());
	boolean isAdmin = accessControl.isAdmin();
	if(isAdmin || isOrgManager){
		isAdminOrOrgManager = true;
	}	
%>
<html>
	<head>
		<title>属性容器</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
  		<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
  		<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
		
<script language="JavaScript" src="common.js" type="text/javascript"></script>
<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
<SCRIPT language="javascript">	




	

function actionOnmouseover(e){	
	e.style.backgroundColor = "#8080FF";
}

function actionOnmouseup(e){
	e.style.backgroundColor = "#BEC0C2";
}


function queryUser()
{	
	//if(document.userList.userName.value.length < 1 && document.userList.userRealname.value.length < 1){
	//	alert("用户名称和用户实名必须输入一个!!!");
	//	return;
	//}
	userList.action="../menumanager/menuList.jsp"
	userList.submit();	
}


</SCRIPT>		
			<%@ include file="/epp/css/cssControl.jsp"%><body >
			<%if(isAdminOrOrgManager){ %>
				<form name="userList" method="post" >
					<table cellspacing="1" cellpadding="0" border="0" width=98% class="thin">
         				<tr valign='top'>
           					<td height='30'valign='middle' colspan="4">&nbsp;<strong>菜单资源列表</strong></td>
         				</tr>
         				<tr >
           					
           					<td height='30'valign='middle' align="center">资源名称：<input type="text" name="resName" value="<%=QueryresName%>" ></td>
           					<td height='30'valign='middle' align="center">角色名称：</td>
           					<td height='30'valign='middle' align="center"><input type="text" name="roleName" value="<%=QueryroleName%>" ></td>
           					<td height='30'valign='middle' align="center">
           						<input name="search" type="button" class="input" value="查询" onClick="queryUser()">
           					</td>
           				</tr>
						<pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.MenuList" keyName="MenuList" />
						<!--分页显示开始,分页标签初始化-->
						<pg:pager maxPageItems="15" scope="request" data="MenuList" isList="false">
							<tr>
								<!--设置分页表头-->
								
								<td class="headercolor">资源类型名称</td>
								<td class="headercolor">资源名称</td>
								<td class="headercolor">角色名称</td>		
								<td class="headercolor" height='30'>操作类型</td>						
							
							</tr>
							<pg:param name="resName" />
							<pg:param name="roleName" />
							

							<!--检测当前页面是否有记录-->
							<pg:notify>
								<tr height="18px" class="labeltable_middle_tr_01">
									<td colspan="100" align='center'>
										暂时没有菜单资源
									</td>
								</tr>
							</pg:notify>

							<!--list标签循环输出每条记录-->
							<pg:list>								
								<tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'" onclick="" >
									
									<td class="tablecells" nowrap="nowrap">
										<pg:cell colName="resTypeName" defaultValue="" />
									</td>									
									<td class="tablecells" nowrap="nowrap" >
										<pg:cell colName="resName" defaultValue="" />
									</td>
									<td class="tablecells" nowrap="nowrap">
										<pg:cell colName="roleName" defaultValue="" />
									</td>
									<td class="tablecells" nowrap="nowrap" height='20'>
										<pg:cell colName="opid" defaultValue="" />
									</td>
<!--									<td class="tablecells" nowrap="nowrap">-->
<!--										-->
<!--										<pg:equal colName="fettle" value="1">在岗</pg:equal>-->
<!--					  					<pg:equal colName="fettle" value="0">未知</pg:equal>																										    					    							    				    		-->
<!--					  					<pg:equal colName="fettle" value=" ">未知</pg:equal>-->
<!--									</td>	-->
								</tr>
							</pg:list>
							<tr height="18px" class="labeltable_middle_tr_01">
								<td colspan=4 align='center'>a
									<pg:index />
								</td>						
							</tr>
							<input name="queryString" value="<pg:querystring/>" type="hidden">
						</pg:pager>

				  </table>
				</form>
<%}else{ %>
<div align="center">没有权限！请与系统管理员联系</div>
<%} %>
			</body>
			<center>
</html>

