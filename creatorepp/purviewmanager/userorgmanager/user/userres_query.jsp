<%
/*
 * <p>Title: 机构资源查询页面</p>
 * <p>Description: 机构资源查询页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-26
 * @author liangbing.tao
 * @version 1.0
 *
 */
 %>
 
<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ page import="java.util.List"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.resource.ResourceManager,
				com.chinacreator.config.ConfigManager"%>



<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);

	String userId = (String)request.getParameter("userId");
	String orgId = (String)request.getParameter("orgId");
	String typeName = (String)request.getParameter("typeName");

	//查询资源列表
	List resQueue = null;
	ResourceManager resManager = new ResourceManager();
	resQueue = resManager.getResourceInfos();
	
	request.setAttribute("resList",resQueue);

	// 权限是否关联机构
	// 彭盛 2011-3-15 
	boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);

%>
<html>
	<head>    
 		<title>用户机构权限资源查询</title>
		<script language="JavaScript" src="../../scripts/common.js" type="text/javascript"></script>		
		<script language="JavaScript" src="../../scripts/pager.js" type="text/javascript"></script>
		<SCRIPT language="javascript">
		
		function sub(){
			if("<%=isrolerelatedorg%>"=="true"){
				userreslist.action="userres_querylist.jsp?restypeId="
					+ document.all("resourcetype").value + "&resId="
					+ document.all("resId").value + "&opId="
					+ document.all("operategroup").value+ "&resName="
					+ document.all("resName").value + "&typeName=<%=typeName%>"
					+ document.all("isCurrOrg").value;
			}else{
				userreslist.action="userres_querylist.jsp?restypeId="
					+ document.all("resourcetype").value + "&resId="
					+ document.all("resId").value + "&opId="
					+ document.all("operategroup").value+ "&resName="
					+ document.all("resName").value + "&typeName=<%=typeName%>";
			}
				
			userreslist.submit();
		}
		
		function getOperateType(id){
				getopergroup.location.href = "resChange.jsp?restypeId="+id;
		}
		</SCRIPT>
		<link href="../../css/windows.css" rel="stylesheet" type="text/css">
		<link href="../../css/treeview.css" rel="stylesheet" type="text/css">
		<style>
			body
			{
			    SCROLLBAR-HIGHLIGHT-COLOR: #ffffff;
				SCROLLBAR-SHADOW-COLOR: #ffffff;
				SCROLLBAR-3DLIGHT-COLOR: #ffffff;
				SCROLLBAR-ARROW-COLOR: #ffffff;
				SCROLLBAR-TRACK-COLOR: #ffffff;
				SCROLLBAR-DARKSHADOW-COLOR: #ffffff;
				SCROLLBAR-FACE-COLOR: #ffffff;	
			}
		</style>
	</head>

	<%@ include file="/epp/css/cssControl.jsp"%><body  scrolling="no">
		<div id="contentborder" valign="top" align="center" >
			<form name = "userreslist" method="post" target="forDocList">
			<input type="hidden" name="userId" value="<%=userId%>">
			<input type="hidden" name="orgId" value="<%=orgId%>">
		
				<table width="100%" border="0"   cellpadding="0" cellspacing="0" class="thin">
					<tr>
						<td height='20'>
							资源标识：<input type="text" name="resId" size="15"/>
							资源名称：<input type="text" name="resName" size="15"/>
						    <select class="select" id="resourcetype" name="resourcetype" onchange="getOperateType(this.options[this.selectedIndex].value)">
						      	<option value="">--请选择资源类型--</option>
						      	<pg:list requestKey="resList" needClear="false">
								    	<option value="<pg:cell colName="id"/>">
								        	<pg:cell colName="name"/>
										</option>
								</pg:list>
							</select>
							<select class="select" name="operategroup" id="operategroup">
						      	<option value="">--请选择资源操作--</option>
								
							</select>
							<% 
							if(ConfigManager.getInstance().getConfigBooleanValue("enablerresmanaer", false))
							{
							%>
							<select class="select" name="auto" id="auto">
						      	<option value="">--资源类别--</option>
								<option value="0">系统资源</option>
								<option value="1">自定义资源</option>
							</select>
							<% 
							}
							if(isrolerelatedorg){
							%>
							<select class="select" name="isCurrOrg" id="isCurrOrg">						      	
								<option value="false">所有权限</option>
								<option value="true">当前机构下权限</option>
							</select>
							<%} %>
						</td>
						<td>
							<input name="search" type="button" class="input" value="查询" onClick="sub()">
							<input name="reset" type="reset" class="input" value="清空">
						</td>
						</tr>
				</table>	
			</form>	
		</div>
	<iframe id="getopergroup" src="" border="0" height="0" width="0"></iframe>
	</body>

</html>