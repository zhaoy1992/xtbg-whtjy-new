<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String userid = accesscontroler.getUserID();//用户登录ID
	String basePath = request.getScheme() + "://"
		+ request.getServerName() + ":" + request.getServerPort()
		+ path + "/";
	String buessid = "1234";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ymj_filedownload</title>
		<link type="text/css" href="<%=path %>/ccapp/xtbg/resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" rel="stylesheet" />	
		<script type="text/javascript" src="<%=path %>/ccapp/xtbg/resources/plug/jquery-ui-1.8.16.custo/js/jquery-1.6.2.min.js"></script>
		<script type="text/javascript" src="<%=path %>/ccapp/xtbg/resources/plug/jquery-ui-1.8.16.custo/js/jquery-ui-1.8.16.custom.min.js"></script>
		<script type="text/javascript" src="<%=path %>/ccapp/xtbg/resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
		<script src="<%=path %>/ccapp/xtbg/resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	$(function() {
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
});
</script>	
</head>
<body >
	<table style="WIDTH: 100%;">
		<tr>
			<td>
				<div>
					<div id="tabs">
						<div id="titleids" style="display:none;" id="_top">
							<ul>
									<% if("1".equals(userid)){%>
										<li><a href="#tabs-1">上传文件</a></li>
									<% }%>
										<li><a href="#tabs-2">已上传</a></li>
							</ul>
						</div>
						<% if("1".equals(userid)){%>
							<div id="tabs-1">
								<iframe src="ymj_vinSwfUpload-1.2-demo2.jsp?buessid=<%=buessid %>" id="frame1"  frameborder="0" width="100%" height="340px;"></iframe>
							</div>
						<% }%>
							<div id="tabs-2">
								<iframe src="ymj_filelist.jsp?buessid=<%=buessid %>" frameborder="0" id="frame2"  width="100%" height="340px;"></iframe>
							</div>
					</div>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>