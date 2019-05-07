<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld"%>
<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.ResourceAction"%>
<%@ page import="com.chinacreator.resource.ResourceManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.OrgManager,com.chinacreator.sysmgrcore.manager.OperManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Organization"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Roleresop"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.*"%>
<%@ page import="com.chinacreator.framework.MenuItem"%>
<%@ page import="java.util.List,java.util.ArrayList,com.chinacreator.framework.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.db.*,com.chinacreator.sysmgrcore.manager.*"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<% 
    String resId = request.getParameter("resId");
	String resName = request.getParameter("resName");
	String columnID = request.getParameter("columnID");
	String menuPath = request.getParameter("nodePath");
	String resTypeId2 = request.getParameter("resTypeId"); //��Դ����id cs_column
	String resId2 = resId; //��Դid
	String title = resName; //��Դ����
    
    CSMenuManager csmenu = new CSMenuManagerImpl();
    CSMenuModel csmenuModel =  csmenu.getCSMenuModelInfoById(resId);
    
	//��ģ�������Ŀ
	String mouseupimg = "";
	String mouseoverimg = "";
	String mouseclickimg = "";
	String mouseoutimg = "";
	String headimg = "";
	String WorkspaceContent = "";
	String WorkspaceToolbar = "";
	String Left = "";
	String Top = "";
	boolean used =true;
	String Title = "................... ";
	String Id = "";
	String Name = csmenuModel.getTitle();
	String NavigatorToolbar = "";
	String NavigatorContent = "";
	String ParentPath = "";
	String Path = "";
	String StatusContent = "";
	String StatusToolbar = "";    
	
    //��ԴID
	if (resId2 == null) {
		resId2 = (String) request.getAttribute("resId2");
	}
	
	
	
	OperManager operManager = SecurityDatabase.getOperManager();
	ResourceManager resManager = new ResourceManager();

	List operList = resManager.getOperations("column");
	//	List allRole = roleManager.getRoleList();
	if (operList == null) {
		operList = new ArrayList();
	}
	request.setAttribute("operList", operList);
	//request.setAttribute("allRole",allRole);
	String stored = (String) request.getAttribute("stored");
	if (stored == null) {
		stored = "0";
	}
	String roleId = "";
	String rid = "";

%>
<html>


	<head>
		<tab:tabConfig />
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
		<script language="javascript">
	
		    var resTypeId2 ="<%=resTypeId2%>";
			var resId2 ="<%=resId2%>";
			var http_request = false;
			//��ʼ����ָ������ĺ�������������ĺ���
			function send_request(url){
				http_request = false;
				//��ʼ��ʼ��XMLHttpRequest����
				if(window.XMLHttpRequest){//Mozilla
					http_request = new XMLHttpRequest();
					if(http_request.overrideMimeType){//����MIME���
						http_request.overrideMimeType("text/xml");
					}
				}
				else if(window.ActiveXObject){//IE
					try{
						http_request = new ActiveXObject("Msxml2.XMLHTTP");
					}catch(e){
						try{
							http_request = new ActiveXObject("Microsoft.XMLHTTP");
						}catch(e){
						}
					}
				}
				if(!http_request){
					alert("���ܴ���XMLHttpRequest����");
					return false;
				}
				http_request.onreadystatechange = processRequest;
				http_request.open("GET",url,true);
				http_request.send(null);
			}

			function processRequest(){
				if(http_request.readyState == 4){                  
					if(http_request.status == 200){
						//alert(http_request.responseText);
					}
					else{
						alert("�Բ��𣬷���������");
					}
				}
			}
			//------------------------------------------------------------------------------------------
			function changebox(currCheck,rid,priority,opid){
				var roleList = document.roleList;
				var isRecursion = 0;
				//�Ƿ�ݹ�

				if(roleList.isRecursion.length)				
				{
				if(roleList.isRecursion[rid].checked)
						isRecursion = 1;
				}
			   else if(roleList.isRecursion.checked)
			    {
			    	isRecursion = 1;
			    }
			    
				var menuPath="<%=menuPath%>";
				var resid = "<%=resId2%>";
				var restypeid = roleList.resTypeId.value;
				//checked
				if(currCheck.checked){
					send_request('saveRoleOp.jsp?resId='+resid+'&resTypeId='+restypeid+'&opId='+opid+"&checked=1&title=<%=title%>&isRecursion="+isRecursion+"&menuPath="+menuPath);
				}
				//not checked
				else{
					send_request('saveRoleOp.jsp?resId='+resid+'&resTypeId='+restypeid+'&opId='+opid+"&checked=0&title=<%=title%>&isRecursion="+isRecursion+"&menuPath="+menuPath);
				}

				setCheck(currCheck,rid,priority);
			}
			
			function isRecursionClick(currCheck,rid,priority){
		
				var roleList = document.roleList;
				var isRecursion = 0;
				var opid = 0;
				//�Ƿ�ݹ�

				if(roleList.isRecursion.length)				
				{
					if(roleList.isRecursion[rid].checked)
						isRecursion = 1;
				}
			    else if(roleList.isRecursion.checked)
			    {
			    	isRecursion = 1;
			    }
			    
				var menuPath="<%=menuPath%>";
				var resid = "<%=resId2%>";
				var restypeid = roleList.resTypeId.value;
					
					
				var opers = roleList.all("opId"+rid);
				//û�и�ѡ��
  				if(!opers){  	
  					alert("��û��ѡ�����");
  					return;
  				}
  				var n=roleList.all("opId"+rid).length;
  				//ֻ��һ����ѡ��
  				if(!n){
	  				opid = roleList.all("opId"+rid).value;
	  			
					if(roleList.all("opId"+rid).checked){
						send_request('saveRoleOp.jsp?resId='+resid+'&resTypeId='+restypeid+'&opId='+opid+"&checked=1&title=<%=title%>&isRecursion="+isRecursion+"&menuPath="+menuPath);
					}
					else
						send_request('saveRoleOp.jsp?resId='+resid+'&resTypeId='+restypeid+'&opId='+opid+"&checked=0&title=<%=title%>&isRecursion="+isRecursion+"&menuPath="+menuPath);
				}
				//�ж����ѡ��
				for(var i= 0;i<n;i++){
				
					opid = opers[i].value;
					if(opers[i].checked){						
						send_request('saveRoleOp.jsp?resId='+resid+'&resTypeId='+restypeid+'&opId='+opid+"&checked=1&title=<%=title%>&isRecursion="+isRecursion+"&menuPath="+menuPath);
					}
					else
						send_request('saveRoleOp.jsp?resId='+resid+'&resTypeId='+restypeid+'&opId='+opid+"&checked=0&title=<%=title%>&isRecursion="+isRecursion+"&menuPath="+menuPath);
				}
			}
			
			function changebox2(opid,checked){
				var isRecursion = 0;
				//�Ƿ�ݹ�
				if(document.forms[0].isRecursion.checked)
					isRecursion = 1;
				var roleList = document.roleList;
				var resid = "<%=resId2%>";
				var menuPath="<%=menuPath%>";
				var restypeid = roleList.resTypeId.value;
				send_request('saveRoleOp.jsp?resId='+resid+'&resTypeId='+restypeid+'&opId='+opid+"&checked="+checked+"&title=<%=title%>&menuPath="+menuPath+"&isRecursion="+isRecursion);
			}

			function setCheck(currCheck,rid,priority)
			{
			   	var o = document.getElementsByName(currCheck.name);
				var prioritylist = document.getElementsByName("priority"+rid);
				if (currCheck.checked==true && priority.length >1 && (priority.match(/[0-9]/))){
					for (var i=0;i<prioritylist.length;i++){
						var v = prioritylist[i].value;

						if (v.length >1 && (v.match(/[0-9]/)) && priority.substring(0,1) > v.substring(0,1)&& priority.substring(1,2) == v.substring(1,2) )
						{
							o[i].checked=true;
							changebox2(o[i].value,1);
							//alert("3:"+o[i].value);
							//o[i].disabled=true;
						}
					}

					for (var i=0;i<prioritylist.length;i++){
						var v = prioritylist[i].value;
						if (v.length >1 && (v.match(/[0-9]/)) && priority.substring(1,2) != v.substring(1,2) )
						{
							o[i].checked=false;
							changebox2(o[i].value,0);
							//alert("4:"+o[i].value);
							//o[i].disabled=false
						}
					}
				}
				if (currCheck.checked==false  && priority.length >1 && (priority.match(/[0-9]/))){
					for (var i=0;i<prioritylist.length;i++){
						var v = prioritylist[i].value;
						if ( v.length >1 && (v.match(/[0-9]/)) && priority.substring(0,1) > v.substring(0,1) )
						{
							if ( o[i].checked==true ){
								//currCheck.checked==true;
								//o[i].disabled=false;
							}
						}
					}

				}
			}

	</script>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
	</head>
	

	<%@ include file="/epp/css/cssControl.jsp"%><body >
		<tab:tabContainer id="foo-menu-container" selectedTabPaneId="foo-menu">
			<tab:tabPane id="foo-menu" tabTitle="�˵���Ϣ�鿴">
				<FORM name="11" method="post">
					<tr>
						<td height="35" align=center colspan=5>
							<P>
								<B>�˵���Ϣ��ϸ</B>
							</P>
							<P>
								<STRONG></STRONG>
							</P>
							<P></P>
							<P></P>
						</td>
					</tr>

					<fieldSet id="1" title="333">
						<LEGEND align=left>
							<strong><FONT size=2>�˵�������Ϣ</FONT></strong>
						</LEGEND>
						<table>
							<tr>
								<td width="100" height="28" class="detailtitle" wiidth="50%">
									Id:
								</td>
								<td class="detailcontent">
									<%=csmenuModel.getId()%>
								</td>
							</tr>
							<tr>
								<td width="100" height="28" class="detailtitle" wiidth="50%">
									used:
								</td>
								<td class="detailcontent">
									<%=used%>
								</td>
							</tr>
							<tr>
								<td class="detailtitle" height="28">
									Name:
								</td>
								<td class="detailcontent">
									<%=Name%>
								</td>
							</tr>
							<tr>
								<td class="detailtitle" height="28">
									Title:
								</td>
								<td class="detailcontent">
									<%=Title%>
								</td>
							</tr>
							<tr>
								<td class="detailtitle" height="28">
									Path:
								</td>
								<td class="detailcontent">
									<%=csmenu.getCSMenuPath(resId)%>
								</td>
							</tr>
							
							<tr>
								<td class="detailtitle" height="28">
									Type:
								</td>
								<td class="detailcontent">
									<%=csmenuModel.getType()%>
								</td>
							</tr>

							
						</table>
					</fieldSet>					
					<fieldSet title="�˵�ͼƬ��Ϣ">
						<LEGEND align=left>
							<strong><FONT size=2>�˵�ͼƬ��Ϣ</FONT></strong>
						</LEGEND>
						<table>
							<tr>
								<td class="detailtitle" height="28" wiidth="40%">
									mouseupimg:
								</td>
								<td class="detailcontent">
									<%=mouseupimg%>
								</td>
							</tr>

							<tr>
								<td class="detailtitle" height="28">
									mouseoverimg:
								</td>
								<td class="detailcontent">
									<%=mouseoverimg%>
								</td>
							</tr>
							<tr>
								<td class="detailtitle" height="28">
									mouseclickimg:
								</td>
								<td class="detailcontent">
									<%=mouseclickimg%>
								</td>
							</tr>
							<tr>
								<td class="detailtitle" height="28">
									mouseoutimg:
								</td>
								<td class="detailcontent">
									<%=mouseoutimg%>
								</td>
							</tr>
							<tr>
								<td width="124" height="28" class="detailtitle">
									headimg:
								</td>
								<td class="detailcontent">
									<%=headimg%>
								</td>
							</tr>

						</table>
					</fieldSet>


				</FORM>
			</tab:tabPane>


			<tab:tabPane id="bar-menu" tabTitle="�˵���Դ��Ȩ">
				<input name="resId" value="<%=resId%>" type="hidden">
				<fieldset>
					<LEGEND align=left>
						<strong><FONT size=2>����</FONT></strong>
					</LEGEND>
					<%boolean flag;
			AccessControl accesscon = AccessControl.getInstance();
			flag = accesscon.allowIfNoRequiredRoles(resTypeId2);
			//System.out.println("hehelalal" + flag);
			if (flag == true) {

			%>
					<table>
						<tr>
							<td>
								����Դ��û�������κν�ɫ���û���������ĸ�ѡ�򶼴���δ��ѡ��״̬���������,������ʸ���Դ��һ���ڸ�ĳ���û����ɫ��������ɫ���û�Ҳ������Ȩ����ܷ���
							</td>
						</tr>
					</table>
					<%} else {

			%>
					<table align=left>
						<tr>
							<td>
								����Ը���Դ��Ȩ�ſ��Է��ʸ���Դ����û����Ȩ��������ǲ��ܷ��ʸ���Դ
							</td>
						</tr>
					</table>
					<%}%>
				</fieldset>
				<FORM name="roleList" method="post">

					<!--				��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
					<pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.RoleList" keyName="RoleList" />
					<pg:pager maxPageItems="16" scope="request" data="RoleList" isList="false">
						<pg:param name="resTypeId" />
						<pg:param name="resId" />
						<pg:param name="resName" />
						<pg:param name="columnID" />
						<pg:param name="nodePath" />

						<table cellspacing="1" cellpadding="0" border="0" width=98% class="thin">
							<TR>
								<td colspan="3" align="center">
									<span class="STYLE1"><%=title%></span>&nbsp;��Ϊ��Դ�ڸ���ɫ�б�(ֱ��ѡ��ѡ�򼴿ɣ�ϵͳʵʱ����)
								</td>
							</TR>

							<TR>
								<td height='20' class="headercolor">
									��ɫ����
								</td>
								<td height='20' class="headercolor">
									�����б�
								</td>
								<td height='20' class="headercolor">
									�Ƿ�ݹ�
								</td>
							</TR>
							<pg:list>
								<%boolean flag1;
			//�жϸ����Ľ�ɫ�Ƿ��ǳ�������Ա��ɫ
			flag1 = accesscon
					.isAdministratorRole(dataSet.getString("roleName"));
			if (flag1 == true) {

				%>
								<TR onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'">
									<td align="left">
										<pg:cell colName="roleName" />
										<%rid = rowid;
				roleId = dataSet.getString("roleId");
				List hasOper = operManager.getOperResRoleList(roleId, resId2,
						resTypeId2);

				%>
									</td>
									<td align="left">
										<pg:list requestKey="operList" needClear="false" declare="false">
											<input name="opId<%=rid%>" type="checkbox" checked disabled="true"
												<%
						        	String opId = dataSet.getString("id");
						        	
						        	
						        	for(int i = 0; hasOper != null && i < hasOper.size(); i ++)
						        	{
						        		RoleresopKey op = (RoleresopKey)hasOper.get(i);
						        		if(op.getRoleId().equals(roleId) && op.getOpId().equals(opId))
						        		{
						        			out.println("checked");
						        			break;
						        		}

						        	}
						        %>
												value="<%=roleId%>;<pg:cell colName="id"/>" onclick="changebox(this,'<%=rid%>','<pg:cell colName="priority" defaultValue=""/>','<%=roleId%>;<pg:cell colName="id"/>')">

								&gt; <pg:cell colName="name" />
											<input name="priority<%=rid%>" value="<pg:cell colName="priority" defaultValue=""/>" type="hidden">
										</pg:list>


									</td>
									<td>
										<input name="isRecursion" onclick="isRecursionClick(this,'<%=rid%>','<pg:cell colName="priority" defaultValue=""/>')" type="checkbox" checked disabled="true">
										�ݹ���Ȩ�Ӳ˵�
									</td>

								</TR>
								<%} else {
				boolean flag2;
				//�ж���Դ�Ƿ���δ�ܱ�������Դ
				flag2 = accesscon.isUnprotected(resId2, resTypeId2);
				boolean flag4;
				//�ж���Դ���в����Ƿ�ֻ�г�������Ա���ܷ���
				flag4 = accesscon.isExcluded(resId2, resTypeId2);
				if (flag2 == true) {

					%>
								<TR onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'">
									<td align="left">
										<pg:cell colName="roleName" />
										<%rid = rowid;
					roleId = dataSet.getString("roleId");
					List hasOper = operManager.getOperResRoleList(roleId,
							resId2, resTypeId2);

					%>
									</td>
									<td align="left">
										<pg:list requestKey="operList" needClear="false" declare="false">
											<input name="opId<%=rid%>" type="checkbox"
												<%
						        	String opId = dataSet.getString("id");
						        	
						        	
						        	for(int i = 0; hasOper != null && i < hasOper.size(); i ++)
						        	{
						        		RoleresopKey op = (RoleresopKey)hasOper.get(i);
						        		if(op.getRoleId().equals(roleId) && op.getOpId().equals(opId))
						        		{
						        			out.println("checked");
						        			break;
						        		}

						        	}
						        %>
												value="<%=roleId%>;<pg:cell colName="id"/>" onclick="changebox(this,'<%=rid%>','<pg:cell colName="priority" defaultValue=""/>','<%=roleId%>;<pg:cell colName="id"/>')" checked disabled="true">

								&gt; <pg:cell colName="name" />
											<input name="priority<%=rid%>" value="<pg:cell colName="priority" defaultValue=""/>" type="hidden">
										</pg:list>


									</td>
									<td>
										<input name="isRecursion" onclick="isRecursionClick(this,'<%=rid%>','<pg:cell colName="priority" defaultValue=""/>')" type="checkbox" checked disabled="true">
										�ݹ���Ȩ�Ӳ˵�
									</td>
								</TR>
								<%} else if (accesscon.isExcluded(resId2, resTypeId2) == true) {%>
								<TR onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'">
									<td align="left">
										<pg:cell colName="roleName" />
										<%rid = rowid;
					roleId = dataSet.getString("roleId");
					List hasOper = operManager.getOperResRoleList(roleId,
							resId2, resTypeId2);

					%>
									</td>
									<td align="left">
										<pg:list requestKey="operList" needClear="false" declare="false">
											<input name="opId<%=rid%>" type="checkbox"
												<%
						        	String opId = dataSet.getString("id");
						        	
						        	
						        	for(int i = 0; hasOper != null && i < hasOper.size(); i ++)
						        	{
						        		RoleresopKey op = (RoleresopKey)hasOper.get(i);
						        		if(op.getRoleId().equals(roleId) && op.getOpId().equals(opId))
						        		{
						        			out.println("checked");
						        			break;
						        		}

						        	}
						        %>
												value="<%=roleId%>;<pg:cell colName="id"/>" onclick="changebox(this,'<%=rid%>','<pg:cell colName="priority" defaultValue=""/>','<%=roleId%>;<pg:cell colName="id"/>')" disabled="true">

								&gt; <pg:cell colName="name" />
											<input name="priority<%=rid%>" value="<pg:cell colName="priority" defaultValue=""/>" type="hidden">
										</pg:list>


									</td>
									<td>
										<input name="isRecursion" onclick="isRecursionClick(this,'<%=rid%>','<pg:cell colName="priority" defaultValue=""/>')" type="checkbox" disabled="true">
										�ݹ���Ȩ�Ӳ˵�
									</td>
								</TR>
								<%} else {%>
								<TR onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'">
									<td align="left">
										<pg:cell colName="roleName" />
										<%rid = rowid;
					roleId = dataSet.getString("roleId");
					List hasOper = operManager.getOperResRoleList(roleId,
							resId2, resTypeId2);

					%>
									</td>
									<td align="left">
										<pg:list requestKey="operList" needClear="false" declare="false">
											<%boolean flag3;
					//�ж���Դ�Ƿ���δ�ܱ�������Դ
					flag3 = accesscon.isUnprotected(resId2, dataSet
							.getString("id"), resTypeId2);
					if (flag3 == true) {

						%>
											<input name="opId<%=rid%>" type="checkbox"
												<%
						        	String opId = dataSet.getString("id");
						        	
						        	
						        	for(int i = 0; hasOper != null && i < hasOper.size(); i ++)
						        	{
						        		RoleresopKey op = (RoleresopKey)hasOper.get(i);
						        		if(op.getRoleId().equals(roleId) && op.getOpId().equals(opId))
						        		{
						        			out.println("checked");
						        			break;
						        		}

						        	}
						        %>
												value="<%=roleId%>;<pg:cell colName="id"/>" onclick="changebox(this,'<%=rid%>','<pg:cell colName="priority" defaultValue=""/>','<%=roleId%>;<pg:cell colName="id"/>')" checked disabled="true">

								&gt; <pg:cell colName="name" />
											<input name="priority<%=rid%>" value="<pg:cell colName="priority" defaultValue=""/>" type="hidden">
											<%} else if (accesscon.isExcluded(resId2, dataSet
							.getString("id"), resTypeId2) == true) {%>
											<input name="opId<%=rid%>" type="checkbox"
												<%
						        	String opId = dataSet.getString("id");
						        	
						        	
						        	for(int i = 0; hasOper != null && i < hasOper.size(); i ++)
						        	{
						        		RoleresopKey op = (RoleresopKey)hasOper.get(i);
						        		if(op.getRoleId().equals(roleId) && op.getOpId().equals(opId))
						        		{
						        			out.println("checked");
						        			break;
						        		}

						        	}
						        %>
												value="<%=roleId%>;<pg:cell colName="id"/>" onclick="changebox(this,'<%=rid%>','<pg:cell colName="priority" defaultValue=""/>','<%=roleId%>;<pg:cell colName="id"/>')" disabled="true">

								&gt; <pg:cell colName="name" />
											<%} else {%>
											<input name="opId<%=rid%>" type="checkbox"
												<%
						        	String opId = dataSet.getString("id");
						        	
						        	
						        	for(int i = 0; hasOper != null && i < hasOper.size(); i ++)
						        	{
						        		RoleresopKey op = (RoleresopKey)hasOper.get(i);
						        		if(op.getRoleId().equals(roleId) && op.getOpId().equals(opId))
						        		{
						        			out.println("checked");
						        			break;
						        		}

						        	}
						        %>
												value="<%=roleId%>;<pg:cell colName="id"/>" onclick="changebox(this,'<%=rid%>','<pg:cell colName="priority" defaultValue=""/>','<%=roleId%>;<pg:cell colName="id"/>')">

								&gt; <pg:cell colName="name" />
											<%}%>
										</pg:list>


									</td>
									<td>
										<input name="isRecursion" onclick="isRecursionClick(this,'<%=rid%>','<pg:cell colName="priority" defaultValue=""/>')" type="checkbox">
										�ݹ���Ȩ�Ӳ˵�
									</td>
								</TR>
								<%}
			}%>

							</pg:list>
							<tr>
								<td colspan="3" align="center">
									<input name="resTypeId" type="hidden" value="<%=resTypeId2%>">
									<input name="resId" type="hidden" value="<%=resId2%>">
									<input name="title" type="hidden" value="<%=title%>">
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right">
									<pg:index />
								</td>
							</tr>
						</table>
					</pg:pager>
				</FORM>
			</tab:tabPane>
		</tab:tabContainer>
	</body>
</html>
