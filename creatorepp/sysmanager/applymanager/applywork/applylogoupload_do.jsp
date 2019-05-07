<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.*"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>
<%@ page import="com.chinacreator.epp.applymanager.dbmanager.ApplyManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	//用户信息（用户真实名称：用户帐号[用户ID]）
	String userInfo = control.getUserAttribute("userAccount") + ":"
			+ control.getUserAttribute("userName") + "["
			+ control.getUserAttribute("userID") + "]  ";
	//操作的ip地址
	String remoteAddr = request.getRemoteAddr();

	String app_id = request.getParameter("app_id") != null ? request
			.getParameter("app_id") : "";
	String uploadType = request.getParameter("uploadType") != null ? request
			.getParameter("uploadType")
			: "";
	String uploadMessage = "";

	if (app_id.trim().equals("") || uploadType.trim().equals("")) {
		uploadMessage = "上传错误";
	} else {
		//上传文件类型
		final String UpFileType = "bmp|gif|jpg|jpeg";
		//上传文件大小限制
		final int MaxFileSize = 5 * 1024 * 1024;
		//错误标识
		boolean err = false;

		//应用文件路径
		String file_url = ConfigManager.getInstance().getConfigValue("approot")
		+ "/ccapp/";
		//组装图片所在路径，Logo还是背景
		String app_path = file_url + "app_" + app_id + "/" + uploadType;

		//新建一个SmartUpload对象
		SmartUpload su = new SmartUpload();
		//上传初始化
		su.initialize(pageContext);
		su.upload();

		//取文件
		File file = su.getFiles().getFile(0);

		//文件效验
		//判断用户是否选择了文件
		// 取得文件并保存
		if (!file.isMissing()) {
			//得到文件扩展名
			String FileType = file.getFileExt();
			//将扩展名转换成小写
			FileType = FileType.toLowerCase();
			if (UpFileType.indexOf(FileType) == -1) {
		//文件格式不对
		uploadMessage = "文件格式不对";
		err = true;
			}
			//得到文件大小
			int FileSize = file.getSize();
			if (!err && FileSize > MaxFileSize) {
		//文件太大
		uploadMessage = "文件太大";
		err = true;
			}

		} else {
			//文件错误
			uploadMessage = "未选择文件";
			err = true;
		}

		//上传文件
		String filename = "";

		try {
			//如果文件正确则上传
			if (!err && !file.isMissing()) {
		//取文件名
		filename = file.getFileName();
		Date date = new Date();
		long time = date.getTime();
		String title = String.valueOf(time);
		String extn = filename.substring(filename
				.lastIndexOf('.'), filename.length());
		filename = title + extn.toLowerCase();
		//add by minghua.guo[2010-12-22] 判断路径是否存在，不存在就创建
		java.io.File app_pathF = new java.io.File(app_path + "/");
		if(!app_pathF.exists()){
			app_pathF.mkdirs();
		}
		
		file.saveAs(app_path + "/" + filename);
		uploadMessage = "上传成功";

		//	 ********************开始记录日志********************

		String uploadTypeStr = uploadType.trim().equals(
				"applyLogo") ? "背景" : "Logo";
		// 日志管理接口
		LogManager logMgr = SecurityDatabase.getLogManager();
		// 用户信息
		String operUser = userInfo;
		// 日志内容
		String operContent = userInfo + "  上传" + uploadTypeStr
				+ "图片:"
				+ new ApplyManager().getApplyName(app_id) + "["
				+ app_id + "]";
		// 日志类型
		String operModule = "应用管理";
		// 操作的ip地址
		String operSource = remoteAddr;
		// 写入日志
		logMgr.log(operUser, operContent, operModule,
				operSource);
		// ********************日志记录结束********************

			}
		} catch (Exception e) {
			//上传有误
			uploadMessage = "上传失败";
			e.printStackTrace();
		}
	}
%>
<script language="javascript">
		alert("<%=uploadMessage%>");
		window.close();
		window.returnValue="refresh";		
</script>
<script>
    window.onload = function prompt()
    {
        parent.divProcessing.style.display="none";
        parent.location.reload();
    }
</script>
