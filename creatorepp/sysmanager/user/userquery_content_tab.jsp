<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl,com.frameworkset.common.poolman.DBUtil" %>
<%@ page import="com.chinacreator.config.ConfigManager" %>

<%
 			AccessControl accesscontroler = AccessControl.getInstance();
	        accesscontroler.checkAccess(request, response);
	        String userId = accesscontroler.getUserID();
	        DBUtil db = new DBUtil();
		    db.executeSelect("select 1 from td_sm_user");
		    String usercount = String.valueOf(db.size());
		    
		    String userOrgType = (String)request.getParameter("userOrgType");
		    String userName = (String)request.getParameter("userName");
		    String userRealname = (String)request.getParameter("userRealname");
		    if(userOrgType == null)
		    {
		    	userOrgType = "";
		    }
		    if(userName == null)
		    {
		    	userName = "";
		    }
		    if(userRealname == null)
		    {
		    	userRealname = "";
		    }
		    
			//当前用户是否拥有超级管理员权限与部门管理员权限
			boolean isAdminOrOrgManager = false;
			//是否是管理员
			boolean isOrgManager = new OrgAdministratorImpl().isOrgManager(accesscontroler.getUserID());
			boolean isAdmin = accesscontroler.isAdmin();
			if(isAdmin || isOrgManager){
				isAdminOrOrgManager = true;
			}	
%>

<html >
<head>				
	<tab:tabConfig/>
		<title>属性容器</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		
	<script language="JavaScript" src="common.js" type="text/javascript"></script>
	<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
	<SCRIPT language="javascript">	
	var jsAccessControl = new JSAccessControl("#DAE0E9","#F6F8FB","#F6F8FB");
	
	function getUserInfo(e,userId,qstring)
	{
		//var qstring = document.forms[0].queryString.value;	
		if (jsAccessControl.setBackColor(e))
		{		
			getPropertiesToolbar().location.href="userquery_toolbar.jsp?userId="+userId+"&qstring="+qstring;
		}
	}
	
	function getUserInfo2(e,userId,qstring)
	{
		var curruserId = "<%=userId%>";
		if (jsAccessControl.setBackColor(e))
		{		
		    if(userId==curruserId)document.location.href="userInfo2.jsp?userId="+userId+"&qstring="+qstring;
			else document.location.href="userInfo4.jsp?userId="+userId+"&qstring="+qstring;
		}
	}
		
	function actionOnmouseover(e){	
		e.style.backgroundColor = "#8080FF";
	}
	
	function actionOnmouseup(e){
		e.style.backgroundColor = "#BEC0C2";
	}
	
	
	function queryUser()
	{	
		//if(document.userList.userName.value.length < 1 && document.userList.userRealname.value.length < 1){
			//alert("用户名称和用户实名必须输入一个!!!");
			//return;
		//}
		var userOrgType = document.all("userOrgType").value;
		userList.action="../user/userquery_content_tab.jsp?userOrgType="+userOrgType+"&userId=<%=userId%>";
		userList.submit();	
	}
	function queryUserInfo(){
		var userOrgType = document.all("userOrgType").value;
		var userName = document.all("userName").value;
		var userRealname = document.all("userRealname").value;
		var url = "../user/ireport/queryUser_info.jsp?userOrgType="+userOrgType+"&userName="+userName+"&userRealname="+userRealname;
		window.showModalDialog(url,window,"dialogWidth:"+(620)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no");
	}
	function advQueryUser()
	{	
		document.location.href="../user/advQuery.jsp"	
	}
	//---------------------------------------------------------
	function query_User()
	{	
		
		user_List.action="../user/userquery_content_tab.jsp"
		user_List.submit();	
	}
	
	function cleanAll(){
		document.userList.reset();
		document.all.userName.value = "";
		document.all.userRealname.value = "";
	}
	</SCRIPT>	
</head>
<pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.UserSearchList" keyName="UserSearchList" />
<!--分页显示开始,分页标签初始化-->
<pg:pager maxPageItems="15" id="UserSearchList" scope="request" data="UserSearchList" isList="false">
<%@ include file="/epp/css/cssControl.jsp"%><body >
<%if(isAdminOrOrgManager){ %>
		<form name="userList" method="post" >
					<table cellspacing="1" cellpadding="0" border="0" width="98%" class="thin">
         				<tr valign='top'>
           					<td height='30'valign='middle' colspan="5"><img src='../images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;<strong>用户列表
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
           					&nbsp;总用户数为：<!-- <%=usercount%> -->
							<pg:rowcount/>
           					</strong></td>
         				</tr>
         				<tr >           					
           					<td height='30' valign='middle' colspan="3" align="center">
	           					用户登陆名称：<input type="text" name="userName" value="<%=userName%>">
	           					用户实名：<input type="text" name="userRealname" value="<%=userRealname%>">
	           					<%--<%if(ConfigManager.getInstance().getConfigBooleanValue("enableorgusermove",false)){ %>--%>
	           					<select name="userOrgType" >     
	           						<%if("two".equals(ConfigManager.getInstance().getConfigValue("userquerytype"))){%>
	           						<option selected value="hasMainOrg">机构下的用户</option>
									<option value="dis">离散用户</option>  
	           						<%}else{%>      					
									<option selected value="hasMainOrg">有主机构用户</option> 
									<option value="noMainOrg">无主机构用户</option> 
									<option value="dis">离散用户</option>  
									<%}%>
								</select> 
									<%--<%} %>--%>
           					</td>
           					
           					<td height='30'valign='middle' align="center">
           						<input name="search" type="button" class="input" value="查询" onClick="queryUser()">
           						<input type="button" class="input" value="重置" onclick="cleanAll()" >   
           						<input name="mimeograph" type="button" class="input" value="打印" onClick="queryUserInfo()">        						
           						<!--
           						<input name="advsearch" type="button" class="input" value="高级查询" onClick="advQueryUser()">   
           						-->
           					</td>
           					
         				</tr>
						
							<tr>
								<!--设置分页表头-->								
								<td height='30' width="10%" class="headercolor"  >用户登陆名称	</td>
								<td height='30' width="10%" class="headercolor"  >用户实名</td>								
								
								<td height='30' width="*" class="headercolor"  >所在机构</td>
								
								<td height='30' width="20%" class="headercolor"  >手机号码</td>
							</tr>
							<pg:param name="orgId"/>
							<pg:param name="userName"/>
							<pg:param name="userRealname"/>
							<pg:param name="advQuery" />
							<pg:param name="userId" />
							<pg:param name="job_name"/>	
							<pg:param name="userOrgType"/>						
							
                          
							<!--检测当前页面是否有记录-->
							<pg:notify>
								<tr height="18px" class="labeltable_middle_tr_01">
									<td colspan=100 align='center' height='20'>
										暂时没有用户
									</td>
								</tr>
							</pg:notify>

							<!--list标签循环输出每条记录-->
							<pg:list>
								
								<tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'"  onDBLclick=getUserInfo2(this,'<pg:cell colName="userId" defaultValue=""/>','<pg:querystring encode="true"/>') >
									
									<td height='20' class="tablecells" nowrap="nowrap">
										<pg:cell colName="userName" defaultValue="" />
									</td>
									<td height='20' class="tablecells" nowrap="nowrap">
										<pg:cell colName="userRealname" defaultValue="" />
									</td>									
								
									<td height='20' class="tablecells" >
										<pg:cell colName="orgName" defaultValue="" />
									</td>
									
										<td height='20' class="tablecells" nowrap="nowrap" >
										<pg:notnull colName="userMobiletel1"><pg:cell colName="userMobiletel1" defaultValue=" "/></pg:notnull>
										<pg:null colName="userMobiletel1">没有号码</pg:null>
										<pg:equal colName="userMobiletel1" value="">没有号码</pg:equal>
									</td>		
								</tr>
							</pg:list>
							<tr height="18px" class="labeltable_middle_tr_01">
								<td colspan=5 align='center'>
									每页15条记录	共<pg:rowcount/>条记录  <pg:index />
								</td></tr>
							<input name="queryString" value="<pg:querystring/>" type="hidden">
				  </table>
				</form>
				<script>
					if("<%=userOrgType%>" != ""){
						document.all.userOrgType.value="<%=userOrgType%>";
					}
				</script>
				<%}else{ %>
				<div align="center">没有权限！请与系统管理员联系</div>
				<%} %>
				

</body>
</pg:pager>
</html>