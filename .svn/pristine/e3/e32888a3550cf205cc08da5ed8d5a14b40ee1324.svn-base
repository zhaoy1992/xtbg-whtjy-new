<%--
	描述：个人资料分类管理index页面
	作者：邱炼
	版本：1.0
	日期：2013-08-12
--%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String p_type_id = request.getParameter("p_type_id");
	String urlTmp = "";
	if(!StringUtil.nullOrBlank(p_type_id)){
		urlTmp = "?p_type_id="+p_type_id;
	}
	
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
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入其它 -->
<script src="../../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript">
function setRightIframeSrc(url){
	$("#rightIframe1").attr("src",url);
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
				<iframe src="psdatatypetree.jsp<%=urlTmp%>" scrolling="no" width="210px" height="650px" frameborder="0"></iframe>
			</td>
			<td class="td_tree_border_c3d0de">
				<iframe id="rightIframe1" src="psdatatypelist.jsp<%=urlTmp%>" scrolling="no" width="100%" height="610px" frameborder="0"></iframe>
			</td>
		</tr>
	</table>
</body>
</html>