<%
/**
 * <p>Title: 角色主页面</p>
 * <p>Description: 角色主页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
 * @author da.wei
 * @version 1.0
 */
%>

<%@page contentType="text/html; charset=GBK"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenu"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenuImpl"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.Menu"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.RoleType"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleTypeManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@ page import="java.util.List"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>

			

<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request,response);
	
	String roleName = request.getParameter("roleName");
	roleName = roleName == null ? "" :roleName;
	
	String roleTypeName = request.getParameter("roleTypeName");
	roleTypeName = roleTypeName == null ? "" : roleTypeName;
	
	
	String roleDesc = request.getParameter("roleDesc");
	roleDesc = roleDesc == null ? "" : roleDesc;
	String creatorName = request.getParameter("creatorName");
	creatorName=creatorName==null ? "" : creatorName;
	String rootpath = request.getContextPath();
%>

<!--
	用户成员功能改为角色授予用户，去掉此列，加入右键。
	去掉权限列，加入右键。
	将角色权限复制加入右键。
-->

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/treeview.css">
		<script language="JavaScript" src="../../include/pager.js" type="text/javascript"></script>
		<script language="JavaScript" src="../scripts/func.js" type="text/javascript"></script>
		<title>权限管理</title>

		<script language="javascript">
			function lookRoleInfo(roleId){
				if(roleId != null && roleId != ""){
					var ww = openWin('lookRoleInfo.jsp?roleId='+roleId,screen.availWidth-600,screen.availHeight-300);
					if(ww)
					{
						location.reload();
					}
				}
			}
			
			function roleInfo(roleId){
				if(roleId != null && roleId != ""){
					var ww = openWin('modifyRole.jsp?roleId='+roleId,screen.availWidth-600,screen.availHeight-300);
					if(ww)
					{
						//window.location.href = "role.jsp" ;
						window.location.reload();
					}
				}
			}
			
			//角色资源授予
			function rolePurview(roleId){
				if(roleId != null && roleId != ""){
					winresgrant = window.showModalDialog("../grantmanager/role_resFrame.jsp?roleId="+ roleId ,window,"dialogWidth:"+screen.availWidth+";dialogHeight:"+screen.availHeight+";help:no;scroll:auto;status:no");
					window.location.reload();
				}
			}
			
			//角色批量资源授予
			function roleBatchPurview(){
				var roleIds = "";
				var arr = document.getElementsByName("ID");
				for(var i = 0; i < arr.length; i++){
					if(arr[i].checked){
						if(roleIds==""){
							roleIds = arr[i].value;
						}else{
							roleIds += "," + arr[i].value;
						}
					}
				}
				if(roleIds.split(",").length > 1){
					winresgrant = window.showModalDialog("../grantmanager/roleBatch_resFrame.jsp?roleIds="+roleIds ,window,"dialogWidth:"+screen.availWidth+";dialogHeight:"+screen.availHeight+";help:no;scroll:auto;status:no");
					window.location.reload();
				}else{
					alert("请至少选择两条记录！");
					return false;
				}
			}
			
			function copyPurview(roleId){
				if(roleId != null && roleId != ""){
					//winresgrant = window.showModalDialog('purviewRoleCopy.jsp?&roleId='+roleId,window,"dialogWidth:"+(screen.availWidth-200)+";dialogHeight:"+(screen.availHeight-200)+";help:no;scroll:auto;status:no");
					 window.showModalDialog("purviewRoleCopy.jsp?&roleId="+ roleId,"","dialogWidth:"+(850)+"px;dialogHeight:"+(650)+"px;help:no;scroll:auto;status:no");
				}
			}
			function reclaimPurview(roleId){
				if(roleId != null && roleId != ""){
				    if(!confirm("确定要回收角色的资源吗?")){
				        return false;
				    }
					document.form1.action = "../reclaimManager/reclaimRoleRes_do.jsp?roleId="+roleId;
			    	document.form1.target = "hiddenFrame";
			    	document.form1.submit();
				}
			}
			//2008-3-27
			//baowen.liu
			function roleResList(roleId){
				if(roleId != null && roleId != ""){
					//openWin('roleResFrame.jsp?&roleId='+roleId,screen.availWidth-300,screen.availHeight-300);
				  var typeName = "role";
			     window.showModalDialog("roleres_queryframe.jsp?roleId="+ roleId+"&typeName="+typeName,"","dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no");
	
		
				
				}
			}
			
			function rightUserList(roleId){
				if(roleId != null && roleId != ""){
					openWin('role2user.jsp?&roleId='+roleId,screen.availWidth-100,screen.availHeight-100);
				}
			}
			
			function rightUserGroupList(roleId){
				if(roleId != null && roleId != ""){
					openWin('role2group.jsp?&roleId='+roleId,screen.availWidth-200,screen.availHeight-200);
				}
			}
			
			function rightOrgList(roleId){
				if(roleId != null && roleId != ""){
					openWin('role2org.jsp?&roleId='+roleId,screen.availWidth-200,screen.availHeight-200);
				}
			}
			
			function rightOrgJobList(roleId){
				if(roleId != null && roleId != ""){
					openWin('role2orgJob.jsp?&roleId='+roleId,screen.availWidth-200,screen.availHeight-200);
				}
			}
			
			
			function addRole(){
				var ww = openWin('addRole.jsp?flag=0',screen.availWidth-600,screen.availHeight-300)
				if(ww)
				{
					location.reload();
				}
			}
			function roleTypeManage(){
				var ww = openWin('roletype.jsp',screen.availWidth-200,screen.availHeight-300);
				if(ww)
				{
					location.reload();
				}
			}
			
			function reclaimRolesRes(){
				var IDs = document.getElementsByName("ID");
				
				var size = 0;
				
				for(var i=0; i<IDs.length; i++)
				{
					if(IDs[i].checked)
					{
						size ++ ;
					}
				}
				
				if(size > 0)
				{
					if(size > 1){
					
						if(!confirm("确定要回收角色的资源吗?"))
						{
				        	return false;
				    	}
					    document.form1.action = "../reclaimManager/reclaimRoleRes_do.jsp";
					    document.form1.target = "hiddenFrame";
					    document.form1.submit();
				    }else{
				    	alert("请至少选择两条记录！");
						return false;
					}
				}	
				else
				{
					alert("请选择要回收的角色资源!");
				}			
			}
			
			function deleteRole()
			{
				var all = document.getElementsByName("ID");
				var docidStr="";
				for(var i=0;i<all.length;i++)
				{
					if(all[i].checked == true)
					{
						if(all[i].value==1 || all[i].value==2 || all[i].value==3 || all[i].value==4)
						{
							alert("保留角色不能被删除！");
							return false;			
						}
						docidStr = docidStr + all[i].value + ";";
					}
				}
				if(haveSelect('ID'))
				{		
					if(confirm('您确定要删除所选的角色？！'))
					{								
						//document.all.divProcessing.style.display = "block";
					  	form1.action = "role_delete.jsp?role_id=" + docidStr;
						form1.target = "";
						form1.submit();	
					}
					else
					{
					  return false;
					}
				
				}else{
			    	alert("请选择要求删除的角色！");
			    	return false;
			   	}
			   	return true;
			}
			
			//角色授予查询对象（对用户、机构、用户组）
			function roleGrantList(roleId)
			{
				if(roleId != null && roleId != ""){
					openWin('rolegrantframe.jsp?&roleId='+roleId,screen.availWidth-100,screen.availHeight-100);
				}
			}
			
			function querySubmit()
			{
				
				form1.action = "role.jsp";
				form1.submit();
			}
			
			function clearInfo()
			{
				document.getElementById("roleName").value="";
				document.getElementById("roleTypeName").value="";
				document.getElementById("roleDesc").value="";
				document.getElementById("creatorName").value="";
			}
			
			function refreshrolecache(){
				document.forms[0].action = "refreshrolecache.jsp";
				document.forms[0].target = "hiddenFrame";
				document.forms[0].submit();
				document.forms[0].target = "";
			}
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" bgcolor="#F7F8FC">
	    <form name="form1" method="post">
		<div id="contentborder" align="center">
			<table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width="100%" class="thin">
				<tr style="align:left">
					<td height='30' style="align:left" colspan=7>
					
					<%
					  //查看授权与否
					if (control.checkPermission("globalrole",
		                          "rolemanager", AccessControl.ROLE_RESOURCE)){
					%>
						<div align="left">
							<a href="#" onclick="addRole()"><u>新增角色</u></a> | 
							<a href="#" onclick="deleteRole()"><u>删除角色</u></a> | 
							<a href="#" onclick="roleTypeManage()"><u>类型管理</u></a> |
							<a href="#" onclick="reclaimRolesRes()"><u>批量角色权限回收</u></a> |
							<a href="#" onclick="roleBatchPurview()"><u>批量角色权限授予</u></a>
						</div>
					<%
					}
					if(control.isAdmin()){
					%>
					<div align="right">
						<input type="button" class="input" value="角色缓冲刷新" onclick="refreshrolecache()" />
					</div>	
					<%} %>
					</td>
				</tr>
				<tr onkeydown="if(event.keyCode==13)querySubmit();">
					<td >
						<div align="center">
							角色名称：<input type="text" id="roleName" name="roleName" value="<%=roleName%>" size=10 />
						</div>
					</td>
					<td >
						<div align="center">
							角色类型：
							<select id="roleType" name="roleTypeName" id="roleTypeName">
								<option value="" >--请选择--</option>
							<%
								List typenamelist = null;
								RoleTypeManager rtm = new RoleTypeManager();
								typenamelist = rtm.getTypeNameList();
								if(typenamelist != null)
								{
									for(int i=0;i<typenamelist.size();i++)
									{
										RoleType rt = (RoleType)typenamelist.get(i);
										
							%>
								<option value="<%=rt.getRoleTypeID()%>" <%
									if(roleTypeName.equals(rt.getRoleTypeID()))
									{
									%>
										selected="selected"
									<%
									}
									%>>
										<%=rt.getTypeName()%>
								</option>
							<%				
									}
								}
							%>
							</select>
						</div>
					</td>
					<td >
						<div align="center">
							角色描述：<input type="text" name="roleDesc" value="<%=roleDesc%>" id="roleDesc" size=30>
						</div>
					</td>
					<td >
						<div align="center">
							创建人：<input type="text" id="creatorName" name="creatorName" value="<%=creatorName%>" size=10/>
						</div>
					</td>
					<td >
						<div align="center">
							<input name="sub" value="查询" type="button" onclick="querySubmit()" class="input" />
							<input name="clear" value="清空" type="button" onclick="clearInfo()" class="input" />
						</div>
					</td>
				</tr>
			</table>
			<hr width="100%">
			<table width="100%" cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width="100%" class="thin">
				<pg:listdata dataInfo="com.chinacreator.sysmgrcore.purviewmanager.tag.RoleSearchList" keyName="RoleSearchList" />
		<!--分页显示开始,分页标签初始化-->
		<pg:pager maxPageItems="10" id="RoleSearchList" scope="request" data="RoleSearchList" isList="false">
			<tr>
				<!--设置分页表头-->
				<td class="headercolor" width="3%">
				<input type="checkbox" name="checkBoxAll" onclick="checkAll('checkBoxAll','ID')">							
				</td>
				<td height='30' width="19%" class="headercolor" >角色名称</td>
				<td height='30' width="21%" class="headercolor" >角色类型</td>	
				<td height='30' width="40%" class="headercolor" >角色描述</td>
				<td height='30' width="15%" class="headercolor" >角色创建人</td>	
								
			</tr>        
			<pg:param name="roleId"/>
			<pg:param name="roleName" value="<%=roleName%>"/> 
			<pg:param name="roleTypeName" value="<%=roleTypeName%>"/>
			<pg:param name="roleDesc" value="<%=roleDesc%>"/>
			<pg:param name="creatorName" />
			             
			<!--检测当前页面是否有记录-->
			<pg:notify>
				<tr height="18px" class="labeltable_middle_tr_01">
					<td colspan=100 align='center' height='20'>
						暂时没有角色
					</td>
				</tr>
			</pg:notify>
			<%ContextMenu contextmenu = new ContextMenuImpl();%>
			<!--list标签循环输出每条记录-->
			<pg:list>
				<%
					String roleID = dataSet.getString("roleId");
					boolean isDisabled = (roleID.equals("1") || roleID.equals("3"));
					String owner_Id=(String)dataSet.getString("owner_id");
					String curuserId=control.getUserID();
					
					//增加角色的创建人登陆名和实名
					//baowen.liu 2008-4-14
					UserManager usermanager=SecurityDatabase.getUserManager();
					User user=usermanager.getUserById(owner_Id);
					String username=user.getUserName();
					String userrealname=user.getUserRealname();
					
					Menu menu = new Menu();		
					menu.setIdentity("oproletype_" + roleID);

					//角色基本信息查看
					Menu.ContextMenuItem menuitem1 = new Menu.ContextMenuItem();
					menuitem1.setName("基本信息查看");
					menuitem1.setLink("javascript:lookRoleInfo('"+roleID+"')");
					menuitem1.setIcon("../../sysmanager/images/piechart.gif");
					menu.addContextMenuItem(menuitem1);
					
					//不是自己创建的角色,将不显示一下右键菜单,具有超级管理员角色的用户除外.
					//2008-4-9 baowen.liu
					if(owner_Id.equals(curuserId)||control.isAdmin()){
						if(control.checkPermission("globalrole","rolemanager",AccessControl.ROLE_RESOURCE)){
							//角色基本信息修改
							Menu.ContextMenuItem menuitem2 = new Menu.ContextMenuItem();
							menuitem2.setName("基本信息修改");
							menuitem2.setLink("javascript:roleInfo('"+roleID+"')");
							menuitem2.setIcon("../../sysmanager/images/project_close.gif");
							menu.addContextMenuItem(menuitem2);
							menu.addSeperate();
							//权限
							if(!"1".equals(roleID) && !"3".equals(roleID)){
								Menu.ContextMenuItem menuitem7 = new Menu.ContextMenuItem();
								menuitem7.setName("权限授予");
								menuitem7.setLink("javascript:rolePurview('"+roleID+"')");
								menuitem7.setIcon("../../sysmanager/images/Realm.gif");
								menu.addContextMenuItem(menuitem7);
							}
				
							//权限复制
							if("4".equals(roleID) || "1".equals(roleID) || "3".equals(roleID) || "2".equals(roleID)){
							    //1:admin
							    //3 部门管理员角色
							    //2 普通角色
							    //4 部门管理员角色模板
							    //不允许权限回收
							}else{
								Menu.ContextMenuItem menuitem8 = new Menu.ContextMenuItem();
								menuitem8.setName("权限复制");
								menuitem8.setLink("javascript:copyPurview('"+roleID+"')");
								menuitem8.setIcon("../../sysmanager/images/Roles.gif");
								menu.addContextMenuItem(menuitem8);
							}
							
							//权限回收
							if("1".equals(roleID) || "3".equals(roleID)){
							    //1:admin
							    //3 部门管理员角色
							    //不允许权限回收
							}else{					    
								Menu.ContextMenuItem menuitem9 = new Menu.ContextMenuItem();
								menuitem9.setName("权限回收");
								menuitem9.setLink("javascript:reclaimPurview('"+roleID+"')");
								menuitem9.setIcon("../../sysmanager/images/icons/16x16/recycle.gif");
								menu.addContextMenuItem(menuitem9);
							}
							
						}
					}
					menu.addSeperate();
					//角色授予用户
					if(!"2".equals(roleID) && !"3".equals(roleID) && !"4".equals(roleID)){
						if (ConfigManager.getInstance().getConfigBooleanValue("enableorgrole", false))
	                    {			
							//角色授予机构
							if(!"2".equals(roleID) && !"3".equals(roleID) && !"4".equals(roleID)){
								Menu.ContextMenuItem menuitem5 = new Menu.ContextMenuItem();
								menuitem5.setName("机构授予");
								menuitem5.setLink("javascript:rightOrgList('"+roleID+"')");
								menuitem5.setIcon("../../sysmanager/images/procedure.gif");
								menu.addContextMenuItem(menuitem5);
							}
						}
						Menu.ContextMenuItem menuitem3 = new Menu.ContextMenuItem();
						menuitem3.setName("用户授予");
						menuitem3.setLink("javascript:rightUserList('"+roleID+"')");
						menuitem3.setIcon("../../sysmanager/images/profile.gif");
						menu.addContextMenuItem(menuitem3);
						if(ConfigManager.getInstance().getConfigBooleanValue("enablejobfunction", false)){
							//角色授予机构岗位
							Menu.ContextMenuItem menuitem6 = new Menu.ContextMenuItem();
							menuitem6.setName("机构岗位授予");
							menuitem6.setLink("javascript:rightOrgJobList('"+roleID+"')");
							menuitem6.setIcon("../../sysmanager/images/Valve.gif");
							menu.addContextMenuItem(menuitem6);
						}
					}
					
					//设置用户组开关
					if (!"2".equals(roleID) && !"3".equals(roleID) && !"4".equals(roleID) 
						&& ConfigManager.getInstance().getConfigBooleanValue("enablergrouprole", false))
                    {
						//角色授予用户组
						if((!"2".equals(roleID) && !"3".equals(roleID) && !"4".equals(roleID) && owner_Id.equals(curuserId))
							|| control.isAdmin()){
							Menu.ContextMenuItem menuitem4 = new Menu.ContextMenuItem();
							menuitem4.setName("用户组授予");
							menuitem4.setLink("javascript:rightUserGroupList('"+roleID+"')");
							menuitem4.setIcon("../../sysmanager/images/members.gif");
							menu.addContextMenuItem(menuitem4);
						}
					}
					
					
					
					
					menu.addSeperate();
					//权限查询
					Menu.ContextMenuItem menuitem10 = new Menu.ContextMenuItem();
					menuitem10.setName("权限查询");
					menuitem10.setLink("javascript:roleResList('"+roleID+"')");
					menuitem10.setIcon("../../sysmanager/images/markread-16x16.gif");
					menu.addContextMenuItem(menuitem10);
					
					//角色授予情况查询。查询角色的授予给用户，机构，用户组，机构下的岗位。roleofeveryone不需要查询
					if(!roleID.equals("2")){
						Menu.ContextMenuItem menuitem11 = new Menu.ContextMenuItem();
						menuitem11.setName("角色授予查询");
						menuitem11.setLink("javascript:roleGrantList('"+roleID+"')");
						menuitem11.setIcon("../../sysmanager/images/milestone.gif");
						menu.addContextMenuItem(menuitem11);
					}
					
					
					contextmenu.addContextMenu(menu);
				%>
				<tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'">
					<td class="tablecells" nowrap="true">
						<P align="left">
						                           <!-- 不是超级管理员或不是自己创建的角色将不可以选择 2008-4-8 baowen.liu -->
							<input type="checkbox" name="ID" <%if(((!control.isAdmin())&&(!owner_Id.equals(curuserId))) || isDisabled) {%> disabled='true' <%}%> onclick="checkOne('checkBoxAll','ID')" value='<pg:cell colName="roleId" defaultValue=""/>' >						
						</P>
					</td>
					<td id="oproletype_<%=roleID%>" height='20' class="tablecells" bgcolor="#F6FFEF">
						<pg:cell colName="roleName" defaultValue="" />
					</td>		
					<td height='20' class="tablecells" >
						<pg:cell colName="roleType" defaultValue="" />
					</td>
					<td height='20' class="tablecells"  >
						<pg:cell colName="roleDesc" defaultValue="" />
					</td>
					<td height='20' class="tablecells"  >
						<%=username%>【<%=userrealname%>】
					</td>		
				</tr>
			</pg:list>
			<tr height="18px" class="labeltable_middle_tr_01">
				<td colspan="5" align='center'>
					共<pg:rowcount/>条记录  <pg:index />			
				</td>										
			</tr>
			<%request.setAttribute("oproletype", contextmenu);%>
			<pg:contextmenu enablecontextmenu="true" context="oproletype" scope="request" />
			</pg:pager>
			</table>
			<iframe name="hiddenFrame" id="hiddenFrame" src="" width=0 height=0 ></iframe>
		</div>
		</form>
		<div id=divProcessing style="width:200px;height:30px;position:absolute;left:250px;top:260px;display:none">
			<table border="0" cellpadding="0" cellspacing="1" bgcolor="#000000" width="100%" height="100%">
				<tr>
					<td bgcolor=#3A6EA5>r
						<marquee align="middle" behavior="alternate" scrollamount="5">
							<font color=#FFFFFF>...处理中...请等待...</font>
						</marquee>
					</td>
				</tr>
			</table>
		</div>
	</body>
<iframe name="hiddenFrame" width="0" height="0"></iframe>	
</html>
