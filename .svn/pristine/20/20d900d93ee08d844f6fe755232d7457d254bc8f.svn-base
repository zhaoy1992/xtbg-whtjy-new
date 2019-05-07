<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
	<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String select  = request.getParameter("select");
	String username = accesscontroler.getUserAccount();
	if(StringUtil.isBlank(select)){
		select = "111";
	}
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
	var select = "<%=select%>"
		$(function() {
			$("#tabs").tabs({
				select : function(event, ui) {
					var iframeitem = $(ui.panel).find("iframe");
					$(iframeitem).attr("src", $(iframeitem).attr("src"));
					var selected = $("#tabs").tabs('option', 'selected'); 
					if(selected==3){
						$("#frame4").attr("src","sendMail.jsp");
					}
				}
			});
			$("#titleids").css('display','block');
			
			if(select != "111"){
				$("#tabs").tabs({ selected: "<%=select%>" });
			}
		});
		
</script>

<title>邮件tabs页</title>
</head>

<body onload="adaptationWH('titleids','frame1',20);adaptationWH('titleids','frame2',20);adaptationWH('titleids','frame3',20);adaptationWH('titleids','frame4',20);">
	
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
								<li><a id="tabs1" href="#tabs-1" >收件箱</a></li>
								<li><a id="tabs3" href="#tabs-2" >草稿箱</a></li>
								<li><a id="tabs4" href="#tabs-3" >已发送</a></li>
								<%if(CacheCommonManageProxy.getBooleanSystemParam("mailName")){%>
									<li><a id="tabs2" href="#tabs-4" >发文件</a></li>
								<%}else{ %>
									<li><a id="tabs2" href="#tabs-4" >发邮件</a></li>
								<%} %>
								<%if(CacheCommonManageProxy.getBooleanSystemParam("mail.checkEmailBoxMemory") && "admin".equals(username)){%>
									<li><a id="tabs5" href="#tabs-5" >邮箱配置</a></li>
								<%} %>
							</ul> 
						</div>
						
						<div id="tabs-1">
							<iframe src="receiveMail.jsp" id="frame2" frameborder="0"
								width="100%" height="400px" scrolling="yes"></iframe>
						</div>
						<div id="tabs-2">
							<iframe src="cgMail.jsp" id="frame2" frameborder="0"
								width="100%" height="400px" scrolling="yes"></iframe>
						</div>
						<div id="tabs-3">
							<iframe src="yjSendMail.jsp" id="frame3" frameborder="0"
								width="100%" height="400px" scrolling="yes"></iframe>
						</div>
						<div id="tabs-4">
							<iframe src="sendMail.jsp" id="frame4" frameborder="0"
								width="100%" height="400px" scrolling="yes"></iframe>
						</div>
						<%if(CacheCommonManageProxy.getBooleanSystemParam("mail.checkEmailBoxMemory") && "admin".equals(username)){%>
						<div id="tabs-5">
							<iframe src="configEmail.jsp" id="frame4" frameborder="0"
								width="100%" height="400px" scrolling="yes"></iframe>
						</div>
						<%} %>
						
						
					</div>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>