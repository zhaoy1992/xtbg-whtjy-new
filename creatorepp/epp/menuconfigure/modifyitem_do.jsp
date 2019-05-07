<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,
				 com.chinacreator.epp.xml.ParseXml,
				 com.frameworkset.util.StringUtil,
				 com.chinacreator.config.ConfigManager"
				%>
<%
	try
	{
		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request, response);
		
		String currentSystemID = control.getCurrentSystemID();
		String moduleId = request.getParameter("moduleId");
		if(moduleId == null)
		{
			moduleId = "";
		}
		
		String id = StringUtil.replaceNull(request.getParameter("id"));
		String name = StringUtil.replaceNull(request.getParameter("name"));
		//name = new String(name.getBytes("ISO8859_1"), "GBK");
		String navigatortoolbar = StringUtil.replaceNull(request.getParameter("navigatortoolbar"));
		String navigatorcontent = StringUtil.replaceNull(request.getParameter("navigatorcontent"));
		String workspacetoolbar = StringUtil.replaceNull(request.getParameter("workspacetoolbar"));
		String workspacecontent = StringUtil.replaceNull(request.getParameter("workspacecontent"));
		String isUsed = StringUtil.replaceNull(request.getParameter("isUsed"));		
		
		//Ӧ���ɵ�ǰ��Ӧ��id��ö�Ӧ�Ĳ˵��ļ���Ϣ
		String menufile = "module.xml";
       	if(!currentSystemID.equals("module"))
       	{
       		menufile = "module-" + currentSystemID + ".xml";
       	}
       	
		ParseXml px = new ParseXml(ConfigManager.getInstance().getConfigValue("appMenuFilePath") + menufile);
		String moduleName = px.getMenuPropByItemId(id, "name");
		
		//�޸Ĳ˵���֮ǰ��Ҫ�ж���ID��������ͻ
		if(px.idDuplicate(id, false))
		{
			%>
			<script language="javascript">
				alert("��ģ���˵����Id��������!");
				window.close();
				window.returnValue="refresh";
			</script>
			<%
		}
		else if(px.nameDuplicate(name, false))
		{
			%>
			<script language="javascript">
				alert("��ģ���˵����Name��������!");
				window.close();
				window.returnValue="refresh";
			</script>
			<%
		}
		else
		{
			px.updateItem(moduleName, id, name, navigatortoolbar, navigatorcontent, workspacetoolbar, workspacecontent,isUsed);		
			%>
				<script language="javascript">
					alert("�޸ĳɹ�!");
					window.close();
					window.returnValue="refresh";
				</script>
			<%
		}		
	}
	catch (Exception e) 
	{
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
