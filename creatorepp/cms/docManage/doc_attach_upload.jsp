<%
/**
  *	�ϴ��ĵ���ظ���
  */
%>
<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="com.chinacreator.security.*"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.io.*"%>
<jsp:useBean id="date" scope="page" class="net.fiyu.edit.TimeStamp"/>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	String datePath = (String)date.Time_YMD().substring(0,6);
	
	try
	{
		String FileName,FileExt;
		String fileAllName = "";
		//
		String docpath = request.getParameter("docpath");
		//���ļ�
		SmartUpload up = new SmartUpload();
		//��ʼ���ϴ����
		up.initialize(pageContext);
		//�����ϴ��ļ���С
		up.setMaxFileSize(50000*1024);
		
		up.setCharset("gb2312") ;
		
		//�����ϴ��ļ�����
		//String setExt=sAllowExt.replace('|',',');
		//up.setAllowedFilesList(setExt);
		// Upload
		up.upload();
		// Select each file
		for (int i=0;i<up.getFiles().getCount();i++){
		// Retreive the current file
			com.jspsmart.upload.File myFile = up.getFiles().getFile(i);
			if (!myFile.isMissing()) {
				FileName = (String)date.Time_Stamp();
				FileExt = myFile.getFileExt();
				fileAllName = FileName + "." + FileExt;
				//sOriginalFileName=myFile.getFileName();
				String path = "/cms/siteResource/" + docpath + "/" + datePath + "/" + fileAllName;
				String parentPath = config.getServletContext().getRealPath("/") + "/cms/siteResource/"+docpath + "/" + datePath;
				java.io.File parentFile = new java.io.File(parentPath);
				
				if(!parentFile.exists())
				{
					parentFile.mkdirs();
				}
				myFile.saveAs(config.getServletContext().getRealPath("/") + path);
			}
		}
%>
<SCRIPT LANGUAGE="JavaScript">
	//���ø����ڵĽ�������
	var fname = "<%=datePath+"/"+fileAllName%>";
	parent.UploadLoaded(fname);
</SCRIPT>
<%
	}catch(Exception e)
	{
%>
<SCRIPT LANGUAGE="JavaScript">
	alert("�ϴ��ļ�ʧ�ܣ�");
	window.close();
</SCRIPT>
<%
	e.printStackTrace();
	}
%>