<%@ page contentType="text/html; charset=GBK" language="java"%>

<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.channelmanager.publish.OrderPublishManager"%>
<%@ page import="com.chinacreator.cms.channelmanager.publish.Publish"%>



<%
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkAccess(request,response);

	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);


	String siteId = request.getParameter("siteId");
	
	String channelId = request.getParameter("channelId");

	//发布范围数组
	String publishScopeStr = request.getParameter("publishScope") ;

	
	//标识增量发布，还是完全发布
	String increamentStr = request.getParameter("increament");
	
	
	String lever = request.getParameter("lever");
	
	String day = request.getParameter("day");
	
	String time = request.getParameter("time");
	
	String op = request.getParameter("op");
	
	
	boolean flag = false ;

	try
	{
		Publish publish = new Publish() ;
		
		
		publish.setSiteId(Integer.parseInt(siteId)) ;
		publish.setChannelId(Integer.parseInt(channelId)) ;
		
		
		if(op != null && op.equals("deleteOp")) //删除操作
		{
			OrderPublishManager orderPublishManager = new OrderPublishManager();	
			
			orderPublishManager.deleteOrderPublish(publish) ;
			
			flag =  true ;
		}
		else if(op != null && op.equals("updateOp")) //更新操作(修改或添加)
		{
			OrderPublishManager orderPublishManager = new OrderPublishManager();	
			
			publish.setPublishScope(publishScopeStr) ;
			publish.setIncrement(Integer.parseInt(increamentStr)) ;
			publish.setLever(Integer.parseInt(lever)) ;
			publish.setDay(Integer.parseInt(day)) ;
			publish.setTime(Integer.parseInt(time)) ;
			
			if(orderPublishManager.isExiste(publish))
			{
				orderPublishManager.updateOrderPublish(publish) ;
				flag = true ;
			}
			else 
			{
				orderPublishManager.addOrderPublish(publish) ;
				flag  = true ;
			}
		}
			
	}
	catch(Exception e)
	{
		e.printStackTrace();
		flag = false ;
	}
	
%>

<html>
	<head>
		<script language="javascript">
		
			if("true" == "<%=flag%>")
			{
				alert("操作成功!!!");
				hideMarquee() ;
			}
			else 
			{
				alert("操作失败!!!");
				hideMarquee() ;
			}
			
			function hideMarquee()
			{
				if(parent.document.getElementById("publishButton"))
						parent.document.getElementById("publishButton").disabled="";
						
				if(parent.document.getElementById("closeButton"))
						parent.document.getElementById("closeButton").disabled="";   
						
				if(parent.document.getElementById("increamentall"))
						parent.document.getElementById("increamentall").disabled="";
						
				if(parent.document.getElementById("increamentno"))
						parent.document.getElementById("increamentno").disabled="";
						   
				if(parent.document.getElementById("PUBLISH_SITE_INDEX"))
						parent.document.getElementById("PUBLISH_SITE_INDEX").disabled="";
						
				if(parent.document.getElementById("PUBLISH_CHANNEL_INDEX"))
						parent.document.getElementById("PUBLISH_CHANNEL_INDEX").disabled="";
						
				if(parent.document.getElementById("PUBLISH_CHANNEL_RECINDEX"))
						parent.document.getElementById("PUBLISH_CHANNEL_RECINDEX").disabled="";  
						
				if(parent.document.getElementById("PUBLISH_CHANNEL_CONTENT"))
						parent.document.getElementById("PUBLISH_CHANNEL_CONTENT").disabled="";
						
				if(parent.document.getElementById("PUBLISH_CHANNEL_RECCONTENT"))
						parent.document.getElementById("PUBLISH_CHANNEL_RECCONTENT").disabled=""; 
						
						
				if(parent.document.getElementById("lever"))
						parent.document.getElementById("lever").disabled="";
						
				if(parent.document.getElementById("day"))
						parent.document.getElementById("day").disabled="";
						
						
				if(parent.document.getElementById("time"))
						parent.document.getElementById("time").disabled="";
					
						
				if(parent.document.getElementById("waiting_marquee"))
					parent.document.getElementById("waiting_marquee").style.display="none";
					
					
				parent.window.close() ;
				
			}
		</script>
	</head>
	<body>
	</body>
</html>