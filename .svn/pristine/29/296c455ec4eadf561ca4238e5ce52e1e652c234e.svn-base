<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String path = accesscontroler.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.common.util.MenuUtil"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="<%=path %>/ccapp/oa/common/newlayout/resources/css/global.css" type="text/css" rel="stylesheet" />
<link href="<%=path %>/ccapp/oa/common/newlayout/resources/css/layout.css" type="text/css" rel="stylesheet" />
<title>左边菜单</title>
<script type="text/javascript">
var tree = new $.tree();
tree.treeID = "main_tree";
tree.showAreaID = "funcBar_box";
tree.secendMenuLocation = "top";

var menu =  null;
var item = null;
var secendmenu = null;
var secendmenuArray = null;
<%
String pid = "";


List<Map<String, String>> nodes = new ArrayList<Map<String, String>>();
MenuUtil menuUtil = new MenuUtil();
nodes = menuUtil.getMenus(request, response);

for(int i = 0; i < nodes.size(); i++) {
	Map<String, String> menuMap = nodes.get(i);
	pid = menuMap.get("pid");
	if("module".equals(menuMap.get("nType"))) {
		pid = menuMap.get("pid");
		if(StringUtil.isBlank(pid) && i > 0) {
%>
		tree.menuList.push(menu);
<%
		}
%>
		menu =  new $.menu();
		menu.menuId = "<%= menuMap.get("id") %>";
		menu.menuName = '<%=menuMap.get("name")%>';
		menu.text = '<%=menuMap.get("name")%>';
		menu.oper = false;
		menu.lefturl = 'left.jsp';
		menu.isfristpage = false;
		menu.className = '<%= menuMap.get("icon")%>';
		menu.description = '<%= menuMap.get("description")%>';
		menu.headimg = '<%= menuMap.get("headimg")%>';

		secendmenuArray = new Array();
<%
	} else {
		pid = menuMap.get("pid");
%>
		var secendmenu = {};
		secendmenu.menuId = "<%=menuMap.get("pid") %>";
		secendmenu.text = "<%=menuMap.get("name") %>",
		secendmenu.url = "<%=menuMap.get("url")%>",
		secendmenuArray.push(secendmenu);
		menu.secendmenu = secendmenuArray;
<%
	}
}
%>
</script>
</head>

<body>
	<div class="funcBar_box">
		<h3></h3>
		<ul>
			<li><a href="#"><b class="func_an1"></b><br />公文</a></li>
			<li><a href="#"><b class="func_an2"></b><br />通知公告公告</a></li>
			<li><a href="#"><b class="func_an3"></b><br />会议管理</a></li>
			<li><a href="#"><b class="func_an4"></b><br />信息报送</a></li>
			<li><a href="#"><b class="func_an5"></b><br />通知公告</a></li>
			<li><a href="#"><b class="func_an6"></b><br />会议管理</a></li>
			<li><a href="#"><b class="func_an7"></b><br />信息报送</a></li>
			<li><a href="#"><b class="func_an8"></b><br />会议管理</a></li>
			<li><a href="#"><b class="func_an9"></b><br />信息报送</a></li>
			<li><a href="#"><b class="func_an7"></b><br />信息报送</a></li>
			<li><a href="#"><b class="func_an8"></b><br />会议管理</a></li>
			<li><a href="#"><b class="func_an9"></b><br />信息报送</a></li>
		</ul>
	</div>
</body>
</html>
