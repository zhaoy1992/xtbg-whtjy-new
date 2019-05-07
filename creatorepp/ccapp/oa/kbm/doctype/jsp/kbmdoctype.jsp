<%--
	描述：知识库文档分类管理index页面
	作者：肖杰
	版本：1.0
	日期：2013-08-06
--%>
<%@ page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String action=request.getParameter("action");
	String k_type_id = request.getParameter("k_type_id");;
	String k_child_type_id = request.getParameter("k_child_type_id");
	String urlTmp = "";
	if(!StringUtil.nullOrBlank(k_type_id)){
		urlTmp = "?k_type_id="+k_type_id+"&action="+action;
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
<script type="text/javascript">
function setRightIframeSrc(url){
	$("#rightIframe").attr("src",url);
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
				<iframe src="kbmdoctypetree.jsp<%=urlTmp%>" scrolling="no" width="200px" height="650px" frameborder="0" ></iframe>
			</td>
			<td class="td_tree_border_c3d0de">
				<%if(k_child_type_id!=null){%>
				<iframe id="rightIframe" src="kbmdoctypeinfo.jsp?k_type_id=<%=k_child_type_id%>&actionName=update" scrolling="no" width="100%" height="610px" frameborder="0"></iframe>
				<%}else{%>
				<iframe id="rightIframe" src="kbmdoctypelist.jsp<%=urlTmp%>" scrolling="no" width="100%" height="610px" frameborder="0"></iframe>
				<%}%>
			</td>
		</tr>
	</table>
</body>
</html>