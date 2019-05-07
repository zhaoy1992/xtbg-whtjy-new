<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.xtbg.core.common.fancyuoload.dao.FiletransfersSysDao"%>
<%@ page import="com.chinacreator.xtbg.core.common.fancyuoload.dao.impl.FiletransfersSysDaoImpl"%>
<%@ page import="com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean"%>
<%@ page import="com.chinacreator.xtbg.core.common.fancyuoload.service.FiletransferService"%>
<%@ page import="com.chinacreator.xtbg.core.common.fancyuoload.service.impl.FiletransferServiceImpl"%>
<%@ page import="com.chinacreator.xtbg.core.common.fancyuoload.util.FileUtils"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.File"%>
<%@ page import="java.awt.image.BufferedImage"%>
<%@ page import="javax.imageio.ImageIO"%>
<%@ page import="java.io.FileInputStream"%>

<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	String path = request.getContextPath();
	String djsn = request.getParameter("djsn");
	
	String mFilePath = request.getSession().getServletContext().getRealPath("");
	
	FiletransfersSysDao dao = new FiletransfersSysDaoImpl();
	FileInfoBean fileBean = dao.getFileByDjsn(djsn);
	String filePath = mFilePath + FiletransferServiceImpl.upload_To_SeverPath;
	List<FileInfoBean> listFileInfoBean = new ArrayList<FileInfoBean>();
	listFileInfoBean.add(fileBean);
	FiletransferService service = new FiletransferServiceImpl();
	FileUtils.mkDirectory(filePath);//创建文件夹
	service.uploadFileToServer(filePath, listFileInfoBean);//将文件保存到磁盘文件中
	
	File picture = new File(filePath + djsn + fileBean.getExtend());
	BufferedImage sourceImg = ImageIO.read(new FileInputStream(picture));
	String picWidth = sourceImg.getWidth() + "px";
	String picHeight = sourceImg.getHeight() + "px";
	if ((sourceImg.getWidth()) > 1024 && (sourceImg.getHeight()) > 768) {
		picWidth = (sourceImg.getWidth()*0.4) + "px";
		picHeight = (sourceImg.getHeight()*0.3) + "px";
	}

	String basePath = request.getScheme() + "://" + request.getServerName()+ ":" + request.getServerPort() + request.getContextPath();
	String imgSrc = basePath + "/ccapp/FcAttach1/" + djsn + fileBean.getExtend();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>图片在线预览</title>
</head>
<body scroll="auto">
	<div align="center" height="100%">
		<center>
			<img src="<%=imgSrc%>" width="<%=picWidth %>" height="<%=picHeight %>"/>
		</center>
	</div>
</body>
</html>