<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.cms.templatemanager.*"%>
<%@ page import="com.chinacreator.cms.container.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.*"%>
<%
try {
//	String fileName = request.getParameter("fileName");
//	String uri = request.getParameter("uri");
	
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	String userId = control.getUserID();
	if(userId==null || userId.trim().length()==0){
		throw new TemplateManagerException("����ģ����û�������Ϊ��.");
	}

	Template tplt = new Template();
	tplt.setCreateUserId(Long.parseLong(userId));

	String siteId = request.getParameter("siteId");
	if(siteId==null || siteId.trim().length()==0){
		throw new TemplateManagerException("ģ����վ�����,����û��վ��id.");
	}

	
	String name = request.getParameter("templateName");
	if(name==null || name.trim().length()==0){
		throw new TemplateManagerException("ģ�����ֲ���Ϊ��.");
	}
	tplt.setName(name);


	tplt.setDescription(request.getParameter("templateDesc"));


	String header = request.getParameter("tb_templateHead");
	if(header==null || header.trim().length()==0){
		throw new TemplateManagerException("ģ��ͷ����Ϊ��.");
	}
	tplt.setHeader(header);

	tplt.setText(request.getParameter("content2"));
	
	tplt.setType(Integer.parseInt(request.getParameter("templateType")));

	tplt.setIncreasePublishFlag(0);

	TemplateManager tm = new TemplateManagerImpl();
	tm.createTemplateofSite(tplt,Integer.parseInt(siteId));
%>
<script language="javascript">
	alert("�½�Ƶ���ɹ�!");
	parent.openWin.location.reload();
	top.close();
	

</script>
<%
} catch (TemplateManagerException e) {
	e.printStackTrace();
%>
<script language="javascript">
	alert('�½�ģ�����,����!ԭ����:\n<%=e%>');
</script>
<%
}
%>
