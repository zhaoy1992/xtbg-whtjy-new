<%--
　　描述：设置活动环节功能tab操作页面
　　作者：黄海
　　版本：1.0
　　日期：2013-05-31
--%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/util/public.js" charset="utf-8"></script>

<!-- 公共部分引用结束 -->		
<% 
String actionId = request.getParameter("actionId");//活动id
String bussinessType = request.getParameter("bussinessType");//业务类型
String action_name = request.getParameter("action_name");//活动名称
action_name = URLDecoder.decode(action_name, "UTF-8" );
%>
<script type="text/javascript">
	$(function() {
		//特检院OA 中文乱码问题
		var url = "setacttextstatus.jsp?actionId=<%=actionId %>&action_name="+escape(escape("<%=action_name %>"));
		var url2 = "setactcolstatus.jsp?actionId=<%=actionId %>&bussinessType=<%=bussinessType %>&action_name="+escape(escape("<%=action_name %>"));
		jQuery("#frame1").attr("src",url);
		jQuery("#frame2").attr("src",url2);
		$("#tabs").tabs({
			select : function(event, ui) {
				var iframeitem = $(ui.panel).find("iframe");
				$(iframeitem).attr("src", $(iframeitem).attr("src"));
			}
		});
		$("#titleids").css('display','block');
	    adaptationWH('_top','frame1',0);
		adaptationWH('_top','frame2',0);
	});
</script>
<title>公告列表</title>
</head>
<body >
	<table style="WIDTH: 100%;">
		<tr>
			<td>
				<div>
					<div id="tabs">
						<div id="titleids" style="display:none;" id="_top">
							<ul>
								<li><a href="#tabs-1">扩展信息</a></li>
								<li><a href="#tabs-2">表单元素</a></li>
							</ul>
						</div>
						<div id="tabs-1">
							<iframe src="" id="frame1" frameborder="0" heigth="100%" width="100%" ></iframe>
						</div>
						<div id="tabs-2">
							<iframe src="" id="frame2" frameborder="0" width="100%"></iframe>
						</div>
					</div>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>