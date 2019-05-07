<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.*"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>
<%@ page import="com.chinacreator.eppissue.menuissue.vo.MenuIssueVo"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	String uploadMessage = "";

	//�ϴ��ļ�����
	final String UpFileType = "zip";
	//�ϴ��ļ���С���ƣ��ļ���С2G��
	final int MaxFileSize = 2 * 1024 ;
	//�����ʶ
	String err = "false";

	//Ӧ�ø�����ʱ�ļ�·��
	String file_url = MenuIssueVo.s_MENUUPDATE_TEMP;

	//�½�һ��SmartUpload����
	SmartUpload su = new SmartUpload();
	//�ϴ���ʼ��
	su.initialize(pageContext);
	su.upload();

	//ȡ�ļ�
	File file = su.getFiles().getFile(0);

	//�ļ�Ч��
	//�ж��û��Ƿ�ѡ�����ļ�
	// ȡ���ļ�������
	if (!file.isMissing()) {
		//�õ��ļ���չ��
		String FileType = file.getFileExt();
		//����չ��ת����Сд
		FileType = FileType.toLowerCase();
		if (UpFileType.indexOf(FileType) == -1) {
			//�ļ���ʽ����
			uploadMessage = "�ļ���ʽ���ԣ�";
			err = "true";
		}
		//�õ��ļ���С������ΪM��
		int FileSize = file.getSize()/(1024*1024);
		if (err.equals("false") && FileSize > MaxFileSize) {
			//�ļ�̫��
			uploadMessage = "�ļ�̫��";
			err = "true";
		}
	} else {
		//�ļ�����
		uploadMessage = "δѡ���ļ���";
		err = "true";
	}

	//�ϴ��ļ�
	String filename = "";

	try {
		//����ļ���ȷ���ϴ�
		if (err.equals("false") && !file.isMissing()) {
			//ȡ�ļ���
			filename = (file_url + "/"+ file.getFileName()).replace("\\","/");

			file.saveAs(filename);
			uploadMessage = "�ļ��ϴ��ɹ���";			
		}
	} catch (Exception e) {
		//�ϴ�����
		uploadMessage = "�ļ��ϴ�ʧ�ܣ�";
		err = "true";
	}
	
%>
<html>
	<head>		
	</head>
	<body>
		<form name="xmlfileform" action="xml2pt.jsp" method="post">
			<input name="xmlfile" value="<%=file.getFileName() %>" type="hidden">
			<input name="isLoad" value="true" type="hidden">
			<input name="isRefresh" value="true" type="hidden">			
		</form>
		<script language="javascript">
			if("<%=err%>"=="false"){
				alert("<%=uploadMessage%>");
				document.xmlfileform.submit();
			}else{
				alert("<%=uploadMessage%>");			
				document.location='xmlupload.jsp';	
			}			
		</script>
	</body>
</html>
