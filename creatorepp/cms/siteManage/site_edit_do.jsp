<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.cms.sitemanager.*"%>
<%@ page import="com.chinacreator.cms.searchmanager.*"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="com.chinacreator.security.AccessControl,com.chinacreator.cms.sitemanager.*"%>
<%
	try {
		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request, response);

		response.setHeader("Cache-Control", "no-cache"); 
		response.setHeader("Pragma", "no-cache"); 
		response.setDateHeader("Expires", -1);  
		response.setDateHeader("max-age", 0);
        
        String isShowModeWindow = request.getParameter("isShowModeWindow");
        
		Site site = new Site();

		site.setDbName(request.getParameter("dbName"));
		
		String siteId = request.getParameter("siteId"); 
		
		if(siteId==null || siteId.trim().length()==0){
			throw new SiteManagerException("վ��idΪ��,�޷�����վ��");
		
		}	
		
		//���µ�ǰվ�����վ����,da.wei
		CMSSearchManager searchManager = new CMSSearchManager();
		int indexId = searchManager.isAllSiteIndexExist(siteId);
		String index_level = request.getParameter("index_level");
		String index_day = request.getParameter("index_day");
		String index_time = request.getParameter("index_time");
		String index_sql = "update td_cms_site_search set lever=" + index_level + ", day=" + index_day + ", time=" + index_time + " where id=" + indexId;
		try{
			DBUtil index_db = new DBUtil();
			index_db.executeSql(index_sql);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		site.setSiteId(Long.parseLong(siteId));
		String workFlowFrom = request.getParameter("workFlowFrom");

		site.setFtpFolder(request.getParameter("ftpFolder"));
		site.setFtpIp(request.getParameter("ftpIp"));

		String ftpPort = request.getParameter("ftpPort");
		if (ftpPort != null && !"".equals(ftpPort)) {
			site.setFtpPort(Short.parseShort(ftpPort));
		}
		
		String ftpUser = request.getParameter("ftpUser");
		if (ftpUser != null && !"".equals(ftpUser)) {
			site.setFtpUser(ftpUser);
		}
		
		String ftpPassword = request.getParameter("ftpPassword");
		if (ftpPassword != null && !"".equals(ftpPassword)) {
			site.setFtpPassword(ftpPassword);
		}
		
		site.setIndexFileName(request.getParameter("indexFileName"));

		site.setName(request.getParameter("siteName"));

		String publishDestination = request.getParameter("publishDestination");
		if (publishDestination != null && !"".equals(publishDestination)) {
			site.setPublishDestination(Integer.parseInt(publishDestination));
		}
		//�ַ���ʽ����
		String distributeManners = request.getParameter("distributeManners");
		site.setDistributeManners(distributeManners);

		site.setSecondName(request.getParameter("secondName"));

		site.setSiteDesc(request.getParameter("siteDesc"));

		String templateId = request.getParameter("templateId");
		System.out.println("templateId="+templateId.trim());
		if (templateId != null && templateId.trim().length()!=0) {
			site.setIndexTemplateId(Integer.parseInt(templateId.trim()));
		}


		site.setWebHttp(request.getParameter("webHttp"));
		site.setLocalPublishPath(request.getParameter("localpublishpath"));
		String order = request.getParameter("order");
		if (order != null && !"".equals(order)) {
			site.setSiteOrder(Integer.parseInt(order));
		}
	
		SiteManager smi = new SiteManagerImpl();
		//smi.updateSite(site);
		smi.logUpdateSite(site,request,response);
		//�޸�վ����Ϣˢ�»���
		//SiteCacheManager.getInstance().reset();
	%>
	<script language="javascript">
		alert("�༭վ��ɹ�!");
		var isReflash = "";//�����ж��Ƿ�Ҫˢ��
		if(parent.window.document.forms[0].ositeName.value != parent.window.document.forms[0].siteName.value)
		{
			parent.window.returnValue = "saveSite";//�����ж��Ƿ�Ҫˢ��
			isReflash = "reflash";//�����ж��Ƿ�Ҫˢ��
		}
	
	//	window.open("allSiteTree.jsp","perspective_toolbar");
	//	window.open("site_edit.jsp?siteId=<%=siteId%>","perspective_content");
	    <%
		//add by lj��������Ա˵��ֱ�ӵ��վ����ʱ������Ҫ��������رհ�ť
		if("1".equals(isShowModeWindow)){
		%>
			if(isReflash == "reflash")
			{
				window.open("allSiteTree.jsp","perspective_toolbar");
				window.open("site_edit.jsp?siteId=<%=siteId%>","perspective_content");
			}
			parent.location.href = parent.location.href;
		<%}else{%>	    
			parent.close();
		<%}%>
	</script>
	<%} catch (SiteManagerException e) {
		e.printStackTrace();
	%>
		<script language="javascript">
			alert('�༭վ�����,����!ԭ����:\n<%=e.getMessage().replaceAll("\n", "").replaceAll("'","")%>');
			//��ֹ�����ύ
			parent.window.document.all("button")[0].disabled = false;
			//parent.window.document.all("button")[1].disabled = false;
		</script>
	<%}%>
