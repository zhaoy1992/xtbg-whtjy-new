<%--
ntko版附件-下载处理
--%>
<%@page import="com.chinacreator.xtbg.core.file.util.ZIPUtil"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page contentType="text/html; charset=utf-8"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.File"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DataControlUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@page import="com.chinacreator.xtbg.core.upload.dao.*"%>
<%@page import="com.alibaba.fastjson.JSONObject" %>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.fancyuoload.servlet.AttachmentConfigBean"%>


<%
boolean flag = false;
InputStream fis = null;
OutputStream ops = null;
String table_name = StringUtil.deNull(request.getParameter("table_name"));
String attach_id = StringUtil.deNull(request.getParameter("attach_id"));

String rootPath = request.getSession().getServletContext().getRealPath("");
rootPath = rootPath.replace("\\", "/");
try{
	if(!StringUtil.isBlank(attach_id)){
		UploadDao uploadDao = (UploadDao)LoadSpringContext.getApplicationContext().getBean("uploadDaoImpl");
		Connection conn = DbManager.getInstance().getTransactionConnection();
		//1:find file
		List<Map<String,String>> fileList = uploadDao.queryFileUploadBeanList(conn,table_name,attach_id);
		//多个附件的时候，打包成电子邮件附件.zip
		String zipName ="体系文件附件.zip";
		String zipPath ="";
		//String baseUrl = AttachmentConfigBean.getBaseUrl();
		File[] files = new File[fileList.size()];
		for(int m =0 ; m < fileList.size(); m++ ) {
			
			Map<String,String> bean = fileList.get(m);
			
			//只有一个附件的时候
			if(fileList.size() == 1){
				zipName = bean.get("filename");
			}
			File file = AttachmentConfigBean.getRealFile(bean.get("filepos"));
			if(file.exists()){
				zipPath  = rootPath;
				files[m] = file;
			} else {
				continue;
			}
		}
		
		//生成zip包
		if(fileList.size()>1){
			flag = ZIPUtil.createrZipFiles(zipName,zipPath,files);	
		}
		File zipFile = null;
		if(files.length>1){
			 zipFile = new File(zipPath + zipName);
		} else {
			 zipFile = files[0];
		}
		
		//下载zip
		if(zipFile.exists()){
			//2 ready outputstream
			response.reset();
		    response.addHeader("Content-Disposition", "attachment;filename=" + new String(zipName.getBytes("GBK"), "ISO8859-1"));
		    response.addHeader("Content-Length", "" + zipFile.length());
		    response.setContentType("application/octet-stream;charset=GBK");
		    ops = response.getOutputStream();
			//3 ready inputstream
		    fis = new FileInputStream(zipFile);
		    //4 read and write
		    byte[] b = new byte[524288];//1024*512   0.5MB
		    int i = -1;
		    while((i=fis.read(b))>0){
		    	ops.write(b,0,i);
		    }
			flag = true;
			out.clear();
		    out = pageContext.pushBody();
		}
		flag = true;
		out.clear();
	    out = pageContext.pushBody();
		
	}
}catch(Exception e){
	e.printStackTrace();
	Logger.getLogger(this.getClass()).error("下载文件失败",e);
}finally{
	if(fis!=null){
		fis.close();
	}
}
%>

<%
//5失败提醒
if(!flag){%>
	<html lang="en">
	<head>
		<meta charset="UTF-8" />
		<title>Document</title>
	</head>
	<script>
		alert("文件不存在！");
		history.go(-1);
	</script>
	</html>	
<%}%>