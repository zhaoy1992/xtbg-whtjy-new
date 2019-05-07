<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.chinacreator.security.AccessControl,
				com.chinacreator.config.ConfigManager"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
//System.out.println("dddddddddddd =  " + request.getParameter("typeName"));
%>
<html>
<head>    
 <title>属性容器</title>
<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>		
<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
<SCRIPT language="javascript">

function getOperateType(id){
    getopergroup.location.href = "../user/resChange.jsp?restypeId="+id;
}
</SCRIPT>
<link href="../css/windows.css" rel="stylesheet" type="text/css">
<link href="../css/contentpage.css" rel="stylesheet" type="text/css">
<link href="../css/tab.winclassic.css" rel="stylesheet" type="text/css">
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
<div id="contentborder" align="center">
	
		<table width="100%" border="0"  cellpadding="0" cellspacing="1" class="thin">	
			 <pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.BrowseResList" keyName="BrowseResList"/> 
			<!--分页显示开始,分页标签初始化-->
			<pg:pager maxPageItems="17" scope="request" data="BrowseResList" isList="false">
			<tr class="labeltable_middle_td">
			<!--设置分页表头-->
				<td height='20' class="headercolor" nowrap>资源类型</td>
				<td height='20' class="headercolor" nowrap>资源标识</td>
				<td height='20' class="headercolor" nowrap>资源名称</td>
				<td height='20' class="headercolor" nowrap>操作类型</td>
				<td height='20' class="headercolor" nowrap>资源来源</td>
				<td height='20' class="headercolor" nowrap>授权时间</td>
				<% 
				if(ConfigManager.getInstance().getConfigBooleanValue("enablerresmanaer", false))
				{
				%>
					<td height='20' class="headercolor" nowrap>资源类别</td>
				<% 
					}
				%>
				<!-- <td height='20' class="headercolor" nowrap>角色标识</td> -->
			</tr>
			<pg:param name="restypeId"/>
			<pg:param name="resId"/>
			<pg:param name="resName"/>
			<pg:param name="opId"/>
			<pg:param name="userId"/>
			<pg:param name="id"/>
			<pg:param name="orgjob"/>
			<pg:param name="type"/>
			<pg:param name="name"/>
			<pg:param name="typeName"/>
			<pg:param name="resResource"/>
			<pg:param name="orgId"/>
			<pg:param name="auto"/>

			<!--检测当前页面是否有记录-->
			<pg:notify>
			<tr height="18px" >
				<td class="detailcontent" colspan=100 align='center'>暂时没有资源</td>
			</tr>
			</pg:notify>			      
			<!--list标签循环输出每条记录-->			      
			<pg:list>
			<tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'">	      	
				<td class="tablecells" align=left  nowrap><pg:cell colName="resTypeName" defaultValue=""/></td>							
				<td class="tablecells" align=left nowrap><pg:cell colName="resId" defaultValue=""/></td>
				<td class="tablecells" align=left nowrap><pg:cell colName="resName" defaultValue=""/></td>
				<td class="tablecells" align=left><pg:cell colName="opName" defaultValue=""/></td>
				
				<td class="tablecells" align=left>
				<pg:cell colName="resResource" defaultValue=""/>
				</td>
				<td class="tablecells" align=left>
					<pg:cell colName="sDate" defaultValue="未知时间" dateformat="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<% 
					if(ConfigManager.getInstance().getConfigBooleanValue("enablerresmanaer", false))
					{
				%>
					<td class="tablecells" align=left>
						<pg:equal colName="auto" value="0" >系统资源</pg:equal>
						<pg:equal colName="auto" value="1" ><font color="#0000FF">自定义资源</font></pg:equal>
					</td>
				<% 
					}
				%>
				<!-- <td class="tablecells" align=left nowrap><pg:cell colName="roleId" defaultValue=""/></td> -->
			</tr>
			</pg:list>
			<tr height="18px" >
				<td class="detailcontent" colspan=7 align='center'>共<pg:rowcount/>条记录 <pg:index /><input type="hidden" name="queryString" value="<pg:querystring/>"></td>
			</tr> 
			</pg:pager>
		</table>	
	</form>	
</div>
<iframe id="getopergroup" src="" border="0" height="0" width="0"></iframe>
</body>

</html>