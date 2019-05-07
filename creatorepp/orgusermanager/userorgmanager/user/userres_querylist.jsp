<%
/*
 * <p>Title: 机构资源查询列表</p>
 * <p>Description: 机构资源查询列表</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-26
 * @author liangbing.tao
 * @version 1.0
 *
 */
 %>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,
				com.chinacreator.config.ConfigManager"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	String typeName = request.getParameter("typeName");
	//System.out.println("typeName = " + typeName);

	String orgId = (String)request.getParameter("orgId");
	String isCurrOrg = (String)request.getParameter("isCurrOrg");
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
		<link href="../../css/windows.css" rel="stylesheet" type="text/css">
		<link href="../../css/treeview.css" rel="stylesheet" type="text/css">
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
						<pg:param name="isCurrOrg"/>
		
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
						<td class="detailcontent" colspan=7 align='center'>
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