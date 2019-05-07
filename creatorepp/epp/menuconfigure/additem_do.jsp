<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,
			com.chinacreator.epp.xml.ParseXml,
			com.frameworkset.util.StringUtil,
			com.chinacreator.config.ConfigManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.framework.Framework"%>
<%@ page import="com.chinacreator.epp.menuconfigure.ParseXmlAddDS"%>
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
		String moduleId = request.getParameter("moduleId");
		if (moduleId == null) {
			moduleId = "";
		}
		String isedit_item = StringUtil.replaceNull(request.getParameter("isedit_item"));
		String isdelete = StringUtil.replaceNull(request.getParameter("isdelete"));
		String dsName = StringUtil.replaceNull(request.getParameter("ds_name"));
		String id = StringUtil.replaceNull(request.getParameter("id"));
		String name = StringUtil.replaceNull(request
		.getParameter("name"));
		//name = new String(name.getBytes("ISO8859_1"), "GBK");
		String navigatortoolbar = StringUtil.replaceNull(request
		.getParameter("navigatortoolbar"));
		String navigatorcontent = StringUtil.replaceNull(request
		.getParameter("navigatorcontent"));
		String workspacetoolbar = StringUtil.replaceNull(request
		.getParameter("workspacetoolbar"));
		String workspacecontent = StringUtil.replaceNull(request
		.getParameter("workspacecontent"));
		String isUsed = StringUtil.replaceNull(request
		.getParameter("isUsed"));
		String moduletype = StringUtil.replaceNull(request
		.getParameter("moduletype"), "1");
		String configtype = StringUtil.replaceNull(request
		.getParameter("configtype"), "1");
		String isEdit = StringUtil.replaceNull(request
		.getParameter("isEdit"), "false");
		String itemdisicon = StringUtil.replaceNull(request.getParameter("itemdisicon"));
		String itemenicon = StringUtil.replaceNull(request.getParameter("itemenicon"));	
		
		//Ӧ���ɵ�ǰ��Ӧ��id��ö�Ӧ�Ĳ˵��ļ���Ϣ
		String menufile = "module.xml";
		if (!currentSystemID.equals("module")) {
			menufile = "module-" + currentSystemID + ".xml";

		}

		//ParseXml px = //new ParseXml(Framework.menu_folder + menufile);
		ParseXmlAddDS px= new ParseXmlAddDS(Framework.menu_folder + menufile);
		if (isEdit.equals("true")) {
			String moduleName = px.getMenuPropByItemId(id, "name");
			//�޸Ĳ˵���֮ǰ��Ҫ�ж���ID��������ͻ
			if (px.idDuplicate(id, false)) {
%>
	<script language="javascript">
		alert("��ģ���˵����Id��������!");
		window.close();
		window.returnValue="refresh";
	</script>
<%--<%
		} else if (px.nameDuplicate(name, false)) {
%>
	<script language="javascript">
		alert("��ģ���˵����Name��������!");
		window.close();
		window.returnValue="refresh";
	</script>
--%><%
		} else {
			px.updateItem(moduleId, id, name, navigatortoolbar,
				navigatorcontent, workspacetoolbar,
				workspacecontent, isUsed, moduletype,
				configtype,isedit_item,isdelete,dsName,itemdisicon,itemenicon); 
		//		 ********************��ʼ��¼��־********************
		// ��־����ӿ�
		LogManager logMgr = SecurityDatabase.getLogManager();
		// �û���Ϣ
		String operUser = userInfo;
		// ��־����
		String operContent = userInfo + "  �޸��Ӳ˵�:" + name + "["
				+ id + "]";
		// ��־����
		String operModule = "�˵�����";
		// ������ip��ַ
		String operSource = remoteAddr;
		// д����־
		logMgr.log(operUser, operContent, operModule,
				operSource);
		// ********************��־��¼����********************
%>
	<script language="javascript">
		alert("�޸ĳɹ�!");
		window.close();
		window.returnValue="refresh";
	</script>
<%
		}
		} else {
			//��Ӳ˵���֮ǰ��Ҫ�ж���ID��������ͻ
			if (px.idDuplicate(id, true)) {
%>
	<script language="javascript">
		alert("��ģ���˵����Id��������!");
		window.close();
		window.returnValue="refresh";
	</script>
<%--<%
} else if (px.nameDuplicate(name, true)) {
%>
<script language="javascript">
					alert("��ģ���˵����Name��������!");
					window.close();
					window.returnValue="refresh";
				</script>--%>
<%
		} else {
		px.createItem(moduleId, id, name, navigatortoolbar,
				navigatorcontent, workspacetoolbar,
				workspacecontent, isUsed, moduletype,
				configtype,isedit_item,isdelete,dsName,itemdisicon,itemenicon);

		//		 ********************��ʼ��¼��־********************
		// ��־����ӿ�
		LogManager logMgr = SecurityDatabase.getLogManager();
		// �û���Ϣ
		String operUser = userInfo;
		// ��־����
		String operContent = userInfo + "  �����Ӳ˵�:" + name + "["
				+ id + "]";
		// ��־����
		String operModule = "�˵�����";
		// ������ip��ַ
		String operSource = remoteAddr;
		// д����־
		logMgr.log(operUser, operContent, operModule,
				operSource);
		// ********************��־��¼����********************
%>
	<script language="javascript">
		alert("�����ɹ�!");
		window.close();
		window.returnValue="refresh";
	</script>
<%
		}
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
%>

<script>
    window.onload = function prompt()
    {
        //parent.divProcessing.style.display="none";
        parent.location.reload();
    }
</script>
