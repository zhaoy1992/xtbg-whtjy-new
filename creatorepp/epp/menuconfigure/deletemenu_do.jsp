<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,com.chinacreator.epp.xml.ParseXml,com.chinacreator.config.ConfigManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.framework.Framework"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%
		try {
		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request, response);
		//		�û���Ϣ���û���ʵ���ƣ��û��ʺ�[�û�ID]��
		String userInfo = control.getUserAttribute("userAccount") + ":"
		+ control.getUserAttribute("userName") + "["
		+ control.getUserAttribute("userID") + "]  ";
		//������ip��ַ
		String remoteAddr = request.getRemoteAddr();

		String currentSystemID = control.getCurrentSystemID();
		String moduleId = request.getParameter("moduleIds");
		if (moduleId == null) {
			moduleId = "";
		}
		String[] moduleIds = moduleId.split(";");

		//Ӧ���ɵ�ǰ��Ӧ��id��ö�Ӧ�Ĳ˵��ļ���Ϣ
		String menufile = "module.xml";
		if (!currentSystemID.equals("module")) {
			menufile = "module-" + currentSystemID + ".xml";
		}
		ParseXml px = new ParseXml(Framework.menu_folder + menufile);

		// ��־����ӿ�
		LogManager logMgr = SecurityDatabase.getLogManager();
		// �û���Ϣ
		String operUser = userInfo;
		// ��־����
		String operModule = "ģ�����";//modify by zzz
		// ������ip��ַ
		String operSource = remoteAddr;

		for (int i = 0; i < moduleIds.length; i++) {
			//ģ������
			String modulename = px.getMenuElement(moduleIds[i]).getAttribute("name");

			px.removeNode(moduleIds[i], "module");
			//	 ********************��ʼ��¼��־********************
			// ��־����
			String operContent = userInfo + "  ɾ��ģ��:" + modulename
			+ "[" + moduleIds[i] + "]";

			// д����־
			logMgr.log(operUser, operContent, operModule, operSource);
			// ********************��־��¼����********************
		}
%>
<script language="javascript">
			alert("ɾ���ɹ�!");			
			getNavigatorContent().location.href=getNavigatorContent().location.reload();
			
		</script>
<%
		} catch (Exception e) {
		e.printStackTrace();
	}
%>

<script>
    window.onload = function prompt()
    {
        parent.divProcessing.style.display="none";
        parent.location.reload();
    }
</script>
