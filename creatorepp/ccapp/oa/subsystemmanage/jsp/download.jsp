<%@page import="com.chinacreator.xtbg.core.common.util.FilePathUtil"%>
<%@page import="com.chinacreator.sysmgrcore.purviewmanager.Escape"%>
<%@ page language="java" contentType="application/octet-stream; charset=gbk"%>
<%@ page import="java.io.*"%>
<%--
������ϵͳ�ļ�����ҳ��
���ߣ�steven.zhu
�汾��1.0
���ڣ�2011-7-11
--%>
<%
	String hrefPath=request.getParameter("hrefPath");
	FilePathUtil fileUtil = new FilePathUtil();
	fileUtil.initialize(pageContext);
	String dir = fileUtil.getPhysicalPath(hrefPath, 0);
	System.out.println(hrefPath);
	//System.out.println(dir);
	//�ļ��ľ��Ե�ַ(��d:\workspce....֮���)
    //String filelocation = dir+"����������ȵ���ģ��.xls";
	String zwName="�û���¼��Ϣ.xls";
	String filelocation = dir+zwName;
	String displayname=zwName;
	displayname = new String(displayname.getBytes("GBK"), "ISO8859_1");
    response.reset();
	OutputStream output = null;
	FileInputStream fis = null;
	try {
		output = response.getOutputStream();
		File file=new File(filelocation);
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

