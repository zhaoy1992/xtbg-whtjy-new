<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
	<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String select  = request.getParameter("select");
	String username = accesscontroler.getUserAccount();
	if(StringUtil.isBlank(select)){
		select = "111";
	}
	String indexReturn = request.getParameter("indexReturn");
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
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
	var select = "<%=select%>"
	var indexReturn = '<%=indexReturn%>';
		$(function() {
			$("#tabs").tabs({
				select : function(event, ui) {
					var iframeitem = $(ui.panel).find("iframe");
					$(iframeitem).attr("src", $(iframeitem).attr("src"));
					var selected = $("#tabs").tabs('option', 'selected'); 
				}
			});
			$("#titleids").css('display','block');
			
			if(select != "111"){
				$("#tabs").tabs({ selected: "<%=select%>" });
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

<title>申请查询tabs页</title>
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
								<li><a id="tabs1" href="#tabs-1" >发放登记</a></li>
								<li><a id="tabs2" href="#tabs-2" >发放记录</a></li>
							</ul> 
						</div>
						
						<div id="tabs-1">
							<iframe src="youkadjlist.jsp" id="frame1" frameborder="0"
								width="100%" height="500px" scrolling="yes"></iframe>
						</div>
						<div id="tabs-2">
							<iframe src="youkafflist.jsp" id="frame2" frameborder="0"
								width="100%" height="500px" scrolling="yes"></iframe>
						</div>
					</div>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>