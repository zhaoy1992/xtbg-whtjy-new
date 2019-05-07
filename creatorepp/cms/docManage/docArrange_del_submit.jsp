<%
/**
  *	����һ���ĵ����ö�����
  * action
  */
%>
<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@page import="com.chinacreator.cms.documentmanager.*"%>
<%@page import="com.chinacreator.cms.documentmanager.bean.*"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.driver.publish.*"%>
<%@ page import="com.chinacreator.cms.driver.publish.impl.*"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@page import="com.chinacreator.cms.channelmanager.*"%>
<%@page import="com.chinacreator.cms.sitemanager.*"%>

<%
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);
	
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
	
	DocumentManager dm = new DocumentManagerImpl();
	ChannelManager cm = new ChannelManagerImpl();
	SiteManager siteManager = new SiteManagerImpl();
	
	String channelid = request.getParameter("channelid");
	String siteid = request.getParameter("siteid");
	
	Site site = siteManager.getSiteInfo(siteid);
	Channel channel = cm.getChannelInfo(channelid);
	Document doc = null;//dm.getPartDocInfoById(docid);
	
	StringBuffer doctitles = new StringBuffer();
	String userid = accesscontroler.getUserID();
	String docid = request.getParameter("docid");

	String[] docids = docid.split(":");
	for( int i=0;i<docids.length;i++)
	{
		doc = dm.getPartDocInfoById(docids[i]);
		doctitles.append(doc.getSubtitle()).append(";");
	}
	//ȡ���ö�
	boolean b = dm.delArrangeDoc(docids);
	//��¼������־
	LogManager logManager = SecurityDatabase.getLogManager();
	logManager.log(accesscontroler.getUserAccount(),"ȡ���ö��ĵ�.�ĵ�����:��" + site.getName() + " վ�㣬" + channel.getDisplayName() + " Ƶ����" + doctitles.toString(),"�ĵ�����",request.getRemoteAddr(),"");
	/*
	try
	{
		//��ʼ����������
	 	WEBPublish publish = new WEBPublish();
		publish.init(request,response,pageContext,accesscontroler);
		PublishCallBack callback = new PublishCallBackImpl();
		publish.setPublishCallBack(callback);
		
		publish.recursivePubObjectOfChannelAncester(siteid,channelid,RecursivePublishManager.RECURSIVE_PUB_DEL_ARRANGEDOC);
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	*/
	%>
	<html>
		<body>
		<iframe name="recursiveFrame" src="recursiveHandle.jsp?siteId=<%=siteid%>&channelId=<%=channelid%>&action=<%=RecursivePublishManager.RECURSIVE_PUB_DEL_ARRANGEDOC%>"></iframe>
		</body>
	</html>
	<%
	
	if(b){%>
		<SCRIPT LANGUAGE="JavaScript"> 
			alert("ȡ���ö��ĵ��ɹ���");
			
			try
			{
				window.parent.document.all("reload").click();
				var urlstr = window.parent.dialogArguments.parent.perspective_content.frames[1].frames[0].frames[1].frames[1].document.URL;
				window.parent.dialogArguments.parent.perspective_content.frames[1].frames[0].frames[1].frames[1].location.href = urlstr;
			}
			catch(e)
			{
				var str = window.parent.location.href;
				if(str.indexOf("?")==-1)
				{
					window.parent.location.href = window.parent.location.href;
				}
				else
				{
					try
					{
						var strArray = str.slice(0,str.indexOf("?"));
						window.parent.location.href = strArray+"?"+window.parent.document.all.queryString.value;
					}
					catch(e)
					{
						window.parent.location.href = window.parent.location.href;
					}
				}
				window.close();
			}
			
		</script>
	
	<%}else{%>
		
		<SCRIPT LANGUAGE="JavaScript"> 
			alert("ȡ���ö��ĵ�ʧ�ܣ�");
			window.close();
		</script>
	<%
		}
	%>			