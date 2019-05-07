
<%@page import="com.chinacreator.xtbg.core.directory.dao.imploracle.DirectoryDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.directory.dao.DirectoryDao"%>
<%@page import="com.chinacreator.sysmgrcore.manager.db.UserManagerImpl"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page	import="com.chinacreator.xtbg.core.directory.entity.UserinfoBean"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.directory.service.*"%>
<%@page import="com.chinacreator.xtbg.core.directory.service.impl.*"%>
<%@page import="com.chinacreator.sysmgrcore.entity.User"%>
<%
/*
 * <p>Title: 更新用户信息主页面</p>
 * <p>Description: 更新用户信息主页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-21
 * @author liangbing.tao
 * @version 1.0
 */
%>


<%@ page language="java" contentType="text/html; charset=utf-8"%>

<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.sql.Date" %>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>


<%
	
		AccessControl accesscontroler = AccessControl.getInstance();	
		accesscontroler.checkAccess(request, response);
	    DirectoryDao directoryDao = new DirectoryDaoImpl();
	    UserinfoBean userinfoBean = new UserinfoBean();
	    userinfoBean.setUserid(request.getParameter("userid")) ;
	    userinfoBean.setUserRealname(request.getParameter("userRealname")) ;
	    userinfoBean.setUserMobiletel1(request.getParameter("userMobiletel1")) ;
	    userinfoBean.setUserMobiletel2(request.getParameter("userMobiletel2")) ;
	    userinfoBean.setMail(request.getParameter("mail")) ;
	    userinfoBean.setHomePhone(request.getParameter("homePhone")) ;
	    userinfoBean.setUserWorktel(request.getParameter("userWorktel"));
	    userinfoBean.setRemark4(request.getParameter("remark4"));  //短号
	    
		 directoryDao.updateTopUserInfo(userinfoBean);
%>

<script language="javascript">
var mes = "操作成功";
var bool = true;
var ok=function(){
	/* window.parent.location.reload(); */
	if(getParentWindow('windowId').userSearch){
		getParentWindow('windowId').userSearch();
	}
}
if(!window.top.removeAlertWindows('',false,bool,mes,false)){
	if(bool){
		ok();
	}
	else{
		window.top.alert(mes)
	}
}
</script>