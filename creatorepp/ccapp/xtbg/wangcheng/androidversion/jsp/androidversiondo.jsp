<%@page import="com.chinacreator.xtbg.wangcheng.androidversion.dao.imploracle.AndroidVersionDaoImpl"%>
<%@page import="com.chinacreator.xtbg.wangcheng.androidversion.dao.AndroidVersionDao"%>
<%@page import="com.chinacreator.xtbg.wangcheng.androidversion.service.AndroidVersionService"%>
<%@page import="com.chinacreator.xtbg.wangcheng.androidversion.service.impl.AndroidVersionServiceIfc"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.wangcheng.androidversion.entity.AndroidVersionBean;"%>
<%@page contentType="text/html; charset=utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>JGRID</title>

<%
    String path = request.getRealPath("");
    
	String action = StringUtil.deNull(request.getParameter("action"));//action的值
	String version_esn = StringUtil.deNull(request.getParameter("version_esn"));//version_esn的值
	String version_sn = StringUtil.deNull(request.getParameter("version_sn"));//version_sn的值
	String version_name = StringUtil.deNull(request.getParameter("version_name"));//version_name的值
	String upload_path = StringUtil.deNull(request.getParameter("upload_path"));//upload_path的值
	//String up_time = new Date();//更新时间的值
	String version_content = StringUtil.deNull(request.getParameter("version_content"));//version_content的值
	String is_must_install = StringUtil.deNull(request.getParameter("is_must_install"));//is_must_install的值
	//String filepath = path + "\\androidversionupload";
	String ids = request.getParameter("userIds");
	//String fileIds = request.getParameter("fileIds"); //获取要删除的文件的名称
	//String upload_path = request.getParameter("upload_path");
	//String[] fids = fileIds.split(",");
	//System.out.println("即将删除的文件："+filepath+"\\"+fids);
	AndroidVersionService androidVersionService = new AndroidVersionServiceIfc();
	AndroidVersionBean bean = new AndroidVersionBean();
	
	bean.setIs_must_install(is_must_install);
	bean.setUpload_path(upload_path);
	bean.setVersion_content(version_content);
	bean.setVersion_name(version_name);
	bean.setVersion_esn(version_esn);
	bean.setVersion_sn(version_sn);
	String flag = "faild";
	if("delete".equals(action)){
		flag = androidVersionService.deleteAndroidVersion(ids);
	} else {
		flag = androidVersionService.saveAndroidVersion(bean);
	}
	
%>
<script type="text/javascript">
var mes = "";
var bool = true;
if("<%=flag%>" =="faild"){
	alert("操作失败");
}else {
	alert("操作成功");
	parent.location.href="../../../wangcheng/androidversion/jsp/androidversionlist.jsp";	
}
</script>
<body>
</body> 
</html>