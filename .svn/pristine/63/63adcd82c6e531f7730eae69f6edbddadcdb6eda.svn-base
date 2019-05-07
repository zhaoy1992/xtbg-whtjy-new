<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html;charset=GBK" language="java"%>

<%
/**
 * <p>Title: del附件组</p>
 * <p>Description: 删除附件信息</p>
 * <p>Copyright: Copyright (c) 2011</p>
 * <p>Company: chinacreator</p>
 * @Date 2011-07-06
 * @author steven.zhu
 * @version 1.0
 **/
 %>
 


<%@page import="com.chinacreator.xtbg.jqueryupload.filebuess.dao.impl.FiletransfersSysDaoImpl"%><html>
  <head>
	<title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=GBK">
 </head>
<body>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String djsn=request.getParameter("djsn");       	//分组编号
String buessid=request.getParameter("buessid");
String isPre = request.getParameter("isPre");
String isallowdelete = request.getParameter("isallowdelete");
	
	try{
	boolean rs=new FiletransfersSysDaoImpl().delFile(djsn);
	if(rs){
		out.println("<script language='JavaScript'>window.alert('文件删除成功！');window.parent.location.href('ymj_filelist.jsp?buessid="+buessid+"')</script>");
	}else{
		out.println("<script language='JavaScript'>window.alert('文件删除失败！');window.close();</script>");
	}
	}catch(Exception e){
	//	e.printStackTrace();
		out.println("<script language='JavaScript'>window.alert('文件删除失败！');window.close();</script>");
	}
%>
	</body>
</html>
