<%
/**
 * <p>Title: 机构岗位设置处理页面</p>
 * <p>Description: 机构岗位设置处理页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-17
 * @author da.wei
 * @version 1.0
 **/
 %>
  <%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.OrgJobAction"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.*"%>
<%
	
		//---------------START--用户组管理写操作日志
		AccessControl control = AccessControl.getInstance();
		control.checkManagerAccess(request,response);
		String operContent="";        
        String operSource=control.getMachinedID();
        String openModle="机构管理";
        String userName = control.getUserAccount();//getUserName();
        String description="";
        LogManager logManager = SecurityDatabase.getLogManager(); 		
		//---------------END
		//多个jobId
		String mutijobId = request.getParameter("jobId");
		String orgId = request.getParameter("orgId");
		String jobSn = request.getParameter("jobSn");
		String[] arr_jobid = mutijobId.split(",");
		OrgManager orgManager = SecurityDatabase.getOrgManager();
		String jobName_log = "";
		for(int j = 0; j < arr_jobid.length; j++){
			if("".equals(jobName_log)){
				jobName_log = LogGetNameById.getJobNameByJobId(arr_jobid[j]);
			}else{
				jobName_log += "," + LogGetNameById.getJobNameByJobId(arr_jobid[j]);
			}
		}
		String orgName_log = LogGetNameById.getOrgNameByOrgId(orgId);			
		if(jobSn == null)//递归 把岗位设置到子机构
		{
			//--用户组管理写操作日志	
			operContent="递归添加机构及岗位的关系,岗位："+jobName_log+"　机构："+orgName_log; 						
			description="";
			logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);          
			//--	end	 --
			String jobIds = request.getParameter("jobIds");
			orgManager.addSubOrgjob(orgId,jobIds.split(","));		   
		}
		else if(jobSn.equals("-1"))//删除岗位
			{
			//--用户组管理写操作日志	
			operContent="删除机构及岗位的关系,岗位："+jobName_log+"　机构："+orgName_log; 						
			description="";
			logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);          		
			//--	end	 --
			orgManager.deleteOrgjob(orgId,arr_jobid);
		}
		else if(jobSn.equals("-2"))//递归删除岗位
			{
			//--用户组管理写操作日志	
			operContent="递归删除机构及岗位的关系,岗位："+jobName_log+"　机构："+orgName_log; 						
			description="";
			logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);          		
			//--	end	 --
			orgManager.deleteSubOrgjob(orgId,arr_jobid);
		}
		else{//增加岗位
			//--用户组管理写操作日志	
			operContent="添加机构及岗位的关系,岗位："+jobName_log+"　机构："+orgName_log; 						
			description="";
			logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);          
			//--	end	 --
		    orgManager.addOrgjob(orgId,arr_jobid,jobSn);
		}
%>
<script>
    window.onload = function prompt(){
        alert("操作成功!");
        parent.divProcessing.style.display="none";
        parent.document.getElementById("button1").disabled = false;
        parent.document.getElementById("button2").disabled = false;
        parent.document.getElementById("button3").disabled = false;
        parent.document.getElementById("button4").disabled = false;
        parent.document.getElementById("button11").disabled = false;
        parent.document.getElementById("button22").disabled = false;
        parent.document.getElementById("button33").disabled = false;
        parent.document.getElementById("button44").disabled = false;
        parent.document.getElementById("button55").disabled = false;
        parent.document.getElementById("button111").disabled = false;
        parent.document.getElementById("button222").disabled = false;
        parent.document.getElementById("button333").disabled = false;
    }
</script>