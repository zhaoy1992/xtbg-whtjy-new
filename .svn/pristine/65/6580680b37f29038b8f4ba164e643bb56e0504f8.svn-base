<%@ page language="java" contentType="text/html; charset=GBK"%>
<%
/**
 * 
 * <p>Title: 资源授予情况列表</p>
 *
 * <p>Description: 资源授予情况列表</p>
 *
 * <p>Copyright: Copyright (c) 2008</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2008-11-4
 * @author gao.tang
 * @version 1.0
 */
 %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl accessControl = AccessControl.getInstance();
	if(!accessControl.checkManagerAccess(request, response)){
		return;
	}
	
	//授予的对象查询，包括（机构，用户，角色，机构岗位）  必选
	String type = request.getParameter("type");
%>
<html>
<head>
	<title>资源操授予查询</title>
	<link rel="stylesheet" type="text/css" href="../../css/windows.css">
	<script type="text/javascript" language="Javascript">
	</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body >
<form action="" method="post" name="queryList">
	<table width="100%" border="0"   cellpadding="0" cellspacing="0" class="thin">
	  <pg:listdata dataInfo="com.chinacreator.sysmgrcore.purviewmanager.tag.ResQueryList" keyName="ResQueryList"/> 
	  <!--分页显示开始,分页标签初始化-->
	  <pg:pager maxPageItems="17" scope="request" data="ResQueryList" isList="false">
	  <tr class="labeltable_middle_td">
	  <!--设置分页表头-->
	  	<%if(type.equals("user")){ %>
		<td height='20' class="headercolor" nowrap>用户所在机构</td>
		<td height='20' class="headercolor" nowrap>用户帐户</td>
		<td height='20' class="headercolor" nowrap>用户姓名</td>
		<%}else if(type.equals("role")){ %>
		<td height='20' class="headercolor" nowrap>角色名称</td>
		<td height='20' class="headercolor" nowrap>角色所属类型</td>
		<td height='20' class="headercolor" nowrap>角色创建人</td>
		<%}else if(type.equals("orgjob")){ %>
		<td height='20' class="headercolor" nowrap>岗位所设置的机构</td>
		<td height='20' class="headercolor" nowrap>岗位名称</td>
		<td height='20' class="headercolor" nowrap>岗位创建人</td>
		<%}else if(type.equals("org")){ %>
		<td height='20' class="headercolor" nowrap>机构显示名称</td>
		<%} %>
		<td height='20' class="headercolor" nowrap>操作类型</td>
		<td height='20' class="headercolor" nowrap>资源来源</td>
		<td height='20' class="headercolor" nowrap>授权时间</td>
		<!-- <td height='20' class="headercolor" nowrap>角色标识</td> -->
	  </tr>
	  <pg:param name="restypeId"/>
	  <pg:param name="resId"/>
	  <pg:param name="resName"/>
	  <pg:param name="operategroup"/>
	  <pg:param name="type"/>
	  <pg:param name="selid"/>
	  <pg:param name="selname"/>
	  <pg:param name="isRecursion"/>
	  <!--检测当前页面是否有记录-->
	  <pg:notify>
	    <tr height="18px" >
		  <td class="detailcontent" colspan=100 align='center'>暂时没有记录</td>
	    </tr>
	  </pg:notify>	
	  <!--list标签循环输出每条记录-->			      
	  <pg:list>
	  <tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'">	      	
	    <%if(type.equals("user")){ %>
		<td class="tablecells" align=left  nowrap><pg:cell colName="remark5" defaultValue=""/></td>							
		<td class="tablecells" align=left nowrap><pg:cell colName="userName" defaultValue=""/></td>
		<td class="tablecells" align=left nowrap><pg:cell colName="userRealname" defaultValue=""/></td>
		<%}else if(type.equals("role")){ %>
		<td class="tablecells" align=left  nowrap><pg:cell colName="roleName" defaultValue=""/></td>							
		<td class="tablecells" align=left nowrap><pg:cell colName="roleTypeName" defaultValue=""/></td>
		<td class="tablecells" align=left nowrap><pg:cell colName="userRealname" defaultValue=""/></td>
		<%}else if(type.equals("orgjob")){ %>
		<td class="tablecells" align=left  nowrap><pg:cell colName="remark5" defaultValue=""/></td>							
		<td class="tablecells" align=left nowrap><pg:cell colName="jobName" defaultValue=""/></td>
		<td class="tablecells" align=left nowrap><pg:cell colName="userRealname" defaultValue=""/></td>
		<%}else if(type.equals("org")){ %>
		<td class="tablecells" align=left  nowrap><pg:cell colName="remark5" defaultValue=""/></td>
		<%} %>
		<td class="tablecells" align=left><pg:cell colName="opName" defaultValue=""/></td>
		<td class="tablecells" align=left>
		<pg:cell colName="resResource" defaultValue=""/>
		</td>
		<td class="tablecells" align=left>
			<pg:cell colName="sDate" defaultValue="未知时间" dateformat="yyyy-MM-dd HH:mm:ss"/>
		</td>
		<!-- <td class="tablecells" align=left nowrap><pg:cell colName="roleId" defaultValue=""/></td> -->
	</tr>
	  </pg:list>
	    <tr height="18px" >
		  <td class="detailcontent" colspan=6 align='center'>共<pg:rowcount/>条记录 <pg:index /><input type="hidden" name="queryString" value="<pg:querystring/>"></td>
        </tr> 
	  </pg:pager>
	</table>
</form>
</body>
</html>
