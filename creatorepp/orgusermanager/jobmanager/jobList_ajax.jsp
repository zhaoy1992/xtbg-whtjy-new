
<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.sysmgrcore.entity.Role"%><%
/*
 * <p>Title: 岗位角色设置页面</p>
 * <p>Description: 岗位角色设置页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
 * @author liangbing.tao
 * @version 1.0
 */
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.JobManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Job"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Organization"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.OrgManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleManager"%>
<%@ page import="java.util.List"%>


<%
			AccessControl accessControl = AccessControl.getInstance();
			accessControl.checkManagerAccess(request,response);

			String jobId = request.getParameter("jobId");
			String orgId = request.getParameter("orgId");

			JobManager jobManager = SecurityDatabase.getJobManager();
			OrgManager orgManager = SecurityDatabase.getOrgManager();

			String jobName = null;
			String orgName = null;
			Job job = null;
			Organization org = null;

			if (jobId != null && !jobId.equals("")) {
				job = jobManager.getJobById(jobId);
				org = orgManager.getOrgById(orgId);
				jobName = job.getJobName();
				orgName = org.getOrgName();
			}

			RoleManager roleManager = SecurityDatabase.getRoleManager();
			List existRole = roleManager.getJobListByRoleJob(jobId, orgId);

			List rolelist = roleManager.getRoleList();
			List allRole = new ArrayList();
			if(rolelist != null)
			{
				for(int i=0; i<rolelist.size(); i++)
				{
					Role role = (Role) rolelist.get(i) ;
					//超级管理员不能将默认的角色授予岗位
					if(accessControl.isAdmin())
					{
						String roleId = role.getRoleId() ;
						if(!roleId.equals("1") && !roleId.equals("2")
							&& !roleId.equals("3") && !roleId.equals("4"))
							{
								allRole.add(role);	
							}
					}
					else
					{
						if(accessControl.checkPermission(role.getRoleId(),"roleset",AccessControl.ROLE_RESOURCE))
						{
							allRole.add(role);	
						}
					}
				}
			}
			request.setAttribute("allRole", allRole);
			request.setAttribute("existRole", existRole);
%>
<html>
	<head>
		<title>岗位角色设置</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/treeview.css">
		<SCRIPT LANGUAGE="JavaScript"> 
		function addRole()
		{	
		   var n=document.all("roleId").options.length-1;
		   	 	
		   for(var i=0;i<document.all("allist").options.length;i++)
		   {
		   		var op=document.all("allist").options[i];
		   		if(op.selected)
		   			addone(op.text,op.value,n);
		   }
		  changebox();
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
		
function deleteall()
{
	//for (var m=document.all("roleId").options.length-1;m>=0;m--)
	//{
    	//document.all("roleId").options[m]=null
    //}
    //changebox();
    //授权的个数 只能删除所授权的角色的
	 var havePurviewRoleCount = document.all("allist").options.length-1 ;
	 
	 var roleIds = "";
	 
	 var noPurviewRoles = "";
	 
	 for (var m=document.all("roleId").options.length-1;m>=0;m--)
	 {
		var option = document.all("roleId").options[m];
	   
    	var flag1 = false;
    	for(var n=havePurviewRoleCount; n>=0; n--)
    	{
    		if(document.all("allist").options[n].value==option.value)
    		{
		      	roleId = option.value;
		      	if(roleIds == "")
		      	{
		      		roleIds = roleId;
		      	}
		      	else
		      	{
		      		roleIds = roleIds + "," + roleId;
		      	}
		        document.all("roleId").options[m]=null;
		        flag1 = true;
		    }
        }
        if(!flag1)
        {
        	if(noPurviewRoles == "")
        	{
	    		noPurviewRoles = "对以下角色没有删除权限：\n" + option.text;
	    	}
	    	else
	    	{
	    		noPurviewRoles += "\n" + option.text;
	    	}
        }
	}
	 
	if(roleIds != "")
	{
		changebox();	
	}
	 else
	 {
	    if(noPurviewRoles != "")
	    {
	    	alert(noPurviewRoles);
	    }
	    else
	    {
	    	//alert("至少选择一个角色!");
    		return ;
    	}
	}   
    
    
}
		      
		function addall()
		{
			var n=document.all("roleId").options.length-1;
			var p=document.all("allist").options.length-1;		  
		     for(var i=0;i<document.all("allist").options.length;i++)
		     {
		     	var op=document.all("allist").options[i];
		     	addone(op.text,op.value,n);  
		   	 }
		   changebox();
		}
		
function deleterole()
{
	 
	 //授权的个数 只能删除所授权的角色
	 var havePurviewRoleCount = document.all("allist").options.length-1 ;
	 
	 var roleIds = "";
	 
	 var noPurviewRoles = "";
	 
	 for (var m=document.all("roleId").options.length-1;m>=0;m--)
	 {
		var option = document.all("roleId").options[m];
	    if(document.all("roleId").options[m].selected)
	    {
	    	var flag1 = false;
	    	for(var n=havePurviewRoleCount; n>=0; n--)
	    	{
	    		if(document.all("allist").options[n].value==option.value)
	    		{
			      	roleId = option.value;
			      	if(roleIds == "")
			      	{
			      		roleIds = roleId;
			      	}
			      	else
			      	{
			      		roleIds = roleIds + "," + roleId;
			      	}
			        document.all("roleId").options[m]=null;
			        flag1 = true;
			    }
	        }
	        if(!flag1)
	        {
	        	if(noPurviewRoles == "")
	        	{
		    		noPurviewRoles = "对以下角色没有删除权限：\n" + option.text;
		    	}
		    	else
		    	{
		    		noPurviewRoles += "\n" + option.text;
		    	}
	        }
	    }
	}
	 
	 if(roleIds != "")
	 {
		changebox();	
	 }
	 else
	 {
	    if(noPurviewRoles != "")
	    {
	    	alert(noPurviewRoles);
	    }
	    else
	    {
	    	alert("至少选择一个角色!");
    		return ;
    	}
	}     
}
		
		//---------------------------------------
		var http_request = false;
		function send_request(url)
		{
			http_request = false;
			//开始初始化XMLHttpRequest对象
			if(window.XMLHttpRequest)
			{//Mozilla
				http_request = new XMLHttpRequest();
				if(http_request.overrideMimeType)
				{//设置MIME类别
					http_request.overrideMimeType("text/xml");						
				}
			}
			else if(window.ActiveXObject)
			{//IE
				try
				{
					http_request = new ActiveXObject("Msxml2.XMLHTTP");
				}
				catch(e)
				{
					try
					{
						http_request = new ActiveXObject("Microsoft.XMLHTTP");							
					}
					catch(e){}
				}
			}
			
			if(!http_request)
			{
				alert("不能创建XMLHttpRequest对象");
				return false;
			}
			http_request.onreadystatechange = processRequest;
			http_request.open("GET",url,true);
			http_request.send(null);
		}
					
		function processRequest()
		{
			if(http_request.readyState == 4)
			{
				//alert(http_request.status);
				if(http_request.status == 200)
				{
					//alert(http_request.responseText);
					alert("操作成功!");
				}
				else
				{
					alert("对不起，服务器错误");
				}
				
				document.all("button1").disabled =  false;
				document.all("button2").disabled = false;
				document.all("button3").disabled = false;
				document.all("button4").disabled = false;
				document.all("reset").disabled = false;
				parent.divProcessing.style.display="none";
				
			}
			else
			{
				document.all("button1").disabled =  true;
				document.all("button2").disabled = true;
				document.all("button3").disabled = true;
				document.all("button4").disabled = true;
				document.all("reset").disabled = true;
				divProcessing.style.display="";
				
			}
		}
					
		function changebox()
		{				 
		   	 var len=document.all("roleId").options.length;			  	 	
			 //var roleId = document.all("roleId").value;
			 var jobId="<%=jobId%>";
			 var orgId="<%=orgId%>"
			 var roleId=new Array(len)
			 for (var i=0;i<len;i++)
			 {	      
			   roleId[i]=document.all("roleId").options[i].value;
	 		 }   
			 send_request('saveJobRole.jsp?jobId='+jobId+'&roleId='+roleId+'&orgId='+orgId);
		}
		</SCRIPT>
		<script language="javascript" src="../../include/dragdiv.js"></script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no" onload="loadDragDiv();">
		<div id="contentborder">
			<center>
				<form name="RoleOrgForm" action="" method="post">
					<table width="80%" border="0" cellpadding="0" cellspacing="1">
						<tr class="tabletop">
							<td width="40%" align="center">
								&nbsp;
							</td>
							<td width="20%" align="center">
								&nbsp;
							</td>
							<td width="40%" align="center">
								&nbsp;
							</td>
						</tr>
						<tr class="tabletop">
							<td width="40%" align="center">
								可设置的角色
							</td>
							<td width="20%" align="center">
								&nbsp;
							</td>
							<td width="40%" align="center">
								机构(<%=orgName%>)下的岗位(<%=jobName%>)<br/>已设置的角色
							</td>
						</tr>
						<tr class="tabletop">
							<td width="40%" align="center">
								&nbsp;
							</td>
							<td width="20%" align="center">
								&nbsp;
							</td>
							<td width="40%" align="center">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td align="right">
								<div class="win" id="dd_1" align="left">
									<select name="allist" multiple style="width:98%" onDBLclick="addRole()" size="18">
										<pg:list requestKey="allRole">
											<option value="<pg:cell colName="roleId"/>">
												<pg:cell colName="roleName" />
											</option>
										</pg:list>
									</select>
								</div>
							</td>

							<td align="center">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td align="center">
											<input name="button1" type="button" class="input" value="&gt;" onclick="addRole()">
										</td>
									</tr>
									<tr>
										<td align="center">
											&nbsp;
										</td>
									</tr>
									<tr>
										<td align="center">
											<input name="button2" type="button" class="input" value="&gt;&gt;" onclick="addall()">
										</td>
									</tr>
									<tr>
										<td align="center">
											&nbsp;
										</td>
									</tr>
									<tr>
										<td align="center">
											<input name="button3" type="button" class="input" value="&lt;&lt;" onclick="deleteall()">
										</td>
									</tr>
									<tr>
										<td align="center">
											&nbsp;
										</td>
									</tr>
									<tr>
										<td align="center">
											<input name="button4" type="button" class="input" value="&lt;" onclick="deleterole()">
										</td>
									</tr>
									<tr>
										<td align="center">
											&nbsp;
										</td>
									</tr>
								</table>
							</td>
							<td>
								<div class="win" id="dd_2" align="left">
									<select name="roleId" multiple style="width:98%" onDBLclick="deleterole()" size="18">
										<pg:list requestKey="existRole">
											<option value="<pg:cell colName="roleId"/>">
												<pg:cell colName="roleName" />
											</option>
										</pg:list>
									</select>
								</div>
							</td>
						</tr>
					</table>
					<br />
					<br />
					<br />
					<br />
					<input name="reset" type="button" class="input" value="返回" onClick="window.close();">
					<input type="hidden" name="jobId" value="<%=jobId%>" />
					<input type="hidden" name="orgId" value="<%=orgId%>" />
				</form>
			</center>
		</div>
		<br/>
		<div id=divProcessing style="width:200px;height:30px;position:absolute;left:350px;top:460px;display:none">
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
</html>
