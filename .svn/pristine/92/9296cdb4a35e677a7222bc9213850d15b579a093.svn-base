<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@page import="com.chinacreator.cms.driver.publish.*,
				com.chinacreator.cms.driver.publish.impl.*,
				com.chinacreator.cms.driver.distribute.DistributeManager,
				com.chinacreator.security.AccessControl"%>
<%
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkAccess(request,response);

	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);

	String siteId = request.getParameter("siteId");//Õ¾µãid
	String channelId = request.getParameter("channelId");//ÆµµÀid

	WEBPublish publish = new WEBPublish();
	publish.init(request,response,pageContext,accessControl);
	PublishCallBack callback = new PublishCallBackImpl();
	publish.setPublishCallBack(callback);
	
	if("".equals(channelId)||channelId==null)
	{
		publish.viewSite(siteId);
	}
	else
	{
		publish.viewChannel(siteId,channelId);
	}
	String viewUrl = "../../" + callback.getViewUrl();
	%>
	<script language="javascript">
		parent.window.close();
		window.open("<%=viewUrl%>");
	</script>