<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html>
<head>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

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

<title>台账tabs页</title>
</head>

<body onload="adaptationWH('titleids','frame1',20);adaptationWH('titleids','frame2',20);adaptationWH('titleids','frame3',20);">
	<table style="WIDTH: 100%;">
	<tr>
    <td>

	</td>
  </tr>
		<tr>
			<td>
				<div>
					<div id="tabs">
						<div id="titleids" style="display:none;">
							<ul>
								<li><a href="#tabs-1">办公设备</a></li>
								<li><a href="#tabs-2">仪器设备</a></li>
								<li><a href="#tabs-3">土地房屋</a></li>
								<li><a href="#tabs-4">电器</a></li>
								<li><a href="#tabs-5">公用物资</a></li>
								<li><a href="#tabs-6">家具</a></li>
								<li><a href="#tabs-7">车辆</a></li>
							</ul>
						</div>
						<div id="tabs-1">
							<iframe src="officeaccountlist.jsp" id="frame1" frameborder="0"
								width="100%" height="400px" scrolling="yes"></iframe>
						</div>
						<div id="tabs-2">
							<iframe src="devaccountinfolist.jsp" id="frame2" frameborder="0"
								width="100%" height="400px" scrolling="yes"></iframe>
						</div>
						<div id="tabs-3">
							<iframe src="" id="frame3" frameborder="0"
								width="100%" height="400px" scrolling="yes"></iframe>
						</div>
						<div id="tabs-4">
							<iframe src="" id="frame4" frameborder="0"
								width="100%" height="400px" scrolling="yes"></iframe>
						</div>
						<div id="tabs-5">
							<iframe src="" id="frame5" frameborder="0"
								width="100%" height="400px" scrolling="yes"></iframe>
						</div>
						<div id="tabs-6">
							<iframe src="" id="frame6" frameborder="0"
								width="100%" height="400px" scrolling="yes"></iframe>
						</div>
						<div id="tabs-7">
							<iframe src="" id="frame7" frameborder="0"
								width="100%" height="400px" scrolling="yes"></iframe>
						</div>
					</div>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>