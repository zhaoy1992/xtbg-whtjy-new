<%@page import="com.chinacreator.xtbg.core.news.dao.impl.newsDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String n_id = StringUtil.deNull(request.getParameter("n_id"));
	newsDaoImpl impl = new newsDaoImpl();
	Map<String,String> map = impl.queryNews(n_id);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<!-- 引入jQuery -->
<script type="text/javascript" src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<!-- 引入上传控件-->
<script type="text/javascript">jQuery.noConflict();</script>
<script type="text/javascript" src="../resources/plug/fancyupload/mootools-1.2.5-core-jm.js"></script>
<script type="text/javascript" src="../resources/plug/fancyupload/source/Fx.ProgressBar.js"></script>
<script type="text/javascript" src="../resources/plug/fancyupload/source/Swiff.Uploader.js"></script>
<script type="text/javascript" src="../resources/plug/fancyupload/source/FancyUpload3.Attach.js"></script>
<script type="text/javascript" src="../resources/plug/fancyupload/myfancyupload.js"></script>
<style type="text/css">
.a_box{ width:90%; margin:10px auto; background:#fff; border:solid 1px #999; box-shadow: 0px 0px 6px #bbb;}
.a_box_title{ font-size:42px; line-height:50px; width:100%; text-align:center; color:#f00; margin-top: 50px;}
.a_box_msg{height:40px; line-height:40px; width:90%; text-align:center; margin:0px auto; border-bottom:solid 2px #f00;}
.a_box_title_h3{ font-size:25px; height:70px; line-height:70px; width:100%; text-align:center; color:#000;}
.a_box_msg_h3{height:30px; line-height:30px; width:100%; text-align:center; font-size:16px;}
.a_box_main{ width:90%; margin:0px auto;}
.a_box_main p{ line-height:35px; text-indent:2em; margin-top:10px; font-size:16px;}

.a_box_fujian{ width:90%; margin:20px auto;}
.a_box_fujian h3{ width:100%; float:left; height:40px; line-height:40px; border-bottom:solid 1px #ccc; margin-bottom:5px;}
.a_box_fujian ul li{ float:left; line-height:26px; width:100%;}
.a_box_fujian ul li b{ margin-right:8px;}
.a_box_tips{ width:90%; margin:20px auto; line-height:35px; text-align:right;}
</style>
<title>查看</title>
<script type="text/javascript">
jQuery(function(){
	jQuery(".a_box_main").css("font-size","18px");
	jQuery(".a_box_main").find("p,span,div").css("font-size","18px");
	})
			
function back_table(){
	location.href="newsviewlist.jsp";
}


</script>
</head>

<body style="overflow-y: auto;">
	<div class="a_box" style="overflow-y: auto;">
		<div class="a_box_title" style="font-size:42px; width:100%; text-align:center; color:#f00;float: "><%=map.get("n_title") %></div>
<!-- 		<div class="a_box_title_h3" style="font-size:25px; width:100%; text-align:center; color:#000;"></div> -->
		<div style="height:40px; line-height:40px; width:90%; text-align:center; margin:0px auto; border-bottom:solid 2px #f00;">
			<div style="float: left;">
				信息来源：<span id="write_user_name"><%=map.get("n_org_name") %></span>
			</div>
			<div style="float: right">
				发布时间：<span id="publish_time"><%=map.get("n_date") %></span>&nbsp;&nbsp;
			</div>
		</div>
		<div class="a_box_msg_h3" style="height:30px; line-height:30px; width:100%; text-align:center; font-size:16px;"></div><!-- 副标题 -->
		<div class="a_box_main" style="width:90%; margin:0px auto;">
		<%=map.get("n_content") %>
		</div>
<!-- 		<div class="a_box_fujian" style="width:90%; margin:20px auto;"> -->
<!-- 			<h3>附件</h3> -->
<!-- 			<ul style="padding-left: 10px;" id="_fileshow"></ul> -->
<!-- 		</div> -->
	</div>
	<div class="a_box_tips">
		【<a href="###" onclick="back_table()">返回</a>】
	</div>
</body>
</html>