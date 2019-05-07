<%
/*
 * <p>Title: 角色授予用户组的显示处理页面</p>
 * <p>Description: 角色授予用户组的显示处理页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-25
 * @author liangbing.tao
 * @version 1.0
 */
%>


<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleManager" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.GroupManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.Role" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.Group" %>
<%@ page import="java.util.List,
				java.util.ArrayList" %>
<%@ page import="com.chinacreator.security.AccessControl"%>


<%
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkManagerAccess(request,response);
	
	String curUserId = accessControl.getUserID(); 
	
	String roleId = request.getParameter("roleId");
	String groupId = request.getParameter("groupId");
	
	
	RoleManager roleManager = SecurityDatabase.getRoleManager();
	Role role = roleManager.getRoleById(roleId);
	
	String roleName = role.getRoleName();
	
	GroupManager groupManager = SecurityDatabase.getGroupManager();
	Group group = groupManager.getGroupByID(groupId);
	
	List allGroup;
	List existGroup;
	if (groupManager.isContainChildGroup(group)) 
	{
		allGroup = groupManager
				.getGroupList("select * from td_sm_Group o where o.PARENT_ID="
						+ groupId + " or o.GROUP_ID=" + groupId + "");
		existGroup = groupManager
							.getGroupList("select * from td_sm_group o,td_sm_grouprole b where (o.PARENT_ID="
									+ groupId + " or o.GROUP_ID=" + groupId + ") and o.group_id=b.group_id"
									+ " and b.role_id='"+roleId+"'");				
	}
	else
	{
		allGroup = groupManager
				.getGroupList("select * from td_sm_Group o where o.GROUP_ID="
						+ groupId + "");
		existGroup = groupManager
							.getGroupList("select * from td_sm_group o,td_sm_grouprole b where o.GROUP_ID="
									+ groupId + " and o.group_id=b.group_id and b.role_id='"+roleId+"'");					
	}
	
	//List existGroup = groupManager.getGroupList(role);
	List usergroupsetGroup = null;
	if(allGroup.size() > 0){
		usergroupsetGroup = new ArrayList();
		for(int i = 0; i < allGroup.size(); i++){
			Group setGroup = (Group)allGroup.get(i);
			String groupIdSelf = String.valueOf(setGroup.getGroupId()); 
			//if(accessControl.checkPermission(groupIdSelf,"usergroupset",AccessControl.GROUP_RESOURCE)
			//	|| curUserId.equals(String.valueOf(setGroup.getOwner_id()))){
			if(curUserId.equals(String.valueOf(setGroup.getOwner_id()))){//自己创建的组才能设置给角色
				usergroupsetGroup.add(setGroup);
			}
		}
	}
	if(accessControl.isAdmin()){
		request.setAttribute("allGroup", allGroup);
	}else{
		request.setAttribute("allGroup", usergroupsetGroup);
	}
	request.setAttribute("existGroup", existGroup);
			
%>
<html>
<head>    
  <title>属性容器</title>
   <link rel="stylesheet" type="text/css" href="../css/windows.css">
	<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
	<SCRIPT LANGUAGE="JavaScript"> 
	function addGroup()
	{	
	   var n=document.all("groupId").options.length-1;
	   
	    var selectgroups = "";
	    
	    if(document.all("allist").options.length < 1)
	    {
	    	alert("没有要添加的用户组！");
	    	return;
	    }
	    
	    for(var i=0;i<document.all("allist").options.length;i++)
	    {
		   var op=document.all("allist").options[i];
		   if(op.selected)
		   {	
		    	var retvalue =addone(op.text,op.value,n);
		    	if(retvalue)
		    	{
		    		if(selectgroups == "" )
		    		{
			    		selectgroups  += retvalue;
			    	}
			    	else
			    	{
			    		selectgroups  +="," + retvalue;
			    	}
			    		
		    	}
		    	else
		    	{
		    		alert("已授予的用户组！");
		    		return;
		    	}	
		   }
	   
	  }
	  if(selectgroups != "")
	  {
	  	send_request('savaRoleGroup.jsp?roleId='+<%=roleId%>+'&groupId='+selectgroups+'&tag=add');
	  }
	  else
	  {
	  	alert("请选择要添加的用户组！");
	  }		  
	}
	
	function addone(name,value,n)
	{
	   for(var i=n;i>=0;i--)
	   {
			if(value==document.all("groupId").options[i].value)
			{
			  return;
			}
		}
	   var op=new Option(name,value);
	   document.all("groupId").add(op);
	   return value;	   
	}
	
	function deleteall()
	{
		var leftLen = document.all("allist").length;
		var selectgroups= "";
		if(document.all("groupId").options.length < 1){
	    	alert("没有要删除的用户组！");
	    	return;
	    }
	    var infos = "";
		for (var m=document.all("groupId").options.length-1;m>=0;m--)
		{
			var flag1 = false;
			var retvalue = document.all("groupId").options[m].value ;
			var optionText = document.all("groupId").options[m].text;
			for(var i = 0; i < leftLen; i++){
				if(retvalue==document.all("allist").options[i].value){
					if(selectgroups== "" ){
			    		selectgroups  += retvalue;
			    	}else{
			    		selectgroups  += "," + retvalue;
			    	}
					document.all("groupId").options[m]=null;
					flag1 = true;
				}
			}
			if(!flag1){
				if(infos!=""){
					infos += "\n" + optionText; 
				}else{
					infos = optionText;
				}
			}
		}
		if(selectgroups != ""){
			send_request('savaRoleGroup.jsp?roleId='+<%=roleId%>+'&groupId='+selectgroups+'&tag=delete');
		}else{
			if(infos!=""){
				alert("对以下用户组没有权限：\n"+infos);
				return false;
			}else{
				alert("请选择要删除的用户组！");
				return false;
			}
		}
	}
	
	
	function addall()
	{
		var n=document.all("groupId").options.length-1;
		
		if(document.all("allist").options.length < 1)
		{
	    	alert("没有要添加的用户组！");
	    	return;
	    }
	    var selectgroups = "";
	    
	    for(var i=0;i<document.all("allist").options.length;i++)
	     {     
		     var op=document.all("allist").options[i];
		     
		     var retvalue = addone(op.text,op.value,n); 
		    if(retvalue)
	    	{
	    		if(selectgroups == "" )
	    		{
		    		selectgroups  += retvalue;
		    	}
		    	else
		    	{
		    		selectgroups  +="," + retvalue;
		    	}	
	    	}
	    	 
		}
		
		if(selectgroups != "")
		{
			send_request('savaRoleGroup.jsp?roleId='+<%=roleId%>+'&groupId='+selectgroups+'&tag=add');
		}
	   
	}
	
	function deleteGroup()
	{
		var leftLen = document.all("allist").length;
		var selectgroups = "";
		if(document.all("groupId").options.length < 1){
	    	alert("没有要删除的用户组！");
	    	return;
	    }
	    var infos = "";
		for (var m=document.all("groupId").options.length-1;m>=0;m--){
			var flag1 = false;		 	
    		if(document.all("groupId").options[m].selected){
   				var retvalue = document.all("groupId").options[m].value;
				var optionText = document.all("groupId").options[m].text;
				for(var i = 0; i < leftLen; i++){
					if(retvalue==document.all("allist").options[i].value){
		  				if(selectgroups == "" ){
		  					selectgroups  += retvalue;
		  				}else{
		  					selectgroups  += "," + retvalue;
		  				}
		  				document.all("groupId").options[m]=null;
		  				flag1 = true;
		  			}
  				}
  				if(!flag1){
  					if(infos!=""){
  						infos += "\n" + optionText;
  					}else{
  						infos = optionText;
  					}
  				}
     		}
		}
		  
		if(selectgroups != ""){
		  	send_request('savaRoleGroup.jsp?roleId='+<%=roleId%>+'&groupId='+selectgroups+'&tag=delete');
		}else{
			if(infos!=""){
				alert("对以下用户组没有权限：\n"+infos);
				return false;
			}else{
		  		alert("请选择要删除的用户组！");
		  	}
		}
	      
	}
					
	function send_request(url)
	{
		document.all.divProcessing.style.display = "block";
		
		document.all("button1").disabled = true;
		document.all("button2").disabled = true;
		document.all("button3").disabled = true;
		document.all("button4").disabled = true;
		
		document.all("back").disabled = true;
		
		document.all.RoleGroupForm.action = url;
		document.all.RoleGroupForm.target = "hiddenFrame";
		document.all.RoleGroupForm.submit();
	}	
	</SCRIPT>
 </head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
	<div id="contentborder">
		<center>
			<form name="RoleGroupForm"  method="post" >
				<table width="80%" border="0" cellpadding="0" cellspacing="1">
					<tr class="tabletop">
					    <td width="40%" align="center">&nbsp;</td>
					    <td width="20%" align="center">&nbsp;</td>
					    <td width="40%" align="center">&nbsp;</td>
					 </tr>
					  <tr class="tabletop">
					    <td width="40%" align="center">可选组</td>
					    <td width="20%" align="center">&nbsp;</td>
					    <td width="40%" align="center">角色(<%=roleName%>)已授予的组</td>
					  </tr>
					  <tr class="tabletop">
					    <td width="40%" align="center">&nbsp;</td>
					    <td width="20%" align="center">&nbsp;</td>
					    <td width="40%" align="center">&nbsp;</td>
					  </tr>
					  <tr>
					     <td  align="right" >
					     	<select name="allist"  multiple style="width:80%" onDBLclick="addGroup()" size="18">
									  <pg:list requestKey="allGroup">
										<option value="<pg:cell colName="groupId"/>"><pg:cell colName="groupName"/></option>
									  </pg:list>			
							</select>
						 </td>				  	  	
					     <td align="center">
					     	<table width="100%" border="0" cellspacing="0" cellpadding="0">
					      		<tr>
					        		<td align="center">
					        			<input name="button1" type="button" class="input" value="&gt;" onclick="addGroup()">
					        		</td>
					      		</tr>
							    <tr>
							       <td align="center">&nbsp;</td>
							    </tr>
						      	<tr>
						        	<td align="center"><input name="button2" type="button" class="input" value="&gt;&gt;" onclick="addall()"></td>
						      	</tr>
   						        <tr>
						        	<td align="center">&nbsp;</td>
						        </tr>
							    <tr>
							        <td align="center"><input name="button3" type="button" class="input" value="&lt;&lt;" onclick="deleteall()"></td>
							    </tr>
							    <tr>
							        <td align="center">&nbsp;</td>
							    </tr>
							    <tr>
				        			<td align="center">
				        				<input name="button4" type="button" class="input" value="&lt;" onclick="deleteGroup()">
				        			</td>
				      			</tr>
							    <tr>
							        <td align="center">&nbsp;</td>
							    </tr>
				    		</table>
				    	</td>
					    <td >
					     <select name="groupId"  multiple style="width:80%" onDBLclick="deleteGroup()" size="18">
									  <pg:list requestKey="existGroup">
										<option value="<pg:cell colName="groupId"/>"><pg:cell colName="groupName"/></option>
									  </pg:list>			
						 </select>														
						</td>				 								  
				  	</tr>
					<tr class="tabletop">
					    <td width="40%" align="center">&nbsp;</td>
					</tr>
				    <tr>
				    	<td colspan="3" align="center">
				    		<input type="button" name="back" class="input" value="返回" onclick="window.close()"/>
				    	</td>
				    </tr>
				</table>
			</form>
		</center>
	</div>

	<div id=divProcessing style="width:200px;height:30px;position:absolute;left:150;top:400px;display:none">
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