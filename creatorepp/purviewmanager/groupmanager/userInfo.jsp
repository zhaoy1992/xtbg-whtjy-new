
<%
/*
 * <p>Title: �û����û���������</p>
 * <p>Description:���û������û�����</p>
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
	//�õ���ǰ�û���ID
	String curUserId=accesscontroler.getUserID();
	//�õ��û���Ĵ�����
	GroupManager groupManager=SecurityDatabase.getGroupManager();
    Group group=groupManager.getGroupByID(groupId);
    
    String groupowner_id = String.valueOf(group.getOwner_id());
    
	String sql = "";	
	
	String userRealName = SQLHelper.parameterFormat(request.getParameter("userRealName"));
	String userName = SQLHelper.parameterFormat(request.getParameter("userName"));
	
	// Ȩ���Ƿ��������
	// ��ʢ 2011-3-15 
	boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);
	
	
	if(groupId == null || "".equals(groupId))
	{
		groupId="-1";
		userName = "";
		userRealName = "";
	}
	else
	{		
		//��ȡ�û���Ϣ
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
		<title>��������</title>
		<link href="../css/windows.css" rel="stylesheet" type="text/css">
		<link href="../css/treeview.css" rel="stylesheet" type="text/css">
		
		<script language="JavaScript" src="../scripts/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../scripts/pager.js" type="text/javascript"></script>
		
		<script language="javascript">
		
			var groupId = "<%=groupId%>";
			
			//�������û���
			function addsonGroup()
			{
				if(groupId == -1)
				{
					alert("��ѡ���û���!!!");
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
			
			//�޸��û���
			function editGroup()
			{
				if(groupId == -1)
				{
					alert("��ѡ���û���!!!");
					return false;
				}
				
				
				editWindow = window.showModalDialog("groupInfo_edit.jsp?groupId=" + groupId,
										 window,"dialogWidth:"+(580)+"px;dialogHeight:"+(350)+"px;help:no;scroll:auto;status:no");
				
										 
				if(editWindow)
				{
					window.location.reload();
				}										 							 
			}
			
			
			//ɾ���û���
			function delGroup()
			{
				if(groupId == -1)
				{
					alert("��ѡ���û���!!!");
					return false;
				}
				
				if (window.confirm("ɾ��������ɾ�����鲢�Ҳ��ɻָ�����ȷ��Ҫɾ������û�����")) 
				{				
					groupForm.action= "submitGroup.jsp?flag=3&groupId=" + groupId;
					groupForm.submit();
				}
				
			}
			
			function changeRole()
			{
				if(groupId == -1)
				{
					alert("��ѡ���û���!!!");
					return false;
				}
				
				changeRoleWindow = window.showModalDialog("changeRole_ajax.jsp?groupId=" + groupId,
										 window,"dialogWidth:"+(700)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no");
										 
				
			}
			
			function addRole()
			{
				if(groupId == -1)
				{
					alert("��ѡ���û���!!!");
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
					alert("��ѡ���û���!!!");
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
			//�û�������
				var winsubteam;
				winsubteam = window.showModalDialog("user2group.jsp?userId="+ userId+"&&orgId="+orgId ,window,"dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no");
				if(winsubteam=="ok")
				{
					window.location.reload();
				}
			}
			
			function viewUserInfo(userId)
			{
			//�û�������Ϣ
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
							//���г�������Ա��ɫ�Ļ������û��Լ��������û������κο��� 
							//2008-4-9 baowen.liu
							if(accesscontroler.isAdmin() || 
								(curUserId.equals(groupowner_id) && accesscontroler.checkPermission("globalgroup",
		                           "groupmanager", AccessControl.GROUP_RESOURCE))){
							%>
							<div align="left">
								<a href="#" onclick="addRole();">
									<u>��������û�</u>
								</a> | 
								
								<a href="#" onclick="changeRole();">
									<u>������ɫ</u>
								</a> | 
								
								<a href="#" onclick="editGroup();">
									<u>�޸��û�����Ϣ</u>
								</a> | 
								
								<a href="#" onclick="delGroup();">
									<u>ɾ���û���</u>
								</a> | 
								
								<a href="#" onclick="lookInfo();">
									<u>�鿴�û�����Ϣ</u>
								</a> | 
		
								<a href="#" onclick="addsonGroup();">
									<u>��������</u>
								</a>						
							</div>
							<%
							}else if(accesscontroler.checkPermission("globalgroup",
		                           "groupmanager", AccessControl.GROUP_RESOURCE)){//�鿴ʱ����Ȩ�û���ȫ�ֲ�����Ȩ��
							%>
							<div align="left">
								<a href="#" onclick="addsonGroup();">
									<u>��������</u>
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
									�û�ʵ��
								</div>
							</td>
							<td width="21%">
								<div align="left">
									<input type="text" name="userRealName" value="<%=userRealName%>" size="35">
								</div>
							</td>
							<td width="15%">
								<div align="center">
									��¼����
								</div>
							</td>
							<td width="21%">
								<div align="left">
									<input type="text" name="userName" value="<%=userName%>" size="35">
								</div>
							</td>
							<td width="21%">
								<div align="center">
									<input type="submit"  value="��ѯ" class="input">
									<input type="button"  value="���" onclick="clearInfo()" class="input">
								</div>
							</td>
						</tr>
					</table>
				
				<hr width="100%">
				
				<table width="100%" cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% class="thin">			
						<tr class="labeltable_middle_td" 
							onmouseover="this.className='mouseover'"
							onmouseout="this.className= 'mouseout'" >
							<!--���÷�ҳ��ͷ-->
							<td height='30' bgcolor="#EDEFF6" class="headercolor">
								�û�ʵ��
							</td>
							<td height='30' bgcolor="#EDEFF6" class="headercolor">
								��¼����
							</td>
							<td height='30' bgcolor="#EDEFF6" class="headercolor">
								���ڻ���
							</td>
							<td height='30' bgcolor="#EDEFF6" class="headercolor">
								�ֻ�����
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
							
							<!--��⵱ǰҳ���Ƿ��м�¼-->
							<pg:notify>
								<tr height='25' class="labeltable_middle_tr_01">
									<td colspan=100 align='center'>
										������ʱ���û���Ϣ
									</td>
								</tr>
							</pg:notify>
						
						
							<%
								ContextMenu contextmenu = new ContextMenuImpl();
					 		%>
					 		
							<!--list��ǩѭ�����ÿ����¼-->
							<pg:list>
								<%
									
									String userId = dataSet.getString("user_id");
									String currorgId = dataSet.getString("org_id");
									
									Menu menu = new Menu();
									menu.setIdentity("operUser_" + userId+currorgId);		
									//���ǵ�ǰ�û��Ĵ�������,��ֹ�鿴�û�������Ϣ,2008-4-8 baowen.liu
									if(curUserId.equals(groupowner_id)||accesscontroler.isAdmin()) {
									//�û�������Ϣ�鿴
									//2008-3-24 baowen.liu
									Menu.ContextMenuItem menuitem1 = new Menu.ContextMenuItem();
									menuitem1.setName("�û���Ϣ�鿴");
									menuitem1.setLink("javascript:viewUserInfo("+userId+")");
									menuitem1.setIcon("../images/rightmenu_images/edit.gif");
									menu.addContextMenuItem(menuitem1);
												
									//���������ã�Ϊ�û����ã��¼��������ȥ���飩�����飻ֻ��admin�����д������
									if(accesscontroler.isAdmin()){
										Menu.ContextMenuItem menuitem = new Menu.ContextMenuItem();
										menuitem.setName("����������");
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
											<pg:null colName="user_mobiletel1">û�к���</pg:null>
											<pg:equal colName="user_mobiletel1" value="">û�к���</pg:equal>
									</td>
								</tr>
							</pg:list>
							
							<tr height="30px">
								<td class="detailcontent" colspan=4 align='center'>
										��<pg:rowcount />����¼<pg:index />
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
									����ѡ���û���
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