
<%@page import="com.chinacreator.sysmgrcore.manager.RoleTypeManager"%><%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase,com.chinacreator.config.*" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.Role" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.User" %>
<%@ page import="com.chinacreator.security.AccessControl" %>
<%@ page import="java.util.*
				,com.chinacreator.sysmgrcore.web.struts.form.UserRoleManagerForm
				,com.chinacreator.sysmgrcore.manager.GroupManager
				,com.chinacreator.sysmgrcore.manager.OrgManager
				,com.chinacreator.sysmgrcore.entity.Organization
				,com.chinacreator.sysmgrcore.entity.Group" %>
<%
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkManagerAccess(request,response);
	
	String uid2 = request.getParameter("userId");
	String uid = request.getParameter("userId");
	request.setAttribute("userId", uid2);
	String orgId = request.getParameter("orgId");
	request.setAttribute("orgId", orgId);

	String orgid = request.getParameter("orgId");
	UserRoleManagerForm userRoleForm = new UserRoleManagerForm();
	userRoleForm.setOrgId(orgid);
	userRoleForm.setUserId(uid.toString());
	RoleManager roleManager = SecurityDatabase.getRoleManager();
	UserManager userManager = SecurityDatabase.getUserManager();
	User user = userManager.getUserById(uid);
	List existRole = new ArrayList();
	// 权限是否关联机构
	// 彭盛 2011-3-15 
	boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);
	if(isrolerelatedorg){ 
		existRole = roleManager.getRoleListByUserRole(uid,orgId);
	}else{
		existRole = roleManager.getRoleListByUserRole(user);
	}
	
	//角色类别Map
	Map roleTypeMap = new RoleTypeManager().getRoleTypeMap();
	
	String sql = "";
	if ("1".equals(accessControl.getUserID())) {
		sql = "select * from td_sm_role t where t.role_id not in('2','3','4') order by t.role_type,t.role_name";
	} else {
		sql = "select * from td_sm_role t where t.role_id not in('1','2','3','4') order by t.role_type,t.role_name";
	}	
	List list = roleManager.getRoleList(sql);
	List allRole = null;
	
	// 角色列表加权限
	for (int i = 0; list != null && i < list.size(); i++) {
		Role role = (Role) list.get(i);
		if (accessControl.checkPermission(role.getRoleId(), "roleset",
		AccessControl.ROLE_RESOURCE)) {
			if (allRole == null){
				allRole = new ArrayList();
			}
			if (AccessControl.isAdministratorRole(role.getRoleName())) {
				allRole.add(role);
			}else{
				if (!role.getRoleName().equals(
						AccessControl.getEveryonegrantedRoleName())) {
					allRole.add(role);
				}
			}
		}
	}
	//System.out.println("allRole = " + allRole.size());
	
	//得到用户所属组得到用户所属角色
	GroupManager groupManager = SecurityDatabase.getGroupManager();
	OrgManager orgManager = SecurityDatabase.getOrgManager();
	List groupList = groupManager.getGroupList(user);
	List orgList = orgManager.getOrgList(user);

	//得到用户岗位对应的角色
	List jobRole = roleManager.getJobRoleByList(uid2);
	if (ConfigManager.getInstance().getConfigBooleanValue(
			"enableorgrole", true)) {
		Set userOrgRole = new HashSet();
		for (int i = 0; orgList != null && i < orgList.size(); i++) {
			Organization org = (Organization) orgList.get(i);
			List role = roleManager.getRoleList(org);
			if(role != null && role.size() > 0){
				userOrgRole.addAll(role);
			}
		}
		request.setAttribute("orgRole", new ArrayList(userOrgRole));
	}
	
	if (ConfigManager.getInstance().getConfigBooleanValue(
			"enablergrouprole", true)) {
		Set userGroupRole = new HashSet();
		for (int i = 0; groupList != null && i < groupList.size(); i++) {
			Group group = (Group) groupList.get(i);
			List role = roleManager.getRoleList(group);
			if(role != null && role.size() > 0){
				userGroupRole.addAll(role);
			}
		}
		request.setAttribute("groupRole", new ArrayList(userGroupRole));
	}
	request.setAttribute("allRole", allRole);
	request.setAttribute("existRole", existRole);
	request.setAttribute("userRoleForm", userRoleForm);
	request.setAttribute("jobRole", jobRole);
	
	String userName = user.getUserRealname();
	String currentlyUserId = accessControl.getUserID();
	
	//用户有权限的角色ID--gao.tang 2008.01.28
	List list1 = new ArrayList();
	//list1 = (List) request.getAttribute("allRole");
	list1 = allRole;
	String popedomRoleIds = "";
	Role popedomRole = new Role();
	if(list1 != null)
	{
		for (int i = 0; i < list1.size(); i++) {
			popedomRole = (Role) list1.get(i);
			if ("".equals(popedomRoleIds)) {
				popedomRoleIds = popedomRole.getRoleId();
			} else {
				popedomRoleIds += "," + popedomRole.getRoleId();
			}
		}
	}

%>
<html>
<head>    
<title>用户【<%=userName%>】角色授予</title>
<!--script language="JavaScript" src="../scripts/ajax.js" type="text/javascript"></script-->  
<script language="JavaScript" src="../../../include/querySelect.js" type="text/javascript"></script>
<SCRIPT LANGUAGE="JavaScript"> 
function send_request(url){
	document.all.divProcessing.style.display = "block";
	document.OrgJobForm.action = url;
	document.OrgJobForm.target = "hiddenFrame";
	document.OrgJobForm.submit();
}
function addone(name,value,n){
   for(var i=n;i>=0;i--){
		if(value==document.all("roleId").options[i].value){
		  return;
		}
	}
   var op=new Option(name,value);
   document.all("roleId").add(op);   
}
function addRole(flag){	
	if(document.all("allist").length==0){
		alert("没有角色！");
		return false;
	}
	if(flag == 1){
	      var n=document.all("roleId").options.length-1;
	      var orgId = document.all("orgId").value;
	      var roleIds = "";	   	 	
	      for(var i=0;i<document.all("allist").options.length;i++){
	          var op=document.all("allist").options[i];
	          if(op.selected){
	              addone(op.text,op.value,n);
	              if(roleIds=="") roleIds = roleIds + op.value;
	              else roleIds = roleIds + "," + op.value;
	          }
	      }	  	       
	      if(roleIds!=""){
    	      send_request('saveUserRole.jsp?userId=<%=uid%>&orgId='+orgId+'&roleId='+roleIds+'&op=add');
    	  }else{
    	  	  alert("请选择要设置的角色！");
    	  	  return false;
    	  }    
	  }else{
   		alert("对不起，您没有权限，请联系系统管理员");   		
   	  } 
   	  
}
function addall(flag){
	if(document.all("allist").length==0){
		alert("没有角色！");
		return false;
	}
	if(flag == 1){
		var n=document.all("roleId").options.length-1;
		var p=document.all("allist").options.length-1;		
		var roleIds = "";	 
		var orgId = document.all("orgId").value;  	   
	    for(var i=0;i<document.all("allist").options.length;i++){
	        var op=document.all("allist").options[i];
	        addone(op.text,op.value,n);  
	        if(roleIds=="") roleIds = roleIds + op.value;
	        else roleIds = roleIds + "," + op.value;
	   } 
	   if(roleIds!="")
    	   send_request('saveUserRole.jsp?userId=<%=uid%>&orgId='+orgId+'&roleId='+roleIds+'&op=add'); 
    }
    else{
   		alert("对不起，您没有权限，请联系系统管理员");   		
   	}
}

function deleterole(flag){
	if(document.all("roleId").length==0){
		alert("没有角色！");
		return false;
	}
	if(flag == 1){
	    var roleIds = "";	 
	    var orgId = document.all("orgId").value;
	    
		for (var m=document.all("roleId").options.length-1;m>=0;m--){
		    if(document.all("roleId").options[m].selected){
		        var op = document.all("roleId").options[m];
			    if(op.value=="3"){
		    		alert("部门管理员角色"+op.text+"不能删除！");
		    		return;
		    	}
		    	if(op.value=="4"){
		    		alert("部门管理员角色模板角色"+op.text+"不能删除！");
		    		return;
		    	}
		    	if(op.value=="1" && "<%=uid%>"=="1"){
		    		alert("系统管理员角色"+op.text+"不能删除！");
		    		return;
		    	}
		    	if("<%=uid%>"=="<%=currentlyUserId%>" && "<%=uid%>" != "1"){
		    		alert("警告：不能删除自己的角色！");
		    		return;
		    	}
	            if(roleIds=="") roleIds = roleIds + op.value;
	            else roleIds = roleIds + "," + op.value;
	            //document.all("roleId").options[m]=null;
	        }
	 	}
	    if(roleIds!=""){
    	   send_request('saveUserRole.jsp?userId=<%=uid%>&orgId='+orgId+'&roleId='+roleIds+'&op=delete');
    	}else{
    		alert("请选则要删除的角色！");
    		return false;
    	}     
   	}
   	else{
   		alert("对不起，您没有权限，请联系系统管理员");   		
   	}
}
function deleteall(flag){
	if(document.all("roleId").length==0){
		alert("没有角色！");
		return false;
	}
	if(flag == 1){
	    var roleIds = "";
	    var orgId = document.all("orgId").value;	
	    
		for (var m=document.all("roleId").options.length-1;m>=0;m--){
		    var op = document.all("roleId").options[m];
		    if(op.value=="3"){
	    		alert("部门管理员角色"+op.text+"不能删除！");
	    		return;
	    	}
	    	if(op.value=="1" && "<%=uid%>"=="1"){
		    	alert("系统管理员角色"+op.text+"不能删除！");
		    	return;
		    }
		    if("<%=uid%>"=="<%=currentlyUserId%>" && "<%=uid%>" != "1"){
	    		alert("警告：不能删除自己的角色！");
	    		return;
	    	}
		    if(roleIds=="") roleIds = roleIds + op.value;
	        else roleIds = roleIds + "," + op.value;
	        //document.all("roleId").options[m]=null;
	    }
	    if(roleIds!="")
    	   send_request('saveUserRole.jsp?userId=<%=uid%>&orgId='+orgId+'&roleId='+roleIds+'&op=delete');
	}else{
   		alert("对不起，您没有权限，请联系系统管理员");   		
   	}
   	
}

function changebox(){				 
	var len=document.all("roleId").options.length;			  	 	
    var roleId=new Array(len);
    var orgId = document.all("orgId").value;
    for (var i=0;i<len;i++){	      
        roleId[i]=document.all("roleId").options[i].value;
    }           		
	
}

function roleChangebox(){
	var tablesFrame= document.getElementsByName("orgjoblist");
	//var roleIdValue = document.all.jobrolelist.value;
	var roleIdValue = document.all("jobrolelist").value;
	tablesFrame[0].src = "org_job.jsp?userId=<%=uid%>&roleId=" + roleIdValue;
}

//关闭窗口 gao.tang 2007.11.16
function closed(){
	parent.window.close();
	parent.window.returnValue="ok";
}

function window.onhelp(){  
  //selectRole();
  return false;
}

function selectRole(){
	var url = "selectRoletree.jsp";
	var selectValue = "";
	selectValue = window.showModalDialog(url,window,"dialogWidth:"+(600)+"px;dialogHeight:"+(400)+"px;scroll=yes;status=no;titlebar=no;toolbar=no;maximize=yes;minimize=0;")
	if(selectValue != ""){
		document.all("selectRoles").value = selectValue;
	}
}
</SCRIPT>
<script language="javascript" src="../../scripts/dragdiv.js"></script>
</head>
<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../../css/windows.css">
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="yes" onload="loadDragDiv()" onunload="window.returnValue='ok';" >
<center>
<form name="OrgJobForm" target="hiddenFrame" action="" method="post" >
<input name="userId" value="<%=uid%>" type="hidden">
<input name="popedomRoleIds" value="<%=popedomRoleIds%>" type="hidden">


<table width="80%" border="0" cellpadding="0" cellspacing="1">

<tr class="tabletop">
    <td width="40%" align="center">&nbsp;</td>
    <td width="20%" align="center">&nbsp;</td>
    <td width="40%" align="center">&nbsp;</td>
  </tr>
  <%
  	//RoleManager roleManager = SecurityDatabase.getRoleManager();
  	String everyoneRolename = AccessControl
  			.getEveryonegrantedRoleName();
  	Role role = roleManager.getRoleByName(everyoneRolename);
  	if (role != null) {
  %>
  <tr class="tabletop" cols="3">
    <td colspan="3"><font color="red">
	提示：用户默认授予（<%=everyoneRolename%>）角色</font></td>
  </tr>
  <tr class="tabletop">
    <td width="40%" align="center">&nbsp;</td>
    <td width="20%" align="center">&nbsp;</td>
    <td width="40%" align="center">&nbsp;</td>
  </tr>
  <%
  }
  %>
  <tr class="tabletop">
    <td width="40%" align="left">可选角色</td>
    <td width="20%" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td width="40%" align="right">用户<%=user.getUserRealname()%>(<%=user.getUserName()%>)已授予角色</td>
  </tr>
  
  <tr>
  	<td width="40%" align="left">
  		<input name="selectRoles" type="text" value="" onkeydown="enterKeydowngo()" onpropertychange="onBlurryQueryChange()" ondblclick=""  />
  		<input name="que" type="button" value="查询" onclick="blurryQuary()" class="input" />
  		<input name="nextQue" style="display:none" type="button" value="查找下一个" onclick="nextQuery()" class="input" />
  	</td>
    <td width="20%" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td width="40%" align="left">
    	
    </td>
  </tr>
  
  <tr >
     <td  align="left" >
     <div class="win" id="dd_1" align="left" title="下拉选择框的右边边框可以左右拖动" >
     <select name="allist"  multiple style="width:98%" onDBLclick="addRole(1)" size="15" title="下拉选择框的右边边框可以左右拖动">
		  <pg:list requestKey="allRole">
		  <% 
		  	String roleType = dataSet.getString("roleType");
		  %>
			<option value="<pg:cell colName="roleId"/>" rolename="<pg:cell colName="roleName"/>"><pg:cell colName="roleName"/> (<%=roleTypeMap.get(roleType) %>)</option>
		  </pg:list>			
	</select>
	</div>
	</td>				  
		  	
    <td align="center">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="center"><input name="button1" type="button" class="input" value="&gt;" onclick="addRole(1)"> </td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
      </tr>
      <tr>
        <td align="center"><input name="button2" type="button" class="input" value="&gt;&gt;" onclick="addall(1)"> </td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
      </tr>
      <tr>
        <td align="center"><input name="button3" type="button" class="input" value="&lt;&lt;" onclick="deleteall(1)"> </td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
      </tr>
      <tr>
        <td align="center"><input name="button4" type="button" class="input" value="&lt;" onclick="deleterole(1)"> </td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
      </tr>
    </table>
    </td>
    <td align="right">
    <div class="win" id="dd_2" align="center" title="下拉选择框的右边边框可以左右拖动">
     <select name="roleId"  multiple style="width:98%" onDBLclick="deleterole(1)" size="15" title="下拉选择框的右边边框可以左右拖动">
				  <pg:list requestKey="existRole">
				  <% 
				  	String roleType = dataSet.getString("roleType");
				  %>
					<option value="<pg:cell colName="roleId"/>"><pg:cell colName="roleName"/> (<%=roleTypeMap.get(roleType) %>)</option>			
				  </pg:list>			
	 </select>
	 </div>					
	</td>				 
				  
  </tr>
  
  <tr class="tabletop">
    <td width="40%" align="left">&nbsp;</td>
    <td width="20%" align="center">&nbsp;</td>
    <td width="40%" align="right">&nbsp;</td>
  </tr>
 
  <tr class="tabletop" >
  
    <td width="40%" align="center"> 
    <%
     			if (ConfigManager.getInstance().getConfigBooleanValue(
     			"enableorgrole", true)) {
     %>机构已授予该用户角色<%
     }
     %></td>
  
    <td width="20%" align="center">&nbsp;</td>
    
    <td width="40%" align="center"> 
    <%
     			if (ConfigManager.getInstance().getConfigBooleanValue(
     			"enablergrouprole", true)) {
     %>用户组已授予该用户角色<%
     }
     %></td>
    
  </tr>
  <tr >
     <td  align="left" >
     <%
     if (ConfigManager.getInstance().getConfigBooleanValue(
     			"enableorgrole", true)) {
     %>
     <div class="win" id="dd_3"  align="left" title="下拉选择框的右边边框可以左右拖动">
     <select name="orgrolelist"  multiple style="width:98%" size="15" disabled="true" title="下拉选择框的右边边框可以左右拖动">   
				  <pg:list requestKey="orgRole">
					<option value="<pg:cell colName="roleId"/>"><pg:cell colName="roleName"/></option>
				  </pg:list>			
	</select>
	</div>
	<%
	}
	%>
	</td>		
	<td align="center">&nbsp;</td>
	 <td  align="right" >
	 <%
	 if (ConfigManager.getInstance().getConfigBooleanValue(
	 			"enablergrouprole", true)) {
	 %>
	 <div class="win" id="dd_4" align="left" title="下拉选择框的右边边框可以左右拖动">
     <select name="grouprolelist"  multiple style="width:98%" size="15" disabled="true" title="下拉选择框的右边边框可以左右拖动">   
				  <pg:list requestKey="groupRole">
					<option value="<pg:cell colName="roleId"/>"><pg:cell colName="roleName"/></option>
				  </pg:list>			
	</select>
	</div>
	<%
	}
	%>
	</td>
 </tr>
 <%
 	if (ConfigManager.getInstance().getConfigBooleanValue(
 			"enablejobfunction", false)) {
 %>	
 <tr class="tabletop">
    <td width="40%" align="center">&nbsp;</td>
    <td width="20%" align="center">&nbsp;</td>
    <td width="40%" align="center">&nbsp;</td>
  </tr>
 <tr>
 	<td align="left">用户岗位对应的角色</td>
 	<td align="center">-----------------></td>
 	<td align="right">用户岗位角色所隶属的<font color="#CC9900">机构</font>-<font color="#996600">岗位</font></td>
 </tr>
 <tr>
 <td align="left"><div class="win" id="dd_5" align="left" title="下拉选择框的右边边框可以左右拖动">
	<select name="jobrolelist" multiple style="width:98%" size="15" onchange="roleChangebox()" title="下拉选择框的右边边框可以左右拖动">
				  <pg:list requestKey="jobRole">
				  	<option value="<pg:cell colName="roleId"/>"><pg:cell colName="roleName"/></option>
				  </pg:list>
	</select></div>
 </td>
 <td>&nbsp;</td>
 <td align="right">
 	<div class="win" id="dd_6" align="left" title="下拉选择框的右边边框可以左右拖动">
 	<select name="userjobList" multiple style="width:98%" size="15" title="下拉选择框的右边边框可以左右拖动">
		
	</select>
	</div>
 </td>
 </tr>
 <%
 }
 %>
 <tr>
 	<td align="center" colspan="4">
 		<input name="but4" type="button" class="input" value="关闭" onclick="closed();"/>
 	</td>
 </tr>
  
</table>
<pg:beaninfo requestKey="userRoleForm">
<input type="hidden"  name="orgId" value="<pg:cell colName="orgId"  defaultValue=""/>"/>
<input type="hidden"  name="uid" value="<pg:cell colName="userId"  defaultValue=""/>"/>
</pg:beaninfo>
</form>
</center>
</div>
<div id=divProcessing style="width:200px;height:25px;position:absolute;left:245px;top:298px;display:none">
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
<iframe name="orgjoblist" src="org_job.jsp?" width=0 height=0></iframe>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</html>

