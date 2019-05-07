<%--
描述：薪酬更新用户信息
作者：童佳
日期：2014-03-25
 --%>
 <%@page import="com.chinacreator.xtbg.core.directory.entity.HeTongBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@page	import="com.chinacreator.xtbg.core.directory.entity.UserinfoBean"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.directory.service.*"%>
<%@page import="com.chinacreator.xtbg.core.directory.service.impl.*"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	
	UserinfoBean userinfoBean = new UserinfoBean();
	userinfoBean.setUserid(request.getParameter("userid"));
	userinfoBean.setUserRealname(request.getParameter("userRealname"));
	//特检院 OA  追加 薪酬信息 start
	userinfoBean.setNew_xc_gwgz(request.getParameter("new_xc_gwgz"));
	userinfoBean.setNew_xc_xjgz(request.getParameter("new_xc_xjgz"));
	userinfoBean.setNew_xc_yfgz(request.getParameter("new_xc_yfgz"));
	userinfoBean.setNew_xc_yb(request.getParameter("new_xc_yb"));
	userinfoBean.setNew_xc_ylbx(request.getParameter("new_xc_ylbx"));
	userinfoBean.setNew_xc_sybx(request.getParameter("new_xc_sybx"));
	userinfoBean.setNew_xc_gjj(request.getParameter("new_xc_gjj"));
	userinfoBean.setNew_xc_cb(request.getParameter("new_xc_cb"));
	userinfoBean.setNew_xc_cbhj(request.getParameter("new_xc_cbhj"));
	userinfoBean.setNew_xc_sfhj(request.getParameter("new_xc_sfhj"));
	//特检院 OA  追加 薪酬信息  end
	
	DirectoryServiceIfc service = new DirectoryServiceImpl();
	service.updateUserXCinfo(userinfoBean);
%>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
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