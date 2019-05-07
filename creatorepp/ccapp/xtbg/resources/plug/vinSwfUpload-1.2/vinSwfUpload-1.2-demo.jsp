<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
	String path = request.getContextPath();
	String base1Path = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


<title>Ê×Ò³</title>

<script type="text/javascript" src="jquery-1.4.2.min.js"></script>
<link href="css/vinSwfUpload-1.2-skin.css" rel="stylesheet" type="text/css"/>
<link href="css/vinSwfUpload-1.2.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="core/swfupload.js"></script>
<script type="text/javascript" src="vinSWFUpload-1.2.js"></script>
<script type="text/javascript">
	$(function() {
		// ÎÄµµ¾ÍÐ÷
		var path = "<%=path%>/";
		$("#vinEdit1").vinSWFUpload( {
			uploadURL:'<%=path%>/swf/upload',
			width : 500,
			heigth : 300,
			sizeUnit:"M",
			autoRemove:true,
			flashURL : path+"jqueryuploadfile/resources/core/SWFUpload.swf",
			addImgURl:path+"jqueryuploadfile/resources/images/add.gif",
			uploadImgURl:path+"/jqueryuploadfile/resources/images/upload.png",
			stopImgURl:path+"jqueryuploadfile/resources/images/stop.png",
			deleteImgURl:path+"jqueryuploadfile/resources/images/trash.gif",
			tipImgURl:path+"jqueryuploadfile/resources/images/tip.gif"
		});	
	});
</script>
</head>
<body>
<br>
<div id="mian"></div>
<hr>
</body>
</html>