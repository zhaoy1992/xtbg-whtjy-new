<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.io.*,java.util.*,java.util.zip.*,com.chinacreator.cms.util.FileUtil"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="com.chinacreator.cms.templatemanager.*"%>
<%@ page import="com.chinacreator.cms.container.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.util.*"%>
<html>
<base target="_self">
<body>
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
    
    //����ģ���,��ģ������浽session
    String siteId = request.getParameter("siteId");
    String tmplzipname = request.getParameter("tmplzipname");
    tmplzipname = tmplzipname==null?"":tmplzipname;
	siteId = siteId==null?"":siteId;
	
    String repeatTmplName = request.getParameter("repeatTmplName");
    String repeatTmplAtt = request.getParameter("repeatTmplAtt"); 
      
	//��ʱģ��ID
	int tmplId = 888;
	//TemplatePackageManager pgManager = new TemplatePackageManager();
	TemplatePackage tmplpg = new TemplatePackage();
	TemplateInfo templateInfo = new TemplateInfo();
	Template template = new Template();
	tmplpg.setTemplatePackage(false);	
	tmplpg.setUnpackage_path(CMSUtil.getPath(CMSUtil.getPath(CMSUtil.getAppRootPath() , "cms/siteResource/siteTemplate"),tmplzipname));

	//����Template
	if(siteId != null){	
		template.setSiteId(Integer.parseInt(siteId));		
	}		
	String uri = request.getParameter("uri");
	template.setTemplatePath(uri);	
	String templateName = request.getParameter("templateName");
	template.setName(templateName);	
	String templateDesc = request.getParameter("templateDesc");
	template.setDescription(templateDesc);	
	String templateType = request.getParameter("templateType");
	if(templateType!=null){
		template.setType(Integer.parseInt(templateType));
	}
	String templateStyle = request.getParameter("templateStyle");
	if(templateStyle!=null && !"".equals(templateStyle)){
		template.setStyle(Integer.parseInt(templateStyle));
		System.out.println(template.getStyle());
	}
	template.setCreateUserId(Long.parseLong(control.getUserID()));
	template.setHeader("null");
	template.setText("null");	
	template.setPersistType(Template.PERSISTINFILE);		
	String fileName = request.getParameter("fileName");
	if(fileName!=null && fileName.trim().length()!=0){
		template.setTemplateFileName(fileName);
	}
	template.setTemplateId(tmplId);
	
	//����TemplatePackage	
	templateInfo.setTemplate(template);
	tmplpg.addTemplateInfo(templateInfo);
	//���浽session
	session.removeAttribute(tmplzipname);
	session.setAttribute(tmplzipname,tmplpg);
%>

    <form name="form1" method="post">
        <input type="hidden" name="tmplzipname" value="<%=tmplzipname%>">
        <input type="hidden" name="siteId" value="<%=siteId%>">
        <!--ģ��ID-->
        <input type="hidden" name="tmplname" value="<%=tmplId%>">
        
        <input type="hidden" name="repeatTmplName" value="<%=repeatTmplName%>">
        <input type="hidden" name="repeatTmplAtt" value="<%=repeatTmplAtt%>">
    </form>
</body>
<script>
    window.onload=function autosubmit(){
        document.form1.action="import_template_do.jsp?importType=local";        
        document.form1.submit();
        
    }
</script>

</html>
    