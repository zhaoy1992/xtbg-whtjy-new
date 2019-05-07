<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.*"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>
<%@ page import="com.chinacreator.eppissue.menuissue.vo.MenuIssueVo"%>
<%@ page import="com.chinacreator.epp.ouexcelmanager.ImpExcelOrgUser"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	String uploadMessage = "";

	//上传文件类型
	final String UpFileType = "xls";
	//上传文件大小限制（文件大小2G）
	final int MaxFileSize = 2 * 1024;
	//错误标识
	String err = "false";

	//应用更新临时文件路径
	String file_url = MenuIssueVo.s_MENUUPDATE_TEMP;

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
			uploadMessage = "文件格式不对！";
			err = "true";
		}
		//得到文件大小（换算为M）
		int FileSize = file.getSize() / (1024 * 1024);
		if (err.equals("false") && FileSize > MaxFileSize) {
			//文件太大
			uploadMessage = "文件太大！";
			err = "true";
		}
	} else {
		//文件错误
		uploadMessage = "未选择文件！";
		err = "true";
	}

	//上传文件
	String filename = "";

	try {
		//如果文件正确则上传
		if (err.equals("false") && !file.isMissing()) {
			java.io.File fileurl = new java.io.File(file_url);
			if(!fileurl.exists()){
				fileurl.mkdirs();
			}
			//取文件名
			filename = (file_url + "/" + file.getFileName()).replace(
			"\\", "/");

			file.saveAs(filename);
			uploadMessage = "文件上传成功！";
		}
	} catch (Exception e) {
		//上传有误
		uploadMessage = "文件上传失败！";
		err = "true";
	}
	
	if("false".equals(err)){
		String curUserId = control.getUserID();
		ImpExcelOrgUser ieou = new ImpExcelOrgUser();
		uploadMessage = ieou.impExcelOrgUser(filename,curUserId);
	}
%>
<script language="javascript">
		alert("<%=uploadMessage%>");
		parent.document.getElementById("impButton").disabled=false;			
		document.location='default.jsp';	
</script>

