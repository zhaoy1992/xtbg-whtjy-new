<%@page import="com.chinacreator.xtbg.core.kbm.service.impl.KbmDocServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.upload.util.UploadConstants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.xtbg.core.common.fancyuoload.dao.FiletransfersSysDao"%>
<%@ page import="com.chinacreator.xtbg.core.common.fancyuoload.dao.impl.FiletransfersSysDaoImpl"%>
<%@ page import="com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean"%>
<%@ page import="com.chinacreator.xtbg.core.common.fancyuoload.service.FiletransferService"%>
<%@ page import="com.chinacreator.xtbg.core.common.fancyuoload.service.impl.FiletransferServiceImpl"%>
<%@ page import="com.chinacreator.xtbg.core.common.fancyuoload.util.FileUtils"%>
<%@ page import="java.util.*"%>

<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String file_id = request.getParameter("file_id");
	String path = request.getContextPath();
	KbmDocServiceImpl service = new KbmDocServiceImpl();
	Map<String,String> map = new HashMap<String,String>();
	map = service.getFileDetail(file_id);
	String basePath = request.getScheme() + "://" + request.getServerName()+ ":" + request.getServerPort() + request.getContextPath();
	String url = UploadConstants.UPLOADSAVEPATH+"OA_FILEUPLOAD_KBM/"+map.get("yearfolder")+"/"+map.get("monthfolder")+"/"+map.get("attach_id"); 
	String cebSrc = basePath + url +"/"+file_id + ".pdf";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>PDF在线预览</title>
	<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" ></script>
<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript" charset="utf-8"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/jquery-media/jquery.media.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<script type="text/javascript">
		jQuery(function(){
			//初始化插件 
	    	new controlWordOrPdf({
	    	 	 //展示插件的节点
	    	     dom : "#showIframe",
	    	     //鼠标滚动的相对对象，默认为window,如果是相对于整个document滚动的，可以不传 
	    	     scrollDom : "#vcenter",  
	    	     //鼠标滚动到的高度
	    	     scrollHeight : 20,
	    	     //滚动缓冲的高度
	    	     bufferHeight : 20,
	    	     //插件节点的高度
	    	     height : "100%",
	    	     //插件节点的宽度
	    	     width : "100%",   
	    	     editAble : false,
	    	     //展示的文件类型
	    	     type : "pdf",
	    	     //展示的文件，word为文件id，pdf为文件名
	    	     file : '<%=cebSrc%>' 
	    	});
		});
		function setheightpdf(){
			
			jQuery("#showIframe").css("height","700");
		}
	</script>
</head>
<body onload="setheightpdf()">
	<iframe id="showIframe" style="width:100%;height:700px;" src="<%=cebSrc %>"></iframe>
</body>
</html>

