<%-- 
描述：权限管理TAB页面
作者：黄艺平
版本：1.0
日期：2013-04-24
 --%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.sysmgrcore.manager.OrgAdministrator"%>
<%@page import="com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl"%>
<%@page import="java.util.List"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%

AccessControl control = AccessControl.getInstance();
control.checkAccess(request, response);
String path = request.getContextPath();
OrgAdministrator orgAdministrator = new OrgAdministratorImpl();
String curUserId = control.getUserID();
List list = orgAdministrator.getManagerOrgsOfUserByID(curUserId);
boolean isAdminOrOrgManager = false;//当前登陆用户是否具有部门管理员角色或者超级管理员角色
if(list.size() > 0 || control.isAdmin()){//判断是否是部门管理员和拥有超级管理员角色
  	  isAdminOrOrgManager = true;
}

%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<!-- 引入其它 -->
<script src="../resources/jquery-1.7.1.min.js" type="text/javascript"></script>
<script src="../resources/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>


<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script> 

<script type="text/javascript">
	$(function() {
		var iframeSrcArr = new Array();
    	iframeSrcArr[iframeSrcArr.length] = "org_main1.jsp";
    	iframeSrcArr[iframeSrcArr.length] = "devyiqisbmain.jsp";
		$("#tabs").tabs({
			select : function(event, ui) {
				var iframeitem = $(ui.panel).find("iframe");
				//$(iframeitem).attr("src", $(iframeitem).attr("src"));
				 $(iframeitem).attr("src", iframeSrcArr[ui.index]);
			}
		});

		jQuery("#frame1").attr("src","org_main1.jsp");
	});
</script>
<title>权限管理</title>
</head>
<body>
	<table style="WIDTH: 100%;">
		<tr>
			<td>
				<% 
					if(true) {
				%>
				<div>
					<div id="tabs">
						<div id="titleids">
							<ul>
								<li><a href="#tabs-1">办公设备</a></li>
								<li><a href="#tabs-2">仪器设备</a></li>
							</ul>
						</div>
						<div id="tabs-1" >
							<iframe src="" id="frame1" frameborder="0" width="100%" height="550" scrolling="no"></iframe>
						</div>
						<div id="tabs-2" >
							<iframe src="" id="frame2" frameborder="0" width="100%" height="550" ></iframe>
						</div>
					</div>
				</div>
				<%
					} else  {
				%>
					<div align="center">没有权限！请与系统管理员联系</div>
				<%
					}
				%>
			</td>
		</tr>
	</table>
</body>
</html>