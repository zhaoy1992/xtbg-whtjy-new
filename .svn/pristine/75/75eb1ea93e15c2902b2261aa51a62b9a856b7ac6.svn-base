<%--
	描述：邮件主页面
	作者：肖杰
	版本：1.0
	日期：2013-11-18
--%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>JGRID</title>
<style type="text/css">
HTML{overflow: hidden;}
.td_tree_border_c3d0de{border:solid 0px #FFFFFF;height:auto}
.tree_bg_eaeaea{background: #FFFFFF}
</style>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">
function setRightIframeSrc(url){
	$("#rightIframe1").attr("src",url);
}
function setLeftIframeSrc(url){
	$("#leftIframe").attr("src",url);
}
function showLeftIframe(flag){
	if(flag){
		$("#leftTd").show();
	}else{
		$("#leftTd").hide();
	}
}
</script>
</head>
<body>
	<table width="100%">
		<tr>
			<td width="200px" class="td_tree_border_c3d0de" id="leftTd">
				<iframe id="leftIframe" src="mailtree.jsp" scrolling="no" width="200px" height="650px" frameborder="0"></iframe>
			</td>
			<td class="td_tree_border_c3d0de">
				<iframe id="rightIframe1" src="receivemail.jsp" scrolling="no" width="100%" height="610px" frameborder="0"></iframe>
			</td>
		</tr>
	</table>
</body>
</html>