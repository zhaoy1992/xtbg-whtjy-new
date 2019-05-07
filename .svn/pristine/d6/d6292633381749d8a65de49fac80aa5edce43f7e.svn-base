<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@page import="com.chinacreator.sysmgrcore.purviewmanager.BussinessCheck"%>
<%@page import="com.chinacreator.sysmgrcore.purviewmanager.DefaultBussinessCheckImpl"%>
<%
/*
 * <p>Title: 岗位修改处理页面</p>
 * <p>Description: 岗位修改处理页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
 * @author liangbing.tao
 * @version 1.0
 */
%>


<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.JobManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Job"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>


<%
		AccessControl control = AccessControl.getInstance();
		control.checkManagerAccess(request,response);
		
		LogManager logManager = SecurityDatabase.getLogManager();
		BussinessCheck bussinessCheck = new DefaultBussinessCheckImpl();
		//如果为true就有岗位没有被删除
		boolean tag = false;
		StringBuffer notice = new StringBuffer("以下岗位删除失败,有机构设置了以下岗位，通过隶属机构查询功能可以查看哪些机构设置了以下岗位：\\n");
		//日志操作模块
		String opModle = "岗位管理";
		//日志操作内容
		StringBuffer operContent = new StringBuffer()
			.append("用户【").append(control.getUserAccount()).append("】删除岗位【");
		String[] id = request.getParameterValues("checkBoxOne");
		//如果为true就有岗位被删除了
		boolean isLog = false;
		boolean state = false;
		if (id != null) 
		{
			for (int i = 0; i < id.length; i++)
			 {					
				JobManager jobManager = SecurityDatabase.getJobManager();
				Job job = jobManager.getJobById(id[i]);
				if(bussinessCheck.jobDeleteCheck(id[i])){//删除岗位成功，该岗位没有被机构设置
					operContent.append(job.getJobName()).append(",");
					isLog = true;
				}else{//该岗位与机构关联，不能删除
					notice.append(job.getJobName()).append("\\n");
					tag = true;
					state = true;
				}
				
				//如果岗位与机构没有关联,删除机构 
				if(!tag){
					tag = jobManager.deleteJob(job);
				}
				
			}
		}
		operContent.append("】");
		if(isLog){//没有任何岗位被删除，就不需要记录日志
			logManager.log(operContent.toString(),opModle);
		}
		if (tag && state) //有不能被删除的岗位
		{
		%>
			<script>
			    alert("<%=notice%>");
			</script>
		<%
		} 
		else if(isLog)//所选岗位都能被删除
		{
		%>
			<script>
				alert("操作成功！");
			</script>
		<%
		}
%>

	<script>
	    window.onload = function prompt()
	    {
	        parent.divProcessing.style.display="none";
	        parent.document.location.reload(true);
	    }
	</script>
