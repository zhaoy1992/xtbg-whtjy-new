<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.sysmgrcore.manager.db.RoleCacheManager"%>
<%
/**
 * 
 * <p>Title: 角色刷新缓冲处理页面</p>
 *
 * <p>Description: 角色刷新缓冲处理页面</p>
 *
 * <p>Copyright: Copyright (c) 2008</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2008-10-14
 * @author gao.tang
 * @version 1.0
 */
 %>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request, response);
	
	String errorMessage = "";
	RoleCacheManager roleCacheManager = RoleCacheManager.getInstance();
	try{
		roleCacheManager.reset();
	}catch(Exception e){
		errorMessage = e.getMessage();
	}
%>
<script language="javascript">
<%if("".equals(errorMessage)){ %>
	alert("操作成功！");
<%}else{ %>
	alert("操作失败，原因如下：\\n<%=errorMessage %>");
<%} %>
</script>