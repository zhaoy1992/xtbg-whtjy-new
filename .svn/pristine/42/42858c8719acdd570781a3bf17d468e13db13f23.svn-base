<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.channelmanager.publish.OrderPublishManager"%>
<%@ page import="com.chinacreator.cms.channelmanager.publish.Publish"%>
<%@ page import="com.chinacreator.cms.channelmanager.ChannelManager"%>
<%@ page import="com.chinacreator.cms.channelmanager.ChannelManagerImpl"%>
<%@ page import="com.chinacreator.cms.channelmanager.Channel"%>

<%

	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);

	String channelId = request.getParameter("channelId");
	String siteId = request.getParameter("siteId");
	String displayName = null ;
	boolean isOpen = false ;
	try
	{
		ChannelManager cm = new ChannelManagerImpl();
		Channel channel = cm.getChannelInfo(channelId);
		
		displayName = channel.getDisplayName();
	
	
		Publish publish = new Publish();	
		publish.setSiteId(Integer.parseInt(siteId)) ;
		publish.setChannelId(Integer.parseInt(channelId)) ;

		OrderPublishManager orderPublishManager = new OrderPublishManager();			
		if(orderPublishManager.isExiste(publish))
		{
			isOpen = true ;
		}
	}	
	catch(Exception e)
	{
		e.printStackTrace() ;
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
<title>:::::频道定时发布功能开关::::::::::::::::::::::.</title>
<style type="text/css">
	.STYLE1 {color: #0000FF}
	.STYLE2 {color: #000099}
	.operStyle{
	width:17;
	height:16;
	}
.style7 {font-size: 5px}
</style>
<script src="../inc/js/func.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	function subform()
	{
		if("<%=isOpen%>" == "true")
		{
			publishFrame.action="ordersitepublish_do.jsp?siteId=<%=siteId%>&channelId=<%=channelId%>&op=deleteOp";
			publishFrame.submit();			
		}
		else
		{
			var url = "../siteManage/ordersitepublish.jsp?siteId=<%=siteId%>&channelId=<%=channelId%>" ;
			var w = openWin(url,480,370);		
			window.close();
		}
			
	}

</SCRIPT>
</head>
<body scroll="no">
	<form target="hiddenFrame" method="post" name="publishFrame" enctype="multipart/form-data">
		<table width="100%" bgcolor="#e7e7f7" height="100%">
			<tr>
				<td width="100%">
					当前频道"<%=displayName%>"的定时发布正处于"<%= isOpen  ?  "开通" : "关闭"%>"状态，您可以<%=isOpen ? "关闭" : "开通"%>定时发布功能.
					<p>
					您确定要<%=isOpen ? "关闭" : "开通" %>吗？
				</td>
			</tr>
			<tr>
				<td width="100%" align="center">
					<input type="button" name="add" value="确定" onclick="subform()">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" name="close" value="返回" onclick="window.close();">
					<br/>
					<br/>
				</td>
			</tr>
		</table>
	</form>
	<iframe name="hiddenFrame" height="0" width="0"></iframe>
</body>
</html>