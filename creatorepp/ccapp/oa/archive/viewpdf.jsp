<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.xtbg.core.common.fancyuoload.dao.FiletransfersSysDao"%>
<%@ page import="com.chinacreator.xtbg.core.common.fancyuoload.dao.impl.FiletransfersSysDaoImpl"%>
<%@ page import="com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean"%>
<%@ page import="com.chinacreator.xtbg.core.common.fancyuoload.service.FiletransferService"%>
<%@ page import="com.chinacreator.xtbg.core.common.fancyuoload.service.impl.FiletransferServiceImpl"%>
<%@ page import="com.chinacreator.xtbg.core.common.fancyuoload.util.FileUtils"%>
<%@ page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>

<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	String path = request.getContextPath();
	String djsn = request.getParameter("djsn");
	String type = StringUtil.deNull(request.getParameter("type"));//做人员持证区别、附件存不同表了
	
	String mFilePath = request.getSession().getServletContext().getRealPath("");
	
	FiletransfersSysDao dao = new FiletransfersSysDaoImpl();
	FileInfoBean fileBean = new FileInfoBean();
	if(type.equals("rycz")){
		fileBean = dao.getFileByDjsn2(djsn);
	}else{
		fileBean = dao.getFileByDjsn(djsn);
	}
	
	String filePath = mFilePath + FiletransferServiceImpl.upload_To_SeverPath;
	List<FileInfoBean> listFileInfoBean = new ArrayList<FileInfoBean>();
	listFileInfoBean.add(fileBean);
	FiletransferService service = new FiletransferServiceImpl();
	FileUtils.mkDirectory(filePath);//创建文件夹
	service.uploadFileToServer(filePath, listFileInfoBean);//将文件保存到磁盘文件中

	String basePath = request.getScheme() + "://" + request.getServerName()+ ":" + request.getServerPort() + request.getContextPath();
	String cebSrc = basePath + "/ccapp/FcAttach1/" + djsn + ".pdf";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>PDF在线预览</title>
	<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/jquery-media/jquery.media.js"></script>
	<script type="text/javascript">
		$(function(){
			//初始化插件 
	    	new controlWordOrPdf({
	    	 	 //展示插件的节点
	    	     dom : "#showIframe",
	    	     //鼠标滚动的相对对象，默认为window,如果是相对于整个document滚动的，可以不传 
	    	     scrollDom : "#vcenter",  
	    	     //鼠标滚动到的高度
	    	     scrollHeight : 252,
	    	     //滚动缓冲的高度
	    	     bufferHeight : 20,
	    	     //插件节点的高度
	    	     height : "100%",
	    	     //插件节点的宽度
	    	     width : "100%",        
	    	     //word是否可编辑
	    	     editAble : false,
	    	     //展示的文件类型
	    	     type : "pdf",
	    	     //展示的文件，word为文件id，pdf为文件名
	    	     file : '<%=cebSrc%>' 
	    	});
		});
	</script>
</head>
<body>
	<iframe id="showIframe" style="width:100%;height:800px;" src="<%=cebSrc %>"></iframe>
</body>
</html>

