
<%
/*
 * <p>Title: 用户组用户操作界面</p>
 * <p>Description:对用户组中用户操作</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
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
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.Menu"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenu"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Group"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.GroupManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.resource.ResourceManager"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenuTag"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenuImpl"%>
<%@ page import="com.chinacreator.epp.util.SQLHelper"%>
<%@ page import="com.chinacreator.epp.util.EgpManager"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%	
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	
	String groupId =(String)request.getParameter("groupId");
	//得到当前用户的ID
	String curUserId=accesscontroler.getUserID();
	//得到用户组的创建人
	GroupManager groupManager=SecurityDatabase.getGroupManager();
    Group group=groupManager.getGroupByID(groupId);
    
    String groupowner_id = String.valueOf(group.getOwner_id());
    
	String sql = "";	
	
	String userRealName = SQLHelper.parameterFormat(request.getParameter("userRealName"));
	String userName = SQLHelper.parameterFormat(request.getParameter("userName"));
	
	// 权限是否关联机构
	// 彭盛 2011-3-15 
	boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);
	
	
	if(groupId == null || "".equals(groupId))
	{
		groupId="-1";
		userName = "";
		userRealName = "";
	}
	else
	{		
		//获取用户信息
			sql = "select distinct ";
			if(isrolerelatedorg){
				sql += "o.remark5 || '(' || getuserjobinfos(u.user_id,o.org_id) || ')' as org_name,o.org_id,";
			}else{
				sql += "getUserorgjobinfos(to_char(u.user_id) || '') as org_name,"; 
			}
			sql +="u.user_id,u.user_name,u.user_realname,u.user_mobiletel1 ";
			sql +="from td_sm_group g,td_sm_usergroup ug,td_sm_user u,td_sm_organization o ";
			if(isrolerelatedorg){
				sql += ",td_sm_userjoborg ujo";
			}else{
				sql += ",td_sm_orguser ujo";
			}
			sql +=" where g.group_id = ug.group_id and ug.user_id = u.user_id and u.user_id = ujo.user_id and ujo.org_id = o.org_id "; 
			sql +=" and g.group_id = " + groupId +"";
			if(isrolerelatedorg){
				sql += " and ug.org_id=o.org_id";
			}
			if(userName != null && !userName.equals(""))
			{
				sql +=" and u.user_name like '%" + userName +"%'";
			}
			else
			{
				userName = "";
			}
			
			if(userRealName != null && !userRealName.equals(""))
			{
				sql +=" and u.user_realname like '%" + userRealName +"%'" ;
			}	
			else
			{
				userRealName = "";
			}			
	}
%>
<html>
	<head>
		<title>属性容器</title>
		<link href="../css/windows.css" rel="stylesheet" type="text/css">
		<link href="../css/treeview.css" rel="stylesheet" type="text/css">
		
		<script language="JavaScript" src="../scripts/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../scripts/pager.js" type="text/javascript"></script>
		
		<script language="javascript">
		
			var groupId = "<%=groupId%>";
			
			//增加子用户组
			function addsonGroup()
			{
				if(groupId == -1)
				{
					alert("请选择用户组!!!");
					return false ;
				}
				
				winuser = window.showModalDialog("groupInfo_addson.jsp?groupId=" + groupId,
										 window,"dialogWidth:"+(550)+"px;dialogHeight:"+(350)+"px;help:no;scroll:auto;status:no");
									 
				if(winuser != null)
				{		

					parent.group_tree.location.href = "groupTree.jsp?collapse="+ winuser +"&request_scope=request&selectedNode="+winuser;

					parent.groupinfo.location.reload();
				}
			}
			
			//修改用户组
			function editGroup()
			{
				if(groupId == -1)
				{
					alert("请选择用户组!!!");
					return false;
				}
				
				
				editWindow = window.showModalDialog("groupInfo_edit.jsp?groupId=" + groupId,
										 window,"dialogWidth:"+(580)+"px;dialogHeight:"+(350)+"px;help:no;scroll:auto;status:no");
				
										 
				if(editWindow)
				{
					window.location.reload();
				}										 							 
			}
			
			
			//删除用户组
			function delGroup()
			{
				if(groupId == -1)
				{
					alert("请选择用户组!!!");
					return false;
				}
				
				if (window.confirm("删除将连带删除子组并且不可恢复，你确认要删除这个用户组吗？")) 
				{				
					groupForm.action= "submitGroup.jsp?flag=3&groupId=" + groupId;
					groupForm.submit();
				}
				
			}
			
			function changeRole()
			{
				if(groupId == -1)
				{
					alert("请选择用户组!!!");
					return false;
				}
				
				changeRoleWindow = window.showModalDialog("changeRole_ajax.jsp?groupId=" + groupId,
										 window,"dialogWidth:"+(700)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no");
										 
				
			}
			
			function addRole()
			{
				if(groupId == -1)
				{
					alert("请选择用户组!!!");
					return false;
				}
				
				addRoleWindow = window.showModalDialog("group2user.jsp?groupId=" + groupId,
										 window,"dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no");
										 
				document.location.reload(); 
			}
			
			function lookInfo()
			{
				if(groupId == -1)
				{
					alert("请选择用户组!!!");
					return false;
				}	
				
				lookInfoWindow = window.showModalDialog("userGroupInfo.jsp?groupId=" + groupId,
										window,"dialogWidth:"+(550)+"px;dialogHeight:"+(350)+"px;help:no;scroll:auto;status:no");
			}
			
			function clearInfo()
			{
				document.getElementById("userName").value = '';
				document.getElementById("userRealName").value = '';
			}
			
			
			function subTeam(userId,orgId)
			{
			//用户隶属组
				var winsubteam;
				winsubteam = window.showModalDialog("user2group.jsp?userId="+ userId+"&&orgId="+orgId ,window,"dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no");
				if(winsubteam=="ok")
				{
					window.location.reload();
				}
			}
			
			function viewUserInfo(userId)
			{
			//用户基本信息
				var winsubteam;
				winsubteam = window.showModalDialog("userInfo1.jsp?userId="+ userId ,window,"dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no");
				
			}
			
		</script>
		
		
		<%@ include file="/epp/css/cssControl.jsp"%><body >	
			<div id="contentborder" align="center">
				<form name="groupForm" method="post" >	
					<input type="hidden" name="groupId" value="<%=groupId%>"/>
					<table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% class="thin">
						<tr style="align:left">
							<td height='30' style="align:left" colspan=5>
							<%
							//具有超级管理员角色的或者是用户自己创建的用户不加任何控制 
							//2008-4-9 baowen.liu
							if(accesscontroler.isAdmin() || 
								(curUserId.equals(groupowner_id) && accesscontroler.checkPermission("globalgroup",
		                           "groupmanager", AccessControl.GROUP_RESOURCE))){
							%>
							<div align="left">
								<a href="#" onclick="addRole();">
									<u>添加隶属用户</u>
								</a> | 
								
								<a href="#" onclick="changeRole();">
									<u>关联角色</u>
								</a> | 
								
								<a href="#" onclick="editGroup();">
									<u>修改用户组信息</u>
								</a> | 
								
								<a href="#" onclick="delGroup();">
									<u>删除用户组</u>
								</a> | 
								
								<a href="#" onclick="lookInfo();">
									<u>查看用户组信息</u>
								</a> | 
		
								<a href="#" onclick="addsonGroup();">
									<u>新增子组</u>
								</a>						
							</div>
							<%
							}else if(accesscontroler.checkPermission("globalgroup",
		                           "groupmanager", AccessControl.GROUP_RESOURCE)){//查看时候授权用户组全局操作的权限
							%>
							<div align="left">
								<a href="#" onclick="addsonGroup();">
									<u>新增子组</u>
								</a>
							</div>
							<% 
								}
							%>
							</td>
						</tr>
						<tr>
							<td width="15%">
								<div align="center">
									用户实名
								</div>
							</td>
							<td width="21%">
								<div align="left">
									<input type="text" name="userRealName" value="<%=userRealName%>" size="35">
								</div>
							</td>
							<td width="15%">
								<div align="center">
									登录名称
								</div>
							</td>
							<td width="21%">
								<div align="left">
									<input type="text" name="userName" value="<%=userName%>" size="35">
								</div>
							</td>
							<td width="21%">
								<div align="center">
									<input type="submit"  value="查询" class="input">
									<input type="button"  value="清空" onclick="clearInfo()" class="input">
								</div>
							</td>
						</tr>
					</table>
				
				<hr width="100%">
				
				<table width="100%" cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% class="thin">			
						<tr class="labeltable_middle_td" 
							onmouseover="this.className='mouseover'"
							onmouseout="this.className= 'mouseout'" >
							<!--设置分页表头-->
							<td height='30' bgcolor="#EDEFF6" class="headercolor">
								用户实名
							</td>
							<td height='30' bgcolor="#EDEFF6" class="headercolor">
								登录名称
							</td>
							<td height='30' bgcolor="#EDEFF6" class="headercolor">
								所在机构
							</td>
							<td height='30' bgcolor="#EDEFF6" class="headercolor">
								手机号码
							</td>
						</tr>
						
						<%
						if(!sql.equals(""))
						{
						%>
						
						<pg:pager statement="<%=sql%>" dbname="<%=EgpManager.getAppDBName() %>" isList="false" maxPageItems="10">
							<pg:param name="groupId"/>
							<pg:param name="userName"/>
							<pg:param name="userRealName"/>
							
							<!--检测当前页面是否有记录-->
							<pg:notify>
								<tr height='25' class="labeltable_middle_tr_01">
									<td colspan=100 align='center'>
										该组暂时无用户信息
									</td>
								</tr>
							</pg:notify>
						
						
							<%
								ContextMenu contextmenu = new ContextMenuImpl();
					 		%>
					 		
							<!--list标签循环输出每条记录-->
							<pg:list>
								<%
									
									String userId = dataSet.getString("user_id");
									String currorgId = dataSet.getString("org_id");
									
									Menu menu = new Menu();
									menu.setIdentity("operUser_" + userId+currorgId);		
									//不是当前用户的创建的组,禁止查看用户基本信息,2008-4-8 baowen.liu
									if(curUserId.equals(groupowner_id)||accesscontroler.isAdmin()) {
									//用户基本信息查看
									//2008-3-24 baowen.liu
									Menu.ContextMenuItem menuitem1 = new Menu.ContextMenuItem();
									menuitem1.setName("用户信息查看");
									menuitem1.setLink("javascript:viewUserInfo("+userId+")");
									menuitem1.setIcon("../images/rightmenu_images/edit.gif");
									menu.addContextMenuItem(menuitem1);
												
									//隶属组设置，为用户设置（新加入组或者去掉组）隶属组；只有admin才能有此项操作
									if(accesscontroler.isAdmin()){
										Menu.ContextMenuItem menuitem = new Menu.ContextMenuItem();
										menuitem.setName("隶属组设置");
										menuitem.setLink("javascript:subTeam("+userId+","+currorgId+")");
										menuitem.setIcon("../images/rightmenu_images/edit.gif");
										menu.addContextMenuItem(menuitem);
									}
													
									contextmenu.addContextMenu(menu);
									
									}	
									
									request.setAttribute("operUser",contextmenu);  
									
								%>
								
								<tr class="labeltable_middle_td"  
									onmouseover="this.className='mouseover'"
									onmouseout="this.className= 'mouseout'">
									<td  id="operUser_<%=userId%><%=currorgId %>" class="tablecells" height='20' align=left bgcolor="#F6FFEF">
											<pg:cell colName="user_realname" defaultValue=""/>
									</td>
									<td height='20' align=left class="tablecells">
										<pg:cell colName="user_name" defaultValue="" />
									</td>
									<td height='20' align=left class="tablecells">
										<pg:cell colName="org_name" defaultValue="" />
									</td>
									<td height='20' align=left class="tablecells">
										<pg:notnull colName="user_mobiletel1">
											<pg:cell colName="user_mobiletel1" defaultValue=" "/></pg:notnull>
											<pg:null colName="user_mobiletel1">没有号码</pg:null>
											<pg:equal colName="user_mobiletel1" value="">没有号码</pg:equal>
									</td>
								</tr>
							</pg:list>
							
							<tr height="30px">
								<td class="detailcontent" colspan=4 align='center'>
										共<pg:rowcount />条记录<pg:index />
									<input type="hidden" name="queryString" value="<pg:querystring/>">
								</td>
							</tr>
							<pg:contextmenu enablecontextmenu="true" context="operUser" scope="request"/> 	
					</pg:pager>
					<%		
						}
						else
						{
					%>
						<tr height="18px">
								<td class="detailcontent" colspan=4 align='center'>
									请先选择用户组
								</td>
							</tr>	
					<%
						}
					%>
				</table>
			</form>
		</div>
	</body>
</html>