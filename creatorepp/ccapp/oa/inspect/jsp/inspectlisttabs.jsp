<%--
　　描述：督查事项查询tab页面
　　作者：肖杰
　　版本：1.0
　　日期：2013-11-6
--%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String send_time=StringUtil.deNull(request.getParameter("send_time"));
String inspect_type=StringUtil.deNull(request.getParameter("inspect_type"));
String inspect_state=StringUtil.deNull(request.getParameter("inspect_state"));
String params="&send_time="+send_time+"&inspect_type="+inspect_type+"&inspect_state="+inspect_state;

String nowyear=DateUtil.getCurrentYear();
String lastyear=Integer.parseInt(nowyear)-1+"";
String lastlastyear=Integer.parseInt(nowyear)-2+"";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 公共部分引用结束 -->		
<script type="text/javascript">
var params="<%=params%>";
	$(function() {
		$("#tabs").tabs({//每个页面只刷新一次
			select : function(event, ui) {
				var iframeitem = $(ui.panel).find("iframe");
				
				var url;
				if(ui.index == 0){
					url = "inspectlistselect.jsp?plan_endtime="+<%=nowyear%>+params;
				}if(ui.index == 1){
					url = "inspectlistselect.jsp?plan_endtime="+<%=lastyear%>+params;
				}if(ui.index == 2){
					url = "inspectlistselect.jsp?plan_endtime="+<%=lastlastyear%>+params;
				}
				//每次清理地址，然后赋值
				jQuery("#frame").attr("src","");
				//if(IsSpace($(iframeitem).attr("src"))){//只在第一次点击的时候加载
				$(iframeitem).attr("src", url);
			}
		});
		$("#titleids").css('display','block');
	    adaptationWH('_top','frame',40);
	});
</script>
<title>督查事项查询</title>
</head>
<body >
	<table style="WIDTH: 100%;">
		<tr>
			<td>
				<div>
					<div id="tabs">
						<div id="titleids" style="display:none;" id="_top">
							<ul>
								<li><a href="#tabs-1"><%=nowyear %></a></li>
								<li><a href="#tabs-1"><%=lastyear %></a></li>
								<li><a href="#tabs-1"><%=lastlastyear %></a></li>
							</ul>
						</div>
						<div id="tabs-1">
							<iframe src="inspectlistselect.jsp?plan_endtime=2013<%=params %>"; id="frame" frameborder="0"
								width="100%"></iframe>
						</div>
						
					</div>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>