<%@ page language="java" contentType="text/html; charset=GBK"%>
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
try{
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	String pathContext = (String)session.getAttribute("pathContext");
	if(pathContext==null || pathContext.trim().length()==0){
%>
		<script type="text/javascript">
			alert("û���ṩ��Դ��������·��,�޷�������Դ.");
			top.close();
		</script>
<%
		return;
	}else{
        pathContext = pathContext.replaceAll("\\\\","/");
    }
	String uri = request.getParameter("uri");
	String files = request.getParameter("files");
	if(files==null||files.trim().length()==0){
%>
		<script type="text/javascript">
			alert("��ѡ����Ҫɾ�����ļ�(��).");
		</script>
<%		
		return;		
	}
	
	String[] fileNames = files.split("<>");
	if(uri==null){
		uri = "";
	}else{
		uri = uri.replace('\\','/');
		if(uri.startsWith("/")){
			uri = uri.substring(1);
		}
		if(!uri.endsWith("/")){
			uri = uri+"/"; 
		}
		if("/".equals(uri.trim())){
			uri = "";
		}
	}
	
	for(int i=0;i<fileNames.length;i++){
		FileUtil.deleteFile(pathContext+"/"+uri+"/"+fileNames[i]);
		FileUtil.deleteFileOnly(pathContext+"/"+uri+"/"+fileNames[i]);	
	}	
}catch(Exception e){
%>
	<script type="text/javascript">
		alert("ɾ���ļ�ʱ�����쳣,<%=e.getMessage()%>");
	</script>	
<%	e.printStackTrace();
	return;
}
%>
<script type="text/javascript">
	alert("ɾ���ļ��ɹ�!");
	parent.document.location.href = parent.document.location.href ;	
</script>
</body>
</html>