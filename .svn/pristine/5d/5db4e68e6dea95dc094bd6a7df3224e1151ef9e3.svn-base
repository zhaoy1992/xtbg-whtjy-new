<%@page contentType="text/html;charset=GBK"%>
<%@page import="com.chinacreator.workflow.shark.procconfig.ProcessConfigManager"%>
<%
String actId = request.getParameter("actId");
String pro_name = request.getParameter("pro_name");
String pro_version = request.getParameter("pro_version");
String pro_id = request.getParameter("pro_id");
String mgrName = "";
ProcessConfigManager processConfigManager = new ProcessConfigManager();
String combJson = "{Data:[]}";
if(actId != null){
	mgrName = pro_name + "#" + pro_version + "#" + pro_id;
	combJson = processConfigManager.getBeforeActs(actId,mgrName);
}
out.print(combJson);
%>
