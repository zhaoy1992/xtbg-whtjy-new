<%@page import="com.chinacreator.xtbg.pub.personwork.service.impl.AbookInServiceImpl"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.service.AbookInServiceIfc"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.frameworkset.orm.transaction.TransactionManager"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.ParseExcelUtil"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="javax.transaction.RollbackException"%>
<%@page import="javax.servlet.jsp.JspWriter"%>
<%@ page import="java.util.*"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="com.chinacreator.eppissue.menuissue.vo.MenuIssueVo"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<base href="<%=basePath%>"> 
<title>JGRID</title>

<%
	
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String user_id = accesscontroler.getUserID();
	String wdo=request.getParameter("wdo");
	boolean flag = true;
	String new_directory_id = "";
	String outStr="";
	String uploadMessage = "";
	AbookInServiceIfc abookInServiceIfc = new AbookInServiceImpl();
	if("batch".equals(wdo)){
	final String UpFileType = "xls";//上传文件类型
	final int MaxFileSize = 2 * 1024;//上传文件大小限制（文件大小2G）
	String err = "false";//错误标识
	String file_url = MenuIssueVo.s_MENUUPDATE_TEMP;//应用更新临时文件路径
	SmartUpload su = new SmartUpload();//新建一个SmartUpload对象
	su.initialize(pageContext);//上传初始化
	su.upload();
	String filename = "";//上传文件
	try {
		
		//java.io.File file = new java.io.File(filepath);
	File file = su.getFiles().getFile(0);//取文件

	//文件效验//判断用户是否选择了文件// 取得文件并保存
	if (!file.isMissing()) {
		String FileType = file.getFileExt();//得到文件扩展名
		FileType = FileType.toLowerCase();//将扩展名转换成小写
		if (UpFileType.indexOf(FileType) == -1) {
			uploadMessage = "文件格式不对！";//文件格式不对
			err = "true";
		}
		int FileSize = file.getSize() / (1024 * 1024);//得到文件大小（换算为M）
		if (err.equals("false") && FileSize > MaxFileSize) {
			uploadMessage = "文件太大！";//文件太大
			err = "true";
		}
	} else {
		uploadMessage = "未选择文件！";//文件错误
		err = "true";
	}
		if (err.equals("false") && !file.isMissing()) {//如果文件正确则上传
			java.io.File fileurl = new java.io.File(file_url);
			if(!fileurl.exists()){
				fileurl.mkdirs();
			}
			filename = (file_url + "/" + file.getFileName()).replace(
			"\\", "/");//取文件名
			file.saveAs(filename);
			uploadMessage = "导入成功！";
		}
	} catch (Exception e) {
		flag=false;
		uploadMessage = "导入失败！";//上传有误
		err = "true";
	}
	if("false".equals(err)){
	    outStr = abookInServiceIfc.importSalaryExcel2DB(filename);
	}
	}else if("single".equals(wdo)){
		Map<String,String> map=new HashMap<String,String>();
		map.put("username", request.getParameter("username"));
		map.put("usersex", request.getParameter("usersex"));
		map.put("duties", request.getParameter("duties"));
		map.put("org", request.getParameter("org"));
		map.put("user_mobiletel1", request.getParameter("user_mobiletel1"));
		map.put("user_worktel", request.getParameter("user_worktel"));
		abookInServiceIfc.singleInput(map);
	}
%>
<!-- 沈js -->
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"  charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"  charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript">
var mes = "";
var bool = true;
if(<%=flag%>){
	mes = "操作成功"; 
}else{
	mes = "操作失败"	;
	bool = false;
}
//removeAlertWindows = function(windowId,isClose,processVal,msg,isBreak,url)
if("single"=="<%=wdo%>"){
	if(window.top.removeAlertWindows('',false,bool,mes,true)){
		if(bool){
			window.top.alert(mes);
		}
		else{
			window.top.alert(mes);
		}
	}
}	
<%
if("batch".equals(wdo)){
	System.out.println(outStr);
	out.print("window.parent.setOutStr("+"'"+outStr+"'"+")");	
}
%>
</script>
</head>
<body>
</body> 
</html>