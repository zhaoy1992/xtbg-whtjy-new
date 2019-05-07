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
<!-- 引入jQuery -->
<script type="text/javascript"
	src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script
	src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
	type="text/javascript"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>

	<script type="text/javascript">
		$(function() {
			$("#tabs").tabs({
				select : function(event, ui) {
					var iframeitem = $(ui.panel).find("iframe");
					$(iframeitem).attr("src", $(iframeitem).attr("src"));
				}
			});
			$("#titleids").css('display','block');
		});
	</script>
	<title>在线人数详细信息</title>
</head>
<body>
	<TABLE style="WIDTH: 100%;">
		<TR>
			<TD>
				<div>
					<div id="tabs">
						<div id="titleids" style="display:none;" id="_top">
							<ul>
								<li><a href="#tabs-1">树型显示</a></li>
								<li><a href="#tabs-2">列表显示</a></li>
								<!--  <li><a href="#tabs-3">退稿列表</a></li>-->
							</ul>
						</div>
						<div id="tabs-1">
							<iframe src="../../tree/jsp/viewOnlineTreer.jsp" id="frame1" frameborder="0"
								width="100%" height="400px"></iframe>
						</div>
						<div id="tabs-2">
							<iframe src="loginViewList.jsp" id="frame2" frameborder="0" scrolling="no"
								width="100%" height="330px"></iframe>
						</div>
					</div>
				</div>
			</TD>
		</TR>
	</TABLE>
</body>
</html>