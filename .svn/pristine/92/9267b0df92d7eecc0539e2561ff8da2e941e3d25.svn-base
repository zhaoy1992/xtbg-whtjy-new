<%@page language="java" contentType="text/html; charset=gbk" pageEncoding="gbk"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.UUID"%>
<%@page import="java.util.Date"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();
	
	
	String attach_id = UUID.randomUUID().toString();

	//附件 上传 
	String departid = request.getParameter("departid");

	String serverName = (String) request.getServerName();
	String serverPort = String.valueOf(request.getServerPort());
	String contextPath = (String) request.getContextPath();

	String rootPath = request.getSession().getServletContext()
			.getRealPath("");
	rootPath = rootPath.replace("\\", "/");

	String pathup = "/iWebFile2005/iWebServer.jsp";
	String mServerUrl = "http://" + serverName + ":" + serverPort
			+ contextPath + pathup;
	String tableName = "OA_FILEUPLOAD_PAPER";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资料添加</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script> 
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../../iWebFile2005/iWebFile2005.js" charset="utf-8"></script>
<script type="text/javascript" src="../../upload/js/fileupload.js" charset="utf-8"></script>
</head>
<body >
	<form id="docform" name="docform" method="post">
		<table border="0" cellspacing="0" cellpadding="0"
			 >
			<tr>
				<th width="191"  > 文件上传：</th>
				<td>
					<input id=fa type=file value="" style="width: 60%" class=inputcss> 
					<a class="LinkButton" onClick="UpLoadFile('<%=tableName %>',getFullPath(fa),'<%=rootPath%>','<%=departid%>','<%=attach_id%>','<%=mServerUrl%>')">[上传文档]</a>
				</td>
			</tr>
		</table>
	</form>
	<a name="asdf" onclick="window.location='uploadlist.jsp?attach_id=<%=attach_id%>'">gotolist>>>>>>>>>></a>
	<iframe name="hiddenFrame1" width=0 height=0></iframe>
</body>
</html>