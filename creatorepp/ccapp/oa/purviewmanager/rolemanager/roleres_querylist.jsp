<%-- 
	描述：角色资源查询列表
	作者：黄艺平
	版本：1.0
	日期：2013-05-30
 --%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);

%>

<html>
	<head>    
		<title>属性容器</title>
		<script language="JavaScript" src="../../scripts/common.js" type="text/javascript"></script>		
		<script language="JavaScript" src="../../scripts/pager.js" type="text/javascript"></script>
		<SCRIPT language="javascript">
			function getOperateType(id)
			{
			    getopergroup.location.href = "resChange.jsp?restypeId="+id;
			}
		</SCRIPT>
		<link href="../css/windows.css" rel="stylesheet" type="text/css">
		<link href="../css/treeview.css" rel="stylesheet" type="text/css">
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
		<div id="contentborder" align="center">
				<table width="100%" border="0"  cellpadding="0" cellspacing="1" class="thin">	
					 <pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.BrowseResList" 
					 													keyName="BrowseResList"/> 
					 													
					<!--分页显示开始,分页标签初始化-->
					
					<pg:pager maxPageItems="17" scope="request" data="BrowseResList" isList="false">
					
					<tr class="labeltable_middle_td">
					<!--设置分页表头-->
						<td height='20' class="headercolor" nowrap>资源类型</td>
						<td height='20' class="headercolor" nowrap>资源标识</td>
						<td height='20' class="headercolor" nowrap>资源名称</td>
						<td height='20' class="headercolor" nowrap>操作类型</td>
						<%
							if("USER".equals(request.getParameter("typeName")))
							{
						%>
						<td height='20' class="headercolor" nowrap>资源来源</td>
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
		
					<!--检测当前页面是否有记录-->
					<pg:notify>
						<tr height="18px" >
							<td class="detailcontent" colspan=100 align='center'>暂时没有资源</td>
						</tr>
					</pg:notify>	
							      
					<!--list标签循环输出每条记录-->			      
					<pg:list>
					<tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'">	      	
						<td class="tablecells" align=left  nowrap>
							<pg:cell colName="resTypeName" defaultValue=""/>
						</td>							
						<td class="tablecells" align=left nowrap>
							<pg:cell colName="resId" defaultValue=""/>
						</td>
						<td class="tablecells" align=left nowrap>
							<pg:cell colName="resName" defaultValue=""/>
						</td>
						<td class="tablecells" align=left>
							<pg:cell colName="opName" defaultValue=""/>
						</td>
						<%
							if("role".equals(request.getParameter("typeName")))
							{
						%>
							<td class="tablecells" align=left>
								<pg:cell colName="resResource" defaultValue=""/>
							</td>
						<%
							}
						%>
						<!-- <td class="tablecells" align=left nowrap><pg:cell colName="roleId" defaultValue=""/></td> -->
					</tr>
					</pg:list>
					<tr height="18px" >
						<td class="detailcontent" colspan=5 align='center'>
							共<pg:rowcount/>条记录 <pg:index />
							<input type="hidden" name="queryString" value="<pg:querystring/>"></td>
					</tr> 
					</pg:pager>
				</table>
			</form>	
		</div>
	<iframe id="getopergroup" src="" border="0" height="0" width="0"></iframe>
	</body>

</html>