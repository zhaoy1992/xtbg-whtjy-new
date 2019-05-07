<%@ page language="java" pageEncoding="GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
	<%
		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request, response);
		String currentSystemID = control.getCurrentSystemID();
		String appUserName = "app_" + currentSystemID;
		appUserName = appUserName.toUpperCase();
		
		
		String dbName = request.getParameter("dbName");
		DBUtil dbUtil = new DBUtil();
		//String sql = "select djid from tb_form ";
		String sql = "select t.* from TB_FORM t,FC_BILLZL f where t.djid=f.djid and f.xmltext is not null";
		dbUtil.executeSelect(dbName,sql);
		StringBuffer sb = new StringBuffer("");
		sb.append("[");
		for (int i = 0; i < dbUtil.size(); i++) {
			sb.append("{\"djid\":\"").append(dbUtil.getString(i,"djid")).append("\", \"cssFolder\":\"").append(dbUtil.getString(i, "CSSFOLDER")).
				append("\", \"eformId\":\"").append(dbUtil.getString(i, "eform_id")).append("\"}");
			if(i!=dbUtil.size()-1){
				sb.append(",");
			}
		}
		sb.append("]");
		out.print(sb.toString());
	%>

