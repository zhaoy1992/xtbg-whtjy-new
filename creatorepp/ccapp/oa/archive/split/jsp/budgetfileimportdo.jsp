<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@page import="com.jspsmart.upload.SmartUpload"%>
<%@page import="com.jspsmart.upload.File"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.SplitLogService"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.impl.SplitLogServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OASystemCache"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.BudgetFileService"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.impl.BudgetFileServiceImpl"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<base href="<%=basePath%>">
	<title>拆分文件导入jsp</title>
		<%
		AccessControl accesscontroler = AccessControl.getAccessControl();
		accesscontroler.checkAccess(request, response);
		
		String outStr = "";
		String uploadMessage = "";
		final String UpFileType = "xls";//上传文件类型
		final int MaxFileSize = 2 * 1024;//上传文件大小限制（文件大小2G）
		String err = "false";//错误标识
		String relative_path = "";
		String file_url = OASystemCache.getContextProperty("oa_split_file_save_path");
		SmartUpload su = new SmartUpload();//新建一个SmartUpload对象
		su.initialize(pageContext);//上传初始化
		su.upload();
		
		String header_row = su.getRequest().getParameter("header_row");
		String bus_id = su.getRequest().getParameter("bus_id");
		String user_id = su.getRequest().getParameter("user_id");
		String dept_id = su.getRequest().getParameter("dept_id");
		String file_code = su.getRequest().getParameter("file_code");
		String annual = su.getRequest().getParameter("annual");
		String template_type = su.getRequest().getParameter("template_type");
		
		String filepath = "";//上传文件
		String fileName = "";	//上传文件的文件名
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
				relative_path = java.io.File.separator + "splitfile"
								+java.io.File.separator+new SimpleDateFormat("yyyyMMdd").format(new Date())
								+java.io.File.separator+bus_id;
				java.io.File fileurl = new java.io.File(file_url + relative_path);
				if (!fileurl.exists()) {
					fileurl.mkdirs();
				}
				filepath = (fileurl + "/" + file.getFileName()).replace("\\", "/");//取文件名
				file.saveAs(filepath);
				fileName = file.getFileName();
				uploadMessage = "导入成功！";
			}
		} catch (Exception e) {
			uploadMessage = "导入失败！";//上传有误
			err = "true";
		}
		if ("false".equals(err)) {
			outStr = "开始拆分文件...";
			BudgetFileService service = new BudgetFileServiceImpl();
			outStr = service.splitFile(relative_path,fileName,file_code,Integer.parseInt(header_row),user_id,dept_id,bus_id,annual,template_type);
		} else {
			outStr = uploadMessage;
		}
%>
<script type="text/javascript">
	<%
		out.print("window.parent.setOutStr("+"'"+outStr+"'"+")");
	%>
</script>
	</head>
	<body>
		<table>
			<tr>
				<td>
				</td>
			</tr>
		</table>
	</body>
</html>