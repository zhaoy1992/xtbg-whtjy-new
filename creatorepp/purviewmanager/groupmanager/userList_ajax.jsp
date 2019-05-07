<%
/*
 * <p>Title: 隶属用户处理的前台界面</p>
 * <p>Description: 隶属用户处理的前台界面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
 * @author liangbing.tao
 * @version 1.0
 */
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.GroupManager" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.Group,
				com.chinacreator.sysmgrcore.entity.User" %>
<%@ page import="java.util.List,
				java.util.ArrayList"%>
<%@ page import="com.chinacreator.security.AccessControl,
				com.chinacreator.sysmgrcore.manager.db.OrgManagerImpl"  %>				
<%@ page
	import="com.chinacreator.sysmgrcore.purviewmanager.usercheckorg.api.UserCheckOrgFactory"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>
<%
	AccessControl accesscontrol = AccessControl.getInstance();
    accesscontrol.checkManagerAccess(request,response);
    
    String curUserOrgId = accesscontrol.getChargeOrgId(); 
    OrgManagerImpl orgImpl = new OrgManagerImpl();
	String groupId = (String)request.getSession().getAttribute("curGroupId");
	String orgid = request.getParameter("orgId");
	GroupManager groupManager=SecurityDatabase.getGroupManager();
	List allUserList=groupManager.getUserList(groupId,orgid,null);
	Group group = groupManager.getGroupByID(groupId);
	UserManager userManager = SecurityDatabase.getUserManager();
	List existUser = null;
	
	// 权限是否关联机构
	// 彭盛 2011-3-15 
	boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);
	
	StringBuffer existUserSql = new StringBuffer();
	if(isrolerelatedorg){
		existUserSql.append("select * from td_sm_user a,td_sm_usergroup b where a.user_id=b.user_id and b.group_id=")
		.append(group.getGroupId()).append(" and b.org_id='")
		.append(orgid).append("'"); 
	}else{
		existUserSql.append("select * from td_sm_user a,td_sm_usergroup b where a.user_id=b.user_id and b.group_id=")
		.append(group.getGroupId()).append(" and a.user_id in(")
		.append("select user_id from td_sm_userjoborg where org_id='").append(orgid)
		.append("')"); 
	}
	//if(accesscontrol.isAdmin()){
	//	existUser = userManager.getUserList(group);
	//}else{
		existUser = userManager.getUserList(existUserSql.toString());
	//}
	List userList = null;
	if(accesscontrol.isAdmin()){
		//userList = allUserList;
		if(allUserList.size() > 0){
			User user = null;
			userList = new ArrayList();
			for(int i = 0; i < allUserList.size(); i++){
				user = (User)allUserList.get(i);
				String userIdI = String.valueOf(user.getUserId());
				//屏蔽被借调用户  彭盛 2011-3-10
				boolean isSecondUser = UserCheckOrgFactory.getIUserCheckOrgInstance().isSecondUserByOrgIDToMess(userIdI,orgid,null);
				if(!isSecondUser){
					userList.add(user);
				}
			}
		}
	}else{
		if(allUserList.size() > 0){
			User user = null;
			userList = new ArrayList();
			for(int i = 0; i < allUserList.size(); i++){
				user = (User)allUserList.get(i);
				String userIdI = String.valueOf(user.getUserId());
				boolean isCurOrgManager = orgImpl.isCurOrgManager(curUserOrgId,userIdI);
				boolean isAdmin = accesscontrol.isAdminByUserid(userIdI); 
				//屏蔽被借调用户  彭盛 2011-3-10
				boolean isSecondUser = UserCheckOrgFactory.getIUserCheckOrgInstance().isSecondUserByOrgIDToMess(userIdI,orgid,null);
				if(!isAdmin && !isCurOrgManager && !isSecondUser){
					userList.add(user);
				}
			}
		}
	}
	List existUserList = null;
	if(accesscontrol.isAdmin()){
		existUserList = existUser;
	}else{
		if(existUser.size() > 0){
			existUserList = new ArrayList();
			User user = null;
			for(int i = 0; i < existUser.size(); i++){
				user = (User)existUser.get(i);
				String userIdI = String.valueOf(user.getUserId());
				boolean isCurOrgManager = orgImpl.isCurOrgManager(curUserOrgId,userIdI);
				boolean isAdmin = accesscontrol.isAdminByUserid(userIdI); 
				if(!isAdmin && !isCurOrgManager){
					existUserList.add(user);
				}
			}
		}
	}
	request.setAttribute("existUser",existUserList);
	request.setAttribute("allUser",userList);
%>
<html>
	<head>
		<title>属性容器</title>
		<script language="javascript" src="<%=request.getContextPath()%>/include/dragdiv.js"></script>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/treeview.css">
		
		<script language="JavaScript">
  		var allowSubmit=false; 
		//添加选中的角色
		function addUser()
		{	
   			var selectUserIds="";
   			var selectedDrop=document.all("userIds");
   			var count=document.all("allist").options.length;
   			for(var i=0;i<count;i++)
   			{
   				//
   				var op=document.all("allist").options[i];
   				if(op.selected)
   				{
   					//	
					addone(op.text,op.value);
					//
					if(allowSubmit)selectUserIds+=","+op.value;
				}
   			}
   			if(selectUserIds.length>0)send_request(selectUserIds,'add');
		}
		//添加所有的角色
		function addall()
		{
    		var selectUserIds="";
			var count=document.all("allist").options.length;	  
    		for(var i=0;i<count;i++)
    		{
     			var op=document.all("allist").options[i];
     			addone(op.text,op.value);  
     			if(allowSubmit)selectUserIds+=","+op.value;
    		}
   			if(selectUserIds.length>0)send_request(selectUserIds,'add');
		}
		//将列表框中的选项进行追加
		function addone(name,value)
		{
   			allowSubmit=true;
   			for(var i=0;i<document.all("userIds").options.length;i++)
  			{
	 			if(value==document.all("userIds").options[i].value)
	 			{
	 				allowSubmit=false;
	 				break;
	 			}
  			}
   			if(allowSubmit)document.all("userIds").add(new Option(name,value));
		}
		//删除选中的角色
		function deleteUser()
		{
    		var selectUserIds="";
 			for(var m=document.all("userIds").options.length-1;m>=0;m--)
 			{
	    		if(document.all("userIds").options[m].selected)
	    		{
	    			selectUserIds+=","+document.all("userIds").options[m].value;
	    			document.all("userIds").options.remove(m);
	    		}
			}
			if(selectUserIds.length>0)send_request(selectUserIds,'delete');
		}
		//删除所有的角色
		function deleteall()
		{
    		var selectUserIds="";
    		var count=document.all("userIds").options.length;
			for (var m=0;m<count;m++)
			{
	    		selectUserIds+=","+document.all("userIds").options[m].value;
			}
			if(selectUserIds.length>0)
			{
				document.all("userIds").innerHTML="";
    			send_request(selectUserIds,'delete');
   			}	
		}
		//将参数提交至隐藏帧进行处理
		function send_request(selectUserIds,flag)
		{
    		selectUserIds=selectUserIds.substring(1,selectUserIds.length);
			document.all.divProcessing.style.display = "block";
			
			document.all("button1").disabled = true; 
			document.all("button2").disabled = true;
			document.all("button3").disabled = true;
			document.all("button4").disabled = true;
			document.all("back").disabled = true;
			
			
			document.OrgJobForm.action = 'editgroupuser.jsp?userId='+selectUserIds+'&&groupId='+<%=groupId%>+'&&flag='+flag+'&&orgId=<%=orgid%>';
			document.OrgJobForm.target = "hiddenFrame";
			document.OrgJobForm.submit();
		}
		</script>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" onload="loadDragDiv()">
		<div id="contentborder" align="center">
			<center>
				<form name="OrgJobForm" action="" method="post">
					<table width="80%" border="0" cellpadding="0" cellspacing="1" class="table">
						<tr class="tabletop">
						    <td width="40%" align="center">&nbsp;</td>
						    <td width="20%" align="center">&nbsp;</td>
						    <td width="40%" align="center">&nbsp;</td>
						  </tr>
						<tr class="tr">
							<td class="td" width="40%" align="center">
								可选用户
							</td>
							<td width="20%" class="td" align="center">
								&nbsp;
							</td>
							<td width="40%" align="center" class="td">
								已授予用户
							</td>
						</tr>
						<tr class="tabletop">
						    <td width="40%" align="center">&nbsp;</td>
						    <td width="20%" align="center">&nbsp;</td>
						    <td width="40%" align="center">&nbsp;</td>
						  </tr>
						<tr class="tr">
							<td class="td" align="right"><div class="win" id="dd_1" align="left">
								<select class="select" name="allist" multiple style="width:98%" onDBLclick="addUser()" size="18">
									<pg:list requestKey="allUser" needClear="false">
										<option value="<pg:cell colName="userId"/>">
											<pg:cell colName="userRealname" />(<pg:cell colName="userName" />)
										</option>
									</pg:list>
								</select></div>
							</td>

							<td align="center" class="td">
								<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr class="tr">
										<td align="center" class="td">
											<input name="button1" type="button" class="input" value="&gt;" onclick="addUser()">
										</td>
									</tr>
									<tr class="tr">
										<td align="center" class="td">
											&nbsp;
										</td>
									</tr>
									<tr class="tr">
										<td align="center" class="td">
											<input name="button2" type="button" class="input" value="&gt;&gt;" onclick="addall()">
										</td>
									</tr>
									<tr class="tr">
										<td align="center" class="td">
											&nbsp;
										</td>
									</tr>
									<tr class="tr">
										<td align="center" class="td">
											<input name="button3" type="button" class="input" value="&lt;&lt;" onclick="deleteall()">
										</td>
									</tr>
									<tr class="tr">
										<td align="center" class="td">
											&nbsp;
										</td>
									</tr>
									<tr class="tr">
										<td align="center" class="td">
											<input name="button4" type="button" class="input" value="&lt;" onclick="deleteUser()">
										</td>
									</tr>
									<tr class="tr">
										<td align="center" class="td">
											&nbsp;
										</td>
									</tr>
								</table>
							</td>
							<td class="td"><div class="win" id="dd_2" align="left">
								<select class="select" name="userIds" multiple style="width:98%" onDBLclick="deleteUser()" size="18">
									<pg:list requestKey="existUser" needClear="false">
										<option value="<pg:cell colName="userId"/>">
											<pg:cell colName="userRealname" />(<pg:cell colName="userName" />)
										</option>
									</pg:list>
								</select></div>
							</td>
						</tr>						
					</table>
					<input type="hidden" name="orgId" value="<%=orgid%>" />
					<div align="center">
						<br/>
						<br/>
						<input type="button" class="input" name="back" value="返回" onclick="window.close()"/>
					</div>
				</form>
			</center>
		</div>
		<div id=divProcessing style="width:200px;height:30px;position:absolute;left:150px;top:450px;display:none">
			<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%">
			    <tr>
				    <td bgcolor=#3A6EA5>
					    <marquee align="middle" behavior="alternate" scrollamount="5">
						    <font color=#FFFFFF>...处理中...请等待...</font>
						</marquee>
					</td>
				</tr>
			</table>
		</div>
	</body>
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</html>
