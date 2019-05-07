<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager,com.chinacreator.sysmgrcore.manager.OrgManager
				,com.chinacreator.sysmgrcore.manager.JobManager,java.util.List" %>
<%@page import="com.chinacreator.sysmgrcore.entity.*,com.chinacreator.sysmgrcore.web.struts.form.*"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.db.OrgCacheManager
				,java.util.ArrayList" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkAccess(pageContext);
	
	//String userId = (String)session.getAttribute("userId");
	String userId = request.getParameter("userId");
		if (userId == null) {
			out.println("�û�������");
			return;
		} 
	UserManager userManager = SecurityDatabase.getUserManager();
	User user = userManager.getUserById(userId);
  	String userName= user.getUserRealname();
	
		OrgManager orgManager = SecurityDatabase.getOrgManager();
		String orgid = request.getParameter("orgId");
		//��ȡ��ǰ�Ĳ������ڵĻ���
		Organization org = OrgCacheManager.getInstance().getOrganization(orgid);
		
		
		JobManager jobManager = SecurityDatabase.getJobManager();
			
		List existJob = jobManager.getJobList(org,user);//�û��ڵ�ǰ�����µĸ�λ
		List allJob = jobManager.getJobList(org);	
		
		//Ȩ�޹��ˣ� �ܽ��и�λ����ĸ�λ�����ǣ���ǰ��¼�û����������Ź���Ա���������Щ��λ�л������õ�Ȩ�ޡ�	
		List list1 = new ArrayList();
	    if(existJob != null)
	    {
	    	for(int i=0;i<existJob.size();i++)
	    	{
	    		Job job = (Job)existJob.get(i);
	    		if(accessControl.checkPermission(job.getJobId(), "orgset", AccessControl.JOB_RESOURCE))
	    		{
	    			list1.add(job);
	    		}
	    	}
	    }
	    List list2 = new ArrayList();
	    if(allJob != null)
	    {
	    	for(int i=0;i<allJob.size();i++)
	    	{
	    		Job job = (Job)allJob.get(i);
	    		if(accessControl.checkPermission(job.getJobId(), "orgset", AccessControl.JOB_RESOURCE))
	    		{
	    			list2.add(job);
	    		}
	    	}
	    }
		session.setAttribute("existJob", list1);
		session.setAttribute("allJob", list2);
%>
<html>
  <head>
  <title>�û���<%=userName%>��������λ</title>
  </head>
<frameset rows="*" cols="100%" framespacing="3" frameborder="yes" border="0" >
<frame src="../user/changeJob_ajax.jsp?userId=<%=userId%>&orgId=<%=orgid%>" name="lusersys1" id="lusersys1">
<!--frame src="../user/rusersys_ajax.jsp" name="rusersys1" id="rusersys1"-->
</frameset>
</html>