<%--
	描述：字典数据主界面
	作者：肖杰
	版本：1.0
	日期：2013-7-23
--%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String orgid=request.getParameter("orgid");
	String dict_type=request.getParameter("dict_type");
	String dictdata_id=request.getParameter("dictdata_id");

%>
<title>字典数据主界面</title>
<style type="text/css">
HTML{overflow: hidden;}
</style>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">

function getTempValue(url){
	$("#dictdata").attr("src",url);
}
jQuery(function(){
	if((""!="<%=orgid%>")&&("1"=="<%=dict_type%>")){
		var url1="dictdata_tree.jsp?orgid=<%=orgid %>&dict_type=<%=dict_type %>&dictdata_id=<%=dictdata_id %>";
		var url2="dictdatalist.jsp?orgid=<%=orgid %>&dict_type=<%=dict_type %>";
		jQuery("#dictdatatree").attr("src",url1);
		jQuery("#dictdata").attr("src",url2);
	}
});
</script>
</head>
<body style="overflow-y: hidden;">
	<table width="100%">
		<tr>
			<%if((!StringUtil.isBlank(orgid))&&("1".equals(dict_type))){ %>
			<td width="180px">
				<iframe id="dictdatatree" name="dictdatatree" src="" scrolling="no" width="180px" height="680" style="padding:0px;" frameborder="0"></iframe>
			</td>
			<td>
				<iframe id="dictdata" src=""  scrolling="no" width="100%" height="680" frameborder="0"></iframe>
			</td>
			<%}else{ %>
			<td>
				<iframe id="dictdata" src="dictdatalist.jsp?orgid=<%=orgid %>" scrolling="no" width="100%" height="680" frameborder="0"></iframe>
			</td>
			<%} %>
		</tr>
	</table>
</body>
</html>