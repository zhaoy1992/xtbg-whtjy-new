<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.io.*,java.util.*,java.util.zip.*,com.chinacreator.cms.util.FileUtil"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="com.chinacreator.cms.templatemanager.*"%>
<%@ page import="com.chinacreator.cms.container.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.util.*"%>

<div id=divProcessing style="width:200px;height:30px;position:absolute;left:200px;top:330px;display:none">
	<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%">
	    <tr>
		    <td bgcolor=#3A6EA5>
			    <marquee align="middle" behavior="alternate" scrollamount="5">
				    <font color=#FFFFFF>...������...��ȴ�...</font>
				</marquee>
			</td>
		</tr>
	</table>
</div>
<%
    AccessControl control = AccessControl.getInstance();
    control.checkAccess(request, response);
    response.setHeader("Cache-Control","no-cache");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", -1);
    response.setDateHeader("max-age", 0);
    
    //local����/remoteԶ�̵���
    String importType = request.getParameter("importType"); 
    importType = importType==null?"":importType;
    
    //ģ��ȥ�ر�־
    String repeatTmplName = request.getParameter("repeatTmplName");
    //����ȥ�ر�־
    String repeatTmplAtt = request.getParameter("repeatTmplAtt"); 
     
    //com.chinacreator.cms.CMSManager cmsManager  = new com.chinacreator.cms.CMSManager();
    //cmsManager.init(request,session,response,control);  
    String siteId = request.getParameter("siteId"); 
    siteId = siteId==null?"":siteId;
   
    //ģ��ID
    String[] tmplnames = request.getParameterValues("tmplname");
    //ģ�������
    String tmplzipname = request.getParameter("tmplzipname");
    //��session��ȡ��TemplatePackageģ�������
    TemplatePackage tmplpg = (TemplatePackage)session.getAttribute(tmplzipname);
    session.removeAttribute("tmplzipname");
    
     //��·����"\"ת��Ϊ"\\"
   String tmpPath=tmplpg.getUnpackage_path().replaceAll("\\\\","\\\\\\\\");
     
    //ģ���б�
    List tmplInfos = tmplpg.getTemplateInfos();
        
    TemplatePackageManager pgManager = new TemplatePackageManager();    
    for(int i=0;i<tmplnames.length;i++){
        //tmplname��ģ��ID
        String tmplname = tmplnames[i];
        if("".equals(tmplname) || "on".equals(tmplname)) 
            continue;     
        
        for(int j=0;j<tmplInfos.size();j++){
            TemplateInfo tmplInfo = (TemplateInfo)tmplInfos.get(j);
            Template template = tmplInfo.getTemplate();
            if(tmplname.equals(String.valueOf(template.getTemplateId()))){
                tmplpg.addSelectTemplateInfo(tmplInfo);
                //break;
            }
        }
    }
    int copytype = pgManager.getFileCopyType(repeatTmplName,repeatTmplAtt);
    pgManager.importTmpls(request,tmplpg,siteId,importType,copytype);
    
    
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<title></title>
	<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
</head>
<base target="_self">
<body>
<table width="98%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" align="center">    
        <tr>
            <td width="4%" height="30" align="right">
                <img src="../images/ico_point.gif" width="25" height="25">
            </td>
            <td height="30" class="cms_title_blue">
                  ģ�嵼��ɹ�
            </td>
        </tr>
        <tr>
            <td colspan="2" style="height:9px; background-color:#3266B1"></td>
        </tr>
        <tr>
            <td colspan="2" style="height:10px; background-color:#fff"></td>
        </tr>
        <tr>
            <td colspan="2">
                <table width="100%" align="center" border="0"  bordercolor="#f0f0f0">
                    <tr>                        
                        <td height="24" align="center">
                               ģ�嵼��ɹ�! 
                        </td>                          
                    </tr>
                    <tr>
                       <td colspan=2 height="54" align="center">
		                   <input type="button" type="button" class="cms_button" value="�ر�" onclick="closeit()" >
		               </td> 
                    </tr>                    
                </table>
            </td>
        </tr>
    </table>
    <form name="form1" method="post" ></form>
</body>

<script language="javascript">    
    if("<%=importType%>" == "local")//���ص���,ˢ����ߵ���        
        parent.parent.TreeFrm.location.href = parent.parent.TreeFrm.location;
    function closeit(){
	    if(parent.document.all("divProcessing"))
	        parent.document.all("divProcessing").style.display="none";
	    if("<%=importType%>" == "local"){ 
			if(confirm("��ȷ��Ҫ�ر���?") ){
				deleteTmpDir();  
			}
		}else{
		    deleteTmpDir(); 
		    window.returnValue="ok";			
			window.close();
		}
		 
	}  	
	function deleteTmpDir(){
	   var tmpPath = "<%=tmpPath%>";	   
	    document.form1.action = "deleteTmpDir.jsp?tmpPath="+tmpPath;
	    document.form1.target="hiddenFrame" ;
	    document.form1.submit();	    
	}  
	
</script>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</html>