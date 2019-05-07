<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String index = request.getParameter("index");
	AccessControl accesscontroler = AccessControl.getInstance();
	String path = request.getContextPath();
	accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();//获得当前登录用户id
	String username = accesscontroler.getUserAccount();
	String todoworktabstype =request.getParameter("todoworktabstype");
	String entrance = request.getParameter("entrance");
	String pagefrom1=request.getParameter("pagefrom");
	String indexReturn = request.getParameter("indexReturn");
		
		String waittotal=request.getParameter("waittotal");
	/*获取待办列表统计数据end*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- 引入jQuery -->
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="<%=path%>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入其它 -->
<script src="<%=path%>/ccapp/oa/resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!--公共部分结束  -->
<script type="text/javascript">
var indexReturn = '<%=indexReturn%>';
		$(function() {
			$("#tabs").tabs({
				select : function(event, ui) {
					var iframeitem = $(ui.panel).find("iframe");
					$(iframeitem).attr("src", $(iframeitem).attr("src"));
				}
			});
			$("#tabs").tabs("select","<%=index%>");
			$("#titleids").attr("style","display:true");
			
		});
		function countTotaltApproval(num){
			$("#t1").html("("+num+")");
		}
		function countTotaltRead(num){
			$("#t2").html("("+num+")");
		}
		function countTotaltWork(num){
			$("#t3").html("("+num+")");
		}
		function countTotaltProcess(num){
			$("#t4").html("("+num+")");
		}
		function countTotaltMeeting(num){
			$("#t5").html("("+num+")");
		}
		function countTotaltTask(num){
			$("#t6").html("("+num+")");
		}
		//打开页面
		function openForms(url, flowname){
			var width = jQuery(window.top).width();//界面宽度
		    var height = jQuery(window.top).height();//界面高度
			url= url+"&height="+height+"&width="+width;
			url= url+"&windowsId=newwindows1&indexReturn="+indexReturn;
			//openAlertWindows('newwindows1',url,flowname,width,height,'0%','0%');
			openAlertWindows('newwindows1',url,flowname,width,height-86,86,'0%','','',true);
		}		
		//设置默认的返回页面
		function setIndexReturn(index){
			indexReturn = index;
		}
	</script>
<title>待办事项</title>
</head>
<body onload="adaptationWH('_top','frame3',39);adaptationWH('_top','frame2',39);adaptationWH('_top','frame1',39);adaptationWH('_top','frame4',39);">
	<TABLE style="WIDTH: 100%;">
		<TR>
			<TD>
				<div>
					<div id="tabs">
						<div id="titleids" style="display:none;" id="_top">
							<ul>
								<li><a href="#tabs-1" >等待审批<span class="color_red" id="t1"></span></a></li>
								<li><a href="#tabs-2" >等待阅读<span class="color_red" id="t2"></span></a></li>
								<li><a href="#tabs-3">公文待办<span class="color_red" id="t3"></span></a></li>
								<li><a href="#tabs-4">事务待办<span class="color_red" id="t4"></span></a></li>
								<li><a href="#tabs-5">会议通知<span class="color_red" id="t5"></span></a></li>
								<li><a href="#tabs-6">任务待办<span class="color_red" id="t6"></span></a></li>
							</ul>
						</div>
						<div id="tabs-1">
							<iframe src="waitingapproval.jsp?type=true" id="frame1" frameborder="0"
								width="100%"></iframe>
						</div>
						<div id="tabs-2">
							<iframe src="waitingread.jsp" id="frame2" frameborder="0"
								width="100%"></iframe>
						</div>
						<div id="tabs-3">
							<iframe src="doworklist.jsp" id="frame3" frameborder="0"
								width="100%" height="510px"></iframe>
						</div>
						<div id="tabs-4">
							<iframe src="doprocesslist.jsp" id="frame4" frameborder="0"
								width="100%" height="510px"></iframe>
						</div>
						<div id="tabs-5">
							<iframe src="../../../../oa/meeting/jsp/meetingviewlist.jsp?status=index" id="frame4" frameborder="0"
								width="100%" height="510px"></iframe>
						</div>
						<div id="tabs-6">
							<iframe src="../../../../oa/task/jsp/mytasklist.jsp?status=index" id="frame4" frameborder="0"
								width="100%" height="510px"></iframe>
						</div>
						
					</div>
				</div>
			</TD>
		</TR>
	</TABLE>

</body>
</html>