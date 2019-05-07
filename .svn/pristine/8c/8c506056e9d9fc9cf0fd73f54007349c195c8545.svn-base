<%
/*
 * <p>Title: 用户隶属岗位保存页面</p>
 * <p>Description: 用户隶属岗位保存页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-22
 * @author liangbing.tao
 * @version 1.0
 */
 %>
 
 
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.*"%>


<%
		AccessControl control = AccessControl.getInstance();
		control.checkManagerAccess(request,response);
		
		String uid2 = request.getParameter("userId");
		Integer uid = Integer.valueOf(uid2);
		String orgId = request.getParameter("orgId");
		String jobId = request.getParameter("jobId");
		String flag = request.getParameter("flag");
		//---------------START--
		String userName_log = LogGetNameById.getUserNameByUserId(uid2);
		String orgName_log = LogGetNameById.getOrgNameByOrgId(orgId);
		String operContent="";        
        String operSource=control.getMachinedID();
        String openModle="用户管理";
        String userName = control.getUserName();
        LogManager logManager = SecurityDatabase.getLogManager(); 
 		operContent=userName+" 调整了用户 "+userName_log+" 在机构 "+ orgName_log+" 下的岗位"; 						
		logManager.log(control.getUserAccount(),operContent,openModle,operSource,"");          
		//---------------END	
		UserManager userManager = SecurityDatabase.getUserManager();
		String message = "";
		if(jobId!=null){
			String jobIds[] =StringUtil.split(jobId,"\\,");
			if(flag.equals("1")){			    
				message = userManager.storeUserOrgJob(uid,orgId,jobIds);	
			}
			if(flag.equals("0")){		
				message = userManager.deleteUserOrgJob(uid,orgId,jobIds);	
			}
		 }
%>

<script>
    window.onload = function prompt(){
    	<%
        	if("fail".equals(message)){
        		out.print("alert('操作失败！')");
        	}else if("success".equals(message)){
        		out.print("alert('操作成功！')");
        	}
        %>
        parent.divProcessing.style.display="none";
        //parent.refreshPage();
        
        parent.document.all("button1").disabled = false;
		parent.document.all("button2").disabled = false;
		parent.document.all("button3").disabled = false;
		parent.document.all("button4").disabled = false;
		parent.document.all("butn").disabled = false;
		parent.document.all("butn2").disabled = false;
        
    }
</script>