<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%@ page import="com.chinacreator.cms.channelmanager.ChannelCacheManager"%>

<%@ page import="com.chinacreator.cms.sitemanager.SiteManager" %>
<%@ page import="com.chinacreator.cms.sitemanager.SiteManagerImpl" %>
<%@ page import="com.chinacreator.cms.sitemanager.Site" %>

<%@ page import="com.chinacreator.cms.channelmanager.ChannelManager" %>
<%@ page import="com.chinacreator.cms.channelmanager.ChannelManagerImpl" %>
<%@ page import="com.chinacreator.cms.channelmanager.Channel" %>

<%@ page import="com.chinacreator.event.Event" %>
<%@ page import="com.chinacreator.event.EventImpl" %>
<%@ page import="com.chinacreator.cms.event.CMSEventType" %>

<%@ page import="com.chinacreator.cms.util.CMSUtil" %>




<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request, response);
	
	//flag值为site，刷新站点缓冲；flag值为channel，刷新频道
	String flag = request.getParameter("flag");
	
	//站点ID 或是 频道ID
	String refreshId = request.getParameter("refreshId") ;
	
	
	
	String errorMessage = "";
	
	if(refreshId != null)
	{
		if("site".equals(flag))
		{
			try
			{
				SiteManager siteManager = new SiteManagerImpl();
				
				Site site = siteManager.getSiteInfo(refreshId) ;
				
				Event event = new EventImpl(site,CMSEventType.EVENT_SITE_UPDATE);
				
				siteManager.change(event,true) ;
				
			}
			catch(Exception e)
			{
				errorMessage = control.formatErrorMsg(e.getMessage());
			}
			
		}else if("channel".equals(flag))
		{
			try
			{
		
				ChannelCacheManager channelCacheManager = CMSUtil.getChannelCacheManager(refreshId) ;
								
				channelCacheManager.reset() ;
							
			}
			catch(Exception e)
			{
				errorMessage = control.formatErrorMsg(e.getMessage());
			} 
		}else if("subChannel".equals(flag))
		{
			try
			{
				ChannelManager channelManager = new ChannelManagerImpl();
				
				Channel channel = channelManager.getChannelInfo(refreshId) ;
				
				Event event = new EventImpl(channel,CMSEventType.EVENT_CHANNEL_UPDATE);
				
				channelManager.change(event,true) ;
				
			}
			catch(Exception e)
			{
				errorMessage = control.formatErrorMsg(e.getMessage());
			}
		}
	}
%>
<script language="javascript">
<%
	if("".equals(errorMessage))
	{ 
%>
	alert("操作成功！");
	
<%  }
	else
	{ 
%>
	alert("操作失败，原因如下：\\n<%=errorMessage %>");
<%
	}
%>
</script>