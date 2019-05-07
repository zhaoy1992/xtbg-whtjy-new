<%
/*
 * <p>Title: 岗位机构树页面</p>
 * <p>Description: 岗位机构树页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-25
 * @author baowen.liu
 * @version 1.0
 */
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page
	import="com.chinacreator.security.AccessControl,
	com.chinacreator.sysmgrcore.entity.Job,
	com.chinacreator.sysmgrcore.manager.JobManager,
	com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request,response);
	String jobId = request.getParameter("jobId");
	JobManager jobManager = SecurityDatabase.getJobManager();
	Job job = jobManager.getJobById(jobId);
	String jobName = job.getJobName();
	String href = "jobconferorg.jsp?jobId="+ jobId;
%>
<html>
<head>    
  <title>属性容器</title>
  <link rel="stylesheet" type="text/css" href="../css/windows.css">
  <link rel="stylesheet" type="text/css" href="../css/treeview.css"> 
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
<div id="contentborder">

<form name="OrgJobForm" action="" method="post" >
<table class="table" width="100%" border="0" cellpadding="0" cellspacing="1"> 
  <tr class="tr" >
     <td  class="td">
     
    <tree:tree tree="role_org_tree"
    	           node="role_org_tree.node"
    	           imageFolder="../images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
    			   href="<%=href%>"
    			   target="orgList"
    			   mode="static-dynamic"
    			   >                         
                   <tree:param name="jobId"/>

    			   <tree:treedata treetype="com.chinacreator.sysmgrcore.purviewmanager.menu.OrgTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="机构树"
    	                   expandLevel="1"
    	                   showRootHref="true"
    	                   needObserver="false"
    	                   refreshNode="false"
    	                   />
    	</tree:tree>
	</td>				  
  </tr>  
</table>
</form>

</div>
</body>
</html>
