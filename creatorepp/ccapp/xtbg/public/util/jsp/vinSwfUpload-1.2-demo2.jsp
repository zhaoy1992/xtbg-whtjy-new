<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String buessid = request.getParameter("buessid");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


<title>Ê×Ò³</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<script type="text/javascript"	src="../../resources/plug/vinSwfUpload-1.2/jquery-1.4.2.min.js"></script>

<link	href="../../resources/plug/vinSwfUpload-1.2/css/vinSwfUpload-1.2-skin.css" rel="stylesheet" type="text/css" />
<link	href="../../resources/plug/vinSwfUpload-1.2/css/vinSwfUpload-1.2.css"	rel="stylesheet" type="text/css" />
<script type="text/javascript"	src="../../resources/plug/vinSwfUpload-1.2/core/swfupload.js"></script>
<script type="text/javascript"	src="../../resources/plug/vinSwfUpload-1.2/vinSWFUpload-1.2.js"></script>
<script type="text/javascript">
	$(function() {
		// ÎÄµµ¾ÍÐ÷
		var path = "<%=path%>/ccapp/xtbg/resources/plug/vinSwfUpload-1.2/";
		var upload = $("#vinEdit").vinSWFUpload( {
			uploadURL:'<%=path%>/servlet/FileUpload?buessid=<%=buessid%>',
			width : 553,
			heigth : 180,
			sizeUnit:"M",
			maxSize:'-30',//1M	
			skin:"green",
			autoRemoveStoped:false,
			flashURL : path+"core/SWFUpload.swf",
			addImgURl:path+"images/add.gif",
			uploadImgURl:path+"/images/upload.png",
			stopImgURl:path+"images/stop.png",
			deleteImgURl:path+"images/trash.gif",
			tipImgURl:path+"images/tip.gif"
		});
	});
</script>
</head>


<body>
<div id="vinEdit" ></div>
</body>
</html>