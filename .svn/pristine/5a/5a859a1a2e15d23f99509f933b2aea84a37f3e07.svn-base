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
		
		//应该由当前的应用id获得对应的菜单文件信息
		String menufile = "module.xml";
       	if(!currentSystemID.equals("module"))
       	{
       		menufile = "module-" + currentSystemID + ".xml";
       	}
       	
		ParseXml px = new ParseXml(ConfigManager.getInstance().getConfigValue("appMenuFilePath") + menufile);
		String moduleName = px.getMenuPropByItemId(id, "name");
		
		//修改菜单项之前需要判断重ID和重名冲突
		if(px.idDuplicate(id, false))
		{
			%>
			<script language="javascript">
				alert("有模块或菜单项的Id与其重名!");
				window.close();
				window.returnValue="refresh";
			</script>
			<%
		}
		else if(px.nameDuplicate(name, false))
		{
			%>
			<script language="javascript">
				alert("有模块或菜单项的Name与其重名!");
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
					alert("修改成功!");
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
