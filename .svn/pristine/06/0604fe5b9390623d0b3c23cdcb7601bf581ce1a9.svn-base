<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenu"%>
<%@ page
	import="com.frameworkset.common.tag.contextmenu.ContextMenuImpl"%>
<%@ page
	import="com.frameworkset.common.tag.contextmenu.Menu,com.frameworkset.util.StringUtil"%>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	//应该由当前的应用id获得对应的菜单文件信息，由模块的id获得对应的菜单项信息
	String moduleId = StringUtil.replaceNull(request
			.getParameter("moduleId"));
	String currentSystemID = control.getCurrentSystemID();

	String idQuery = StringUtil.replaceNull(request
			.getParameter("idQuery"));
	String nameQuery = StringUtil.replaceNull(request
			.getParameter("nameQuery"));
	String isUsedQuery = StringUtil.replaceNull(request
			.getParameter("isUsedQuery"));

	String item_id = StringUtil.replaceNull(request.getParameter("id"));
	String isSelect = StringUtil.replaceNull(request
			.getParameter("isSelect"));

	String type = StringUtil.replaceNull(request.getParameter("type"),
			"");
%>
<html>
	<head>
		<base target="_self">
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<link rel="stylesheet" type="text/css"
			href="../../purviewmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="../../purviewmanager/css/treeview.css">
		<script language="JavaScript"
			src="../../purviewmanager/scripts/func.js" type="text/javascript"></script>
		<tab:tabConfig />
		<title>菜单项管理</title>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/sysmanager/applymanager/common.js"
			type="text/javascript"></script>

		<script language="javascript">	
					
			function deleteitem()
			{
			    var all = document.getElementsByName("ID");
				var itemIds="";
				for(var i=0;i<all.length;i++)
				{
					if(all[i].checked == true)
					{
						if(all[i].value == "menuconfigure")
						{
							alert("菜单项‘菜单配置管理’不允许被删除！");
							return false;
						}
						if(all[i].value == "menuconfigure")
						{
							alert("菜单项‘权限管理’不允许被删除！");
							return false;
						}
						itemIds = itemIds + all[i].value + ";";
					}
				}
				if(haveSelect('ID'))
				{		
					if(confirm('您确定要删除所选的菜单项？！'))
					{								
						document.all.divProcessing.style.display = "block";
					  	itemform.action = "deleteitem_do.jsp?itemIds="+itemIds;
					    itemform.target = "hiddenFrame";
					    itemform.submit();					    	
					}
					else
					{
					  return false;
					}
				
				}else{
			    	alert("请选择要求删除的菜单项！");
			    	return false;
			   	}
			   		//漂亮的模态窗口刷新方法
			   	//	var a = document.createElement("a"); 
				//	a.href = document.location.href; 
				//	document.body.appendChild(a); 
				//	a.click();
					
				//	document.location.reload();
				//	getNavigatorContent().location.reload();
			   	return true;
			}
			
			function addmodule()
			{
				var ww = openWin('addmodule.jsp?moduleId=<%=moduleId%>',screen.availWidth-320,screen.availHeight-140)
				if(ww)
				{								
					parent.location.reload();
					getNavigatorContent().location.reload();
				}
			}
			
			
			
			function additem()
			{
				var ww = openWin('additemmain.jsp?moduleId=<%=moduleId%>',screen.availWidth-320,screen.availHeight-140)
				if(ww)
				{
					//漂亮的模态窗口刷新方法
					var a = document.createElement("a"); 
					a.href = document.location.href; 
					document.body.appendChild(a); 
					a.click();
					
					document.location.reload();				
					getNavigatorContent().location.reload();
				}
			}
			
			function modifyitem(itemId)
			{
				var ww = openWin('modifyitem.jsp?moduleId=<%=moduleId%>&itemId='+itemId,screen.availWidth-320,screen.availHeight-140)
				if(ww)
				{
					//漂亮的模态窗口刷新方法
					var a = document.createElement("a"); 
					a.href = document.location.href; 
					document.body.appendChild(a); 
					a.click();
					
					document.location.reload();				
					getNavigatorContent().location.reload();
				}
			}
			
			function queryitem()
			{
				var a = document.createElement("a"); 
				a.href = document.location.href; 
				var newhref = a.href;
				newhref = newhref.substring(0,newhref.indexOf('?'));
				newhref = newhref + "?moduleId=<%=moduleId%>&type=<%=type%>" + "&idQuery=" + itemform.idQuery.value + "&nameQuery=" + itemform.nameQuery.value + "&isUsedQuery=" + itemform.isUsedQuery.value;
				a.href = newhref;
				document.body.appendChild(a); 
				a.click();
			}
			
			function resetquery()
			{
				itemform.idQuery.value = "";
				itemform.nameQuery.value = "";
				var r = document.itemform.isUsedQuery;
				for(var i = 0; i < r.length; i++){
   						if(r[i].value == ""){
    							r[i].selected = true;
    							break;
   							}
					}
			}
			
			function showClick(e){
				var jsAccessControl = new JSAccessControl("#DAE0E9","#F6F8FB","#F6F8FB");
				jsAccessControl.setBackColor(e);
	
			}
			
		</script>

	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" bgcolor="#F7F8FC">
		<form name="itemform" method="post">

			<input type="hidden" name="currentSystemID"
				value="<%=currentSystemID%>" />
			<input type="hidden" name="moduleId" value="<%=moduleId%>" />


			<div id="contentborder" align="center">

				<table cellspacing="1" cellpadding="0" border="0"
					bordercolor="#EEEEEE" width=100% class="thin">
					<%
					if ("menu".equals(type)) {
					%>
					<!-- 
					<tr style="align:left">
						<td height='30' style="align:left" colspan=7>
							<div align="left">

								<a href="#" onclick="addmodule()"><u>新增子模块</u> </a> |
								<a href="#" onclick="additem()"><u>新增菜单项</u> </a> |
								<a href="#" onclick="deleteitem()"><u>删除菜单项</u> </a>

							</div>
						</td>
					</tr> -->
					<%
					}
					%>
					<tr>
						<td width="25%">
							<div align="left">
								ID：
								<input type="text" name="idQuery" value="<%=idQuery%>" />
							</div>
						</td>
						<td width="25%">
							<div align="left">
								名称：
								<input type="text" name="nameQuery" value="<%=nameQuery%>" />
							</div>
						</td>
						<td width="17%">
							<div align="left">
								是否使用：
								<SELECT ID="isUsedQuery" NAME="usedQuery">
									<OPTION VALUE="">
										请选择
										<%
									if (isUsedQuery.equals("true")) {
									%>
									
									<OPTION VALUE="true" SELECTED>
										活动
									<OPTION VALUE="false">
										不启用
										<%
																		} else if (isUsedQuery.equals("false")) {
																		%>
									
									<OPTION VALUE="true">
										活动
									<OPTION VALUE="false" SELECTED>
										不启用
										<%
																		} else {
																		%>
									
									<OPTION VALUE="true">
										活动
									<OPTION VALUE="false">
										不启用
										<%
																		}
																		%>
									
								</SELECT>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<div align="right">
								<input name="sub" value="查询" type="button" onclick="queryitem()"
									class="input" />
								<input name="clear" value="重置" type="button"
									onclick="resetquery()" class="input" />
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</div>
						</td>
					</tr>
				</table>
				<hr width="100%">
				<table width="100%" cellspacing="1" cellpadding="0" border="0"
					bordercolor="#EEEEEE" width=100% class="thin">
					<pg:listdata dataInfo="com.chinacreator.epp.xml.ItemList"
						keyName="ItemList" />
					<!--分页显示开始,分页标签初始化-->
					<pg:pager maxPageItems="10" id="ItemList" scope="request"
						data="ItemList" isList="false">
						<tr>
							<!--设置分页表头-->
							<td class="headercolor" width="3%">
								<input type="checkbox" name="checkBoxAll"
									onclick="checkAll('checkBoxAll','ID')">
							</td>
							<td height='30' width="10%" class="headercolor">
								菜单项ID
							</td>
							<td height='30' width="10%" class="headercolor">
								菜单项名称
							</td>
							<td height='30' width="10%" class="headercolor">
								使用数据源
							</td>
							<td height='30' width="17%" class="headercolor">
								导航区工作条
							</td>
							<td height='30' width="17%" class="headercolor">
								导航区内容区
							</td>
							<td height='30' width="17%" class="headercolor">
								工作区工作条
							</td>
							<td height='30' width="17%" class="headercolor">
								工作区内容区
							</td>
							<!-- <td height='30' width="10%" class="headercolor">
								是否使用
							</td> -->
						</tr>

						<pg:param name="currentSystemID" />
						<pg:param name="moduleId" />
						<pg:param name="isUsedQuery" />
						<pg:param name="type" />

						<!--检测当前页面是否有记录-->
						<pg:notify>
							<tr height="18px" class="labeltable_middle_tr_01">
								<td colspan=100 align='center' height='20'>
									暂时没有菜单项
								</td>
							</tr>
						</pg:notify>

						<%
						ContextMenu contextmenu = new ContextMenuImpl();
						%>
						<!--list标签循环输出每条记录-->
						<pg:list>
							<%
									String itemId = dataSet.getString("id");
									String itemName = dataSet.getString("name");
							%>
							<%--<%
						Menu menu = new Menu();
						
						menu.setIdentity("item_" + itemId);
						
						Menu.ContextMenuItem menuitem1 = new Menu.ContextMenuItem();
						menuitem1.setName("修改");
						menuitem1.setLink("javascript:modifyitem('"+itemId+"')");
						menuitem1.setIcon("../../purviewmanager/images/rightmenu_images/doc_fbyl.gif");
						menu.addContextMenuItem(menuitem1);
						
						contextmenu.addContextMenu(menu);
						%>--%>

							<tr onmouseover="this.className='mouseover'"
								onmouseout="this.className= 'mouseout'"
								onclick="showClick(this)"
								onDBLclick="javascript:modifyitem('<%=itemId%>')">
								<td class="tablecells"
									style="word-break:break-all;word-wrap: break-word">
									<P align="left">
									<% if("false".equals(dataSet.getString("isdelete").trim())){ %>
										<input type="checkbox" name="ID" disabled="disabled">
									<%}else{ %>
										<input type="checkbox" name="ID"
											onclick="checkOne('checkBoxAll','ID')"
											value='<pg:cell colName="id" defaultValue=""/>'>
									<%} %>	
									</P>
								</td>
								<td id="item_<%=itemId%>" height='20' class="tablecells"
									style="word-break:break-all;word-wrap: break-word">
									<pg:cell colName="id" defaultValue="" />
								</td>
								<td height='20' class="tablecells"
									style="word-break:break-all;word-wrap: break-word">
									<pg:cell colName="name" defaultValue="" />
								</td>
								<td height='20' class="tablecells"
									style="word-break:break-all;word-wrap: break-word">
									<pg:cell colName="datasource" defaultValue="" />
								</td>
								<td height='20' class="tablecells"
									style="word-break:break-all;word-wrap: break-word">
									<pg:cell colName="navigatortoolbar" defaultValue="" />
								</td>
								<td height='20' class="tablecells"
									style="word-break:break-all;word-wrap: break-word">
									<pg:cell colName="navigatorcontent" defaultValue="" />
								</td>
								<td height='20' class="tablecells"
									style="word-break:break-all;word-wrap: break-word">
									<pg:cell colName="workspacetoolbar" defaultValue="" />
								</td>
								<td height='20' class="tablecells"
									style="word-break:break-all;word-wrap: break-word">
									<pg:cell colName="workspacecontent" defaultValue="" />
								</td>
								<!-- <td height='20' class="tablecells"
									style="word-break:break-all;word-wrap: break-word">
									<pg:cell colName="isUsed" defaultValue="" />
								</td> -->
							</tr>
						</pg:list>
						<tr height="18px" class="labeltable_middle_tr_01">
							<td colspan="8" align='center'>
								共
								<pg:rowcount />
								条记录
								<pg:index />
							</td>
						</tr>
						<%
						request.setAttribute("item", contextmenu);
						%>
						<pg:contextmenu enablecontextmenu="false" context="item"
							scope="request" />
					</pg:pager>
				</table>
			</div>
			<div id=divProcessing
				style="width:200px;height:30px;position:absolute;left:250px;top:460px;display:none;">
				<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000"
					width="100%" height="100%">
					<tr>
						<td bgcolor=#3A6EA5>
							<marquee align="middle" behavior="alternate" scrollamount="5">
								<font color=#FFFFFF>...处理中...请等待...</font>
							</marquee>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</body>

	<iframe name="hiddenFrame" width="0" height="0"></iframe>
</html>
