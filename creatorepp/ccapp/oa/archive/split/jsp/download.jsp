<%@ page language="java" contentType="application/octet-stream; charset=gbk"%>
<%@ page import="java.io.*"%>
<%@page import="com.chinacreator.xtbg.core.common.util.FilePathUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OASystemCache"%>
<%--
描述：系统文件下载页面
作者：steven.zhu
版本：1.0
日期：2011-7-11
--%>
<%
	String hrefPath=request.getParameter("hrefPath");
	String zwName=request.getParameter("zwName");
	if(hrefPath != null){
		hrefPath = java.net.URLDecoder.decode(hrefPath , "UTF-8");
	}
	if(zwName != null){
		zwName = java.net.URLDecoder.decode(zwName , "UTF-8");
	}
	FilePathUtil fileUtil = new FilePathUtil();
	fileUtil.initialize(pageContext);
	String dir = OASystemCache.getContextProperty("oa_split_file_save_path")+hrefPath;
	String displayname=zwName;
	displayname = new String(displayname.getBytes("GBK"), "ISO8859_1");
    response.reset();
	OutputStream output = null;
	FileInputStream fis = null;
	try {
		output = response.getOutputStream();
		File file=new File(dir);
		if(file.exists()){
			response.setContentType("application/octet-stream");
			response.addHeader("Content-disposition", "attachment; filename=\""+displayname+"\"");
			fis = new FileInputStream(file);
			byte[] b = new byte[1024];
			int i = 0;
			while ((i = fis.read(b)) > 0) {
				output.write(b, 0, i);
			}
		}
		output.flush();
		out.clear();
		out = pageContext.pushBody();
	} catch (Exception e) {
	    e.printStackTrace();
	} finally {
		if (fis != null) {
			fis.close();
			fis = null;
		}
		if (output != null) {
			output.close();
			output = null;
		}
	}
%>

