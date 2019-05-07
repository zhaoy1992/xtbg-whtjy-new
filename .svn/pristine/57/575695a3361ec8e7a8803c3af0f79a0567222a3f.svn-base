<%--
描述：菜单授权页面
作者：黄艺平
版本：1.0
时间：2013-5-30
 --%>
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
<%@ page import="com.chinacreator.sysmgrcore.purviewmanager.usercheckorg.api.UserCheckOrgFactory"%>   
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>              
<%
    AccessControl control = AccessControl.getInstance();
   	control.checkManagerAccess(request,response);
    String userIds =  request.getParameter("userIds") == null ? "":request.getParameter("userIds");
    PurviewManager manager = new PurviewManagerImpl();
    String userNames = manager.getUserNamesByUserIds(userIds);
    String orgId = request.getParameter("orgId");
    
	//屏蔽被借调用户  彭盛 2011-3-10
	StringBuffer secondUserName = new StringBuffer();
	boolean isSecondUser = UserCheckOrgFactory.getIUserCheckOrgInstance().isSecondUserByOrgIDToMess(userIds,orgId,secondUserName);
%>
<html>
	<head>
		<title>回收用户【<%=userNames%>】权限</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/treeview.css">
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" onload="init()">
		<br>
		<form name="form1" method="post" target="hiddenFrame" >
		<input type="hidden" name="userIds" value="<%=userIds%>">
		<fieldset>
		<legend class="td"><font size="2">回收用户【<%=userNames%>】权限</font></legend>	
				<br>
				<table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% >
					<tr align="left">
					    <td class="td"><b>请选择相应权限进行回收:</b></td>				    
					</tr>
					<tr>
					    <td></td>				    
					</tr>
				</table>
				<table cellspacing="1" cellpadding="0" border="0" align="center"  bordercolor="#EEEEEE" width=80% >					
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
				<br>			
		</fieldset>
		<br>
		<fieldset>
		<legend><font size="2">操作区</font></legend>
		<table cellspacing="1" cellpadding="0" border="0" align="center"  bordercolor="#EEEEEE" width=50% >					
			<tr>
			    <td class="td"><input type="button" class="input" value="回收" onclick="reclaim()">
			    &nbsp;&nbsp;&nbsp;&nbsp;
			    <input type="button" class="input" value="关闭" onclick="removeAlertWindows('',true)">
			</td>
			</tr>			
		</table>
		<br>
		</fieldset>
		</form>
	</body>
	<script language="javascript">
		function init(){
			if("<%=isSecondUser%>"=="true"){
				alert("被借调用户在该机构下不能被授予角色：<%=secondUserName%>");
				window.close();
			}
		}
	
	    function reclaim(){
	        var directRes = "";
	        var userRoleRes = "";
	        var userOrgJobRes = "";	   
	        var userGroupRes = "";//用户的用户组权限     
	        if(document.all.userRoleRes && document.all.userRoleRes.checked){
	            directRes = document.all.userRoleRes.value;
	        }
	        if(document.all.directRes && document.all.directRes.checked){
	            userRoleRes = document.all.directRes.value;
	        }
	        if(document.all.userOrgJobRes && document.all.userOrgJobRes.checked){
	            userOrgJobRes = document.all.userOrgJobRes.value;
	        }
	        if(document.all.userGroupRes && document.all.userGroupRes.checked){
	        	userGroupRes = document.all.userGroupRes.value;
	        }
	        if(directRes == "" && userRoleRes == "" && userOrgJobRes == "" && userGroupRes == ""){
	            alert("没有选择回收任何权限!");
	            return false;
	        }else{	   
		        document.form1.target = "hiddenFrame";
		        document.form1.action = "reclaimuserres_do.jsp?orgId=<%=orgId%>";
		        document.form1.submit();
	        }
	    }
	</script>
	<iframe id="hiddenFrame" name="hiddenFrame" src="" width=0 height=0></iframe>
</html>
