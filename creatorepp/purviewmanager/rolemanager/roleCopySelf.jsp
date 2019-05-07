<%
/*
 * <p>Title: 将其它角色复制给该角色</p>
 * <p>Description: 将其它角色复制给该角色</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-19
 * @author liangbing.tao
 * @version 1.0
 */
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.Role" %>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>

<%  
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request,response);
	
    String rolecopyId = request.getParameter("roleId");
    
    
    if(rolecopyId == null) 
    {
    	rolecopyId = (String) request.getAttribute("roleId");
    }
    
    
    RoleManager roleManager = SecurityDatabase.getRoleManager();

    
	Role role = roleManager.getRoleById(rolecopyId);
	
	String roleName = role.getRoleName();
	
	
	
	session.setAttribute("roleTabId", "5"); 
	String admin = "false";
	
	if ( role.getRoleName().equals("administrator") || role.getRoleName().equals("admin"))
	{
		admin = "true";
	}
%>


<html>
	<head>
	    <script language="JavaScript" src="../scripts/common.js" type="text/javascript"></script>
	    <script language="javascript" src="../scripts/selectTime.js"></script>
		<SCRIPT language="JavaScript" SRC="../scripts/validateForm.js"></SCRIPT>
		<link href="Images/style.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="../css/windows.css">
        <link rel="stylesheet" type="text/css" href="../css/treeview.css">
        <script language="javascript">
			var isExist = "<%=admin%>";
			function checkAll(totalCheck,checkName)
			{
			   var selectAll = document.getElementsByName(totalCheck);
			   var o = document.getElementsByName(checkName);
			   if(selectAll[0].checked==true)
			   {
				   for (var i=0; i<o.length; i++)
				   {
			      	  if(!o[i].disabled)
			      	  {
			      	  	o[i].checked=true;
			      	  }
				   }
			   }
			   else
			   {
				   for (var i=0; i<o.length; i++)
				   {
			   	  	  o[i].checked=false;
			   	   }
			   }
			}
			
			function checkOne(totalCheck,checkName)
			{
			   var selectAll = document.getElementsByName(totalCheck);
			   var o = document.getElementsByName(checkName);
				var cbs = true;
				for (var i=0;i<o.length;i++)
				{
					if(!o[i].disabled)
					{
						if (o[i].checked==false)
						{
							cbs=false;
						}
					}
				}
				if(cbs)
				{
					selectAll[0].checked=true;
				}
				else
				{
					selectAll[0].checked=false;
				}
			}
			
			function copyroleres(copyType) 
			{
				if ( isExist == "true")
				{
					alert("系统管理员的权限不能复制！");
					return;
				}
			    var checks = "";
			    var arr = new Array();
			    arr = document.getElementsByName("checkBoxOne");
			    for(var i = 0; i < arr.length; i++)
			    {
			    	if(arr[i].checked)
			    	{
			    		if(checks == "")
			    		{
			    			checks = arr[i].value;
			    		}
			    		else
			    		{
			    			checks += "," + arr[i].value;
			    		}
			    	}
			    }
			    var outMsg;
			    if (checks != "")
			    {
			    	if (copyType==1)
			    	{
			    		outMsg = "你确定要复制所选的角色的权限 给角色<%=roleName%>吗？";
			        	if (confirm(outMsg))
			        	{
			        		document.getElementById("copy").disabled = true ;
							document.getElementById("back").disabled = true ;
							document.all.divProcessing.style.display = "block";
			        		
			        		
							rolecopyList.action="roleCopySelf_do.jsp?roleName=<%=roleName%>&checks="+checks;
							rolecopyList.target="copySeftFrame" ;
						    rolecopyList.submit();
						}
					} 
			    }
			    else
			    {
			    	alert("至少要选择一条记录！");
			    	return false;
			    }
				//return false;
			}
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body >
		<form name="rolecopyList" method="post" >
			<input name="rolecopyId" value="<%=rolecopyId%>" type="hidden">
			<table cellspacing="1" cellpadding="0" border="0" width=98% class="thin">
 				<tr valign='top'>
   					<td align="center" colspan="5">&nbsp;<strong>将以下角色权限赋给角色：<%=roleName%></strong></td>
 				</tr>
 				
 				<pg:listdata dataInfo="com.chinacreator.sysmgrcore.purviewmanager.tag.RoleCopy" keyName="RoleCopy" />
            	<!--分页显示开始,分页标签初始化-->
			<pg:pager maxPageItems="15" scope="request" data="RoleCopy" isList="false">
				<tr>
	            <!--设置分页表头-->
					<td class="headercolor" width="10">
						<input type="checkBox" name="checkBoxAll" onClick="checkAll('checkBoxAll','checkBoxOne')" width="10">
					</td>
					<td class="headercolor">角色名称</td>
					<td class="headercolor">角色类型名称</td>
			    </tr>
			    <pg:param name="rolecopyId" />
			    <pg:param name="roleId" />
            <!--检测当前页面是否有记录-->
				<pg:notify>
					<tr height="18px" class="labeltable_middle_tr_01">
						<td colspan=100 align='center'>
							该角色暂时没有权限
						</td>
					</tr>
				</pg:notify>
							

                        <!--list标签循环输出每条记录-->
				<pg:list>								
					<tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'" onclick="" >
						<td class="tablecells" nowrap="nowrap">
							<input type="checkBox" name="checkBoxOne" onClick="checkOne('checkBoxAll','checkBoxOne')" value="<pg:cell colName='roleId' defaultValue=''/>">
						</td>
						<td class="tablecells" nowrap="nowrap" height='20'>
							<pg:cell colName="roleName" defaultValue="" />
						</td>
						<td class="tablecells" nowrap="nowrap" height='20'>
							<pg:cell colName="roleTypeName" defaultValue="" />
						</td>
			        </tr>
				</pg:list>
               <tr height="18px" class="labeltable_middle_tr_01">
					<td colspan=4 align='center'>
						共<pg:rowcount/>条记录 <pg:index />
						<input type="button" value="确定" id="copy" name="copy" class="input" onclick="javascript:copyroleres(1)">	
						<input type="button" value="返回" id="back" name="back" class="input" onclick="window.close()">	
					</td>						
				
			  </tr>

			<input name="queryString" value="<pg:querystring/>" type="hidden"></pg:pager>
  		</table>
	</form>
	<br/>
	<div id=divProcessing style="width:200px;height:30px;position:absolute;left:250px;top:260px;display:none">
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
	<iframe name="copySeftFrame" width="0" height="0"></iframe>
</body>
</html>