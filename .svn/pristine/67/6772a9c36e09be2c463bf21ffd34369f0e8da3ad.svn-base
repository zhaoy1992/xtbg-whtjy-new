<%@page import="com.chinacreator.xtbg.core.subsystemmanage.service.impl.SubSystemServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.subsystemmanage.service.SubSystemServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.subsystemmanage.entity.SubsysUserImportBean"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.frameworkset.orm.transaction.TransactionManager"%>
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
	//子系统ID
	String sys_id = request.getParameter("sys_id");
	String filepath = request.getParameter("filepath");
	boolean flag = false;
	String new_directory_id = "";
	SubsysUserImportBean subsysUserImportBean = new SubsysUserImportBean();
	//子系统ID
	subsysUserImportBean.setSys_id(sys_id);
	String outStr="";
	String filelocation = "临床路劲导入格式.xls";
	String uploadMessage = "";
	final String UpFileType = "xls";//上传文件类型
	final int MaxFileSize = 2 * 1024;//上传文件大小限制（文件大小2G）
	String err = "false";//错误标识
	String file_url = MenuIssueVo.s_MENUUPDATE_TEMP;//应用更新临时文件路径
	SmartUpload su = new SmartUpload();//新建一个SmartUpload对象
	su.initialize(pageContext);//上传初始化
	su.upload();
	String filename = "";//上传文件
	try {
		
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
		uploadMessage = "导入失败！";//上传有误
		err = "true";
	}
	if("false".equals(err)){
		subsysUserImportBean.setImport_file(filename);
		SubSystemServiceIfc subSystemServiceIfc = new SubSystemServiceImpl();
	    outStr = subSystemServiceIfc.importUserInfoExcel2DB(subsysUserImportBean);
	}

%>
<script type="text/javascript">

	var mes = "";
	var bool = true;
	if(<%=flag%>){
		//mes = "操作成功";
	}else{
		//mes = "操作失败"	;
		bool = false;
	}
	<%
		System.out.println(outStr);
		out.print("window.parent.setOutStr("+"'"+outStr+"'"+")");	
	%>

</script>
</head>

<body>
<table>
<tr>
<td >

</td>
</tr>
</table>
</body> 
</html>