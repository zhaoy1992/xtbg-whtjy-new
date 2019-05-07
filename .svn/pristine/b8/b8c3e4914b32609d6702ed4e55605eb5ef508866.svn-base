<%--
	描述：业务类型index页面
	作者：肖杰
	版本：1.0
	日期：2013-10-30
--%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String d_type_id = request.getParameter("d_type_id");
	String urlTmp = "";
	if(!StringUtil.nullOrBlank(d_type_id)){
		urlTmp = "?d_type_id="+d_type_id;
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>JGRID</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">
function setRightIframeSrc(url){
	$("#rightIframe1").attr("src",url);
}
function setleftIframeSrc(url){
	$("#leftIframe1").attr("src",url);
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
			<td width="200px" class="content_02_box_div_table_td" id="leftTd">
				<iframe id="leftIframe1" src="navigator_content.jsp" scrolling="no" width="200px" height="580px" frameborder="0"></iframe>
			</td>
			<td class="content_02_box_div_table_td">
				<iframe id="rightIframe1" src="form_class_home.jsp" scrolling="no" width="100%" height="580px" frameborder="0"></iframe>
			</td>
		</tr>
	</table>
</body>
</html>