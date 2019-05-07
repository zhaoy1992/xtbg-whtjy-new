<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.cms.documentmanager.*"%>
<%@page import="com.chinacreator.cms.documentmanager.bean.*"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.driver.publish.impl.*"%>
<%@ page import="com.chinacreator.cms.driver.publish.*"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.cms.util.CMSUtil"%>

<%
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);
	
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
	
	DocumentManager dm = new DocumentManagerImpl();
	
	//�ӡ��ѷ�������ҳ��͡�Ƶ���ĵ���ҳ��ᴫ��flag������
	//ֵΪrecursive����ʾҪ�ݹ淢��������Ȼ��Ҫ���жϣ�ֻ�д��ڡ��ѷ���״̬���ĵ����ܵݹ�
	String flag = request.getParameter("flag"); 
	String siteId = request.getParameter("siteId");
	String errorstr = "";//��Ų���ɾ�����ĵ��������Ϣ
	String userid = accesscontroler.getUserID();
	String docidStr = request.getParameter("docidStr");	
	String[] docidArr = docidStr.split(";");
	//���ĵ�id���ַ�������ת��Ϊ��������	
	int[] intDocids = new int[docidArr.length];
	for(int i=0;i<docidArr.length;i++){
		intDocids[i] = Integer.parseInt(docidArr[i].trim());
	}
	Map map = dm.eliminateUnOpDoc(intDocids);
	errorstr = (String)map.get("errormsg");
	if(!"".equals(errorstr))
		errorstr = "�����ĵ�����ɾ����\\n" + errorstr;
	intDocids = (int[])map.get("docids");
	try{
		StringBuffer doctitles = new StringBuffer();
		java.util.List recursivedocs = new java.util.ArrayList();
		
		//��ȡҪ�ݹ鷢�����ĵ�
		if("recursive".equals(flag))
		{
			java.util.List docs = dm.getDocInfoByIds(docidStr);	
					
			for(int i=0;i<docs.size();i++)
			{
				
				Document recdoc = (Document)docs.get(i);
				doctitles.append(recdoc.getSubtitle()).append(";");
				if(recdoc.getStatus() == 5 && recdoc.getDocflag() == 0)
				{
					recursivedocs.add(recdoc);
				}
			}
		}
		
		try
		{
			dm.deleteDoc(request, intDocids, siteId);
		}
		catch(DocumentManagerException e)
		{
			errorstr = e.getMessage();
			e.printStackTrace();
		}

		
		//��¼������־
		LogManager logManager = SecurityDatabase.getLogManager();
		logManager.log(accesscontroler.getUserAccount(),"ɾ���ĵ�.�ĵ�����:" + doctitles.toString(),"�ĵ�����",request.getRemoteAddr(),"");
		if("recursive".equals(flag))
		{
			if(recursivedocs.size() > 0)
			{
				int action = RecursivePublishManager.ACTIONTYPE_DELETE;
				session.removeAttribute("docs");
				session.setAttribute("docs",recursivedocs);
			%>
				<html>
				<body>
				<iframe name="recursiveFrame" src="recursiveHandle.jsp?siteId=<%=siteId%>&action=<%=action%>"></iframe>
				</body>
				</html>
				<!-- publish.recursivePubObjectOfDocuments(siteId,docs,RecursivePublishManager.ACTIONTYPE_ARCHIVE);-->
			<%
			}
		}

		%>
		<SCRIPT LANGUAGE="JavaScript">
			<%if(!errorstr.equals("")){%>
				alert("<%=CMSUtil.filterStr(errorstr)%>");
			<%}else{%>
				alert("ɾ���ĵ��ɹ���");
			<%}%>
			var str = parent.document.location.href;
			var end = str.indexOf("?");
			var strArray;
			if(end != -1)
			 	strArray= str.slice(0,end);
			else
				strArray = str;
			parent.document.location.href = strArray+"?" + parent.document.all.queryString.value;
		</script>
		
	<%}catch(Exception e){
		e.printStackTrace();
	%>		
		<SCRIPT LANGUAGE="JavaScript"> 
			alert("ɾ���ĵ�ʧ�ܣ�");
		</script>		
	<%
		}
	%>			