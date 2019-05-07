<%
/*
 * <p>Title: 为岗位选择机构的保存处理页面</p>
 * <p>Description:为岗位选择机构的保存处理页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-25
 * @author baowen.liu
 * @version 1.0
 */
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById,
                 com.chinacreator.sysmgrcore.manager.OrgManager,
                 com.chinacreator.sysmgrcore.manager.JobManager,
                 com.chinacreator.sysmgrcore.entity.Job,
                 com.chinacreator.sysmgrcore.entity.Organization,
                 com.chinacreator.sysmgrcore.entity.Orgjob"%>
<%
	
		//---------------START--用户组管理写操作日志
		AccessControl control = AccessControl.getInstance();
		control.checkManagerAccess(request,response);
		String operContent="";        
        String operSource=control.getMachinedID();
        String openModle="岗位管理";
        String description="";
        LogManager logManager = SecurityDatabase.getLogManager();
        OrgManager orgManager = SecurityDatabase.getOrgManager(); 		
		//---------------END
		String jobId = request.getParameter("jobId");
		String orgId = request.getParameter("orgId");
		//1为增加机构岗位关系，0为删除机构岗位关系
		String flag = request.getParameter("flag");
		
		String orgIds[] =orgId.split("\\,");
		//--用户组管理写操作日志	
		String orgNames_log = LogGetNameById.getOrgNamesByOrgIds(orgIds);
		String jobName_log = LogGetNameById.getJobNameByJobId(jobId);
		String[] arr_jobid = {jobId};
		if("0".equals(flag)){
			//System.out.println("----------------岗位编号："+jobId);
			operContent="修改岗位机构,岗位："+jobName_log+" 机构："+orgNames_log; 						
			description="";
			logManager.log(control.getUserAccount(),operContent,openModle,operSource,description);
			
			for(int i = 0; i < orgIds.length; i++){
				orgManager.deleteOrgjob(orgIds[i],arr_jobid);
			}
		}else{
		//System.out.println("----------------岗位编号："+jobId);
			operContent="修改岗位机构,岗位："+jobName_log+" 机构："+orgNames_log; 						
			description="";
			logManager.log(control.getUserAccount(),operContent,openModle,operSource,description);
			
			for(int i = 0; i < orgIds.length; i++){
				orgManager.addOrgjob(orgIds[i],arr_jobid,"1");
			}
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
        parent.document.getElementById("button5").disabled = false;
    }
</script>
