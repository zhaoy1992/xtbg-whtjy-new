<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@ page import="com.chinacreator.cms.sitemanager.*,com.chinacreator.cms.documentmanager.*"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.*"%>
<%@ page import="com.chinacreator.cms.channelmanager.*"%>
<%
//Ƶ��ѡ��������ѡ��ѡ��
//���˹���ƽ̨�е�����������񡢷������񡢷������񡢷������ĵ����¸��ĵ����鵵�ĵ��������ĵ���
//�Ȳ�ѯʱ�õ���Ƶ����ѡ��
//�ĵ��ɼ�ģ��༭ʱ�õ���Ƶ����ѡ��
//Ƶ���������ĵ������У�Ƶ������ʱ�õ���Ƶ����ѡ��
//Ƶ���༭�Լ�����ʱ����������Ƶ����ҳʱ�õ���Ƶ����ѡ��
%>
<%
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);

	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	String type = request.getParameter("type");	  //�����ͣ�ֵΪsingle	��ʾ��ѡ����ֵΪnull��multi��ʾ��ѡ��
	String tempTitle = ":::��Ƶ��ѡ��::::::";
	if("single".equals(type))
		tempTitle = ":::��Ƶ��ѡ��::::::";
	
	String siteid = request.getParameter("siteid");
	
	String taskType = request.getParameter("taskType");
	String curChannelid = request.getParameter("channelid");
	
	
%>
<script language="javascript">
	
</script>
<html>
	<head>
		<title><%=tempTitle%></title>
	</head>
	<frameset rows="80%,*" border=0>
		<%if("single".equals(type)){%>
		<frame frameborder=0  noResize scrolling="yes" marginWidth=0 name="multi_chn_slt_top" src="single_channel_select.jsp?siteid=<%=siteid%>"></frame>
		<%}else{%>
		<frame frameborder=0  noResize scrolling="yes" marginWidth=0 name="multi_chn_slt_top" src="multi_channel_select.jsp?siteid=<%=siteid%>&taskType=<%=taskType%>"></frame>
		<%}%>
		<frame frameborder=0  noResize scrolling="no" marginWidth=0 name="multi_chn_slt_ok" src="multi_channel_select_submit.jsp?taskType=<%=taskType%>&channelid=<%=curChannelid%>" ></frame>	
	</frameset>
</html>