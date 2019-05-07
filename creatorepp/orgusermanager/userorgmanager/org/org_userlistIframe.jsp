<%
/*
 * <p>Title:�������û��б���ʾҳ��</p>
 * <p>Description: �������û��б���ʾҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-21
 * @author liangbing.tao
 * @version 1.0
 */
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>


<%@ page import="
				 com.frameworkset.common.tag.contextmenu.Menu,
				 com.frameworkset.common.tag.contextmenu.ContextMenuImpl,
				 com.frameworkset.common.tag.contextmenu.ContextMenu,
				 com.chinacreator.security.AccessControl,
				 com.chinacreator.config.ConfigManager,
				 com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl,
				 com.chinacreator.resource.ResourceManager"%>
<%@page import="com.chinacreator.ca.CaProperties"%>
<%@ page
	import="com.chinacreator.sysmgrcore.purviewmanager.usercheckorg.api.UserCheckOrgFactory"%>
<%
	
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	ResourceManager resManager = new ResourceManager();
    String resId = resManager.getGlobalResourceid(AccessControl.ORGUNIT_RESOURCE);
	String curOrgId = request.getParameter("orgId");
	String currentOrgId = accesscontroler.getChargeOrgId();
	//��ǰ��½�û�ID
	String curUserId = accesscontroler.getUserID();
	if(curOrgId == null)
		curOrgId = (String)request.getAttribute("orgId");
	String reFlush = "false";
	if (request.getAttribute("reFlush") != null) 
	{
		reFlush = "true";
	}
	
	String userNamesNo = String.valueOf(session.getAttribute("promptString"));
	session.removeAttribute("promptString");
	//System.out.println(userNamesNo);
	Integer currUserId = (Integer)session.getAttribute("currUserId");
	
	if(currUserId == null)
	{
		currUserId = Integer.valueOf("-1");
	}
	
	//String curOrgId = (String)session.getAttribute("orgId");
	String desc = (String)request.getParameter("pager.desc");	
	String intervalType = (String)request.getParameter("intervalType");
	String taxmanager = (String)request.getParameter("taxmanager");
	String ischecked="";
	if((String)request.getAttribute("ischecked")==null)
	{
		ischecked ="";
	}
	else
	{
		ischecked =(String)request.getAttribute("ischecked");
	}
	
	OrgAdministratorImpl orgAdministratorImpl = new OrgAdministratorImpl();
	
	//��λ���ܿ���
	boolean isJobOpen = ConfigManager.getInstance().getConfigBooleanValue("enablejobfunction", false);
	
	//�Ƿ����  "�Ƿ�˰��Ա" ��ѡ��
	boolean istaxmanager = ConfigManager.getInstance().getConfigBooleanValue("istaxmanager", false);
	//�Ƿ������û����ڶ��������
	boolean isUserOrgs = ConfigManager.getInstance().getConfigBooleanValue("sys.user.enablemutiorg", false);
	//�û��鿪��
	boolean isGroup = ConfigManager.getInstance().getConfigBooleanValue("enablergrouprole", false);
	// �ж��Ƿ�ƽ̨
	boolean isEgp = accesscontroler.getCurrentSystemID().equals("module")?true:false; 
	
  	//�ж��Ƿ���û����û���ɾ�Ĳ˵�����
  	//minghua.guo[2010-12-13]
  	boolean orguser_modify_forbidden = ConfigManager.getInstance().getConfigBooleanValue("orguser.modify.forbidden",false);
  	
  	// Ȩ���Ƿ��������
	// ��ʢ 2011-3-15 
	boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);
	
  	// Ӧ�����Ƿ����������༭�û�����
  	// ��ʢ 2011-10-25
  	boolean isappnewuser = ConfigManager.getInstance().getConfigBooleanValue("orguser.isappnewuser",false);
%>
<html>
	<head>
		<title>��������</title>
		<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">		
		<script language="JavaScript" src="../../scripts/pager.js" type="text/javascript"></script>
		<script language="JavaScript" src="../../scripts/common.js" type="text/javascript"></script>
		<SCRIPT language="javascript">	
		function sortBy(byName){
			var desc = "false";
		
			if ( "<%=desc%>"  == desc ) desc = "true";
			userList.action="org_userlistIframe.jsp?orgId=<%=curOrgId%>&pager.offset=0&pager.sortKey="+byName+"&pager.desc="+desc;
			userList.submit();
		}
			
		function actionOnmouseover(e){	
			e.style.backgroundColor = "#8080FF";
		}
		
		function actionOnmouseup(e){
			e.style.backgroundColor = "#BEC0C2";
		}
		
		function advQueryUser()
		{	
			history.back();	
		}
		
		var winOpen
		function orderUser(){
		    winOpen = window.open("about:blank","win","scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=130,left=210");                   
		    document.all.form2.target = "win";
		    document.all.form2.action = "user_order_ajax.jsp?orgId=<%=curOrgId%>";
		    timer = window.setInterval("isClosed()",500);
		    document.all.form2.submit();
		}
		var timer;
		function isClosed(){
		    if(winOpen.closed==true){
		        window.location.href = window.location;
		        window.clearInterval(timer);
		    }
		}
		
		<!-- gao.tang 2007.11.05 start �Ҽ��˵���ת·��  -->
		function userInfoquery(userId){ 
			//�û�������Ϣ�鿴 userInfo_tab.jsp
			var winbasic;
			var url="../user/userInfo_tab_query.jsp?orgId=<%=curOrgId%>&userId="+userId;
			winbasic = window.showModalDialog(url,window,"dialogWidth:"+(850)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0");
			
		}
		
		function userInfoupdate(userId){ 
			//�û�������Ϣ�޸� userInfo_tab.jsp
			var winbasic;
			var url="../user/userInfo_tab_update.jsp?orgId=<%=curOrgId%>&userId="+userId;
			winbasic = window.showModalDialog(url,window,"dialogWidth:"+(850)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0");
			if(winbasic=="ok"){
				window.location.reload();
			}
		}
		
		function subJob(userId,orgId){
			//�û�������λ  userjoborg.jsp
			var winsubjob;
			var url2 = "../user/userjoborg.jsp?userId="+userId+"&orgId="+orgId;
			//alert(url2);
			//window.open(url2);
			winsubjob = window.showModalDialog(url2,window,"dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0");
			if(winsubjob=="ok"){
				document.location = document.location;
			}
		}
		
		function subOrg(userId){
			//�û���������
			var winsuborg;
			winsuborg = window.showModalDialog("../user/subjectionOrg.jsp?userId="+ userId + "&orgId=<%=curOrgId%>",window,"dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0");
			if(winsuborg=="ok"){
				window.location.reload();
			}
		}
		
		function subTeam(userId){
			//�û�������
			var winsubteam;
			//window.open("../user/user2group.jsp?userId="+ userId + "&orgId=<%=curOrgId%>");
			winsubteam = window.showModalDialog("../user/user2group.jsp?userId="+ userId + "&orgId=<%=curOrgId%>",window,"dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0");
			//if(winsubteam=="ok"){
			//	window.location.reload();
			//}
		}
		
		function roleGrant(userId){
			//�����µ��û���ɫ����
			var winrolegrant;
			winrolegrant = window.showModalDialog("../user/changeRole_ajax.jsp?userId="+ userId + "&orgId=<%=curOrgId%>",window,"dialogWidth:"+(800)+"px;dialogHeight:"+(700)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0");
			if(winrolegrant=="ok"){
				document.location = document.location;
			}
		}
		
		function resGrant(userId){
			//�û���Դ��������
			var winresgrant;
			//window.open("../../grantmanager/user_resFrame.jsp?userId="+ userId + "&orgId=<%=curOrgId%>");
			winresgrant = window.showModalDialog("../../grantmanager/user_resFrame.jsp?currRoleId="+ userId + "&orgId=<%=curOrgId%>",window,"dialogWidth:"+screen.availWidth+";dialogHeight:"+screen.availHeight+";help:no;scroll:auto;status:no;maximize=yes;minimize=0");
		}
		
		function purviewCopy(userId){
			//Ȩ�޸���
			var winpurviewcopy;
			//window.open("../user/purview_copy.jsp?userId="+ userId + "&orgId=<%=curOrgId%>");
			winpurviewcopy = window.showModalDialog("../user/purview_copy.jsp?userId="+ userId + "&orgId=<%=curOrgId%>",window,"dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0");
			//if(winpurviewcopy=="ok"){
			//	window.location.reload();
			//}
		}
		
		function purviewReclaim(userId,orgId){
		    //Ȩ�޻���
		    var winpurviewReclaim;
			winpurviewReclaim = window.showModalDialog("../../reclaimManager/reclaimUserRes.jsp?userIds="+ userId+"&&orgId="+orgId ,window,"dialogWidth:"+(400)+"px;dialogHeight:"+(300)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0");
			if(winpurviewReclaim=="ok"){
				//window.location.reload();
				document.location = document.location;
			}
		}
		
		function userOrg(userId){
			//�û��ɹ���Ļ����б���Ϣ
			var winuserOrg;
			//window.open("../user/managerOrg_list.jsp?orgId=<%=curOrgId%>&userId="+userId);
			winuserOrg = window.showModalDialog("../user/managerOrg_list.jsp?orgId=<%=curOrgId%>&userId="+userId,window,"dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0");
		}
		
		function userResList(userId){
			//�û�Ȩ�޲�ѯ
			var typeName = "USER";
			window.showModalDialog("../user/userres_queryframe.jsp?orgId=<%=curOrgId%>&userId="+ userId+"&typeName="+typeName,"","dialogWidth:"+(1000)+"px;dialogHeight:"+(700)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0");
		}
		
		//�û���ְ����б�
		function userHisJob(userId){
			var sty = "dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0";
			window.showModalDialog("../user/userHisJobQuery.jsp?userId="+userId,window,sty);
			//window.open("../user/userHisJobQuery.jsp?userId="+userId);
		}
		
		function usersx(){
			document.location = document.location;
		}
		<!-- gao.tang 2007.11.05 end    -->
		
		function userResetCa(userName){
			document.userList.action="../user/resetCa.jsp?userName="+userName;
			document.userList.target="deluser";
			document.userList.submit();
		}
		
		</SCRIPT>		
			<%@ include file="/epp/css/cssControl.jsp"%><body  >
				<form name="userList" method="post" >
				<input type="hidden" name="orgId" value="<%=curOrgId%>"/>
				<div style="width:100%;height:100%;overflow:auto">
         				<table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% class="thin">
         				<pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.Org_UserListSn" keyName="UserListSn" />
						<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
						<pg:pager maxPageItems="10" scope="request" data="UserListSn" isList="false">
							<tr>
								<!--���÷�ҳ��ͷ-->
								<td height='30' class="headercolor" width="6%">
								<P align="left">
								<INPUT type="checkbox" name="checkBoxAll" onclick="checkAll('checkBoxAll','checkBoxOne')" value="on">
								</P>
								</td>
								<td height='30' class="headercolor" onclick="sortBy('userName')" width="15%" >��½����</td>
								<td height='30' class="headercolor" onclick="sortBy('userName')" width="15%" >�û�ʵ��</td>
								<td height='30' class="headercolor" onclick="sortBy('userName')" width="15%" >�û��Ա�</td>
								<td height='30' class="headercolor" onclick="sortBy('userName')" >�û���� </td>							
								<td height='30' class="headercolor" onclick="sortBy('userName')" >��ǰ״̬</td>	
								<% 
								if(istaxmanager){
								%>
								<td height='30' class="headercolor" onclick="sortBy('userName')" width="15%" >�Ƿ�˰��Ա</td>
								<% 
								}
								%>
								<td class="headercolor" onclick="sortBy('userName')" >��������</td>
							</tr>
							<pg:param name="orgId" />
							<pg:param name="userName" />
							<pg:param name="userRealname" />
							<pg:param name="taxmanager" />
							<pg:param name="intervalType" />
							<pg:param name="istaxmanager" />
							<pg:param name="userIsvalid" />
							<pg:param name="userSex" />
							<pg:param name="userType"/>
							<pg:param name="isOrgManager" />
							<!--��⵱ǰҳ���Ƿ��м�¼-->
							<pg:notify>
								<tr height="18px" class="labeltable_middle_tr_01">
									<td colspan=100 align='center'>
										��ʱû���û�
									</td>
								</tr>
							</pg:notify>
				<!--  ----2007.10.16     chunqiu.zhao   ---------------->			
						    <%
								ContextMenu contextmenu = new ContextMenuImpl();
					 		%>

						
							<!--list��ǩѭ�����ÿ����¼-->
							<pg:list>
			<!--  ----2007.10.16     chunqiu.zhao   ---------------->	
						<%	
							int userId = dataSet.getInt("userId");
							String userIdStr = String.valueOf(userId);
							String userName = dataSet.getString("userName");
							String org_id = dataSet.getString("orgId");
							//System.out.println("orgId = " + org_id);
							//�Ƿ��ǹ���Ա
							boolean isOrgManager = false;
							if(isrolerelatedorg){							
								isOrgManager = orgAdministratorImpl.isOrgAdmin(userIdStr,org_id);
							}else{
								isOrgManager = orgAdministratorImpl.isOrgManager(userIdStr);
							}
							//�Ƿ�ӵ�г�������Ա��ɫ
							boolean isRoleAdmin = accesscontroler.isAdminByUserid(userIdStr);
							//�б��е��û��Ƿ����Լ�
							boolean isSelf = String.valueOf(userId).equals(curUserId);
							//�б��е��û��Ƿ���ͬ�����Ź���Ա
							boolean isSisterOrgManager = currentOrgId.equals(org_id) && isOrgManager;
							String isRoleAdminOrOrgManager = "";//�Ƿ�ӵ�г�������Ա��ɫ�벿�Ź���Ա��ɫ
							if(isOrgManager && isRoleAdmin){
								isRoleAdminOrOrgManager = "(���Ź���Ա����������Ա��ɫ)";
							}else if(isRoleAdmin){
								isRoleAdminOrOrgManager = "(��������Ա��ɫ)";
							}else if(isOrgManager){
								isRoleAdminOrOrgManager = "(���Ź���Ա)";
							}
							//���α�����û�  ��ʢ 2011-3-10							
							boolean isSecondUserByOrg = !UserCheckOrgFactory.getIUserCheckOrgInstance().isSecondUserByOrgIDToMess(""+userId,org_id,null);
							boolean isSecondUser = UserCheckOrgFactory.getIUserCheckOrgInstance().isSecondUser(""+userId,null);
							// �Ƿ������� ��ʢ 2011-3-10
							boolean isMainOrg = UserCheckOrgFactory.getIUserCheckOrgInstance().isMainOrg(""+userId,org_id);							
							
							Menu menu = new Menu();
							menu.setIdentity("opuser_"+userId);
							//--Menu Add -----------------------Starting---------------------------------
							//�û�������Ϣ�鿴�����ﲻ��Ȩ�޿��ƣ��ڴ򿪵�ҳ�����
							Menu.ContextMenuItem menuitemquery = new Menu.ContextMenuItem();
							menuitemquery.setName("������Ϣ�鿴");
							menuitemquery.setLink("javascript:userInfoquery("+userId+")");
							menuitemquery.setIcon("../../../sysmanager/images/issue/status_reopened.gif");
							menu.addContextMenuItem(menuitemquery);
							
							if("1".equals(curUserId)){//�����ǰ��½�û�Ϊadmin
								if(isEgp){
									//�ж��Ƿ���û����û���ɾ�Ĳ˵�����
								  	//minghua.guo[2010-12-13]
									if(!orguser_modify_forbidden && isMainOrg){
										Menu.ContextMenuItem menuitem2 = new Menu.ContextMenuItem();
										menuitem2.setName("������Ϣ�޸�");
										menuitem2.setLink("javascript:userInfoupdate("+userId+")");
										menuitem2.setIcon("../../images/edit.gif");
										menuitem2.setDisabled(isSelf);
										menu.addContextMenuItem(menuitem2);
									}
									if(CaProperties.CA_LOGIN_SERVER){
										//ʹ��������֤���ģ�����key�����к�
										Menu.ContextMenuItem menuitemca = new Menu.ContextMenuItem();
										menuitemca.setName("����CA����");
										menuitemca.setLink("javascript:userResetCa('"+userName+"')");
										menuitemca.setIcon("../../../sysmanager/images/issue/priority_blocker.gif");
										menuitemca.setDisabled(!"1".equals(curUserId));
										menu.addContextMenuItem(menuitemca);
									}
								}else{
									// Ӧ�����Ƿ����������༭�û�����
  									// ��ʢ 2011-10-25
									if(isappnewuser && isMainOrg){
										Menu.ContextMenuItem menuitem2 = new Menu.ContextMenuItem();
										menuitem2.setName("������Ϣ�޸�");
										menuitem2.setLink("javascript:userInfoupdate("+userId+")");
										menuitem2.setIcon("../../images/edit.gif");
										menuitem2.setDisabled(isSelf);
										menu.addContextMenuItem(menuitem2);
									}
														
								//���α�����û�  ��ʢ 2011-3-10
									if(isSecondUserByOrg){
										menu.addSeperate();
										Menu.ContextMenuItem menuitem7 = new Menu.ContextMenuItem();
										menuitem7.setName("Ȩ������");
										menuitem7.setLink("javascript:resGrant("+userId+")");
										menuitem7.setIcon("../../../sysmanager/images/tool-reply.gif");
										if(isRoleAdmin){//���ѡ�е��û���ӵ�г�������Ա��ɫ
											menuitem7.setDisabled(isRoleAdmin);
										}else{
											menuitem7.setDisabled(isSelf);
										}
										menu.addContextMenuItem(menuitem7);
										
										Menu.ContextMenuItem menuitem8 = new Menu.ContextMenuItem();
										menuitem8.setName("Ȩ�޻���");
										menuitem8.setLink("javascript:purviewReclaim("+userId+",'"+org_id+"')");
										menuitem8.setIcon("../../../sysmanager/images/icons/16x16/recycle.gif");
										menuitem8.setDisabled(isSelf);
										menu.addContextMenuItem(menuitem8);
										
										Menu.ContextMenuItem menuitem9 = new Menu.ContextMenuItem();
										menuitem9.setName("Ȩ�޸���");
										menuitem9.setLink("javascript:purviewCopy("+userId+")");
										menuitem9.setIcon("../../../sysmanager/images/tool-reply_all.gif");
										if(isRoleAdmin || isOrgManager){
											menuitem9.setDisabled(true);
										}else{
											menuitem9.setDisabled(isSelf);
										}
										menu.addContextMenuItem(menuitem9);
										menu.addSeperate();
										
										if(isJobOpen){
											Menu.ContextMenuItem menuitem3 = new Menu.ContextMenuItem();
											menuitem3.setName("�û���λ����");
											menuitem3.setLink("javascript:subJob("+userId+",'"+org_id+"')");
											menuitem3.setIcon("../../../sysmanager/images/tree_images/channel_closedFolder.gif");
											if(isRoleAdmin || isOrgManager){
												menuitem3.setDisabled(true);
											}else{
												menuitem3.setDisabled(isSelf);
											}
											menu.addContextMenuItem(menuitem3);
										}
										
										if(isUserOrgs && !isSecondUser){
											Menu.ContextMenuItem menuitem4 = new Menu.ContextMenuItem();
											menuitem4.setName("����������");
											menuitem4.setLink("javascript:subOrg("+userId+")");
											menuitem4.setIcon("../../../sysmanager/images/Groups.gif");
											menuitem4.setDisabled(isSelf);
											menu.addContextMenuItem(menuitem4);
										}
										
										Menu.ContextMenuItem menuitem6 = new Menu.ContextMenuItem();
										menuitem6.setName("��ɫ����");
										menuitem6.setLink("javascript:roleGrant("+userId+")");
										menuitem6.setIcon("../../../sysmanager/images/tool-forward16.gif");
										menuitem6.setDisabled(isSelf);
										menu.addContextMenuItem(menuitem6);
										
										if (isGroup){
											Menu.ContextMenuItem menuitem5 = new Menu.ContextMenuItem();
											menuitem5.setName("����������");
											menuitem5.setLink("javascript:subTeam("+userId+")");
											menuitem5.setIcon("../../../sysmanager/images/online-users.gif");
											menuitem5.setDisabled(isSelf);
											menu.addContextMenuItem(menuitem5);
										}
										//menu.addSeperate();
									}
								}
							}else if(!"1".equals(curUserId) && accesscontroler.isAdmin()){//�����ǰ��½�û�Ϊӵ�г�������Ա���û��Ҳ���admin
								//�ж��Ƿ���û����û���ɾ�Ĳ˵�����
							  	//minghua.guo[2010-12-13]
								if(!orguser_modify_forbidden && isMainOrg){
									Menu.ContextMenuItem menuitem2 = new Menu.ContextMenuItem();
									menuitem2.setName("������Ϣ�޸�");
									menuitem2.setLink("javascript:userInfoupdate("+userId+")");
									menuitem2.setIcon("../../images/edit.gif");
									if(isRoleAdmin){
										menuitem2.setDisabled(isRoleAdmin);
									}else{
										menuitem2.setDisabled(isSelf);
									}
									menu.addContextMenuItem(menuitem2);
								}
								
								menu.addSeperate();
								
								//���α�����û�  ��ʢ 2011-3-10
								if(isSecondUserByOrg){
								Menu.ContextMenuItem menuitem7 = new Menu.ContextMenuItem();
								menuitem7.setName("Ȩ������");
								menuitem7.setLink("javascript:resGrant("+userId+")");
								menuitem7.setIcon("../../../sysmanager/images/tool-reply.gif");
								if(isRoleAdmin){
									menuitem7.setDisabled(isRoleAdmin);
								}else{
									menuitem7.setDisabled(isSelf);
								}
								menu.addContextMenuItem(menuitem7);
								
								Menu.ContextMenuItem menuitem8 = new Menu.ContextMenuItem();
								menuitem8.setName("Ȩ�޻���");
								menuitem8.setLink("javascript:purviewReclaim("+userId+",'"+org_id+"')");
								menuitem8.setIcon("../../../sysmanager/images/icons/16x16/recycle.gif");
								if(isRoleAdmin){
									menuitem8.setDisabled(isRoleAdmin);
								}else{
									menuitem8.setDisabled(isSelf);
								}
								menu.addContextMenuItem(menuitem8);
								
								Menu.ContextMenuItem menuitem9 = new Menu.ContextMenuItem();
								menuitem9.setName("Ȩ�޸���");
								menuitem9.setLink("javascript:purviewCopy("+userId+")");
								menuitem9.setIcon("../../../sysmanager/images/tool-reply_all.gif");
								if(isRoleAdmin || isOrgManager){
									menuitem9.setDisabled(true);
								}else{
									menuitem9.setDisabled(isSelf);
								}
								menu.addContextMenuItem(menuitem9);
								menu.addSeperate();
								
								if(isJobOpen){
									Menu.ContextMenuItem menuitem3 = new Menu.ContextMenuItem();
									menuitem3.setName("�û���λ����");
									menuitem3.setLink("javascript:subJob("+userId+",'"+org_id+"')");
									menuitem3.setIcon("../../../sysmanager/images/tree_images/channel_closedFolder.gif");
									if(isRoleAdmin || isOrgManager){
										menuitem3.setDisabled(true);
									}else{
										menuitem3.setDisabled(isSelf);
									}
									menu.addContextMenuItem(menuitem3);
								}
								if(isUserOrgs && !isSecondUser){
									Menu.ContextMenuItem menuitem4 = new Menu.ContextMenuItem();
									menuitem4.setName("����������");
									menuitem4.setLink("javascript:subOrg("+userId+")");
									menuitem4.setIcon("../../../sysmanager/images/Groups.gif");
									if(isRoleAdmin){
										menuitem4.setDisabled(isRoleAdmin);
									}else{
										menuitem4.setDisabled(isSelf);
									}
									menu.addContextMenuItem(menuitem4);
								}
								
								Menu.ContextMenuItem menuitem6 = new Menu.ContextMenuItem();
								menuitem6.setName("��ɫ����");
								menuitem6.setLink("javascript:roleGrant("+userId+")");
								menuitem6.setIcon("../../../sysmanager/images/tool-forward16.gif");
								if(isRoleAdmin){
									menuitem6.setDisabled(isRoleAdmin);
								}else{
									menuitem6.setDisabled(isSelf);
								}
								menu.addContextMenuItem(menuitem6);
								
								if (isGroup){
									Menu.ContextMenuItem menuitem5 = new Menu.ContextMenuItem();
									menuitem5.setName("����������");
									menuitem5.setLink("javascript:subTeam("+userId+")");
									menuitem5.setIcon("../../../sysmanager/images/online-users.gif");
									if(isRoleAdmin){
										menuitem5.setDisabled(isRoleAdmin);
									}else{
										menuitem5.setDisabled(isSelf);
									}
									menu.addContextMenuItem(menuitem5);
								}
								}
							}else{//�����½�û�Ϊ���Ź���Աʱ
								boolean state = false;
								if(isSisterOrgManager || isRoleAdmin){
									state = true;
								}else{
									state = isSelf;
								}
								//�ж��Ƿ���û����û���ɾ�Ĳ˵�����
							  	//minghua.guo[2010-12-13]
								if(!orguser_modify_forbidden && isMainOrg){
								Menu.ContextMenuItem menuitem2 = new Menu.ContextMenuItem();
								menuitem2.setName("������Ϣ�޸�");
								menuitem2.setLink("javascript:userInfoupdate("+userId+")");
								menuitem2.setIcon("../../images/edit.gif");
								if(accesscontroler.checkPermission("orgunit","userupdate",AccessControl.ORGUNIT_RESOURCE)){
									menuitem2.setDisabled(state);
								}else{
									menuitem2.setDisabled(true);
								}
								menu.addContextMenuItem(menuitem2);
								}
								menu.addSeperate();
								
								//���α�����û�  ��ʢ 2011-3-10
								if(isSecondUserByOrg){
								boolean isPurset = accesscontroler.checkPermission("orgunit","purset",AccessControl.ORGUNIT_RESOURCE);
								Menu.ContextMenuItem menuitem7 = new Menu.ContextMenuItem();
								menuitem7.setName("Ȩ������");
								menuitem7.setLink("javascript:resGrant("+userId+")");
								menuitem7.setIcon("../../../sysmanager/images/tool-reply.gif");
								if(isPurset){
									menuitem7.setDisabled(state);	
								}else{
									menuitem7.setDisabled(true);
								}
								menu.addContextMenuItem(menuitem7);
								
								Menu.ContextMenuItem menuitem8 = new Menu.ContextMenuItem();
								menuitem8.setName("Ȩ�޻���");
								menuitem8.setLink("javascript:purviewReclaim("+userId+",'"+org_id+"')");
								menuitem8.setIcon("../../../sysmanager/images/icons/16x16/recycle.gif");
								if(isPurset){
									menuitem8.setDisabled(state);	
								}else{
									menuitem8.setDisabled(true);
								}
								menu.addContextMenuItem(menuitem8);
								
								Menu.ContextMenuItem menuitem9 = new Menu.ContextMenuItem();
								menuitem9.setName("Ȩ�޸���");
								menuitem9.setLink("javascript:purviewCopy("+userId+")");
								menuitem9.setIcon("../../../sysmanager/images/tool-reply_all.gif");
								if(isPurset && !isOrgManager){
									menuitem9.setDisabled(state);	
								}else{
									menuitem9.setDisabled(true);
								}
								menu.addContextMenuItem(menuitem9);
								menu.addSeperate();
								
								if(isJobOpen){
									Menu.ContextMenuItem menuitem3 = new Menu.ContextMenuItem();
									menuitem3.setName("�û���λ����");
									menuitem3.setLink("javascript:subJob("+userId+",'"+org_id+"')");
									menuitem3.setIcon("../../../sysmanager/images/tree_images/channel_closedFolder.gif");
									if(!isOrgManager){
										menuitem3.setDisabled(state);	
									}else{
										menuitem3.setDisabled(true);
									}
									menu.addContextMenuItem(menuitem3);
								}
								if(isUserOrgs && !isSecondUser){
									Menu.ContextMenuItem menuitem4 = new Menu.ContextMenuItem();
									menuitem4.setName("����������");
									menuitem4.setLink("javascript:subOrg("+userId+")");
									menuitem4.setIcon("../../../sysmanager/images/Groups.gif");
									menuitem4.setDisabled(isSelf);
									menu.addContextMenuItem(menuitem4);
								}
								
								Menu.ContextMenuItem menuitem6 = new Menu.ContextMenuItem();
								menuitem6.setName("��ɫ����");
								menuitem6.setLink("javascript:roleGrant("+userId+")");
								menuitem6.setIcon("../../../sysmanager/images/tool-forward16.gif");
								menuitem6.setDisabled(state);
								menu.addContextMenuItem(menuitem6);
								
								if (isGroup){
									Menu.ContextMenuItem menuitem5 = new Menu.ContextMenuItem();
									menuitem5.setName("����������");
									menuitem5.setLink("javascript:subTeam("+userId+")");
									menuitem5.setIcon("../../../sysmanager/images/online-users.gif");
									menuitem5.setDisabled(state);
									menu.addContextMenuItem(menuitem5);
								}
								
							}
							}
							menu.addSeperate();
							//ˢ��ҳ��
							Menu.ContextMenuItem menuitemsx = new Menu.ContextMenuItem();
							menuitemsx.setName("ˢ��");
							menuitemsx.setLink("javascript:usersx()");
							menuitemsx.setIcon("../../../sysmanager/images/dialog-reset.gif");
							menu.addContextMenuItem(menuitemsx);
							
							if(!isEgp){
							//�û��ɹ���Ļ����鿴����������
							Menu.ContextMenuItem menuitem_org = new Menu.ContextMenuItem();
							menuitem_org.setName("�ɹ�����");
							menuitem_org.setLink("javascript:userOrg("+userId+")");
							menuitem_org.setIcon("../../../sysmanager/images/rightMemu/doc_sh.gif");
							menu.addContextMenuItem(menuitem_org);
							
							//�û���Դ�б�
							Menu.ContextMenuItem menuitem1 = new Menu.ContextMenuItem();
							menuitem1.setName("Ȩ�޲�ѯ");
							menuitem1.setLink("javascript:userResList("+userId+")");
							menuitem1.setIcon("../../../sysmanager/images/listQuery.gif");
							menu.addContextMenuItem(menuitem1);
							
							Menu.ContextMenuItem menuitem91 = new Menu.ContextMenuItem();
							menuitem91.setName("�û���ʷ��ְ���");
							menuitem91.setLink("javascript:userHisJob("+userId+")");
							menuitem91.setIcon("../../../sysmanager/images/about.gif");
							menu.addContextMenuItem(menuitem91);
							}
							
							contextmenu.addContextMenu(menu);
							request.setAttribute("opuser",contextmenu);  
									
							//----------------------------Menu Add ----End--------------------------------------
						%>
						
			<!--  ----2007.10.16     chunqiu.zhao   ---------------->
								<%
								     //String backColor="";
								     //if (  )
								     //	backColor="bgcolor=#ff0000";
								     //}
								%>
							<%if(userId!=1){%>	
								<tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'" >
									<td class="tablecells" >
										<P align="left">
											<INPUT type="checkbox" name="checkBoxOne" onclick="checkOne('checkBoxAll','checkBoxOne')" value='<pg:cell colName="userId" defaultValue=""/>' >
										</P>
									</td>
									<td  class="tablecells"   >
										<pg:cell colName="userName" defaultValue="" />
									</td>									
									<td id="opuser_<%=userId%>" class="tablecells"  bgcolor="#F6FFEF" >
										<pg:cell colName="userRealname" defaultValue="" /><%=isRoleAdminOrOrgManager %>
									</td>
									<td  class="tablecells"   >
										<dict:itemname type="sex" expression="{userSex}" />
									</td>
									<td >
										<dict:itemname type="userType" expression="{userType}" />
									</td>
									<td class="tablecells"  > 
										<dict:itemname type="isvalid" expression="{user_isvalid}" />	
    								</td>
    								<% 
									if(istaxmanager){
									%>
    								<td  class="tablecells" >
										<pg:equal colName="istaxmanager" value="1">˰��Ա</pg:equal>
										<pg:equal colName="istaxmanager" value="0">��˰��Ա</pg:equal>
										<pg:equal colName="istaxmanager" value="">��˰��Ա</pg:equal>
									</td>
									<%} %>
									<td class="tablecells" >
										<pg:cell colName="org_Name" defaultValue="" />
									</td>	
								</tr>
							<%}else{%>
								<tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'" >
									<td class="tablecells" >
										<P align="left">
											<font color="#0000FF">
												<INPUT type="checkbox" name="checkBoxOne" onclick="checkOne('checkBoxAll','checkBoxOne')" value='<pg:cell colName="userId" defaultValue=""/>' >
											</font>
										</P>
									</td>
									<td  class="tablecells" >
										<font color="#0000FF"><pg:cell colName="userName" defaultValue="" /><%if(isOrgManager){%>(����Ա)<%}%></font>
									</td>
									<td id="opuser_<%=userId%>" class="tablecells"  bgcolor="#0066FF">
										<pg:cell colName="userRealname" defaultValue="" />
									</td>
									<td  class="tablecells"   >
										<font color="#0000FF"><dict:itemname type="sex" expression="{userSex}" /></font>
									</td>
									<td >
										<dict:itemname type="userType" expression="{userType}" />
									</td>	
									<td class="tablecells"  > 
										<font color="#0000FF"><dict:itemname type="isvalid" expression="{user_isvalid}" /></font> 	
    								</td>
    								<% 
									if(istaxmanager){
									%>
									<td  class="tablecells" >
										<pg:equal colName="istaxmanager" value="1"><font color="#0000FF">˰��Ա</font></pg:equal>
										<pg:equal colName="istaxmanager" value="0"><font color="#0000FF">��˰��Ա</font></pg:equal>
										<pg:equal colName="istaxmanager" value=""><font color="#0000FF">��˰��Ա</font></pg:equal>
									</td>
									<% 
									}
									%>
									<td class="tablecells" >
										<font color="#0000FF"><pg:cell colName="org_Name" defaultValue="" /></font>
									</td>	
								</tr>
							<%}%>
							</pg:list>

							<tr height="18px" class="labeltable_middle_tr_01">
								<td colspan=8 align='center' >
									��<pg:rowcount/>����¼ <pg:index />
								
								</td>								 
						    </tr>
							
							<input name="queryString" value="<pg:querystring/>" type="hidden">
														
							<pg:contextmenu enablecontextmenu="true" context="opuser" scope="request"/> 
						</pg:pager>

				  </table>
				  </div>
				</form>
				<form name="form2" method="POST"></form>
<script language="JavaScript">
	
	var thisUserId = "<%=currUserId.toString()%>";	
	var intervalType = "<%=intervalType%>";
	var taxmanager = "<%=taxmanager%>";
    
    var ops = document.all("intervalType");
    for(var i=0;ops != null && i<ops.options.length;i++){
        if(ops.options[i].value==intervalType) {
          ops.options[i].selected=true;
          break;
        }
    }
    var ops = document.all("taxmanager");
   
    for(var i=0;ops != null && i<ops.options.length;i++){
        if(ops.options[i].value==taxmanager) {
          ops.options[i].selected=true;
          break;
        }
    }
</script>
<iframe name="deluser" height="0" width="0"></iframe>
			</body>
</html>