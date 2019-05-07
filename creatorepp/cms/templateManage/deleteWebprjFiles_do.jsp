<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.io.*" %>
<%@ page import="com.chinacreator.cms.*" %>
<%@ page import="com.chinacreator.cms.util.*"%>
<%@ page import="com.chinacreator.cms.templatemanager.*" %>
<%@ page import="com.chinacreator.cms.sitemanager.*"%>
<%@ page import="com.chinacreator.cms.imagemanager.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title></title>
</head>
<body>
<%
String viewtype = request.getParameter("viewtype"); 
try{
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
    //add by ge.tao ɾ��ˮӡ��¼��
    ImageManagerImpl impl = new ImageManagerImpl();
	CMSManager cmsmanager = new CMSManager();
	cmsmanager.init(request,session,response,control);
	String userId = control.getUserID();
	String siteId =  cmsmanager.getSiteID();
	String pathContext = null;	
	if(siteId!=null && siteId.trim().length()!=0){
		String temp = (new SiteManagerImpl()).getSiteAbsolutePath(siteId);
		if(temp!=null && temp.trim().length()!=0){
			pathContext = new File(temp,"_webprj").getAbsolutePath();
		}
	}
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
			top.close();
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
	FileManagerImpl fm = new FileManagerImpl();
	for(int i=0;i<fileNames.length;i++){
		fm.deleteWebprjFiles(siteId,uri+fileNames[i],userId);
		
        /*ɾ��ˮӡ��¼�� add  by ge.tao*/
        String tmp = CMSUtil.getPath(CMSUtil.getPath(pathContext , uri), fileNames[i]);
        tmp = tmp.replaceAll("\\\\","/");
        tmp = tmp.replaceAll("//","/");
        String sqlstr = "delete TD_CMS_ADDWATERIMAGE where url='"
                      + tmp.toLowerCase() + "'"; 
        impl.execute(sqlstr);
        //ɾ�������ļ�
        String backup = CMSUtil.getPath(CMSUtil.getPath(pathContext, impl.getNORMALIMAGE_FORDER()), fileNames[i]+ ".bak");
        File f = new File(backup);
        if(f.exists()) f.delete();
        /*end*/
	}	
}catch(Exception e){
%>
	<script type="text/javascript">
		alert("ɾ���ļ�ʱ�����쳣,<%=e.getMessage()%>");
		top.close();
	</script>	
<%	e.printStackTrace();
	return;
}
if(viewtype != null && viewtype.equals("other"))
{
%>
<script type="text/javascript">
	alert("ɾ���ļ��ɹ�!");
	var urlstr = parent.window.dialogArguments.parent.ImageListFrm.location.href;
	parent.window.dialogArguments.parent.ImageListFrm.location.href = urlstr;
	window.close();
</script>
<%
}
else
{
%>
<script type="text/javascript">
	alert("ɾ���ļ��ɹ�!");
	window.dialogArguments.reloadView();
	window.dialogArguments.open("navigator_content.jsp","perspective_toolbar");
	top.close();
</script>
<%
}
%>
</body>
</html>