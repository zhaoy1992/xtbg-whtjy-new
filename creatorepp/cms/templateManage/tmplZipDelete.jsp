<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="java.sql.*,java.util.*"%>
<%@ page import="com.chinacreator.security.*"%>
<%@ page import="com.chinacreator.cms.templatemanager.*"%>
<%  
    AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);  
    ServletContext context =session.getServletContext();
    //ģ���ŵ�·��
    String templatePath = application.getRealPath("cms/siteResource/siteTemplate");
    templatePath = templatePath.replaceAll("\\\\","/");
    TemplateManager tmplUtil = new TemplateManagerImpl();
    
    String[] ids = request.getParameterValues("id");
    for(int i=0;i<ids.length;i++){
        if("".equals(ids[i])) continue;
        tmplUtil.deleteExportTmplRecord(ids[i],templatePath);
    }
    
        
%>
<script>
    alert("ɾ���ɹ�");
    window.parent.location.href = window.parent.location;
</script>