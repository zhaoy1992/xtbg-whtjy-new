
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html;charset=GBK" language="java"%>
<%!

%>
<%

	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	/**modify by tian.xia 2011.07.07jsp系统改造**/
	String insid = request.getParameter("insid");
	System.out.println(insid);
	FlowBusiSearchDao flowBusiSearchdao = (FlowBusiSearchDao)LoadSpringContext.getApplicationContext().getBean("flowBusiSearchDaoImpl");
	String procInsId = flowBusiSearchdao.getProcInsIdByBussinessId(flowBusiSearchdao.getProcInsIdByInsId(insid));
	
	String url = request.getContextPath()+"/common_workflow/monitor/ShowProcessInstanceMonitor.jsp?procInsId="+procInsId;
	
	
	
	/**modify end**/
%>


<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowBusiSearchDao"%>
<%@page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%><script type="text/javascript">
window.parent.location = "<%=url%>","perspective_content"; 
</script>