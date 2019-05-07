<%
/*
 * <p>Title: 机构下的角色处理页面</p>
 * <p>Description:机构下的角色处理页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-26
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
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.*" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.*" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<%	
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkManagerAccess(request,response);
	
	
	String orgId = (String) request.getParameter("orgId");
	
	
	OrgManager orgManager = SecurityDatabase.getOrgManager();
	Organization org = orgManager.getOrgById(orgId);
	String orgName = org.getRemark5();
	
	RoleManager roleManager = SecurityDatabase.getRoleManager();	
	
	
	List existRole = roleManager.getRoleList(org);//获取机构已有的角色列表
	
	List list = roleManager.getRoleList();//获取所有角色的列表
	
	
	
	
	//角色列表加权限判断，筛选有权限的角色列表
	List allRole = new ArrayList();
	
	for (int i = 0; list != null && i < list.size(); i++) 
	{
		Role role = (Role) list.get(i);		
		if (accessControl.checkPermission(role.getRoleId(),
							"roleset",
							AccessControl.ROLE_RESOURCE)) 
		{

				//不能出现默认角色：admin,roleforeveryone,orgmanager/ admin能看见admin角色
				if(Integer.parseInt(role.getRoleId()) == 1 
							&& "1".equals(accessControl.getUserID()))
				{
					allRole.add(role);
				}
				
				if(Integer.parseInt(role.getRoleId()) > 4)
				{
					allRole.add(role);
				}				
		}
	}
		
	request.setAttribute("allRole", allRole);
	request.setAttribute("existRole", existRole);
%>
<html>
<head>    
  <title>角色授予</title>
	<SCRIPT LANGUAGE="JavaScript">   
	function send_request(url)
	{
	    document.all.divProcessing.style.display = "block";
	    
	    document.all("button1").disabled = true;
	    document.all("button2").disabled = true;
	    document.all("button3").disabled = true;
	    document.all("button4").disabled = true;
	    document.all("back").disabled = true;
	    
		document.OrgJobForm.action = url;
		document.OrgJobForm.target="hiddenFrame";
		document.OrgJobForm.submit();
	}
	
	function isRecursive()
	{	    
		var ischeck = document.all.item("recursive").checked;
		if(ischeck)
			return "1";
		else
			return "0";	
	}
	function addone(name,value,n)
	{
	   for(var i=n;i>=0;i--)
	   {
			if(value==document.all("roleId").options[i].value)
			{
			  return;
			}
		}
	   var op=new Option(name,value);
	   document.all("roleId").add(op);
	}
	
	function addRole()
	{	
	    var n=document.all("roleId").options.length-1;
	    var roles = ""; 
	    var orgId = document.all("orgId").value;
		var flag = isRecursive();	
		
		if(document.all("allist").options.length < 1)
	    {
	    	alert("没有要添加的角色！");
	    	return;
	    }
	    	
	   	for(var i=0;i<document.all("allist").options.length;i++)
	   	{
		    var op=document.all("allist").options[i];
		    if(op.selected)
		    {
		        addone(op.text,op.value,n);
		        if(roles =="") 
		        {
		        	roles = roles + op.value;
		        }
		        else 
		        {
		        	roles = roles + "," + op.value;
		        }
		    }
		} 
		
		if(roles != "")
		{		
			send_request('storeorgrole.jsp?roleId='+roles+'&orgId='+orgId+'&flag='+flag);  
		}
		else
		{
			alert("请选择要添加的角色！");
			return ;
		}
	}
	
	function addall()
	{		
	    var roles = "";
		var n=document.all("roleId").options.length-1;
		var p=document.all("allist").options.length-1;	
		
		if(document.all("allist").options.length < 1)
	    {
	    	alert("没有要添加的角色！");
	    	return;
	    }
			  
	    for(var i=0;i<document.all("allist").options.length;i++)
	    {
	        var op=document.all("allist").options[i];
	        addone(op.text,op.value,n);  
	        if(roles =="") 
	        {
	        	roles = roles + op.value;
	        }
		    else
		    {
		       roles = roles + "," + op.value;
		    }
	    }
	    
	    if(roles != "")
		{		
			var orgId = document.all("orgId").value;
			var flag = isRecursive();
			send_request('storeorgrole.jsp?roleId='+roles+'&orgId='+orgId+'&flag='+flag);  
	    }
	    else
	    {
	    	alert("请选择要添加的角色！");
			return ;
	    }	    
	}
	
	function deleterole()
	{
	    var roles = "";
	    var unroles = "";
		var orgId = document.all("orgId").value;
		var flag = isRecursive();
		var count = 0;
		if(document.all("roleId").options.length < 1)
		{
	    	alert("没有要删除的角色！");
	    	return;
	    }
		var autorole = document.all("allist");
	    for (var m=document.all("roleId").options.length-1;m>=0;m--)
	    {
		    if(document.all("roleId").options[m].selected)
		    {
		    	count ++;
	      	    var op = document.all("roleId").options[m];
	      	    var isrole = true;
	      	    for(var n = 0; n < autorole.options.length; n++){
	      	    	if(autorole.options[n].value == op.value){
			      	    if(roles =="") 
			      	    {
			      	    	roles = roles + op.value;
			      	    }
				        else
				        {
				        	roles = roles + "," + op.value;
				        }
				        document.all("roleId").options[m]=null;
				        isrole = false;
			        }
		        }
		        if(isrole){
		        	if(unroles == ""){
		        		unroles = op.text;
		        	}else{
		        		unroles += "\n" + op.text;
		        	}
		        }
	        }
	    }
	    if(unroles != ""){
	    	alert("对以下角色没有权限\n" + unroles);
	    }
	    if(roles != "")
	    {
	    	send_request('deleteorgrole.jsp?roleId='+roles+'&orgId='+orgId+'&flag='+flag);
	    }
		if(count < 1)
	    {
	    	alert("请选择要删除的角色！");
	    	return ;
	    }
	    
	 }
	 
	function deleteall()
	{
		var roles = "";
		var unroles = "";
		var orgId = document.all("orgId").value;
		var flag = isRecursive();
		
		if(document.all("roleId").options.length < 1)
		{
	    	alert("没有要删除的角色！");
	    	return;
	    }
	    var autorole = document.all("allist");
		for (var m=document.all("roleId").options.length-1;m>=0;m--)
		{
		    var op = document.all("roleId").options[m];
		    var isrole = true;
		    for(var n = 0; n < autorole.options.length; n++){
	      	    if(autorole.options[n].value == op.value){
		      	    if(roles =="") 
		      	    {
		      	    	roles = roles + op.value;
		      	    }
			        else 
			        {
			        	roles = roles + "," + op.value;	    	
			        }
			    	document.all("roleId").options[m]=null;
			    	isrole = false;
			    }
			 }
			 if(isrole){
		        	if(unroles == ""){
		        		unroles = op.text;
		        	}else{
		        		unroles += "\n" + op.text;
		        	}
		        }
	    }
	    
	    if(unroles != ""){
	    	alert("对以下角色没有权限\n" + unroles);
	    }
	    if(roles != "")
	    {
	    	send_request('deleteorgrole.jsp?roleId='+roles+'&orgId='+orgId+'&flag='+flag);
	    }
	} 
	
  </SCRIPT>
  <link rel="stylesheet" type="text/css" href="../../css/windows.css">
  <link rel="stylesheet" type="text/css" href="../../css/treeview.css">
</head>
 
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
	<div id="contentborder">
		<center>
			<form name="OrgJobForm" action="" method="post" >
				<table width="80%" border="0" cellpadding="0" cellspacing="1">
					<tr class="tabletop">
					    <td width="40%" align="center">&nbsp;</td>
					    <td width="20%" align="center">&nbsp;</td>
					    <td width="40%" align="center">&nbsp;</td>
					 </tr>
					 <tr>
					  	<td width="40%" align="center">
							<input type="checkBox" name="recursive" id="recursive" >
							递归角色授予机构
						</td>
					  </tr>
					  <tr>
					  <td></td>
					  </tr>
					  <tr class="tabletop">
					    <td width="40%" align="center">可选角色</td>
					    <td width="20%" align="center">&nbsp;</td>
					    <td width="40%" align="center">机构(<%=orgName%>)已授予角色</td>
					  </tr>
					  <tr class="tabletop">
					    <td width="40%" align="center">&nbsp;</td>
					    <td width="20%" align="center">&nbsp;</td>
					    <td width="40%" align="center">&nbsp;</td>
					  </tr>
	  				  <tr >
						     <td  align="right" >
							     <select name="allist"  multiple style="width:100%" onDBLclick="addRole()" size="18" >
											  <pg:list requestKey="allRole">
												<option value="<pg:cell colName="roleId"/>"><pg:cell colName="roleName"/></option>
											  </pg:list>			
								</select>
							</td>				  
			  	
	    					<td align="center">
	    						<table width="100%" border="0" cellspacing="0" cellpadding="0">
								      <tr>
								        <td align="center">
								        	<input name="button1" type="button" class="input" value="&gt;" onclick="addRole()">
								        </td>
								      </tr>
								      <tr>
								        <td align="center">&nbsp;</td>
								      </tr>
								      <tr>
								        <td align="center">
								        	<input name="button2" type="button" class="input" value="&gt;&gt;" onclick="addall()">
								        </td>
								      </tr>
								      <tr>
								        <td align="center">&nbsp;</td>
								      </tr>
								      <tr>
								        <td align="center">
								        	<input name="button3" type="button" class="input" value="&lt;&lt;" onclick="deleteall()">
								        </td>
								      </tr>
								      <tr>
								        <td align="center">&nbsp;</td>
								      </tr>
								      <tr>
								        <td align="center">
								        	<input name="button4" type="button" class="input" value="&lt;" onclick="deleterole()">
								        </td>
								      </tr>
								      <tr>
								        <td align="center">&nbsp;</td>
								      </tr>
	    							</table>
	    						</td>
	    						
							    <td >
								    <div style="overflow:auto;">
								     	<select name="roleId"  multiple style="width:100%" onDBLclick="deleterole()"size="18">
										  <pg:list requestKey="existRole">
											<option value="<pg:cell colName="roleId"/>"><pg:cell colName="roleName"/></option>
										  </pg:list>			
									 	</select>				
									</div>				
								</td>				 
	 						 </tr>
	 						 <tr>
	 						 	<td align="center" colspan="3">
	 						 		<input type="button" name="back" value="返回" class="input" onclick="window.close()"/>
	 						 	</td>
	 						 </tr>
						</table>
	   				 <input type="hidden" name="orgId" value="<%=orgId%>"/>
				</form>
			</center>
	</div>
	<div id=divProcessing style="width:200px;height:30px;position:absolute;left:300px;top:400px;display:none">
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