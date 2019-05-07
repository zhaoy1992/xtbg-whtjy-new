<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*" %>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.FiletransfersSysDao"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.entity.FileInfoBean"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.impl.FiletransfersSysDaoImpl"%>
<html>
<body>
<%
InputStream in=null;
FileInfoBean fib = null;
ServletOutputStream sout = null;
try{
	FiletransfersSysDao fsd = new FiletransfersSysDaoImpl();
	String id = request.getParameter("imgid");
	fib = fsd.getFileByDjsn(id);
	sout = response.getOutputStream();
	in = (InputStream)fib.getFileInput();
	byte b[] = new byte[1024];	
	int i = 0;
	while ((i = in.read(b)) > 0) {
		sout.write(b, 0, i);
	}
	out.clear();   
	out = pageContext.pushBody();  
		sout.flush();	
		sout.close();
	} catch (Exception e) {
	    e.printStackTrace();
	} 
	finally {
		if( in != null) {
			in.close();
			in = null;
		}
		if (sout != null) {
			sout.close();
			sout = null;
		}
	}
%>
</body>
</html>