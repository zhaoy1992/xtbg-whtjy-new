<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="com.chinacreator.cms.util.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title></title>
</head>
<body>
<%
try{
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	//����һ����ʱĿ¼
	File temp = new File(application.getRealPath("/"),System.currentTimeMillis()+""+Math.random());
	temp.mkdirs();
 	 
	String pathContext = (String)session.getAttribute("pathContext");
	if(pathContext==null || pathContext.trim().length()==0){
%>
		<script type="text/javascript">
			alert("û���ṩ��Դ��������·��,�޷�������Դ.");
			top.close();
		</script>
<%		
		return;
	}
	String coverFlag = null;
	String uri = null;
	//�����ļ��ϴ�
	FileItemFactory fileitemfactory = new DefaultFileItemFactory(2048000,temp);
	FileUpload fu = new FileUpload(fileitemfactory);
	List fields = fu.parseRequest(request);
	int n=0;
	for(int i=0;fields!=null&&i<fields.size();i++){
		FileItem field = (FileItem)fields.get(i);
		if(field.isFormField()&&"uri".equals(field.getFieldName())){
			uri = field.getString();
		}
		if(field.isFormField()&&"coverFlag".equals(field.getFieldName())){
			coverFlag = field.getString();
		}
	}
	
	File parentFolder = null;
	if(uri!=null && uri.trim().length()!=0){
		parentFolder = new File(pathContext,uri);
	}else{
		parentFolder = new File(pathContext);
	}
	for(int i=0;fields!=null&&i<fields.size();i++){
		FileItem file = (FileItem)fields.get(i);
		if(!file.isFormField()){
			//�����ļ�������ȡ����
			String source_file_name = file.getName().replaceAll("\\\\","/");
			File tempFile = new File(source_file_name);
			File f = new File(parentFolder.getAbsoluteFile(),tempFile.getName());
			if(coverFlag==null && f.exists()){				
				out.println("<script language=\"javascript\">");
				out.println("alert('�ļ��Ѿ�����,�����ϴ�֮ǰ�޸ĺ��ļ���!');");
				out.println("</script>");
				return;	
			}
			f.getParentFile().mkdirs();
			f.createNewFile();
			file.write(f);
		}
	}
	FileUtil.deleteSubfiles(temp.getAbsolutePath());
	FileUtil.deleteFile(temp.getAbsolutePath());
}catch(Exception e){
	out.println("<script language=\"javascript\">");
	out.println("alert('�ϴ����ļ������쳣,�쳣Ϊ"+e.getMessage()+"');");
	out.println("top.close();");
	out.println("</script>");			
	e.printStackTrace();
}
%>
<script type="text/javascript">
	alert("�ϴ��ļ��ɹ�.");
	parent.win.reloadView();
	top.close();
</script>
</body>
</html>
