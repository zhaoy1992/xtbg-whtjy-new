<%-- 
描述：存放位置处理页面
作者：肖杰
版本：1.0
日期：2013-07-15
 --%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FileStorageLocationBean"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileStorageLocationServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileStorageLocationServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<head>
<title>存放位置处理页面</title>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
boolean flag = false;
String flag1="";
boolean flag2 = false;
String subid=request.getParameter("subid");
String action = request.getParameter("action");
Object treeNode = request.getParameter("treeNode");

FileStorageLocationBean fileStorageLocationBean=new FileStorageLocationBean();
FileStorageLocationServiceIfc fileStorageLocationServiceIfc = new FileStorageLocationServiceImpl();
fileStorageLocationBean = (FileStorageLocationBean)RequestBeanUtils.getValuesByRequest(request,fileStorageLocationBean);

if("addFileStorage".equals(action)) {
	flag=fileStorageLocationServiceIfc.addFileStorageLocation(fileStorageLocationBean);
} else if("deleteFileStorage".equals(action)) {
	String f_storage_id=request.getParameter("f_storage_id");
	flag1=fileStorageLocationServiceIfc.deleteFileStorage(f_storage_id);
	if(!"false".equals(flag1)){
		flag=true;
		if("parent".equals(flag1)){
			flag2=true;
		}
	}
} else if("updateFileStorage".equals(action)){
	flag=fileStorageLocationServiceIfc.updateFileStorageLocation(fileStorageLocationBean);
}


%>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
var mes = "";
var bool = true;
var action = "<%=action%>";
if(<%=flag%>){
	bool = false;
	mes = "操作成功"; 
	var submitAlertOK = function(){
		//window.parent.removeWindows('<%=subid %>',true);
		if(action == "deleteFileStorage"){
			window.parent.location.reload();
		}else{
			window.parent.removeWindows('<%=subid%>',true,false,true);
		}
		if(removeWindows('<%=subid %>',true,false,true)){
			window.parent.parent.location.reload();
		}
	}
	var p={
		headerText:'操作信息',
		okName:'确认',
		okFunction:submitAlertOK
	};
	if(<%=flag2%>){
		alert('有数据中存在子类！',p);
	}else{
		alert('操作成功!',p);
	}   
}else{
	mes = "操作失败"	;
	bool = false;
}
</script>
</head>
<body>
</body> 
</html>