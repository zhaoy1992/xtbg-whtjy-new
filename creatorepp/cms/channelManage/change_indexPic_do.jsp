<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.cms.channelmanager.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
try {
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	String channelId = request.getParameter("channelId");
	if(channelId == null || channelId.trim().length()==0){
		throw new ChannelManagerException("Ƶ��idΪnull!");
	}

	ChannelManager cm = new ChannelManagerImpl();
	cm.changeIndexPic(channelId,request.getParameter("outlinePicture"));
%>
<script language="javascript">
	alert("�༭Ƶ������ͼƬ�ɹ�!");
	parent.window.returnValue = true;
	parent.close();
</script>
<%}catch (ChannelManagerException e) {
		e.printStackTrace();
%>
<script language="javascript">
	alert('�༭Ƶ������ͼƬ����,����!ԭ����:\n<%=e.getMessage().replaceAll("\n", "").replaceAll("'","")%>');
</script>
<%
}
%>
