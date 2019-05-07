<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="java.io.*" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.util.*"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenu"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenuImpl"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.Menu"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title></title>
<% 

	AccessControl accesscontrol = AccessControl.getInstance();
	accesscontrol.checkAccess(request, response);
   	
	String pathContext = CMSUtil.getAppRootPath()+"/cms/editor/eWebEditor48/template";
	session.setAttribute("pathContext",pathContext);
	
	String uri = request.getParameter("uri");
    uri = uri==null?"/":uri;
    uri = uri.replaceAll("\\\\","/");
    pathContext = pathContext +"/"+ uri;
%>
<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
a:link {
	color: #000000;
	text-decoration: none;
}
a:visited {
	text-decoration: none;
	color: #000000;
}
a:hover {
	text-decoration: none;
	color: #000000;
}
a:active {
	text-decoration: none;
	color: #000000;
}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	scrollbar-face-color: #C9D1E4; 
    scrollbar-shadow-color: #6B74B7; 
    scrollbar-highlight-color: white; 
    scrollbar-3dlight-color: #E100E1; 
    scrollbar-darkshadow-color:#E100E1; 
    scrollbar-arrow-color:#003492; 
    scrollbar-base-color: #E100E1; 
    scrollbar-track-color: #E9EDF3;
}
.list {
	font-family: Verdana, "宋体";
	font-size: 12px;
	font-weight: lighter;
}
.menu {
	font-size: 14px;
	color: #0F62A3;
	text-align: center;
	padding-left: 5px;
	cursor:hand;
}
-->
</style>
<script src="js/docTpl.js" type="text/javaScript"></script>
</head>
<body>
<form id="form1" name="form1">
<input name="uri" type="hidden" value="<%=uri %>"/>
<table width="100%" height="36" border="0" cellpadding="0" cellspacing="1" bgcolor="#9DB3C4">
	<tr style="background-image:url(../images/Template_FileView_topmenu_Bg.gif)">
		<td height="27" class="menu" onClick="createFile(1,'<%=uri %>')"><img src="../images/Template_adfileDot1.gif" hspace="3" align="absmiddle">新建文件</td>
		<td height="27" class="menu" onClick="createFile(2,'<%=uri %>')"><img src="../images/Template_adDirectryDot1.gif"  hspace="3" align="absmiddle">新建目录</td>
		<td height="27" class="menu" onClick="deleteFiles('','<%=uri %>')"><img src="../images/Template_DellCfile.gif"  hspace="3" align="absmiddle">删除选定文件</td>
		<td height="27" class="menu" onClick="uploadFile('<%=uri %>')"><img src="../images/Template_uploadfileDot1.gif"  hspace="3" align="absmiddle">上传文件</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="Datalisttable">
	<tr class="cms_report_tr">
		<td height="30" width="20px" class="list">
		<!--<object id="dwEditObject" classid="clsid:E7566055-CDA0-4a52-B649-20B42C45677A" codebase="../../InstallFile/DWActiveX.CAB#Version=1,0,0,0"></object>-->	
			<input type="checkBox"  class="checkbox" name="checkBoxAll" onClick="checkAll('checkBoxAll','multiFiles')">  </td>
		<td width="18px" class="list">&nbsp;
			
	  </td>	
		<td width="40%" class="list">
			文件名
		</td>
		<td class="list">
			类型
		</td>
		<td class="list">
			修改时间
		</td>
	</tr>
	<tr  onMouseOver="this.style.background='#E9EDF3'" onmouseenter="onMsEnter(this)" onMouseOut="onMsOut(this)" onClick="goBack('<%=uri %>')" onselectstart="return false" class="cms_data_tr">
			
		<td class="tablecells" colspan="5">返回上一级目录</td>
	</tr>
<%
	File[] files = FileUtil.getSubDirectorieAndFiles(pathContext);
	ContextMenu contextmenu = new ContextMenuImpl();
	if(files != null && files.length > 0)
	{
		for(int i=0;files!=null&&i<files.length;i++){
		String file_name = files[i].getName().toLowerCase();
		String file_type = "unknown";
		if(file_name.endsWith(".html")||file_name.endsWith(".htm")||file_name.endsWith(".xml")||file_name.endsWith(".css")||file_name.endsWith(".js")){
			file_type = "html";
		}
		if(file_name.endsWith(".gif")||file_name.endsWith(".jpg")||file_name.endsWith(".jpeg")){
			file_type = "image";
		}
		if(file_name.endsWith(".css")||file_name.endsWith(".txt")){
			file_type = "txtfile";
		}
		if(file_name.endsWith(".rar")||file_name.endsWith(".zip")){
			file_type = "zip";
		}
		if(files[i].isDirectory())
		{
			file_type = "folder";
		}
		String theId = "T"+((int)(Math.random()*100000));
%>
	<tr onMouseOver="this.style.background='#E9EDF3'" onmouseenter="onMsEnter(this)" onMouseOut="this.style.background='#FFFFFF'" onDblClick="onDBClick(this,'<%=file_name%>',<%=files[i].isDirectory()%>,'<%=uri %>')"  onselectstart="return false" class="cms_data_tr">

	
		<td  height="25" width="20" class="tablecells">
			<input name="multiFiles" class="checkbox" type="checkbox" <%if(file_name.equals("template.js")){out.print("disabled='true'");} %> id="checkbox<%=theId %>" value="<%=file_name %>">
		</td>
		<td height="25" width="18px" class="tablecells">
			<img src="../templateManage/images/<%=file_type %>.gif">
		</td>
		<td width="18px" class="list" id="<%=(file_name.equals("template.js")||file_type.equals("folder"))?"":theId%>">
			<%=file_name %>		
		</td>
		<%
			Menu menu = new Menu();
			menu.setIdentity(theId);
			
			Menu.ContextMenuItem menuitem2 = new Menu.ContextMenuItem();
			menuitem2.setName("删除");
			menuitem2.setLink("javascript:deleteFiles('checkbox"+theId+"','"+uri+"')");
			menuitem2.setIcon(request.getContextPath() +"/sysmanager/images/rightMemu/tpl_del.gif");
			menu.addContextMenuItem(menuitem2);	
			
			Menu.ContextMenuItem menuitem = new Menu.ContextMenuItem();
			menuitem.setName("编辑文件内容");
			menuitem.setLink("javascript:editFileContent('"+file_name+"','"+uri+"')");
			menuitem.setIcon(request.getContextPath() +"/sysmanager/images/rightMemu/doc_edit.gif");
			menu.addContextMenuItem(menuitem);
			
			Menu.ContextMenuItem menuitem1 = new Menu.ContextMenuItem();
			menuitem1.setName("重命名");
			menuitem1.setLink("javascript:reName('"+file_name+"','"+uri+"')");
			//menuitem.setLink("javascript:reName('"+fr.getName()+"','"+fr.getTemplateId()+"')");
			menuitem1.setIcon(request.getContextPath() +"/sysmanager/images/rightMemu/tpl_rename.gif");
			menu.addContextMenuItem(menuitem1);
			//预览键
			Menu.ContextMenuItem menuitemPre = new Menu.ContextMenuItem();
			menuitemPre.setName("预览");
			menuitemPre.setLink("javascript:pubPreviewFile('"+file_name+"','"+uri+"')");
			menuitemPre.setIcon(request.getContextPath() +"/sysmanager/images/rightMemu/tpl_view.gif");
			menu.addContextMenuItem(menuitemPre);
			
			contextmenu.addContextMenu(menu);			
		%>
		<td></td>
		<td></td>
		<%request.setAttribute("opdoc",contextmenu);%>
		<pg:contextmenu context="opdoc" enablecontextmenu="true" scope="request"/>
	</tr>
<%
		}
	}
%>
</table>
</form>
<iframe id="hidFrm" name="hidFrm" style="display:none"></iframe>
</body>
</html>