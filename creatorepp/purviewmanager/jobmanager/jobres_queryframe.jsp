<%
/*
 * <p>Title: ��ԴȨ�޲�ѯ������</p>
 * <p>Description: ��ԴȨ�޸�λ������</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-26
 * @author baowen.liu
 * @version 1.0
 */
%>

<%@ page contentType="text/html; charset=GBK" language="java" %>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.*"%>

<%@ page import="com.chinacreator.sysmgrcore.entity.Job,
				com.chinacreator.sysmgrcore.manager.JobManager,
				com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkManagerAccess(request,response);

String jobId = (String)request.getParameter("jobId");
JobManager jm = SecurityDatabase.getJobManager();
String jobName = null;
if(jobId != null && !jobId.equals("")){
	Job job = jm.getJobById(jobId);
	jobName = job.getJobName();
}
%>
<HTML>
 <HEAD>
   <title>��λ��<%=jobName%>����ԴȨ�޲�ѯ</title>
 
 </HEAD>
  <frameset rows="30,*" border=0>
	<frame frameborder=0  noResize scrolling="no" marginWidth=0 name="forQuery" src="jobres_query.jsp?jobId=<%=jobId%>"></frame>		
	<frame frameborder=0  noResize scrolling="auto" marginWidth=0 name="forDocList" src="jobres_querylist.jsp?jobId=<%=jobId%>"></frame>
	</frameset><noframes></noframes>
</HTML>
