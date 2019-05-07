<%
/*
 * <p>Title: 用户角色权限查询列表</p>
 * <p>Description: 用户角色权限查询列表</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-22
 * @author liangbing.tao
 * @version 1.0
 */
%>


<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkManagerAccess(request,response);
%>


<html>
<head>
	<tab:tabConfig />
		<script language="JavaScript" src="<%=request.getContextPath()%>/public/datetime/calender_date.js" ></script>
		<script language="JavaScript" src="../../scripts/common.js" type="text/javascript"></script>
		<script language="javascript" src="../../scripts/selectTime.js"></script>
		<SCRIPT language="JavaScript" SRC="../../../include/validateForm.js"></SCRIPT>
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
		<style type="text/css">
		    .notice_STYLE{color: #FF0000;display : none }
	        .STYLE1 {color: #FF0000}
	   </style>
</head>	   
<%@ include file="/epp/css/cssControl.jsp"%><body >	   
	<table class="thin" cellspacing="1" cellpadding="0" width="100%">
    	<pg:listdata dataInfo="UserResList" keyName="UserResList" />
	    <!--分页显示开始,分页标签初始化-->
			<pg:pager maxPageItems="13" id="com.chinacreator.sysmgrcore.web.tag.UserResList" scope="request" data="UserResList" isList="false">
		<tr>
	     <!--设置分页表头-->
		    <td class="headercolor">资源类型名称</td>
		    <td class="headercolor">资源名称</td>
			<td class="headercolor" height='30'>操作ID</td>
			<td class="headercolor">角色名称</td>														
		</tr>
			<pg:param name="userId" />
			<pg:param name="restype" />
			<pg:param name="resname" />
								
	
		    <!--检测当前页面是否有记录-->
			<pg:notify>
			<tr height="18px" class="labeltable_middle_tr_01">
				<td colspan=100 align='center'>
					角色暂缺
				</td>
			</tr>
			</pg:notify>
			
			<!--list标签循环输出每条记录-->
			<pg:list>								
			<tr onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'" onclick="" >
				<td class="tablecells" nowrap="nowrap">
					<pg:cell colName="resTypeName" defaultValue="未知" />
				</td>
				<td class="tablecells" nowrap="nowrap">
					<pg:cell colName="resName" defaultValue="" />
				</td>	
				<td class="tablecells" nowrap="nowrap" height='20'>
					<pg:cell colName="opName" defaultValue="" />
				</td>							
				<td class="tablecells" nowrap="nowrap" >
					<pg:cell colName="roleName" defaultValue="" />
				</td>
			</tr>
			</pg:list>
			
		<tr height="18px" class="labeltable_middle_tr_01">
			<td colspan=4 align='center'>
				<pg:index />
			</td>						
		</tr>
		<input name="queryString" value="<pg:querystring/>" type="hidden">					
		</pg:pager>
	</table>
</body>
</html>	

							                       