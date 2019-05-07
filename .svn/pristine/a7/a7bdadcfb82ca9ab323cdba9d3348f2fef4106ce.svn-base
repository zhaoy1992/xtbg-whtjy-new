
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html;charset=GBK" language="java"%>
<%!

%>
<%

AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
	String notinparent = request.getParameter("notinparent");
	/**modify by tian.xia 2011.07.07jsp系统改造**/
	String insid = request.getParameter("insid");
	FlowBusiSearchDao flowBusiSearchdao = (FlowBusiSearchDao)DaoImplClassUtil.getDaoImplClass("flowBusiSearchDaoImpl");
	String procInsId = flowBusiSearchdao.getProcInsIdByBussinessId(flowBusiSearchdao.getProcInsIdByInsId(insid));
	
	String url = request.getContextPath()+"/common_workflow/monitor/ShowProcessInstanceMonitor.jsp?procInsId="+procInsId;
	
	/**modify by tian.xia 2013.04.25 需要判断，是否要在父页面中展示**/
	String parent_str = ".parent";
	if("true".equals(notinparent)){
		parent_str = "";
	}
	
	/**modify end**/
%>

<%@page import="com.chinacreator.xtbg.pub.workflow.dao.FlowBusiSearchDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%><script type="text/javascript">
window<%=parent_str%>.location = "<%=url%>","perspective_content"; 
</script>