<%--
描述：角色名称校验
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
	String role_id = StringUtil.deNull(request.getParameter("role_id"));
	String rolename = StringUtil.deNull(request.getParameter("role_name"));
	DBUtil db = new DBUtil();
	String sql = "";
	if("add".equals(action)){
		sql = "select  count(*) from td_sm_role where role_name ='"+ rolename +"'";
	}else if("update".equals(action)){
		sql = "select  count(*) from td_sm_role where role_name ='"+ rolename +"' and role_id !='"+role_id+"'";
	}
	db.executeSelect(sql);
	if(db.getInt(0,0)>0){
		sucess = true;
	}else{
		sucess = false;
	}
%>
<%=sucess%>