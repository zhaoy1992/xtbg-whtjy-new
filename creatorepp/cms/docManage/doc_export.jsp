<%
/**
  *	�����ݿ⵼�����ĵ�������Ϣ��xml�ļ��У��ڽ�ϸ�����Ϣ���zip��
  * ���û�����
  */
%>
<%@page contentType="text/html;charset=GBK" language="java"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.cms.sitemanager.*"%>
<%@page import="com.chinacreator.cms.documentmanager.*"%>
<%@page import="com.chinacreator.cms.channelmanager.*"%>
<%@page import="com.chinacreator.cms.documentmanager.util.DocZipUtil"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
    
    response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);
	
    //String userid = accesscontroler.getUserID();

	String path = config.getServletContext().getRealPath("/");
	
	ChannelManager cm = new ChannelManagerImpl();
	SiteManager sm = new SiteManagerImpl();
	String siteid = request.getParameter("siteid");
	String zipname = request.getParameter("expzipname");
	
	String[] docids = request.getParameter("docids").split(",");
	int[] docId = new int[docids.length];
	for(int i=0;i<docids.length;i++)
	{
		docId[i] = Integer.parseInt(docids[i]);
	}
	String attrpath="";
	//����Ƶ��id��վ��id��ȡ�ĵ�����·��(�·���) ����·��=վ��·��+Ƶ��·��
	attrpath = sm.getSiteInfo(siteid).getSiteDir();
	String zipfile = DocZipUtil.toZip(zipname,docId,request,path,attrpath);
%>
<script>
	function winClose()
	{
		window.close();
	}
	var zipname = "<%=zipname%>";//�û��Լ�ָ��
	var zipfile = "<%=zipfile%>";//�ļ������жϷ���ֵ
	if(zipfile == "")
	{
		alert("�ļ�����<%=zipname%>���Ѵ��ڣ�������ָ�����ƣ�");
	}
	else
	{
		var uristr = "temp/<%=zipfile%>";
		location.replace("download_expzip.jsp?file=" + uristr);
	}

	//window.setTimeout("winClose()", 1500);
</script>