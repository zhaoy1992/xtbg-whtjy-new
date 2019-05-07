<%--
　　描述：会议通知阅读情况tab主页面
　　作者：黄海
　　版本：1.0
　　日期：2013-6-25
--%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.meeting.util.MeetingConstants"%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String m_notice_id = request.getParameter("m_notice_id");
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
$(function() {
	$("#tabs").tabs({//每个页面只刷新一次
		select : function(event, ui) {
			var iframeitem = $(ui.panel).find("iframe");
			if ($(iframeitem).attr("id")=="frame2" && $(iframeitem).attr("src")==""){
				$(iframeitem).attr("src", "meetingreadlist4noread.jsp?m_notice_id=<%=m_notice_id %>&m_is_read=<%=MeetingConstants.STATUS_FALSE %>");
			}
		}
	});
	$("#titleids").css('display','block');
    adaptationWH('titleids','vcenter',40);
    
	var _documentBodyHeight = window.top.findPageCacheName("_documentBodyHeight");
	jQuery("#maindiv").height(_documentBodyHeight-(_documentBodyHeight-600+100));	
	
});
</script>
<title>会议通知阅读情况</title>
</head>
<body >
	<table style="WIDTH: 100%;">
		<tr>
			<td>
				<div>
					<div id="tabs">
						<div id="titleids" style="display:none;">
							<ul>
								<li><a href="#tabs-1">已阅读</a></li>
								<li><a href="#tabs-2">未阅读</a></li>
							</ul>
						</div>
						<div id="maindiv" class="vcenter" style="height:300px;overflow-x:hidden;overflow-y:auto;">
							<div id="tabs-1">
								<iframe src="meetingreadlist.jsp?m_notice_id=<%=m_notice_id %>&m_is_read=<%=MeetingConstants.STATUS_TRUE %>" id="frame1" frameborder="0"
									 height="900" width="98%" scrolling="no"></iframe>
							</div>
							<div id="tabs-2">
								<iframe src="" id="frame2" frameborder="0"
								 height="900"	width="98%"></iframe>
							</div>
						</div>
					</div>
				</div>
			</td>
		</tr>
	</table>
	<input type="hidden" name="m_notice_id" id="m_notice_id" value="<%=m_notice_id %>" />
</body>
</html>