<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.cms.channelmanager.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.util.StringOperate"%>
<%
try{
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);

	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);

	String siteName = request.getParameter("siteName");
	String siteId   = request.getParameter("siteId");
	String channelId = request.getParameter("channelId");
	String channelName = request.getParameter("channelName");
	String detailTemplateId = request.getParameter("detailTemplateId");
 
	ChannelManager cm = new ChannelManagerImpl();
	
    cm.updateChannelDetailTemplateId(Integer.parseInt(channelId),Integer.parseInt(detailTemplateId));
 
	%>
	<script language="javascript">
		alert("����ģ��ɹ�!");
		parent.updateParentForm();
		parent.close();
		</script>
<%	}catch(Exception e){%>
		<script language="javascript">
		alert('����ģ�����,����!ԭ����:\n<%=e.getMessage().replaceAll("\n","").replaceAll("'","")%>');
		</script>
<%}%>