<%
/**
  *	�ϴ��ĵ���ظ���
  * Ȼ�����ĵ���Ϣ�����ݿ�
  */
%>
<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="com.chinacreator.security.*"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="com.chinacreator.cms.documentmanager.util.DocZipUtil"%>
<%@page import="com.chinacreator.cms.sitemanager.*"%>
<%@page import="com.chinacreator.cms.documentmanager.*"%>
<%@page import="com.chinacreator.cms.channelmanager.*"%>
<jsp:useBean id="date" scope="page" class="net.fiyu.edit.TimeStamp"/>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);

	String siteid= request.getParameter("siteid");
	String channelId = request.getParameter("channelId");

	String FileName,FileExt;
	String fileAllName = "";
	int count = 0;
	
	ChannelManager cm = new ChannelManagerImpl();
	SiteManager sm = new SiteManagerImpl();
	String docpath = sm.getSiteInfo(siteid).getSiteDir();// + "/_webprj/" + cm.getChannelInfo(channelId).getChannelPath() + "/content_files";

	try
	{
		String path = "";
		String type = "";
		
		SmartUpload up = new SmartUpload();
		up.initialize(pageContext);
		up.setMaxFileSize(50000*1024);
		
		up.setCharset("gb2312") ;
		
		up.upload();
		
		com.jspsmart.upload.Request req = up.getRequest();
		String fname = req.getParameter("fname");
		String urlfname = req.getParameter("urlfname");
		
		String folderPath =  config.getServletContext().getRealPath("/") + "cms/docManage/temp/upload" ;			
		java.io.File f = new java.io.File(folderPath) ;
					
		if(!f.exists())
		{
			f.mkdirs() ;
		}
		
		if(fname != null && !(fname.trim().equals("")))//�ϴ��Ĵ���
		{
			//���ļ�
			for (int i=0;i<up.getFiles().getCount();i++){
				com.jspsmart.upload.File myFile = up.getFiles().getFile(i);
				if (!myFile.isMissing()) {
					FileName = (String)date.Time_Stamp();
					FileExt = myFile.getFileExt();
					fileAllName = FileName + "." + FileExt;
					
					path = folderPath + "/" + fileAllName;
					myFile.saveAs(path);
				}
			}
			//�����zip�ļ������ϴ�
			type = DocZipUtil.FORM_REMOTE;
			//��ѹ�������ļ�
			count = DocZipUtil.xml2DB(request,response,channelId,config.getServletContext().getRealPath("/"),fileAllName,docpath,type);
			
			java.io.File tmpfile = new java.io.File(path);
			tmpfile.delete();
		}
		if(urlfname != null && !(urlfname.trim().equals("")))//ѡ�������zip�ļ��Ĵ���
		{
			fileAllName = urlfname.trim();
			//�����zip�ļ��Ǵӷ�����ѡ��
			type = DocZipUtil.FORM_LOCAL;
			//��ѹ�������ļ�
			count = DocZipUtil.xml2DB(request,response,channelId,config.getServletContext().getRealPath("/"),fileAllName,docpath,type);
		}
		
%>
<SCRIPT LANGUAGE="JavaScript">
	//���ø����ڵĽ�������
	var count = "<%=count%>";
	parent.UploadLoaded(count);
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