<%@page contentType="text/html;charset=GBK"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%
	String process_config_id = "";
	if(request.getParameter("process_config_id")!=null){
		process_config_id = request.getParameter("process_config_id");
	}

	String id = "";
	if(request.getParameter("id")!=null){
		id = request.getParameter("id");
	}
	System.out.println("id==="+id+"   process_config_id=="+process_config_id);
	DBUtil dbUtil = new DBUtil();
	dbUtil.executeUpdate("update shark.module_process_config set IS_AVAILABLE='N' where MODULE_ID='"+id+"'");
	dbUtil.executeUpdate("update shark.module_process_config set IS_AVAILABLE='Y' where process_config_id='"+process_config_id+"'");
%>

