<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
AccessControl accesscontroler = AccessControl.getInstance();
String path = request.getContextPath();
accesscontroler.checkAccess(request, response);
String pagefrom = request.getParameter("pagefrom");
String homepage = request.getParameter("flag");
String index = request.getParameter("index");
String indexReturn = request.getParameter("indexReturn");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<!-- 引入jQuery -->
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="<%=path %>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"  type="text/javascript"></script>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>

<!-- 引入其它 -->
<script src="<%=path %>/ccapp/oa/resources/util/public.js" type="text/javascript"></script>
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
			if(index =='3'){
				$("#tabs").tabs('select',"tabs-3");
			}
			if(indexReturn =='2'){
				$("#tabs").tabs('select',"tabs-2");
			}
			
		});
		//打开页面
		function openForms(url, flowname){
			//var height = window.screen.availHeight;
			//var width = window.screen.availWidth;
			var width = jQuery(window.top).width();//界面宽度
			var height = jQuery(window.top).height();//界面高度
			url= url+"&height="+height+"&width="+width;
			url= url+"&windowsId=newwindows1&indexReturn="+indexReturn;
			//弹出款TOP下移，空出标签页及以上位置，165为TOP图片高度，暂时写死，应该是根据TOP的页面高度去动态获取
			openAlertWindows('newwindows1',url,flowname,width,height-86,86,'0%','','',true);
		}		
		//设置默认的返回页面
		function setIndexReturn(index){
			indexReturn = index;
		}
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
							<iframe src="dohandlist.jsp?flag=<%=homepage%>" id="frame1" frameborder="0"
								width="100%" height="500px" scrolling="no"></iframe>
						</div>
						<div id="tabs-2" >
							<iframe src="tobehandlist.jsp" id="frame2" frameborder="0"
								width="100%" height="500px"></iframe>
						</div>
						<div id="tabs-3">
							<iframe src="donehandlist.jsp" id="frame3" frameborder="0"
								width="100%" height="500px"></iframe>
						</div>
					</div>
				</div>
			</TD>
		</TR>
	</TABLE>
</body>
</html>