<%@page import="com.chinacreator.xtbg.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.home.entity.HomeMenuListBean"%>
<%@page import="com.chinacreator.xtbg.home.entity.HomeListBean"%>
<%@page import="com.chinacreator.xtbg.home.entity.HomeTotalBean"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.home.service.impl.HomeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.home.service.HomeServiceIfc"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.framework.*"%>
<%@ page contentType="text/html; charset=GBK"%>
<% 
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userId = accesscontroler.getUserID();
	
	String modulePath = "module::menu://sysmenu$root";
	MenuHelper menuHelper = new MenuHelper(accesscontroler);
	ModuleQueue moduleQueue = menuHelper.getSubModules(modulePath);
	List<Module> moduleList = moduleQueue.getList();
	
	HomeServiceIfc homeServiceIfc = new HomeServiceImpl();
	Map<String, Object> homeconigMap = homeServiceIfc.findHomeConfigById(moduleList, userId);
	
	List<HomeTotalBean> homeTotalBeanList = null;
	List<HomeListBean> homeListBeanList = null;
	List<HomeMenuListBean> homeMenuListBeanList = null;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首页配置</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入公共JS -->
<script src="../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script type="text/javascript">
function saveHomeConfig(){
		var url = "homeconfigdo.jsp";

		params =  {
			jsonparam : toJasonParam()			
		}
		$.ajax({
			url: url,
			type: 'POST',
			dataType: 'json',
			data: params,
			//async : false, 是否为同步：默认是true为异步处理，false为同步处理，如果为同步处理会锁住浏览器，如果此时调试会卡死浏览器，建议调试的时候将此值设为注释掉
			success: function(data){
					alert("操作成功！");
					window.returnValue = "1";
					window.close();
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert("操作失败！");
				window.close();
			}
		});	
}

function toJasonParam(){
	var str = "{'list_id':'"+getCheckValueId("homeListId")+"','menu_id':'"+getCheckValueId("homeMenuId")+"',"+
	"'totaltype_id':'"+getCheckValueId("hometotalId")+"','user_id':'"+<%=userId %>+"'}";
	return descape(escape(str));
}

function getCheckValueId(ids) {
	var checkValue = $("#" + ids).find(":checked");
	var checkArr = [];
	checkValue.each(function () {
		checkArr.push($(this).val());
	});
	return checkArr.join();
}
</script>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<link href="css/Table.css" rel="stylesheet" type="text/css" />
<link href="css/Element.css" rel="stylesheet" type="text/css" />
</head>

<body>
<table class="ctable01" border="0" cellspacing="0" cellpadding="0">

  <tr>
    <td align="center">
	
	<!--首页配置 -->
	<div class="tc_titletext">
	统计菜单配置
	</div>
	
	<div class="start_stu_ydiv" id="hometotalId">
	<ul>
	<%
		if(homeconigMap != null) {
			homeTotalBeanList = (List<HomeTotalBean>)homeconigMap.get("homeTotalBeanList");
			if(homeTotalBeanList.size() > 0) {
				for (int i = 0; i < homeTotalBeanList.size(); i++) {
					HomeTotalBean homeTotalBean = homeTotalBeanList.get(i);
	%>
	<li>
	<input type="checkbox" <%if(!StringUtil.isBlank(homeTotalBean.getTotaltypeconfig_id()) ){%>checked<%} %> value="<%=homeTotalBean.getTotaltype_id() %>"/><%=homeTotalBean.getTotaltype_name() %>
	</li>
	<%
				}
			}
		}
	%>
	</ul>
	
	</div>
	<!--2222 -->
	<div class="tc_titletext">
	列表配置
	</div>
	
	<div class="start_stu_ydiv" id="homeListId">
	<ul>
	<%
		if(homeconigMap != null) {
			homeListBeanList = (List<HomeListBean>)homeconigMap.get("homeListBeanList");
			if(homeListBeanList.size() > 0) {
				for (int i = 0; i < homeListBeanList.size(); i++) {
					HomeListBean homeListBean = homeListBeanList.get(i);
	%>
	<li>
	<input name="listRadio" type="radio" <%if(!StringUtil.isBlank(homeListBean.getHomelistconfig_id()) ){%>checked<%} %> value="<%=homeListBean.getList_id() %>"/><%=homeListBean.getList_name() %>
	</li>
	<%
				}
			}
		}
	%>
	
	</ul>
	
	

	</div>
	
	<!--33333 -->
	<div class="tc_titletext">
	菜单配置
	</div>
	
	<div class="start_stu_ydiv" id="homeMenuId">
	<ul>
	<%
		if(homeconigMap != null) {
			homeMenuListBeanList = (List<HomeMenuListBean>)homeconigMap.get("homeMenuListBeanList");
			if(homeMenuListBeanList.size() > 0) {
				for (int i = 0; i < homeMenuListBeanList.size(); i++) {
					HomeMenuListBean homeMenuListBean = homeMenuListBeanList.get(i);
	%>
	<li>
	<input type="checkbox" <%if(!StringUtil.isBlank(homeMenuListBean.getHomemenuconfig_id()) ){%>checked<%} %> value="<%=homeMenuListBean.getMenu_id() %>"/><%=homeMenuListBean.getMenu_name() %>
	</li>
	<%
				}
			}
		}
	%>

	</ul>
	
	</div>
	
	</td>
  </tr>
  <tr>
    <td valign="top" class="tc_cbutton01">
	<input name="" type="button" value="确定" class="cButton_Gray" onclick="saveHomeConfig()"/> <input name="" type="button" onclick="window.close();" value="关闭" class="cButton_Gray" />	</td>
  </tr>
</table>
</body>
</html>
