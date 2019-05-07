<%
/*
 * <p>Title: 角色用户组列表查询</p>
 * <p>Description:角色用户组列表查询</p>
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
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager"%>




<%	
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	
	String roleId = request.getParameter("roleId");	
	request.setAttribute("action","group");
	
	String groupName = request.getParameter("groupName");
	String groupDesc = request.getParameter("groupDesc");
	//String creator = request.getParameter("creator");
	
	groupName = groupName == null ? "" : groupName ;
	groupDesc = groupDesc == null ? "" : groupDesc ;
	
	UserManager usermanager=SecurityDatabase.getUserManager();
	
%>

<html>
	<head>
		<title>属性容器</title>
		<link href="../css/windows.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css" href="../css/treeview.css">
		<script language="JavaScript" src="../scripts/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../scripts/pager.js" type="text/javascript"></script>
		<script language="javascript">
			function clearInfo()
			{
				//document.getElementById("groupName").value = '';
				//document.getElementById("groupDesc").value = '';
				//document.getElementById("creator").value = '';
				document.groupForm.groupName.value = '';
				document.groupForm.groupDesc.value = '';
				
			}
			function querySub(){
				var groupName = document.groupForm.groupName.value;
				var groupDesc = document.groupForm.groupDesc.value;
				document.groupForm.action = "rolegroupquery.jsp?groupName="+groupName+"&groupDesc="+groupDesc+"&type=group&roleId=<%=roleId%>";
				document.groupForm.submit();
			}
		</script>
		
		<pg:listdata dataInfo="com.chinacreator.sysmgrcore.purviewmanager.tag.RoleGrantSearchList" keyName="RoleGrantSearchList" />
		<!--分页显示开始,分页标签初始化-->
		<pg:pager maxPageItems="15" id="RoleGrantSearchList" scope="request" data="RoleGrantSearchList" isList="false">
		
		<%@ include file="/epp/css/cssControl.jsp"%><body >	
			<div align="center">		
				<form name="groupForm" method="post" >
					<table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width="100%" class="thin">
						<tr height=30>
							<td align="center" width="25%" nowrap>
								用户组名称: <input type="text" name="groupName" value="<%=groupName%>" >
							</td>
							<td  align="center" width="25%" nowrap>
								用户组描述: <input type="text" name="groupDesc" value="<%=groupDesc%>" >
							</td>
							<!-- 
							<td align="center" width="25%" nowrap>
								创建者: <input type="text" name="creator" value="" >
							</td>
							 -->
							<td align="center" width="25%" nowrap>
								<input type="button"  value="查询" onclick="querySub()" class="input">&nbsp;&nbsp;&nbsp;
								<input type="button"  value="清空" onclick="clearInfo()" class="input">&nbsp;&nbsp;&nbsp;
								<input type="button"  value="返回" onclick="window.close()" class="input">&nbsp;&nbsp;&nbsp;
							</td>
						</tr>
					</table>
				
				<hr width="100%">
				<table width="100%" cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width="100%" class="thin">
				
						<pg:param name="groupName"/>
						<pg:param name="groupDesc"/>
						
						<tr class="labeltable_middle_td" 
							onmouseover="this.className='mouseover'"
							onmouseout="this.className= 'mouseout'" >
							<!--设置分页表头-->
							<td height='30' bgcolor="#EDEFF6" class="headercolor" width="40%">
								用户组名称
							</td>
							<td height='30' bgcolor="#EDEFF6" class="headercolor">
								用户组说明
							</td>
							<td height='30' bgcolor="#EDEFF6" class="headercolor">
								用户组创建者
							</td>
						</tr>
						<pg:param name="roleId"/>
						<pg:param name="type" value="group"/>
						<pg:param name="groupName" />
						<pg:param name="groupDesc" />
						<pg:param name="creator"/>
						<!--检测当前页面是否有记录-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									暂时没有用户组
								</td>
							</tr>
						</pg:notify>
						
						<!--list标签循环输出每条记录-->
						<pg:list>
							<% 
							//只显示这个用户创建的用户组 2008-4-8 baowen.liu
	                          //     String  userId=accesscontroler.getUserID();						
								//	String data = (String)dataSet.getString("owner_id");
							  //  if(userId.equals(data)){
							%>
							<tr class="labeltable_middle_td"  
								onmouseover="this.className='mouseover'"
								onmouseout="this.className= 'mouseout'">
								
								<td height='20' align=left class="tablecells">
										<pg:cell colName="groupName" defaultValue="没有名称"/>
								</td>
								
								<td height='20' align=left class="tablecells">
									<pg:cell colName="groupDesc" defaultValue="没有描述" />
								</td>
								
								<td height='20' align=left class="tablecells">
									<%
										//增加角色的创建人登陆名和实名
										//baowen.liu 2008-4-14
										String creatorId = dataSet.getString("owner_id");
										User user=usermanager.getUserById(creatorId);
										String username=user.getUserName();
										String userrealname=user.getUserRealname();
										out.print(username + "【" + userrealname + "】");
									%>
									
								</td>
							</tr>
							<%
							// }
							%>
						</pg:list>
						<tr height="30px">
							<td class="detailcontent" colspan=4 align='center'>
								共<pg:rowcount />条记录<pg:index />
								<input type="hidden" name="queryString" value="<pg:querystring/>">
							</td>
						</tr>
				</table>
			</form>
		</div>
	</body>
	</pg:pager>
</html>