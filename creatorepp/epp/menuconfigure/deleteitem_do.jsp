<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,com.chinacreator.epp.xml.ParseXml,com.chinacreator.config.ConfigManager"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.framework.Framework"%>
<%
		try {
		System.out.println("deleteitem_do.jsp");
		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request, response);
		//		�û���Ϣ���û���ʵ���ƣ��û��ʺ�[�û�ID]��
		String userInfo = control.getUserAttribute("userAccount") + ":"
		+ control.getUserAttribute("userName") + "["
		+ control.getUserAttribute("userID") + "]  ";
		//������ip��ַ
		String remoteAddr = request.getRemoteAddr();

		String currentSystemID = control.getCurrentSystemID();
		String itemId = request.getParameter("itemIds");
		if (itemId == null) {
			itemId = "";
		}
		String[] itemIds = itemId.split(";");

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
		//		 ��־����
		String operModule = "�˵�����";
		// ������ip��ַ
		String operSource = remoteAddr;

		for (int i = 0; i < itemIds.length; i++) {
			//	�Ӳ˵�����
			String itemname = px.getElementById("item", itemIds[i])
			.getAttribute("name");

			px.removeNode(itemIds[i], "item");

			//	 ********************��ʼ��¼��־********************

			// ��־����
			String operContent = userInfo + "  ɾ���Ӳ˵�:" + itemname + "["
			+ itemIds[i] + "]";

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
