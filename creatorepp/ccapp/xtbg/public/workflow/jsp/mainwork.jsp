<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String pagefrom = request.getParameter("pagefrom");
String homepage = request.getParameter("flag");
String index = request.getParameter("index");
String indexReturn = request.getParameter("indexReturn");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"  type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
	<script type="text/javascript">
	var index = '<%=index%>';
	var indexReturn = '<%=indexReturn%>';
		$(function() {
			$("#tabs").tabs({
				select : function(event, ui) {
					var iframeitem = $(ui.panel).find("iframe");
					$(iframeitem).attr("src", $(iframeitem).attr("src"));
				}
			});
			$("#titleids").css('display','block');
			$("#tabs").tabs('select', '#' + '<%=pagefrom%>');
			
			<%if(CacheCommonManageProxy.getBooleanSystemParam("workMainlist")){%>
				if(indexReturn =='4'){
					$("#tabs").tabs('select',"tabs-4");
				}
				if(indexReturn =='5'){
					$("#tabs").tabs('select',"tabs-5");
				}
			<%}%>
			
			if(index =='3'){
				$("#tabs").tabs('select',"tabs-3");
			}
			if(indexReturn =='2'){
				$("#tabs").tabs('select',"tabs-2");
			}
			
		});
	</script>
	<title>工作列表</title>
</head>
<body>
	<TABLE style="WIDTH: 100%;">
		<TR>
			<TD>
				<div>
					<div id="tabs">
						<div id="titleids" style="display:none;">
							<ul>
								<li><a href="#tabs-1">待办列表</a></li>
								<li><a href="#tabs-2">暂存列表</a></li>
								<li><a href="#tabs-3">已办列表</a></li>
							</ul>
						</div>
						<div id="tabs-1" >
							<iframe src="doworklist.jsp?flag=<%=homepage%>" id="frame1" frameborder="0" scrolling="yes"
								width="100%" height="600px" scrolling="no"></iframe>
						</div>
						<div id="tabs-2" >
							<iframe src="tobeworklist.jsp" id="frame2" frameborder="0" scrolling="yes"
								width="100%" height="600px"></iframe>
						</div>
						<div id="tabs-3">
							<iframe src="doneworklist.jsp" id="frame3" frameborder="0" scrolling="yes"
								width="100%" height="600px"></iframe>
						</div>
						
					</div>
				</div>
			</TD>
		</TR>
	</TABLE>
</body>
</html>