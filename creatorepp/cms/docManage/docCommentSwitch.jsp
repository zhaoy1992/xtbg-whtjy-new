<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@ page import="com.chinacreator.cms.channelmanager.*"%>
<%@ page import="com.chinacreator.cms.docCommentManager.*"%>
<%@ page import="com.chinacreator.security.*"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);

	String channelId = request.getParameter("channelId");
	ChannelManager cm = new ChannelManagerImpl();
	DocCommentManager dcm = new DocCommentManagerImpl();
	Channel channel = cm.getChannelInfo(channelId);
	String displayName = channel.getDisplayName();
	int commentSwitch = dcm.getDocCommentSwitch(channelId,"chnl");
	String action = "close";
	if(commentSwitch==1){
		action = "open";
	}
	System.out.println(channelId);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
<title>:::::Ƶ�����۹��ܿ���::::::::::::::::::::::.</title>
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
	function subform(){
		docCommentSwitch.action="docCommentHandle.jsp?channelId=<%=channelId%>&action=<%=action%>";
		docCommentSwitch.submit();	
	}

</SCRIPT>
</head>
<body scroll="no">
	<form target="docComSwitchF" method="post" name="docCommentSwitch" enctype="multipart/form-data">
		<table width="100%" bgcolor="#e7e7f7" height="100%">
			<tr>
				<td width="100%">
					��ǰƵ����<%=displayName%>�������۹��������ڡ�<%=commentSwitch==0?"��ͨ":"�ر�"%>��״̬��������<%=commentSwitch==0?"�ر�":"��ͨ"%>���۹��ܣ�
					<p>
					��ȷ��Ҫ<%=commentSwitch==0?"�ر�":"��ͨ"%>��
				</td>
			</tr>
			<tr>
				<td width="100%" align="center">
					<input type="button" name="add" value="ȷ��" onclick="subform()">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" name="close" value="����" onclick="window.close();">
				</td>
			</tr>
		</table>
	</form>
	<iframe name="docComSwitchF" height="0" width="0"></iframe>
</body>
</html>