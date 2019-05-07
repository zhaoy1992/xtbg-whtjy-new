<%@page import="com.chinacreator.pcbase.androidversion.dao.imploracle.AndroidVersionDaoImpl"%>
<%@page import="com.chinacreator.pcbase.androidversion.dao.AndroidVersionDao"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.chinacreator.pcbase.androidversion.entity.AndroidVersionBean"%>
<%@page import="com.chinacreator.pcbase.util.DataControlUtil"%>
<%@page import="com.chinacreator.pcbase.util.StringUtilForAndroid"%>
<%@page import="java.util.*,com.jspsmart.upload.SmartUpload"%>
<%@ page contentType="text/html; charset=utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>文件上传处理页面</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
    boolean returnValue = false;
    boolean flag = false;
	try{
		//新建一个SmartUpload对象
		SmartUpload su = new SmartUpload();
		//上传初始化
		su.initialize(pageContext);
		// 设定上传限制
		// 1.限制每个上传文件的最大长度。
		//su.setMaxFileSize(10000);
		// 2.限制总上传数据的长度。
		//su.setTotalMaxFileSize(20000);
		// 3.设定允许上传的文件（通过扩展名限制）,仅允许如doc,txt文件。
	    su.setAllowedFilesList("apk");//仅允许apk
		// 4.设定禁止上传的文件（通过扩展名限制）,禁止上传带有exe,bat,jsp,htm,html扩展名的文件和没有扩展名的文件。
		su.setDeniedFilesList("exe,bat,jsp,htm,html");
		    // 上传文件
		su.upload();
	    String versionname = su.getRequest().getParameter("versionname");
	    String version_id = su.getRequest().getParameter("version_id");
		AndroidVersionDao dao = new AndroidVersionDaoImpl();
		if(dao.isHasByversionName(versionname)){//存在
			flag = true;
		}else{
		
			// 将上传文件全部保存到指定目录
			int count = su.save("/androidversionupload");
			
			com.jspsmart.upload.File file = su.getFiles().getFile(0);
			String filename = file.getFileName();
			AndroidVersionBean bean = new AndroidVersionBean();
			bean.setVersion_esn(su.getRequest().getParameter("version_esn"));
			bean.setVersion_sn(su.getRequest().getParameter("version_sn"));
			bean.setSql_sn(su.getRequest().getParameter("sql_sn"));
			bean.setVersion_name(filename);
			bean.setUpload_path("/androidversionupload");
			bean.setVersion_content(su.getRequest().getParameter("version_content").replaceAll("\r","<br>"));
			bean.setIs_must_install(su.getRequest().getParameter("is_must_install"));
			bean.setUpgrade_rangeid(su.getRequest().getParameter("upgrade_rangeid"));
			bean.setUpgrade_rangevalue(su.getRequest().getParameter("upgrade_rangevalue"));
			bean.setVersion_id(version_id);
			dao.insertAndroidVersionBean(bean); //将数据保存到数据库
			returnValue = true;
		}
	}catch(Exception e){
		returnValue = false;
	}
	
%>
<script type="text/javascript">
var mes = "";
var bool = true;
    if(<%=flag%>){
    	mes = "版本文件名称已存在，请修改文件名称再上传";
    	bool = false;
    }else{
		if(<%=returnValue%>){
			mes = "操作成功"; 
		}else{
			mes = "操作失败";
			bool = false;
		}
    }
	window.parent.JqueryDialog.SubmitCompleted(mes, true, bool);

</script>
</head>
<body>
</body> 
</html>