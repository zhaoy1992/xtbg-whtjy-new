<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.UserJobManagerAction"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.*,
				 com.chinacreator.sysmgrcore.entity.User,
				 com.chinacreator.sysmgrcore.manager.OrgManager,
				 com.chinacreator.config.ConfigManager"%>
<%
		//---------------START--用户组管理写操作日志
		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request,response);
		String CurorgId = request.getParameter("CurorgId");
		//是否保留用户所在机构  true：保留
		String hold = request.getParameter("hold");
		System.out.println("hold = " + hold);
		
		OrgManager orgManager = SecurityDatabase.getOrgManager();
		LogManager logManager = SecurityDatabase.getLogManager();
        UserManager userManagerInfo = SecurityDatabase.getUserManager();
        UserManager userManager = SecurityDatabase.getUserManager();
        
		String operContent="";        
        String operSource=request.getRemoteAddr();
        String openModle="用户管理";
        String userName = control.getUserName();//getUserName();
        String description="";
		
		//多个userId
		String userId = request.getParameter("userId")==null?"":request.getParameter("userId");
		String[] folduserIds = userId.split(",");
		//返回提示信息
		String userReturnInfo = "";
		//符合条件的userid串
		String userIdsStr = "";
		for(int u = 0; u < folduserIds.length; u++){
		    String userOrgInfoMsg = userManagerInfo.userOrgInfo(control,folduserIds[u]);
			if(!"".equals(userOrgInfoMsg)){
			    //如果返回值！= "" ， 累加提示信息
			    User user = userManager.getUserById(folduserIds[u]);
				if(userReturnInfo.equals("")){
					userReturnInfo = user.getUserRealname()+"("+user.getUserName()+"):"+userOrgInfoMsg;
				}else{
					userReturnInfo += "\\n" + user.getUserRealname()+"("+user.getUserName()+"):" + userOrgInfoMsg;
				}
			}else{
			    //符合调动条件的userid
				if(userIdsStr.equals("")){
					userIdsStr = folduserIds[u];
				}else{
					userIdsStr += "," + folduserIds[u];
				}
			}
		}
		// 保存符合条件的userid
		String[] userIds = userIdsStr.split(",");
		
		String orgId = request.getParameter("orgId");
		String flag = request.getParameter("flag");
		String classType = request.getParameter("classType");
		String orgName_log = LogGetNameById.getOrgNameByOrgId(orgId);	
		
		//一系列的调动处理
		
		if(!"".equals(userId) && userIds.length>0 && !"".equals(userIds[0]) ){
			if(flag.equals("1")){
			    
				for(int i = 0; i < userIds.length; i++){
					User user = userManager.getUserById(userIds[i]);
					operContent=userName + " 把用户:["+user.getUserName()+"] 调入到 ["+ orgName_log+"] 机构下面"; 						
					logManager.log(control.getUserAccount()+":"+userName,operContent,openModle,operSource,description);    
				}
				
				if(!ConfigManager.getInstance().getConfigBooleanValue("sys.user.enablemutiorg", true)){
				//调入多个机构开关，如果sys.user.enablemutiorg为false则执行下列语句
					if(!classType.equals("lisan")){//不为离散用户调入时执行下列语句
						//先删除用户主机构关系和机构岗位关系
						boolean state2 = orgManager.deleteOrg_UserJob(CurorgId, userIds);
						if(state2){	
							//然后添加用户主机构关系和机构岗位关系
							userManager.addUserOrg(userIds, orgId, "lisan");
						}
					}else{
						//是离散用户时直接添加用户主机构和机构岗位关系
						userManager.addUserOrg(userIds, orgId, classType);	
					}
				}else{//调入多个机构开关，如果sys.user.enablemutiorg为true则执行下列语句
					if("true".equals(hold)){
						//然后添加用户主机构关系和机构岗位关系
						String[] orgIds = new String[]{orgId};
						userManager.storeBatchUserOrg(userIds, orgIds, true);
					}else{
						if(!classType.equals("lisan")){//不为离散用户调入时执行下列语句
							//先删除用户主机构关系和机构岗位关系
							boolean state2 = orgManager.deleteOrg_UserJob(CurorgId, userIds);
							if(state2){	
								//然后添加用户主机构关系和机构岗位关系
								String[] orgIds = new String[]{orgId};
								userManager.storeBatchUserOrg(userIds, orgIds, true);
							}
						 }else{
								//是离散用户时直接添加用户主机构和机构岗位关系
								userManager.addUserOrg(userIds, orgId, classType);	
						 }
					}
				}
			}
			if(flag.equals("0")){		
				System.out.println("删除操作！");
			}
		}
		
		//处理不符合调动的用户。
		if(!"".equals(userReturnInfo)){
			
%>
<script language="javascript">
    var msg = "以下用户调入失败。"
    msg += "\n<%=userReturnInfo%>";
	alert(msg);
</script> 	
<%	
	}
%>
    <script language="javascript">
    var op;
    var n = parent.document.all("userIds").options.length-1;
<%   
    for(int m=0;m<userIds.length;m++){
        String userIdValue = userIds[m];        
%>    
	    for(var i=0;i<parent.document.all("allist").options.length;i++){
	        op = parent.document.all("allist").options[i];	        
	        if(op.value=="<%=userIdValue%>"){
	            parent.addone(op.text,op.value,n);
	            <%if(hold == null){%>
	            	parent.document.all("allist").remove(i);
	            <%}%>
	        }
	    }
   
<%
}	
%>
 </script> 


