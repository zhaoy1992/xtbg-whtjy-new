<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
String basePath = request.getScheme() + "://"
		+ request.getServerName() + ":" + request.getServerPort()
		+ path + "/";
String buessid = request.getParameter("buessid");//此参数用来保存附件对应的id
String lookfj = request.getParameter("lookfj");//此参数用来区分附件是查看还是新增。lookfj=ok为查看。
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>jqueryfileupload</title>
		<link type="text/css" href="<%=path %>/ccapp/xtbg/resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" rel="stylesheet" />	
		<script type="text/javascript" src="<%=path %>/ccapp/xtbg/resources/plug/jquery-ui-1.8.16.custo/js/jquery-1.6.2.min.js"></script>
		<script type="text/javascript" src="<%=path %>/ccapp/xtbg/resources/plug/jquery-ui-1.8.16.custo/js/jquery-ui-1.8.16.custom.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#tabs').tabs();
	$( "#tabs" ).bind( "tabsselect", function(event, ui) {
		if("tabs-2" == ui.panel.id){
			document.frames('frame2').location="filelist.jsp?buessid=<%=buessid %>&lookfj=<%=lookfj %>";
			//$("#frame2").load("filelist.jsp?buessid=1234");
		}
	});
	if('<%=lookfj %>'=='ok'||'<%=lookfj %>'=='readOnly'){
		$("#tabs").tabs({ selected: 1 }); 
		$('#tabs').tabs( 'disable' , 0 ); 
	}
});
</script>
<style type="text/css">
			/*demo page css*/
			body{ font: 62.5% "Trebuchet MS", sans-serif; margin: 0px;}
			.demoHeaders { margin-top: 0em; }
			#dialog_link {padding: .0em 0em .0em 0px;text-decoration: none;position: relative;}
			#dialog_link span.ui-icon {margin: 0 0px 0 0;position: absolute;left: .0em;top: 50%;margin-top: -8px;}
			ul#icons {margin: 0; padding: 0;}
			ul#icons li {margin: 0px; position: relative; padding: 0px 0; cursor: pointer; float: left;  list-style: none;}
			ul#icons span.ui-icon {float: left; margin: 0 4px;}
		</style>
<script>

</script>	
</head>
<body>

<div id="tabs" class="demo" style="width: 570px;height: 230px">
			<ul>
				<li ><a href="#tabs-1">上传文件</a></li>
				<li ><a href="#tabs-2">已上传</a></li>
				
			</ul>
			<div id="tabs-1">
			<iframe src="vinSwfUpload-1.2-demo2.jsp?buessid=<%=buessid %>" id="frame1"  frameborder="0" width="100%" height="200"></iframe>
			</div>
			<div id="tabs-2">
			<iframe src="filelist.jsp?buessid=<%=buessid %>" frameborder="0" id="frame2"  width="100%" height="200"></iframe>
			</div>
			
		</div>


		
</body>
</html>