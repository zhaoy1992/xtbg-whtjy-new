
<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ page import="com.chinacreator.workflow.IWorkFlow"%>
<%@ page import="com.chinacreator.workflow.WorkFlowFactory"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="org.enhydra.shark.SharkUtilities"%>
<%@ page import="org.enhydra.shark.swingclient.SharkClient"%>
<%@ page import="org.enhydra.shark.api.client.wfmodel.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%@ page import="com.chinacreator.workflow.*,com.chinacreator.sysmgrcore.entity.Job,com.chinacreator.sysmgrcore.manager.JobManager,com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>

<%
			String pkgId = request.getParameter("pkgId");
           
            if (pkgId == null)
                pkgId = (String) request.getAttribute("pkgId");
            System.out.println("pkgId:" + pkgId);
            String pkgName = request.getParameter("pkgName");
            if (pkgName == null)
                pkgName = (String) request.getAttribute("pkgName");
            String procDefId = request.getParameter("procDefId");
            if (procDefId == null)
                procDefId = (String) request.getAttribute("procDefId");
            String procDefName = request.getParameter("procDefName");
            if (procDefName == null)
                procDefName = (String) request.getAttribute("procDefName");
            String enProcDefId = "";
            if (procDefId != null)
            {
                enProcDefId = StringUtil.encode(procDefId);
            } else
            {
                enProcDefId = procDefId;
            }
            procDefId = enProcDefId;
	String url = "usermapping_info.jsp?procDefId=" + procDefId + "&procDefName="+procDefName+"&pkgName="+pkgName+"&pkgId="+pkgId+"";
	System.out.println("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq:"+url);
	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   
    
    <title></title>
       
    <script language="javascript">
    	function reloadOpener()
    	{
    		alert("²Ù×÷³É¹¦");
    		
    		if(window.opener)
    		{
    			window.close();
    			window.opener.location = "<%=url%>";
    			
    		}
    		else
    		{
    			parent.window.close();
    			parent.window.opener.location = "<%=url%>";
    		}
    	}
    </script>
  </head>
  
  <%@ include file="/epp/css/cssControl.jsp"%><body >
  <%
   out.println("<script language=\"javascript\">reloadOpener();</script>");
  %>
   
  </body>
</html>
