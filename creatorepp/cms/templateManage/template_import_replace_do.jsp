<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="java.io.*,java.util.*,java.util.zip.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="com.chinacreator.cms.sitemanager.*"%>
<%@ page import="com.chinacreator.cms.templatemanager.*"%>
<%@ page import="com.chinacreator.cms.container.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.util.*"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<title></title>
</head>
<body>
<%
File temp = null;

try{
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	//����һ����ʱĿ¼
	temp = new File(application.getRealPath("/"),"temp16759"+Math.random());
	temp.mkdirs();
 	 
	//��ȡվ�����ļ�ϵͳ�еľ���·��
	String siteId = request.getParameter("siteId");
	if(siteId == null || siteId.trim().length()==0){
		throw new Exception("��ȡ����վ��idʧ��,�޷�����idȥ����Ŀ¼");
	}
	String sitepath = (new SiteManagerImpl()).getSiteAbsolutePath(siteId);
	if(sitepath==null || sitepath.trim().length()==0){
		throw new Exception("����վ��id["+siteId+"],û���ҵ�վ���Ӧ��Ŀ¼,�޷������ϴ����ļ�.");
	}
	File siteroot = new File(sitepath);
	if(!siteroot.exists()){
		siteroot.mkdirs();
	}
	
	String uri = request.getParameter("uri");
	System.out.print("uri="+uri);
	if(uri==null || uri.trim().length()==0){
		//throw new Exception("���ṩģ���ŵ����·��.");
		uri = "" ;
	}

	File currTemplateFolder = new File(new File(siteroot,"_template").getAbsolutePath(),uri);
	//File currTemplateFolder = new File(siteroot,"_template") ;

	
	System.out.println("�ļ�Ŀ¼:"+currTemplateFolder.getAbsolutePath());
	//��ΪĿ¼����һ�ζ�������,����ɾ����
	currTemplateFolder.mkdirs();
	
	FileItemFactory fileitemfactory = new DefaultFileItemFactory(2048000,temp);
	FileUpload fu = new FileUpload(fileitemfactory);
	List fields = fu.parseRequest(request);
	for(int i=0;fields!=null&&i<fields.size();i++){
		FileItem file = (FileItem)fields.get(i);
		if(!file.isFormField()){
			ZipInputStream fullzipfile = new ZipInputStream(new BufferedInputStream(file.getInputStream()));
			FileUtil.upzip(fullzipfile,currTemplateFolder.getAbsolutePath());
		}
	}

	%>
	
	<script language="javascript">
		alert('����ģ��ɹ�');
		window.dialogArguments.location.reload();
		top.close();
	</script>
<%}catch(Exception e){
	out.println("<script language=\"javascript\">");
	out.println("alert('"+e+"');");
	out.println("</script>");
	e.printStackTrace();
}finally{
	try{
		if(temp!=null){
			FileUtil.deleteSubfiles(temp.getAbsolutePath());
			FileUtil.deleteFile(temp.getAbsolutePath());
		}
	}catch(Exception e){}

}
%>
</body>
</html>
