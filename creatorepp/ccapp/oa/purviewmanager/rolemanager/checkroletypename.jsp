<%--
描述：角色类型名称校验
作者：王博
版本：1.0
时间：2013-5-15
 --%>
<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
	boolean sucess = false;
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request,response);
	
	String action = StringUtil.deNull(request.getParameter("action"));
	String type_id = StringUtil.deNull(request.getParameter("type_id"));
	String type_name = StringUtil.deNull(request.getParameter("type_name"));
	DBUtil db = new DBUtil();
	String sql = "";
	if("add".equals(action)){
		sql = "select count(*) from td_sm_roletype where type_name ='" + type_name + "'";
	}else if("update".equals(action)){
		sql = "select count(*) from td_sm_roletype where type_name ='" + type_name + "' and type_id != '" + type_id + "'";
	}
	db.executeSelect(sql);
	if(db.getInt(0,0)>0){
		sucess = true;
	}else{
		sucess = false;
	}
%>
<%=sucess%>