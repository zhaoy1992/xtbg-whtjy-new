<%-- 
描述：程序界面处理页面
作者：肖杰
版本：1.0
日期：2013-07-10
 --%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileProgramPageServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileProgramPageServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FileProgramPageBean"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<head>
<title>程序界面处理页面</title>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
boolean flag = false;
String subid=request.getParameter("subid");
String action = request.getParameter("action");

FileProgramPageBean fileProgramPageBean = new FileProgramPageBean();
FileProgramPageServiceIfc fileProgramPageServiceIfc = new FileProgramPageServiceImpl();

if("addFileProgram".equals(action) || "updateFileProgram".equals(action)) {
	fileProgramPageBean = (FileProgramPageBean)RequestBeanUtils.getValuesByRequest(request,fileProgramPageBean);
	flag = fileProgramPageServiceIfc.handleFileProgramPage(fileProgramPageBean);
} else if("deleteFileProgram".equals(action)) {
	String f_program_id=request.getParameter("f_program_id");
	flag=fileProgramPageServiceIfc.deleteFileProgramPage(f_program_id);
} 

%>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
var mes = "";
var bool = true;
var action = "<%=action%>";
if(<%=flag%>){
	mes = "操作成功"; 
	bool = false;
	var submitAlertOK = function(){

		if(action == "deleteFileProgram"){
			window.parent.location.reload();
		}else{
			parent.back();
		}
	}
   
	var p={
			headerText:'操作信息',
			okName:'确认',
	        okFunction:submitAlertOK
	};
	alert('操作成功!',p);
}else{
	mes = "操作失败"	;
	bool = false;
}
</script>
</head>
<body>
</body> 
</html>