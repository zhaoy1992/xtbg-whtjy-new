<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenu"%>
<%@ page
	import="com.frameworkset.common.tag.contextmenu.ContextMenuImpl"%>
<%@ page
	import="com.frameworkset.util.StringUtil"%>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	//Ӧ���ɵ�ǰ��Ӧ��id��ö�Ӧ�Ĳ˵��ļ���Ϣ
	//�˵��ļ�����ʽ��module-{currentSystemID}.xml
	String currentSystemID = control.getCurrentSystemID();

	String idQuery = StringUtil.replaceNull(request
			.getParameter("idQuery"));
	String nameQuery = StringUtil.replaceNull(request
			.getParameter("nameQuery"));
	String usedQuery = StringUtil.replaceNull(request
			.getParameter("usedQuery"));
	String descriptionQuery = StringUtil.replaceNull(request
			.getParameter("descriptionQuery"));	
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<link rel="stylesheet" type="text/css"
			href="../../purviewmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="../../purviewmanager/css/treeview.css">
		<script language="JavaScript"
			src="../../purviewmanager/scripts/func.js" type="text/javascript"></script>
		<tab:tabConfig />
		<title>ģ���б�</title>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/sysmanager/applymanager/common.js"
			type="text/javascript"></script>

		<script language="javascript">
			
			//module��item����
			function itemmanage(moduleId)
			{
				if(moduleId != null && moduleId != "")
				{
					openWin('itemlist.jsp?moduleId='+moduleId,screen.availWidth,screen.availHeight);
				}
				else
				{
					alert("δ�ܻ��ģ���ID��");
				}
			}
			
			//ɾ��module
			function deletemodule()
			{
			    var all = document.getElementsByName("ID");
				var moduleIds="";
				for(var i=0;i<all.length;i++)
				{
					if(all[i].checked == true)
					{
						if(all[i].value == "sysmanager")
						{
							alert("ģ�顮ϵͳ����������ɾ����");
							return false;
						}
						moduleIds = moduleIds + all[i].value + ";";
					}
				}
				if(haveSelect('ID'))
				{		
					if(confirm('��ȷ��Ҫɾ����ѡ��ģ�飿��'))
					{								
						document.all.divProcessing.style.display = "block";
					  	moduleform.action = "deletemenu_do.jsp?moduleIds="+moduleIds;
					    moduleform.target = "hiddenFrame";
					    moduleform.submit();
					    
					//  parent.location.reload();
					//	getNavigatorContent().location.reload();	
					}
					else
					{
					  return false;
					}
				
				}else{
			    	alert("��ѡ��Ҫ��ɾ����ģ�飡");
			    	return false;
			   	}
			   	return true;
			}
			
			function addmodule()
			{
				var ww = openWin('addmodule.jsp',screen.availWidth-320,screen.availHeight-140)
				if(ww)
				{								
					parent.location.reload();
					getNavigatorContent().location.reload();
				}
			}
			
			function modifymodule(moduleId)
			{
				var ww = openWin('modifymodule.jsp?moduleId='+moduleId,screen.availWidth-320,screen.availHeight-140)
				if(ww)
				{
				
					parent.location.reload();
					getNavigatorContent().location.reload();
				}
			}
			
			function querymodule()
			{
				moduleform.action = "menulist.jsp";
			    moduleform.target = "_self";
			    moduleform.submit();
			}
			
			function resetquery()
			{
				moduleform.idQuery.value = "";
				moduleform.nameQuery.value = "";
				moduleform.descriptionQuery.value = "";
				moduleform.usedQuery.value = "";
			}
			
			
			function showClick(e){
				var jsAccessControl = new JSAccessControl("#DAE0E9","#F6F8FB","#F6F8FB");
				jsAccessControl.setBackColor(e);
	
			}
		
		</script>

	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" bgcolor="#F7F8FC">
		<form name="moduleform" method="post">

			<input type="hidden" name="currentSystemID"
				value="<%=currentSystemID%>" />

			<div id="contentborder" align="center">

				<table cellspacing="1" cellpadding="0" border="0"
					bordercolor="#EEEEEE" width=100% class="thin">
					<!-- 
					<tr style="align:left">
						<td height='30' style="align:left" colspan=7>
							<div align="left">
								<a href="#" onclick="addmodule()"><u>����ģ��</u>
								</a> |
								<a href="#" onclick="deletemodule()"><u>ɾ��ģ��</u>
								</a>
							</div>
						</td>
					</tr> -->
					<tr>
						<td width="23%">
							<div align="left">
								ģ���ID��
								<input type="text" name="idQuery" value="<%=idQuery%>" />
							</div>
						</td>
						<td width="23%">
							<div align="left">
								ģ�����ƣ�
								<input type="text" name="nameQuery" value="<%=nameQuery%>" />
							</div>
						</td>
						<td width="23%">
							<div align="left">
								ģ��������
								<input type="text" name="descriptionQuery"
									value="<%=descriptionQuery%>" />
							</div>
						</td>
					</tr>
					<tr>
						<td width="17%">
							<div align="left">
								�Ƿ�ʹ�ã�
								<SELECT ID="usedQuery" NAME="usedQuery">
									<OPTION VALUE="">
										��ѡ��
									<%
									if (usedQuery.equals("true")) {
									%>
									
									<OPTION VALUE="true" SELECTED>
										�
									<OPTION VALUE="false">
										������
									<%
									} else if (usedQuery.equals("false")) {
									%>
									
									<OPTION VALUE="true">
										�
									<OPTION VALUE="false" SELECTED>
										������
									<%
									} else {
									%>
									
									<OPTION VALUE="true">
										�
									<OPTION VALUE="false">
										������
									<%
									}
									%>
									
								</SELECT>
							</div>
						</td>
						<td width="14%" nowrap colspan="2">
							<div align="right">
								<input name="sub" value="��ѯ" type="button"
									onclick="querymodule()" class="input" />
								<input name="clear" value="����" type="button"
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
					<pg:listdata dataInfo="com.chinacreator.epp.xml.ModuleList"
						keyName="ModuleList" />
					<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
					<pg:pager maxPageItems="10" id="ModuleList" scope="request"
						data="ModuleList" isList="false">
						<tr>
							<!--���÷�ҳ��ͷ-->
							<td class="headercolor" width="3%">
								<input type="checkbox" name="checkBoxAll"
									onclick="checkAll('checkBoxAll','ID')">
							</td>
							<td height='30' width="22%" class="headercolor">
								ģ��ID
							</td>
							<td height='30' width="25%" class="headercolor">
								ģ������
							</td>
							<td height='30' width="25%" class="headercolor">
								ģ��ʹ������Դ
							</td>
							<td height='30' width="25%" class="headercolor">
								ģ������
							</td>
							<!-- <td height='30' width="25%" class="headercolor">
								�Ƿ�ʹ��
							</td> -->
						</tr>

						<pg:param name="currentSystemID" />
						<pg:param name="usedQuery" />
						
						<!--��⵱ǰҳ���Ƿ��м�¼-->
						<pg:notify>
							<tr height="18px" class="labeltable_middle_tr_01">
								<td colspan=100 align='center' height='20'>
									��ʱû��ģ��
								</td>
							</tr>
						</pg:notify>

						<%
						ContextMenu contextmenu = new ContextMenuImpl();
						%>
						<!--list��ǩѭ�����ÿ����¼-->
						<pg:list>
							<%
									String moduleId = dataSet.getString("id");
									String moduleName = dataSet.getString("name");
							%>
							<%--<%
						Menu menu = new Menu();
						
						menu.setIdentity("module_" + moduleId);
	
						Menu.ContextMenuItem menuitem1 = new Menu.ContextMenuItem();
						menuitem1.setName("����˵���");
						menuitem1.setLink("javascript:itemmanage('"+moduleId+"')");
						menuitem1.setIcon("../../purviewmanager/images/rightmenu_images/doc_fbyl.gif");
						menu.addContextMenuItem(menuitem1);
						
						Menu.ContextMenuItem menuitem2 = new Menu.ContextMenuItem();
						menuitem2.setName("�޸�");
						menuitem2.setLink("javascript:modifymodule('"+moduleId+"')");
						menuitem2.setIcon("../../purviewmanager/images/rightmenu_images/doc_fbyl.gif");
						menu.addContextMenuItem(menuitem2);
						
						contextmenu.addContextMenu(menu);
						%>--%>
							<tr onmouseover="this.className='mouseover'"
								onmouseout="this.className= 'mouseout'"
								onclick="showClick(this)"
								onDBLclick="javascript:modifymodule('<%=moduleId%>')">
								<td class="tablecells" nowrap="true">
									<P align="left">
									<% if("true".equals(dataSet.getString("isdelete").trim())){ %>
										<input type="checkbox" name="ID"
											onclick="checkOne('checkBoxAll','ID')"
											value='<pg:cell colName="id" defaultValue=""/>'>
									<%}else{ %>
										<input type="checkbox" name="ID" disabled="disabled">
									<%} %>								
									</P>
								</td>
								<td id="module_<%=moduleId%>" height='20' class="tablecells">
									<pg:cell colName="id" defaultValue="" />
								</td>
								<td height='20' class="tablecells">
									<pg:cell colName="name" defaultValue="" />
								</td>
								<td height='20' class="tablecells">
									<pg:cell colName="datasource" defaultValue="" />
								</td>
								<td height='20' class="tablecells">
									<pg:cell colName="description" defaultValue="" />
								</td>
								<!-- <td height='20' class="tablecells">
									<pg:cell colName="used" defaultValue="" />
								</td> -->								
							</tr>
						</pg:list>
						<tr height="18px" class="labeltable_middle_tr_01">
							<td colspan="5" align='center'>
								��
								<pg:rowcount />
								����¼
								<pg:index />
							</td>
						</tr>
						<%
						request.setAttribute("module", contextmenu);
						%>
						<pg:contextmenu enablecontextmenu="false" context="module"
							scope="request" />
					</pg:pager>
				</table>
			</div>
		</form>
		<div id=divProcessing
			style="width:200px;height:30px;position:absolute;left:250px;top:460px;display:none;">
			<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000"
				width="100%" height="100%">
				<tr>
					<td bgcolor=#3A6EA5>
						<marquee align="middle" behavior="alternate" scrollamount="5">
							<font color=#FFFFFF>...������...��ȴ�...</font>
						</marquee>
					</td>
				</tr>
			</table>
		</div>
	</body>
	<iframe name="hiddenFrame" width="0" height="0"></iframe>
</html>
