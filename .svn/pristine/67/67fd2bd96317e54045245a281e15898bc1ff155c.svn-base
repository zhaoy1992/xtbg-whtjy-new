<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%
    AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link type="text/css" rel="stylesheet"
	href="../../../../resources/css/tabstyle.jsp" />
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen"
	href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script
	src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
	type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/development-bundle/ui/i18n/jquery.ui.datepicker-zh-CN.js"></script>

<!-- 引入jQuery_dialog -->
<link rel="stylesheet" type="text/css" media="screen"
	href="../../../resources/plug/jquery_dialog/jquery_dialog.css" />
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript">
$(function() {
	$( "#tabs" ).tabs({
		select: function(event, ui) {
		var iframeitem = $(ui.panel).find("iframe");
		$(iframeitem).attr("src",$(iframeitem).attr("src"));
		 //$(ui.panel).load("doworklist.jsp");

    	}
	}); 
});
</script>
<title>信息维护</title>
</head>
<body>
<!-- 栏目+快速搜索 -->
	<table class="ColumnTableArea">
      <tr>
        <td class="Columnbg">信息统计</td>
        <td>&nbsp;</td>
        <td ></td>
      </tr>
    </table>
	<TABLE style="WIDTH: 100%;">
			<TR>
				<TD>
				<div class="demo">
				<div id="tabs">
					<ul>
						<li><a href="#tabs-1">数字统计</a></li>
						<li><a href="#tabs-2">详细统计</a></li>
					</ul>
					<div id="tabs-1">
						<iframe src="infoStatisticsList.jsp" id="frame1"  frameborder="0" width="100%" height="510px"></iframe>
					</div>
					<div id="tabs-2">
						<iframe src="infoStaDetailList.jsp" id="frame2"  frameborder="0" width="100%" height="510px"></iframe>
					</div>
				</div>
				</div>
				</TD>
			</TR>
		</TABLE>
</body>
</html>