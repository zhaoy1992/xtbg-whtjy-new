<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.searchmanager.*"%>
<%@ page import="com.chinacreator.cms.searchmanager.bean.*"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);

	String action = request.getParameter("action");
	String flag = request.getParameter("flag");
	String siteId = request.getParameter("siteId");
	
	String successFlag = "1";	//"1"Ϊ��ӳɹ�,"0"Ϊ���ʧ��,"-1"Ϊ������������,weida
	String closeWin = "1";

	boolean samename = true;	//���������ж�,weida
	
	CMSSearchManager sm = new CMSSearchManager();
	
	if("delete".equals(action) || "deleteFile".equals(action)){
		String[] indexes = null;
		if("1".equals(flag))		//վ������
			indexes = request.getParameterValues("webIndexID");
		else if("0".equals(flag))						//վ������
			indexes = request.getParameterValues("siteIndexID");
		else if("3".equals(flag))						//վȺ����
			indexes = request.getParameterValues("sitesIndexID");
		else if("4".equals(flag))						//վȺ����
			indexes = request.getParameterValues("dbIndexID");
		try{
			if("delete".equals(action))
			{
				sm.deleteIndex(indexes);
			}
			else
				sm.deleteIndexFiles(indexes);
			closeWin = "0";
		}catch(Exception e){
			successFlag = "0";
		}
	}else if("add".equals(action)){
		String searchType = request.getParameter("searchType");
		String indexName = request.getParameter("indexName");
		String level = request.getParameter("level");
		String day = request.getParameter("day");
		String time = request.getParameter("time");
		String siteNames = request.getParameter("siteNames");
				
		CMSSearchIndex searchIndex = new CMSSearchIndex();
		searchIndex.setSiteNames(siteNames);

//		searchIndex.setSiteId(Integer.parseInt(siteId.trim()));
		searchIndex.setSiteId(siteId);
		searchIndex.setSearchType(Integer.parseInt(searchType.trim()));
		searchIndex.setIndexName(indexName);
		searchIndex.setLever(Integer.parseInt(level.trim()));
		searchIndex.setDay(Integer.parseInt(day.trim()));
		searchIndex.setTime(Integer.parseInt(time.trim()));
		if("1".equals(flag)){			//վ������
			String startUrl = request.getParameter("startUrl");
			String domainUrl = request.getParameter("domainUrl");
			searchIndex.setDomainUrl(domainUrl);
			searchIndex.setStartUrl(startUrl);
		}else if("2".equals(flag)){		//��վ����
			String siteName = request.getParameter("siteName");
			searchIndex.setSiteName(siteName);
		}
		else if("0".equals(flag)){							//վ������	
			String siteName = request.getParameter("siteName");
			searchIndex.setSiteName(siteName);		
			String chnlId = request.getParameter("chnlId");
			//searchIndex.setChnlId(Integer.parseInt(chnlId.trim()));
			//�ĳɶ��Ƶ��id,�м��ö��Ÿ���,da.wei
			searchIndex.setChnlId(chnlId);
		}else if("4".equals(flag)){							//վ������
			String db_name = request.getParameter("db_name");
			String table_name = request.getParameter("table_name");
			String content_fields = request.getParameter("content_fields");
			String content_path = request.getParameter("content_fields");
			String content_types = request.getParameter("content_types");
			String title_field = request.getParameter("title_field");
			String description_field = request.getParameter("description_field");
			String keyword_field = request.getParameter("keyword_field");
			String publishtime_field = request.getParameter("publishtime_field");
			String wheres = request.getParameter("wheres");
			String primarys = request.getParameter("primarys");
			String access_url = request.getParameter("access_url");
			
			if(content_types.equals("text") || content_types=="text"){content_path="";}
			if(content_types.equals("file") || content_types=="file"){content_fields="";}
			if(content_types.equals("blog") || content_types=="blog"){content_fields="";}
			
			searchIndex.setDb_name(db_name);
			searchIndex.setTable_name(table_name);
			searchIndex.setContent_fields(content_fields);
			searchIndex.setContent_path(content_path);
			searchIndex.setContent_types(content_types);
			searchIndex.setTitle_field(title_field);
			searchIndex.setDescription_field(description_field);
			searchIndex.setKeyword_field(keyword_field);			
			searchIndex.setPublishtime_field(publishtime_field);
			searchIndex.setWheres(wheres);
			searchIndex.setPrimarys(primarys);
			searchIndex.setAccess_url(access_url);
		}
		try{
			samename = sm.addOneIndex(searchIndex); //���������ж�,weida
			closeWin = "1";
		}catch(Exception e){
			successFlag = "0";
		}
		
	}else if("edit".equals(action)){		//����
		String indexId = request.getParameter("indexId");
		String searchType = request.getParameter("searchType");
		String indexName = request.getParameter("indexName");
		String level = request.getParameter("level");
		String day = request.getParameter("day");
		String time = request.getParameter("time");
		
		CMSSearchIndex searchIndex = new CMSSearchIndex();
		searchIndex.setId(Integer.parseInt(indexId.trim()));
//		searchIndex.setSiteId(Integer.parseInt(siteId.trim()));
		searchIndex.setSiteId(siteId);
		searchIndex.setSearchType(Integer.parseInt(searchType.trim()));
		searchIndex.setIndexName(indexName);
		searchIndex.setLever(Integer.parseInt(level.trim()));
		searchIndex.setDay(Integer.parseInt(day.trim()));
		searchIndex.setTime(Integer.parseInt(time.trim()));
		if("1".equals(flag)){			//վ������
			String startUrl = request.getParameter("startUrl");
			String domainUrl = request.getParameter("domainUrl");
			searchIndex.setDomainUrl(domainUrl);
			searchIndex.setStartUrl(startUrl);
		}else if("2".equals(flag)){		//��վ����
			String siteName = request.getParameter("siteName");
			searchIndex.setSiteName(siteName);
		}else if("0".equals(flag)){							//վ������
			String siteName = request.getParameter("siteName");
			searchIndex.setSiteName(siteName);
			String chnlId = request.getParameter("chnlId");
			searchIndex.setChnlId(chnlId);
		}else if("3".equals(flag)){							//վȺ����
			String siteNames = request.getParameter("siteNames");
			searchIndex.setSiteNames(siteNames);
		}else if("4".equals(flag)){
			searchIndex.setDb_name(request.getParameter("db_name"));
			searchIndex.setTable_name(request.getParameter("table_name"));
			searchIndex.setWheres(request.getParameter("wheres"));
			searchIndex.setAccess_url(request.getParameter("access_url"));
			searchIndex.setPrimarys(request.getParameter("primarys"));
			searchIndex.setTitle_field(request.getParameter("title_field"));
			searchIndex.setKeyword_field(request.getParameter("keyword_field"));
			searchIndex.setPublishtime_field(request.getParameter("publishtime_field"));
			searchIndex.setDescription_field(request.getParameter("description_field"));
			
			String content_types = request.getParameter("content_types");
			String content_fields = request.getParameter("content_fields");
			String content_path = request.getParameter("content_fields");
			searchIndex.setContent_types(content_types);
			if(content_types.equals("text") || content_types=="text"){content_path="";}
			if(content_types.equals("file") || content_types=="file"){content_fields="";}
			if(content_types.equals("blog") || content_types=="blog"){content_fields="";}
			searchIndex.setContent_fields(content_fields);
			searchIndex.setContent_path(content_path);
		}
		try{
			samename = sm.updateOneIndex(searchIndex);	//���������ж�,weida
			closeWin = "1";
		}catch(Exception e){
			successFlag = "0";
		}
	}

	if(samename == false)
		successFlag = "-1";
	
	//System.out.println("successFlag:" + successFlag);
	if("1".equals(successFlag)){
		//out.println("<script language='javascript'>alert('��ϲ�������ɹ���');</script>");
		
		%>
		<script language="JavaScript">
		//ˢ��ҳ��
		try
		{		
				parent.win.alert('��ϲ�������ɹ���');
		        parent.closewin();
				var str = parent.document.location.href;
				var querystr = parent.document.all.queryString;
				if(querystr)
				{
					var strArray = str.slice(0,str.indexOf("?"));	
					parent.document.location.href = strArray+"?"+querystr.value;
				}
				else
				{
					parent.document.location.href = str;
				}
				
		}
		catch(e)
		{
			alert('��ϲ�������ɹ���');
		}
		</script>
		<%
		if("1".equals(closeWin))
			out.println("<script language='javascript'>window.close();window.returnValue='cf';</script>");
	}

	if("0".equals(successFlag))
	{
		out.println("<script language='javascript'>alert('�Բ��𣬲���ʧ�ܣ�');</script>");
	}

	if("-1".equals(successFlag))
	{
		out.println("<script language='javascript'>alert('���������ظ�,�����');</script>");
	}//���������ж�,weida
%>