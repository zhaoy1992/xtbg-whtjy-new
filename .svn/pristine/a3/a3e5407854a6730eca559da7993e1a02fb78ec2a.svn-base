<%
/*
 * <p>Title: 角色用户列表查询</p>
 * <p>Description:角色用户列表查询</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-4-14
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
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>


<%@ page import="com.chinacreator.security.AccessControl"%>




<%	
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	request.setAttribute("action","user");
	String roleId = request.getParameter("roleId");	
	
	
	String userName = request.getParameter("userName")==null?"":request.getParameter("userName");
	String userRealName = request.getParameter("userRealName")==null?"":request.getParameter("userRealName");
	
	//userName = userName == null ? "" : userName; 
	//userRealName = userRealName == null ? "" : userRealName ;

	
%>
<html>
	<head>
		<title>属性容器</title>
		<link href="../css/windows.css" rel="stylesheet" type="text/css">
		<link href="../css/treeview.css" rel="stylesheet" type="text/css">
		
		<script language="JavaScript" src="../scripts/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../scripts/pager.js" type="text/javascript"></script>
		<script language="javascript">	
			function clearQueryInfo()
			{
				userList.userName.value = '';
				userList.userRealName.value = '';
			}
			
			function querySub(){
				var userName = userList.userName.value;
				var userRealName = userList.userRealName.value;
				document.userList.action="roleuserquery.jsp?userName="+userName+"&userRealName="+userRealName+"&type=user&roleId=<%=roleId%>";
				document.userList.submit();
			}
		</script>
		<%@ include file="/epp/css/cssControl.jsp"%><body >
			<div align="center">
				<form name="userList" action="" method="post" >	
					<table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% class="thin">
						<tr>
							<td width="10%" nowrap>
								<div align="center">
									 登录名称:
								</div>
							</td>
							<td width="25%" nowrap>
								<div align="left">
									<input type="text" name="userName" value="<%=userName%>" size="30">
								</div>
							</td>
							<td width="10%" nowrap>
								<div align="center">
									 用户实名:
								</div>
							</td>
							<td width="25%" nowrap>
								<div align="left">
									<input type="text" name="userRealName" value="<%=userRealName%>" size="30">
								</div>
							</td>
							<td width="30%">
								<div align="center">
									<input type="button"  value="查询" class="input" onclick="querySub()">&nbsp;&nbsp;&nbsp;
									<input type="button"  value="清空" onclick="clearQueryInfo()" class="input">&nbsp;&nbsp;&nbsp;
									<input type="button"  value="返回" onclick="window.close()" class="input">&nbsp;&nbsp;&nbsp;
								</div>
							</td>
						</tr>
					</table>
				
				<hr width="100%">
				
				<pg:listdata dataInfo="com.chinacreator.sysmgrcore.purviewmanager.tag.RoleGrantSearchList" keyName="RoleGrantSearchList" />
				<!--分页显示开始,分页标签初始化-->
				<pg:pager maxPageItems="15" id="RoleGrantSearchList" scope="request" data="RoleGrantSearchList" isList="false">
					<table cellspacing="1" cellpadding="0" border="0" width=100% class="thin">
						<tr>
							<!--设置分页表头-->								
							<td height='30' width="20%" class="headercolor"  >用户登陆名称	</td>
							<td height='30' width="20%" class="headercolor"  >用户实名</td>
							<td height='30' width="*" class="headercolor"  >所在机构</td>
							<td height='30' width="17%" class="headercolor"  >手机号码</td>
						</tr>
							
						<pg:param name="roleId" value="<%=roleId%>"/>
						<pg:param name="userName"/>
						<pg:param name="userRealName"/>
						<pg:param name="type" value="user"/>
	                      
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
								每页15条记录	共<pg:rowcount/>条记录  <pg:index />
							</td>
						</tr>
					<input name="queryString" value="<pg:querystring/>" type="hidden">
				 </table>
				 </pg:pager>
			</form>
		</div>
	</body>
</html>