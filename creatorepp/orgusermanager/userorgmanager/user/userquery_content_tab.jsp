<%
/*
 * <p>Title: 用户查询页面</p>
 * <p>Description: 用户查询页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-20
 * @author liangbing.tao
 * @version 1.0
 */
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil" %>
<%@ page import="com.chinacreator.config.ConfigManager" %>


<%
 			AccessControl accesscontroler = AccessControl.getInstance();
	        accesscontroler.checkManagerAccess(request,response);
	        
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
%>

<html >
	<head>				
		<tab:tabConfig/>
			<title>属性容器</title>
			<link rel="stylesheet" type="text/css" href="../../css/windows.css">
			<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
			<script language="JavaScript" src="../../scripts/common.js" type="text/javascript"></script>
			<script language="JavaScript" src="../../scripts/pager.js" type="text/javascript"></script>
			<SCRIPT language="javascript">	
				function actionOnmouseover(e)
				{	
					e.style.backgroundColor = "#8080FF";
				}
			
				function actionOnmouseup(e)
				{
					e.style.backgroundColor = "#BEC0C2";
				}
			
			
				function queryUser()
				{	
					var userOrgType = document.all("userOrgType").value;
					userList.action="../user/userquery_content_tab.jsp?userOrgType="+userOrgType+"&userId=<%=userId%>";
					userList.submit();	
				}
				
				function queryUserInfo()
				{
					var userOrgType = document.all("userOrgType").value;
					var userName = document.all("userName").value;
					var userRealname = document.all("userRealname").value;
					var url = "../user/ireport/queryUser_info.jsp?userOrgType="+userOrgType+"&userName="+userName+"&userRealname="+userRealname;
					window.showModalDialog(url,window,"dialogWidth:"+(620)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no");
				}
				
				function clearQueryInfo()
				{
					userList.userName.value = '';
					userList.userRealname.value = '';
				}
		</SCRIPT>	
	</head>
	<pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.UserSearchList" keyName="UserSearchList" />
	<!--分页显示开始,分页标签初始化-->
	<pg:pager maxPageItems="15" id="UserSearchList" scope="request" data="UserSearchList" isList="false">
	
	<%@ include file="/epp/css/cssControl.jsp"%><body >
		<form name="userList" method="post" onkeydown="if(event.keyCode==13)queryUser();">
			<table cellspacing="1" cellpadding="0" border="0" width=100% class="thin">
				<input type="hidden" name="userOrgType" value="hasMainOrg" />
 				<tr valign='top'>
   					<td height='30'valign='middle' colspan="3" nowrap>
   						<strong>用户列表
							<div align="right">总用户数为：<!-- <%=usercount%> -->
								<pg:rowcount/>
							</div>
       					</strong>	
   					</td>
 				</tr>
 				<tr >           		
					<td width="40%" align="center">
						用户登陆名称：<input type="text" name="userName" value="<%=userName%>">
					</td>
					<td width="30%">
						用户实名：<input type="text" name="userRealname" value="<%=userRealname%>">
					</td>
					<td width="30%" align="center">
						<input name="search" type="button" class="input" value="查询" onClick="queryUser()">&nbsp;&nbsp;
						<input name="clearInfo" type="button" class="input" value="清空" onclick="clearQueryInfo()">&nbsp;&nbsp;   
						<%--<input name="mimeograph" type="button" class="input" value="打印" onClick="queryUserInfo()">--%>
					</td>
 				</tr>
 			</table>
     			<hr width=100%>
				<table cellspacing="1" cellpadding="0" border="0" width=100% class="thin">
					<tr>
						<!--设置分页表头-->								
						<td height='30' width="20%" class="headercolor"  >用户登陆名称	</td>
						<td height='30' width="20%" class="headercolor"  >用户实名</td>
						<td height='30' width="*" class="headercolor"  >所在机构</td>
						<td height='30' width="17%" class="headercolor"  >手机号码</td>
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
						<tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'">
							<td height='20' class="tablecells" nowrap="nowrap">
								<pg:cell colName="userName" defaultValue="" />
								<pg:null colName="userName">用户登录名称为空</pg:null>
								<pg:equal colName="userName" value="">用户登录名称为空</pg:equal>
							</td>
							<td height='20' class="tablecells" nowrap="nowrap">
								<pg:cell colName="userRealname" defaultValue="" />
								<pg:null colName="userRealname">用户实名为空</pg:null>
								<pg:equal colName="userRealname" value="">用户实名为空</pg:equal>
							</td>	
							<td height='20' class="tablecells" >
								<pg:cell colName="orgName" defaultValue="" />
								<pg:null colName="orgName">所在机构为空</pg:null>
								<pg:equal colName="orgName" value="">所在机构为空</pg:equal>
							</td>
							<td height='20' class="tablecells" nowrap="nowrap" >
								<pg:notnull colName="userMobiletel1"><pg:cell colName="userMobiletel1" defaultValue=" "/></pg:notnull>
								<pg:null colName="userMobiletel1">号码为空</pg:null>
								<pg:equal colName="userMobiletel1" value="">号码为空</pg:equal>
							</td>		
						</tr>
					</pg:list>
					
					<tr height="30px" class="labeltable_middle_tr_01">
						<td colspan=5 align='center'>
							共<pg:rowcount/>条记录  <pg:index />
						</td>
					</tr>
				<input name="queryString" value="<pg:querystring/>" type="hidden">
			 </table>
		</form>
	</body>
	</pg:pager>
</html>