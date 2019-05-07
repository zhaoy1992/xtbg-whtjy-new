<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.UserRoleManagerAction"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.*,
				java.util.List,java.util.ArrayList,
				com.chinacreator.sysmgrcore.entity.Role"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>
<%
	
		//---------------START--
		AccessControl control = AccessControl.getInstance();
		control.checkManagerAccess(request,response);
		String currentUserId = control.getUserID();
		String operContent="";        
        String operSource=control.getMachinedID();
        String openModle="用户管理";
        String userName = control.getUserName();
        String description="";
        LogManager logManager = SecurityDatabase.getLogManager(); 
        UserManager userManager = SecurityDatabase.getUserManager();		
		//---------------END
		//Integer uid = (Integer) session.getAttribute("currUserId");
		String uid = request.getParameter("userId");
		String orgId = request.getParameter("orgId");
		//操作 新增 还是 删除
		String op = request.getParameter("op");	
        String roleId = "";
        String[] popedomRoleId = request.getParameter("popedomRoleIds").split(",");
        String[] selectedRoleId = request.getParameter("roleId").split(",");
        if(control.isAdmin()){//如果是超级管理员
        	roleId = request.getParameter("roleId");
        }else{
        	for(int i = 0; i < selectedRoleId.length; i++){
        		for(int j = 0; j < popedomRoleId.length; j++){
        			if(selectedRoleId[i].equals(popedomRoleId[j])){
        				if("".equals(roleId)){
        					roleId = selectedRoleId[i];
        				}else{
        					roleId += "," + selectedRoleId[i];
        				}
        			}
        		}
        	}
        }
    	// 权限是否关联机构
		// 彭盛 2011-3-15 
		boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);
        
        //System.out.println("roleId = " + roleId);
		String roleIds[] =roleId.split(",");
		if(roleId!=null && !"".equals(roleId)){
			//--
			String userName_log = LogGetNameById.getUserNameByUserId(uid);
			String roleNames_log = LogGetNameById.getRoleNamesByRoleIds(roleIds);
			String orgName_log = LogGetNameById.getOrgNameByOrgId(orgId);
			if("add".equals(op)){
				operContent="增加用户角色,用户："+userName_log+" 角色："+roleNames_log+" 机构："+orgName_log;	
				//userManager.addUserrole(uid,roleIds);
				//用户角色递归回收,必须保存授予角色的人员
				// 彭盛 2011-3-15 
				if(isrolerelatedorg){
					userManager.addUserrole(uid,roleIds,currentUserId,orgId);
				}else{
					userManager.addUserrole(uid,roleIds,currentUserId);
				}
			}else{
			    operContent="删除用户角色,用户："+userName_log+" 角色："+roleNames_log+" 机构："+orgName_log;	
				//userManager.deleteUserrole(uid,roleIds);
				//用户角色递归回收
				// 彭盛 2011-3-15 
				if(isrolerelatedorg){
					userManager.deleteUserrole(uid,roleIds,orgId,ResManager.ROLE_TYPE_USER);
				}else{
					userManager.deleteUserrole(uid,roleIds,ResManager.ROLE_TYPE_USER);
				}
			}	
			logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);   
		 }
%>
<script>
	function optionText(roleIdStr){
    	var opp;
    	for(var i = 0; i < parent.document.all("roleId").options.length; i++){
    		opp = parent.document.all("roleId").options[i];
    		if(opp.value==roleIdStr){
    			return opp.text;
    		}
    	}
    }

    window.onload = function prompt(){
        //alert("操作成功!");
        parent.divProcessing.style.display="none";
    }
    var returnRoleInfo = "";
    var op = "";
    <%
    if(!"add".equals(op)){
    	for(int i = 0; i < selectedRoleId.length; i++){
    		String roleSelected = selectedRoleId[i];
    %>
    		var flag = false;
		    for(var i = 0; i < parent.document.all("roleId").options.length; i++){
		    	op = parent.document.all("roleId").options[i];
		    	if(op.value=="<%=roleSelected%>"){
		    		<%
		    		for(int z = 0; z < popedomRoleId.length; z++){
		    			if(roleSelected.equals(popedomRoleId[z])){
		    		%>
		    		flag = true;
		    		parent.document.all("roleId").remove(i);
		    		<%}}%>
		    	}
		    }
		    if(!flag){
		    	var str = "<%=roleSelected%>";
		    	if(returnRoleInfo==""){
		    		returnRoleInfo = optionText(str);
		    	}else{
		    		returnRoleInfo += "\n" + optionText(str);
		    	}
		    }
    <%
      }
    }
    %>
    if(returnRoleInfo!=""){
    	alert("对以下角色没有权限" + "\n" + returnRoleInfo);
    }
    
    
</script>