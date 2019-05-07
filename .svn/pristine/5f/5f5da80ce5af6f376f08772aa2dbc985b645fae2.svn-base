<%--
　　描述：档案管理--部门待归档管理
		显示两个标签页:
			filedocbeforearchivelist.jsp
				一 显示 处于 公文归档后的需要调整的 未提交部门档案管理员的档案
			filedocbeforearchivelisthou.jsp
				二 显示 处于 公文归档后的需要调整的 已提交部门档案管理员的档案
　　作者：邹拓
　　日期：2014-05-23
	参数 ：null
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"  type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(function() {
			$("#tabs").tabs({
				select : function(event, ui) {
					var iframeitem = $(ui.panel).find("iframe");
					$(iframeitem).attr("src", $(iframeitem).attr("src"));
				}
			});
			$("#titleids").css('display','block');
			$("#tabs").tabs('select', '#tabs-1');
		});
	</script>
	<title>工作列表</title>
</head>
<body>
	<table style="WIDTH: 100%;">
		<tr>
			<td>
				<div>
					<div id="tabs">
						<div id="titleids" style="display:none;">
							<ul>
								<li><a href="#tabs-1">未提交</a></li>
								<li><a href="#tabs-2">已提交</a></li>
							</ul>
						</div>
						<div id="tabs-1" >
							<iframe src="filedocbeforearchivelist.jsp" id="frame1" frameborder="0"
								width="100%" height="500px" scrolling="no"></iframe>
						</div>
						<div id="tabs-2" >
							<iframe src="filedocbeforearchivelisthou.jsp" id="frame2" frameborder="0"
								width="100%" height="500px"></iframe>
						</div>
					</div>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>