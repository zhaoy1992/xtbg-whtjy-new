<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="java.io.*" %>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ page import="com.chinacreator.security.AccessControl" %>
<%@ page import="com.chinacreator.cms.*"%>
<%@ page import="com.chinacreator.cms.util.*"%>
<%@ page import="com.chinacreator.cms.sitemanager.*" %>
<%@ page import="com.chinacreator.cms.templatemanager.*" %>
<%@ page import="com.chinacreator.cms.imagemanager.ImageManagerImpl"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
<title></title>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);
	
	String uri = request.getParameter("uri");
	//fileFlagΪ"1"��ʾ��ҳ�ļ���ѡ��Ϊnull��""��ʾΪͼƬ��ѡ��
	String fileFlag = request.getParameter("fileFlag");
	//fileFlag = fileFlag == null?"pic":fileFlag;//Ĭ��Ϊѡ��ͼƬ

	CMSManager cmsmanager = new CMSManager();
	cmsmanager.init(request,session,response,control);

	String siteId =  cmsmanager.getSiteID();

	String pathContext = null;
	String waterpicpath = ImageManagerImpl.getWATERIMAGE_FORDER();//ˮӡͼƬ·��
	if(siteId!=null && siteId.trim().length()!=0){
		String temp = (new SiteManagerImpl()).getSiteAbsolutePath(siteId);
		if(temp!=null && temp.trim().length()!=0){
			pathContext = new File(temp,"_template/" + waterpicpath).getAbsolutePath();
		}
	}
	if(pathContext==null || pathContext.trim().length()==0){
%>
		<script language="javascript">
			alert("û���ҵ�վ������·��.");
		</script>
<% 
		return;
	}
%>
<%
response.setContentType("text/html;charset=GBK");
 %>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<script type="text/javascript">
var uri = "";
<%
if(uri!=null && uri.trim().length()!=0){
	out.println("uri = '"+uri+"';");
}
%>
function setImage(name){
	var url = uri.replace("\\","/");
	
	if(url.charAt(0) == '/'){
		url = url.substr(1); 
	}
	if(url.charAt(url.length-1) != '/' && url.search(/\S+/img)!=-1){
		url += "/";
	}
	
	url += name;

	parent.parent.theOpener.setImage(url);
	
	top.close();
}
function preview(fileName,abstractPth){
	var uri = "<%=uri==null?"/":uri%>";
	var url = uri.replace("\\","/");
	if(url.charAt(0) == '/'){
		url = url.substr(1); 
	}
	if(url.charAt(url.length-1) != '/' && url.search(/\S+/img)!=-1){
		url += "/";
	}
   window.open("<%=rootpath%>/cms/siteResource/site<%=siteId%>/_template/<%=waterpicpath%>/"+ url + fileName);
}
function preview1(fileName,abstractPth){
   var uri = "<%=uri==null?"/":uri%>";
	var url = uri.replace("\\","/");
	if(url.charAt(0) == '/'){
		url = url.substr(1); 
	}
	if(url.charAt(url.length-1) != '/' && url.search(/\S+/img)!=-1){
		url += "/";
	}
     var path="<%=rootpath%>/cms/siteResource/site<%=siteId%>/_template/<%=waterpicpath%>/"+ url + fileName;
     window.open("showimg.jsp?filepath="+path);
	
}
function high(ob,fileName){
	var tds = document.getElementsByName("picName");
	for(var i=0;i<tds.length;i++){
		unhigh(tds[i]);
	}
	ob.bgColor="#C3D2E5";
	parent.ToolsFrm.selectedFileName=fileName;
}
function unhigh(ob){
	ob.bgColor="";
}
function test(o)
{
var uri = "<%=uri==null?"/":uri%>";
	var url = uri.replace("\\","/");
	if(url.charAt(0) == '/'){
		url = url.substr(1); 
	}
	if(url.charAt(url.length-1) != '/' && url.search(/\S+/img)!=-1){
		url += "/";
	}
     var path="<%=rootpath%>/cms/siteResource/site<%=siteId%>/_template/<%=waterpicpath%>/"+ url + o.filename;
     window.open(path);
}
</script>
</head>
<body>
<table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolordark="#FFFFFF" bordercolorlight="#eeeeee">
<%
	FileFilter fileFilter = null;
	if(fileFlag != null && fileFlag.equals("media"))
	{
		fileFilter = new MediaFileFilter();
	}
	if(fileFlag != null && fileFlag.equals("pic"))
	{
		fileFilter = new ImageFileFilter();
	}
	if(fileFlag != null && fileFlag.equals("1"))
	{
       fileFilter = new IndexPageFilter(siteId,uri);
	}
	if(fileFlag != null && fileFlag.equals("file"))
	{
       fileFilter = new ResourceFilter();
	}
	File[] files = FileUtil.getSubFiles(pathContext,uri,fileFilter);
	for(int i=0;files!=null&&i<files.length;i++){
%>
	<tr onselectstart="return false" style="cursor:hand;height:25px"  class="cms_data_tr">
		<td  onclick="high(this,'<%=files[i].getName()%>')" name="picName" id = "picName" width="80%">
		<%=files[i].getName()%>
		</td>
		<%
			if(fileFlag != null && fileFlag.equals("pic"))//ͼƬ
			{
		%>
			<td width="20%">
			<script type="text/javascript">
            
           
			var uri = "<%=uri==null?"/":uri%>";
	        var url = uri.replace("\\","/");
	       if(url.charAt(0) == '/')
	         {
		        url = url.substr(1); 
	         }
	       if(url.charAt(url.length-1) != '/' && url.search(/\S+/img)!=-1)
	          {
		         url += "/";
	          }
             var path="<%=rootpath%>/cms/siteResource/site<%=siteId%>/_template/<%=waterpicpath%>/"+ url + "<%=files[i].getName()%>";
             var filename="<%=files[i].getName()%>";
             var imgstr='<image src="'+path+'" filename="'+filename+'" style=\"cursor:hand\" onclick=\"test(this)\" name=\"previewPic\" width=\"40\" height=\"30\" alt=\"Ԥ��\"></image>';
             document.write(imgstr);
			</script>
				
				
			</td>
		<%
			}
			if(fileFlag != null && fileFlag.equals("1"))//��ҳ
			{
		%>
			<td width="20%">
				<a style="cursor:hand" onclick="preview('<%=files[i].getName()%>')">Ԥ��</a>
			</td>
		<%
			}
		%>
	</tr>
<%		
	}
%>	
</table>
 <div id="divProcessing" style="width:280px;height:50px;left:50px;top:150px;display:none">
        <table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%">
            <tr>
                <td bgcolor=#3A6EA5>
                    <marquee align="middle" behavior="alternate" scrollamount="5">
                        <font color=#FFFFFF>...�ļ��ϴ���...��ȴ�...</font>
                    </marquee>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>
