<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.documentmanager.*"%>
<%@ page import="com.chinacreator.cms.channelmanager.*"%>
<%@ page import="com.chinacreator.cms.driver.publish.*"%>
<%@ page import="com.chinacreator.cms.driver.publish.impl.*"%>
<%
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkAccess(request,response);
	
	String docId = request.getParameter("docId");
	DocumentManager dm = new DocumentManagerImpl();
	ChannelManager cm = new ChannelManagerImpl();
	int chnlId = dm.getDocChnlId(Integer.parseInt(docId));
	int siteId = dm.getDocSiteId(Integer.parseInt(docId));
	
	
	if(cm.hasSetDetailTemplate(chnlId+"") && (dm.getDocType(Integer.parseInt(docId))==0 || dm.getDocType(Integer.parseInt(docId))==1)){		
		WEBPublish publish = new WEBPublish();
		publish.init(request,response,pageContext,accessControl);
		PublishCallBack callback = new PublishCallBackImpl();
		publish.setPublishCallBack(callback);
		
		publish.viewDocument(siteId + "",chnlId + "",docId);
		String viewUrl = callback.getViewUrl();
		if(viewUrl!=null)
		{
            //文档类型为0,加上前娺		
			if(dm.getDocType(Integer.parseInt(docId)) == 0)
			{
				viewUrl = request.getContextPath() + "/" + viewUrl;
			}
		%>
			<script language="javascript">
				var buttons = parent.document.getElementsByTagName("input");
				for(var i=0;i<buttons.length;i++)
				{
					buttons[i].disabled = false;
				}
				parent.closewin();
				window.open("<%=viewUrl%>");
			</script>
		<%
		}else{
		%>
			<script language="javascript">
				parent.win.alert("预览失败，可能当前频道未设置细览模板或者模板文件不存在！！");
				var buttons = parent.document.getElementsByTagName("input");
				for(var i=0;i<buttons.length;i++)
				{
					buttons[i].disabled = false;
				}
				parent.closewin();
			</script>
		<%
		}
	}else{
	%>
		<script language="javascript">
			parent.win.alert("预览失败，可能当前频道未设置细览模板、模板文件不存在或该文件无需发布！！");
			var buttons = parent.document.getElementsByTagName("input");
			for(var i=0;i<buttons.length;i++)
			{
				buttons[i].disabled = false;
			}
			parent.closewin();
		</script>
	<%
	}
%>
