<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.util.*" %>
<%@page import="com.chinacreator.cms.sitemanager.*" %>
<%@page import="com.chinacreator.cms.container.Template" %>
<%@ page import="java.util.List"%>
<%@page import="com.chinacreator.cms.templatemanager.*" %>
<%@page import="com.chinacreator.cms.flowmanager.*" %>
<%@page import="com.frameworkset.common.poolman.DBUtil" %>
<%@page import="java.util.*" %>
<%@page import="com.chinacreator.cms.driver.publish.impl.*" %>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);

	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);

	String siteId = request.getParameter("siteId");
	int indexTemplateId = Integer.parseInt(request.getParameter("ddIndexTemplate").trim());
	if(siteId == null || siteId.trim().length()==0){
	%>
		<script language="javascript" type="text/javascript">
			alert("վ��idΪ��,�޷��༭վ��.");
			self.location.href = "about:blank";
		</script>
	<%
		return;
	}
	SiteManager sm = new SiteManagerImpl();
	Site site = sm.getSiteInfo(siteId) ;
	int oraIndexTemplateId=site.getIndexTemplateId();//��ȡԭ��վ���ģ��id
	
	System.out.println("oraIndexTemplateId---"+oraIndexTemplateId);
	site.setIndexTemplateId(indexTemplateId);	
	if(sm.updateSite(site))
	{
	  if(oraIndexTemplateId!=0 && indexTemplateId!= oraIndexTemplateId)
	  {
	    //�����Ϊ�����޸�ǰ��ģ�岻ͬ,����ɾ��վ���ڵݹ鷢����ϵ���еĹ�ϵ����
	     RecursivePublishManagerImpl imp =new RecursivePublishManagerImpl();
	     imp.deletesiteRelation(siteId);
	  }
	%>
	<script language = "javascript">
		alert("�༭�ɹ�");	
		parent.updateParentForm();
		parent.close();
    </script>
	<%
	 
	}else
	{
		%>
	<script language = "javascript">
	alert("�༭ʧ����.");	
    </script>
	<%
	}
%>
