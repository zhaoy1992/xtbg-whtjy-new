<%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>


<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,
                 com.chinacreator.config.ConfigManager,
                 com.chinacreator.sysmgrcore.purviewmanager.db.PurviewManagerImpl,

                 com.chinacreator.sysmgrcore.purviewmanager.PurviewManager"%>
<%    
    AccessControl control = AccessControl.getInstance();
   	control.checkManagerAccess(request,response);
   	String orgId = request.getParameter("orgId")==null?"":request.getParameter("orgId");
   	PurviewManager manager = new PurviewManagerImpl();
   	String orgName = manager.getOrgNameByOrgId(orgId);
%>

<html>
	<head>
		<title>回收机构【<%=orgName%>】权限</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/treeview.css">
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" >
		<br>
		<form name="form1" method="post" target="hiddenFrame" >
		<input type="hidden" name="orgId" value="<%=orgId%>">
		<%
			if (ConfigManager.getInstance().getConfigBooleanValue("enableorgrole", false)
				&& control.checkPermission(orgId,
                        "orgroleset", AccessControl.ORGUNIT_RESOURCE))
            {
        %>
			<fieldset>
			<legend class="td"><font size="2">回收机构【<%=orgName%>】权限</font></legend>	
					<br>
					<table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% >
						<tr align="left">
						    <td class="td"><b>请选择相应权限进行回收:</b></td>
						    <td class="td"><input type="checkbox" name="isOrgRecursion" value="isOrgRecursion">递归回收子机构的权限</td>				    				    
						</tr>
					</table>
					<table cellspacing="1" cellpadding="0" border="0" align="center"  bordercolor="#EEEEEE" width=80% >					
						<tr>
						    <td class="td"><input type="checkbox" name="directOrgRes" value="directOrgRes">直接授予机构的权限</td>
						</tr>
						<tr>
						    <td class="td"><input type="checkbox" name="orgRoleRes" value="orgRoleRes">机构的角色权限</td>				    
						</tr>
					</table>							
			</fieldset>
			<br>
		<%
		    }
		%>
		<fieldset>
		<legend class="td"><font size="2">回收机构【<%=orgName%>】下用户权限</font></legend>	
				<br>
				<table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% >
					<tr align="left">
					    <td class="td"><b>请选择相应权限进行回收:</b></td>	
					    <td class="td"><input type="checkbox" name="isRecursion" value="isRecursion">递归回收子机构下用户的权限</td>				    			    
					</tr>
				</table>
				<table cellspacing="1" cellpadding="0" border="0" align="center"   width=80% >					
					<tr>
					    <td class="td"><input type="checkbox" name="directRes" value="directRes">直接授予用户的权限</td>
					</tr>
					<tr>
					    <td class="td"><input type="checkbox" name="userRoleRes" value="userRoleRes">用户的角色权限</td>				    
					</tr>
					<% 
						if(ConfigManager.getInstance().getConfigBooleanValue("enablejobfunction",false)){
					%> 
					<tr>
					    <td class="td"><input type="checkbox" name="userOrgJobRes" value="userOrgJobRes">用户的机构岗位权限</td>				    
					</tr>
					<% 
						}
					%>	
					<% 
						if(ConfigManager.getInstance().getConfigBooleanValue("enablergrouprole",false)){
					%>
					<tr>
					    <td class="td"><input type="checkbox" name="userGroupRes" value="userGroupRes">用户的所属用户组权限</td>				    
					</tr>				
					<% 
						}
					%>
				</table>							
		</fieldset>
		<br>
		
				
		<fieldset>
		<legend><font size="2">操作区</font></legend>
		<table cellspacing="1" cellpadding="0" border="0" align="center"  bordercolor="#EEEEEE" width=50% >					
			<tr>
			    <td class="td"><input type="button" class="input" value="回收" onclick="reclaim()">
			    &nbsp;&nbsp;&nbsp;&nbsp;
			    <input type="button" class="input" value="关闭" onclick="window.close()">
			</td>
			</tr>			
		</table>
		<br>
		</fieldset>
		</form>
	</body>
	<script language="javascript">
	    function reclaim(){
	        var directOrgRes = "";
	        var orgRoleRes = "";
	        var directRes = "";
	        var userRoleRes = "";
	        var userOrgJobRes = "";	
	        var userGroupRes = "";//用户的用户组权限  
	        var isRecursion = ""; 
	        var isOrgRecursion = "";
	        if(document.all.directOrgRes && document.all.directOrgRes.checked){
	            directRes = document.all.directOrgRes.value;
	        }
	        if(document.all.orgRoleRes && document.all.orgRoleRes.checked){
	            userRoleRes = document.all.orgRoleRes.value;
	        }
	        if(document.all.isOrgRecursion && document.all.isOrgRecursion.checked){
	            isOrgRecursion = document.all.isOrgRecursion.value;
	        }		             
	        if(document.all.userRoleRes && document.all.userRoleRes.checked){
	            directRes = document.all.userRoleRes.value;
	        }
	        if(document.all.directRes && document.all.directRes.checked){
	            userRoleRes = document.all.directRes.value;
	        }
	        if(document.all.userOrgJobRes && document.all.userOrgJobRes.checked){
	            userOrgJobRes = document.all.userOrgJobRes.value;
	        }	        
	        if(document.all.isRecursion.checked){
	            userOrgJobRes = document.all.isRecursion.value;
	        }
	        if(document.all.userGroupRes && document.all.userGroupRes.checked){
	        	userGroupRes = document.all.userGroupRes.value;
	        }
	        if(directOrgRes=="" && orgRoleRes=="" && directRes=="" && userRoleRes=="" && userOrgJobRes=="" && userGroupRes==""){
	            alert("没有选择回收任何权限!");
	            return false;
	        }else{
	            document.form1.target = "hiddenFrame";
	        	document.form1.action = "reclaimOrgUserRes_do.jsp";	
	        	document.form1.submit();        	
	        }	        
	        
	    }
	</script>
	<iframe id="hiddenFrame" name="hiddenFrame" src="" width=0 height=0></iframe>
</html>
