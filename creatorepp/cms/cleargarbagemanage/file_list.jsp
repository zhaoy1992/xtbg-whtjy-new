
<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.util.CMSUtil"%>
<%@ page import="java.io.File"%>
<%@ page import="com.chinacreator.cms.garbagemanager.GarbageManager"%>
<%@ page import="com.chinacreator.cms.garbagemanager.GarbageManagerImp"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>


<%			AccessControl control = AccessControl.getInstance();
			control.checkManagerAccess(request, response);
			
			String rootPath = request.getContextPath() ;
			
			String siteDir = request.getParameter("siteDir");
	
			String uri = request.getParameter("uri");
			
			String path = "" ;
			String contextPath = "" ;
	
			if(siteDir != null 
					&& uri != null 
						&& !siteDir.trim().equals("")
								&& !uri.trim().equals(""))
			{
				
				if(uri.startsWith("_template:"))
				{
					
					uri = uri.substring(10) ;
					path = CMSUtil.getPath(CMSUtil.getTemplateRootPath(siteDir),uri) ;
					contextPath = path.substring(CMSUtil.getAppRootPath().length()) ;
				}
				else if(uri.startsWith("_webprj:"))
				{		
					
					 uri = uri.substring(8) ;
					 path = CMSUtil.getPath(CMSUtil.getPath(CMSUtil.getSiteRootPath(siteDir), "_webprj"),uri);	 
					 contextPath = path.substring(CMSUtil.getAppRootPath().length()) ;		
				}
			
			}
%>


<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<link rel="stylesheet" type="text/css" href="../../purviewmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../purviewmanager/css/treeview.css">
		<script language="JavaScript" src="../inc/js/func.js" type="text/javascript"></script>
		<title>图片搜索</title>

		<script language="javascript">
		
			function openview(url,fileName)
			{
				window.open("<%=rootPath%>" +  url + "/" + fileName);
			}
			
			function delGarbageFiles()
			{
			
				var all = document.getElementsByName("ID");
				var docidStr= "";
				for(var i=0;i<all.length;i++)
				{
					if(all[i].checked == true)
					{
						docidStr = docidStr + all[i].value + ";";
					}
				}
				if(haveSelect('ID'))
				{		
					if(confirm('您确定要删除所选的文件？！'))
					{								
						var tableTag = document.all("garbage_file_list");
						var o = document.getElementsByName("ID");
						var fileNames = "" ;
						for(var i=o.length-1;i>=0;i--)
						{
							if(o[i].checked)
							{
								fileNames = fileNames + o[i].value +";" ; 
								tableTag.childNodes[0].removeChild(o[i].parentElement.parentElement.parentElement);
							}
						}
						form1.delFileNames.value = fileNames ;
						form1.action = "deleteFiles_do.jsp" ;
						form1.target="hiddenFrame" ; 
						form1.submit() ;
					}
					else
					{
					  return false;
					}
				
				}else
				{
			    	alert("请选择要求删除的文件！");
			    	return false;
			   	}
			   	return true;
			}
			
			function init()
			{
				parent.closeWin();
			}
		</script>
	</head>
	<body class="contentbodymargin" bgcolor="#F7F8FC" onload="init();">
		<form name="form1" method="post">
			<input type="hidden" name="delFileNames"/>
			<input type="hidden" name="path" value="<%=path%>"/>
			
			<div id="contentborder" align="center">
				<table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width="100%" class="thin">
					<tr style="align:left">
						<td height='30' style="align:left" colspan=7>
							<div align="left">
								&gt;&gt;&nbsp;<a href="#" onclick="delGarbageFiles()"><u>清除附件</u></a>
							</div>
						</td>
					</tr>
				</table>
				<hr width="100%">
				<table id="garbage_file_list" width="100%" cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width="100%" class="thin">
					<tr>
						<!--设置分页表头-->
						<td class="headercolor" width="3%">
							<input type="checkbox" name="checkBoxAll" onclick="checkAll('checkBoxAll','ID')">
						</td>
						<td height='30' width="20%" class="headercolor">
							名称
						</td>
						<td height='30' width="77%" class="headercolor">
							文件路径
						</td>
					</tr>
					<%
							int count = 0 ;
							
							
							if(uri != null && 
								!"".equals(uri) && 
								!"".equals(path) && 
								!"".equals(contextPath))
							{
								
								File searchFile = new File(path);
								
								String[] fileNames = searchFile.list() ;
								
								
								GarbageManager garbageManager = new GarbageManagerImp();
								
								String format = ConfigManager.getInstance().getConfigValue("cms.uploadfile.clearformat","")  ;
								
								
								for(int i= 0 ; i < fileNames.length ; i++)
								{
									if(garbageManager.isFileOfGarbage(uri,fileNames[i],format))
									{
						%>
						<tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'">
							<td class="tablecells" nowrap="true">
								<P align="left">
									<input type="checkbox" name="ID" value="<%=fileNames[i]%>">
								</P>
							</td>
							<td height='20' class="tablecells" bgcolor="#F6FFEF" onclick="openview('<%=contextPath%>','<%=fileNames[i]%>')">
								<%=fileNames[i]%>
							</td>
							<td height='20' class="tablecells">
								<%=path%>
							</td>
						</tr>	
						<%				count ++ ;
									}
								}
								
								if(count == 0)
								{
						%>
						<tr height="18px" class="labeltable_middle_tr_01">
							<td colspan="3" align='center'>
								没有无关联的文件信息
							</td>										
						</tr>	
						<%
								}
								
							}
							else
							{
					%>
					<tr height="18px" class="labeltable_middle_tr_01">
						<td colspan="3" align='center'>
							没有要查询的信息
						</td>										
					</tr>
					<%
							}					
					%>
				</table>
			</div>
		</form>
	</body>
	<iframe name="hiddenFrame" width="0" height="0"></iframe>
</html>
