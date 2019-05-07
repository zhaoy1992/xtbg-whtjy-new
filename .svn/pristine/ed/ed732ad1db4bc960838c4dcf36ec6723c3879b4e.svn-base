<%
/*
 * <p>Title:角色下权限授予</p>
 * <p>Description: 角色下的权限授予</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-4-2
 * @author liangbing.tao
 * @version 1.0
 */
%>
<%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>


<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@page import="com.chinacreator.config.model.ResourceInfo"%>
<%@ page import="com.chinacreator.resource.ResourceManager,
				 com.chinacreator.sysmgrcore.manager.SecurityDatabase,
				 com.chinacreator.sysmgrcore.manager.OrgManager,
				 com.chinacreator.sysmgrcore.entity.Organization,
				 com.chinacreator.config.ConfigManager,
				 com.chinacreator.security.AccessControl,
				 java.util.List,
				 java.util.ArrayList"%>
				

<%

	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	String curSystem = accesscontroler.getCurrentSystem();
	
	//资源类型types  organization
	String role_type = "organization";
	
	//当前选中授权ID；根据授权类型有user，role两种授权类型，分别为用户ID，和角色ID，机构ID
	String currRoleId = request.getParameter("currRoleId");//授权的机构ID
	
	//是否批量授权 true:批量；false:单个
	String isBatch = "false";

	OrgManager orgManager = SecurityDatabase.getOrgManager();
	
	Organization organization = orgManager.getOrgById(currRoleId);
	
	String orgName = organization.getRemark5() ;

	
	ResourceManager resManager = new ResourceManager();
	
	List list = resManager.getResourceInfos();
	
	//加开关，如果不允许超级管理员之外的用户进行菜单授权，当前用户又不是超级管理员，
	//则去掉菜单项，请注意，是超级管理员，重复，不是啰嗦！
	
	boolean state = ConfigManager.getInstance().getConfigBooleanValue("enablecolumngrant", true)
				 && !accesscontroler.getUserID().equals("1");
	
	if(list == null)
		list = new ArrayList();
	request.setAttribute("resTypeList",list);
	
%>

<html>
	<head>
		<tab:tabConfig/>
		<title>机构【<%=orgName%>】权限授予</title>
		<link rel="stylesheet" type="text/css" href="../css/treeview.css">
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
	</head> 
	
	<%@ include file="/epp/css/cssControl.jsp"%><body  bgcolor="#F7F8FC" >
		<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
	
			<tr>
				<td colspan="2">
					<tab:tabContainer id="role_resFrame" selectedTabPaneId="role-manage">
					<pg:list requestKey="resTypeList" needClear="false">
					
		      			<pg:equal colName="auto" value="true">
		      			<%
		      			ResourceInfo resourceInfo = (ResourceInfo)dataSet.getOrigineObject();
	      				boolean isAppend = resourceInfo.containSystem(curSystem);
		      			String id = "purview-" + dataSet.getString("id");
		      			String iframeid = "iframe-" + dataSet.getString("id");
		      			String name = dataSet.getString("name");
		      			StringBuffer link = new StringBuffer()
		      				.append(dataSet.getString("resource")).append("?currRoleId=").append(currRoleId)
			      			.append("&role_type=").append(role_type)
			      			.append("&isBatch=").append(isBatch);
		      			//String link = dataSet.getString("resource")+"?currRoleId="+currRoleId;
		      			if(isAppend){
		      			if(!(dataSet.getString("resource").equals("resColumnTree.jsp") && !accesscontroler.getUserID().equals("1")))
		      			{
	      				%>
		      			
	<!-- ------------------------------------------------------------------------------------------------------------------------------------------>
						<tab:tabPane id="<%=id%>" tabTitle="<%=name%>" lazeload="true">
							<tab:iframe id="<%=iframeid%>" src="<%=link.toString()%>" frameborder="0" scrolling="no" width="98%" height="600">
							</tab:iframe>
						</tab:tabPane>
						<%

							}
							}
						%>
	<!-------------------------------------------------------------------------------------------------------------------------------->
					  </pg:equal>					
		  			</pg:list>	
					</tab:tabContainer>			
				</td>
			</tr>
		</table>	
		<div align="center"><input name="cols" type="button" value="关闭页面" onclick="window.close();" class="input"/></div>
	  <iframe name="exeman" width="0" height="0" style="display:none"></iframe>
	</body>
</html>

