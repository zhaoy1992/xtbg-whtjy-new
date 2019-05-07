<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.ResourceAction"%>
<%@ page import="com.chinacreator.resource.ResourceManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleManager,com.chinacreator.sysmgrcore.manager.OperManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Roleresop"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.*"%>
<%@ page import="java.util.List,java.util.ArrayList"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.web.tag.OperList" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%
			AccessControl accesscontroler = AccessControl.getInstance();
    		accesscontroler.checkAccess(request, response);
			String resTypeId2 = request.getParameter("resTypeId2");
			String resId2 = request.getParameter("title");//request.getParameter("resId2");
			String resTypeName = request.getParameter("resTypeName");
			String title = request.getParameter("title");
			if (resId2 == null) {
				resId2 = (String) request.getAttribute("resId2");
			}
			if (resTypeId2 == null) {
				resTypeId2 = (String) request.getAttribute("resTypeId2");
			}
			OperManager operManager = SecurityDatabase.getOperManager();
			ResourceManager resManager = new ResourceManager();
			List operList = resManager.getOperations(resTypeId2);
			if (operList == null) {
				operList = new ArrayList();
			}
			request.setAttribute("operList", operList);
			String stored = (String) request.getAttribute("stored");
			if (stored == null) {
				stored = "0";
			}
			String roleId = "";
			String rid = "";

			%>
<html>
	<head>
		<title>ϵͳ����</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
		<SCRIPT language="javascript">
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

			function changebox(currCheck,rid,priority,opid){
				var resid = document.forms[0].title.value;
				var restypeid = document.forms[0].resTypeId.value;
				//checked
				if(currCheck.checked){
					send_request('saveRoleOp.jsp?resId='+resid+'&resTypeId='+restypeid+'&opId='+opid+"&checked=1&title=<%=title%>&resTypeName=<%=resTypeName%>");
				}
				//not checked
				else{
					send_request('saveRoleOp.jsp?resId='+resid+'&resTypeId='+restypeid+'&opId='+opid+"&checked=0&title=<%=title%>&resTypeName=<%=resTypeName%>");
				}

				setCheck(currCheck,rid,priority);
			}

			function changebox2(opid,checked){
				var resid = document.forms[0].title.value;
				var restypeid = document.forms[0].resTypeId.value;
				send_request('saveRoleOp.jsp?resId='+resid+'&resTypeId='+restypeid+'&opId='+opid+"&checked="+checked+"&title=<%=title%>&resTypeName=<%=resTypeName%>");
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

		</SCRIPT>
		<style type="text/css">
<!--
.STYLE1 {color: #0000FF}
-->
        </style>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
		<div id="contentborder" align="center">
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
				<input type="hidden" name="resTypeName" value="<%=resTypeName%>" />
				<input type="hidden" name="restypeId" value="<%=resTypeId2%>" />
				<pg:listdata dataInfo="RoleList" keyName="RoleList" />
				<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
				<pg:pager maxPageItems="18" scope="request" data="RoleList" isList="false">
					<pg:param name="resTypeId2" />
					<pg:param name="resId2" />
					<pg:param name="resTypeName" />
					<pg:param name="title" />

					<table cellspacing="1" cellpadding="0" border="0" width=98% class="thin">
						<input name="resTypeId" type="hidden" value="<%=resTypeId2%>">
						<input name="resId" type="hidden" value="<%=resId2%>">
						<input name="title" type="hidden" value="<%=title%>">
						<TR>
							<td colspan="2" align="center">
								<span class="STYLE1"><%=resTypeName%>>><%=title%></span>&nbsp;�Ľ�ɫ������Ȩ���б�(ֱ��ѡ��ѡ�򼴿ɣ�ϵͳʵʱ����)
							</td>
						</TR>

						<TR>
							<th height='20' class="headercolor">
								��ɫ����
							</th>
							<th height='20' class="headercolor">
								�����б�
							</th>
						</TR>
						<pg:list>
							<%boolean flag1;
							//�жϸ����Ľ�ɫ�Ƿ��ǳ�������Ա��ɫ
							flag1 = accesscon.isAdministratorRole(dataSet.getString("roleName"));
							if (flag1 == true) {

							%>
							<TR onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
								<td align="center">
									<pg:cell colName="roleName" />
									<%rid = rowid;
									roleId = dataSet.getString("roleId");
									List hasOper = operManager.getOperResRoleList(roleId, title,
											resTypeId2);

							%>
								</td>
								<td align="center">
									<pg:list requestKey="operList" needClear="false" declare="false">
										<input name="opId<%=rid%>" type="checkbox"
											<%
						        	String opId = dataSet.getString("id");
						        	//System.out.println("opId="+opId);
						        	for(int i = 0; hasOper != null && i < hasOper.size(); i ++)
						        	{
						        		//Roleresop op = (Roleresop)roleOperList.get(i);
						        		RoleresopKey op = (RoleresopKey)hasOper.get(i);
						        		//System.out.println(i+":::opId2="+op.getId().getOpId());
						        		//System.out.println(i+":::rId="+op.getId().getRoleId());
						        		if(op.getRoleId().equals(roleId) && op.getOpId().equals(opId))
						        		{
						        			out.println("checked");
						        			break;
						        		}

						        	}
						        %>
											value="<%=roleId%>;<pg:cell colName="id"/>" onclick="changebox(this,'<%=rid%>','<pg:cell colName="priority" defaultValue=""/>','<%=roleId%>;<pg:cell colName="id"/>')" checked disabled="true">

										<pg:cell colName="name" />
										<input name="priority<%=rid%>" value="<pg:cell colName="priority" defaultValue=""/>" type="hidden">
									</pg:list>
								</td>
							</TR>
							<%} else {
									boolean flag2;
						        	//�ж���Դ�Ƿ���δ�ܱ�������Դ
									flag2 = accesscon.isUnprotected(title,resTypeId2);
									boolean flag4;
						        	//�ж���Դ���в����Ƿ�ֻ�г�������Ա���ܷ���
									flag4 = accesscon.isExcluded(title,resTypeId2);
									if(flag2==true){
							%>
								<TR onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
									<td align="center">
										<pg:cell colName="roleName" />
										<%rid = rowid;
									roleId = dataSet.getString("roleId");
									List hasOper = operManager.getOperResRoleList(roleId, title,
											resTypeId2);
					
									%>
									</td>
									<td align="center">
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
											<pg:cell colName="name" />
											<input name="priority<%=rid%>" value="<pg:cell colName="priority" defaultValue=""/>" type="hidden">
										</pg:list>
									</td>
								</TR>
							<%
			       			} else if(accesscon.isExcluded(title,resTypeId2)==true){%>
			       				<TR onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
									<td align="center">
										<pg:cell colName="roleName" />
										<%rid = rowid;
									roleId = dataSet.getString("roleId");
									List hasOper = operManager.getOperResRoleList(roleId, title,
											resTypeId2);
					
									%>
									</td>
									<td align="center">
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
											<pg:cell colName="name" />
											<input name="priority<%=rid%>" value="<pg:cell colName="priority" defaultValue=""/>" type="hidden">
										</pg:list>
									</td>
								</TR>
			       			 <%}else{%>
			       				<TR onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
									<td align="center">
										<pg:cell colName="roleName" />
										<%rid = rowid;
									roleId = dataSet.getString("roleId");
									List hasOper = operManager.getOperResRoleList(roleId, title,
											resTypeId2);
					
									%>
									</td>
									<td align="center">
										<pg:list requestKey="operList" needClear="false" declare="false">
										<%
											boolean flag3;
								        	//�ж���Դ�Ƿ���δ�ܱ�������Դ
											flag3 = accesscon.isUnprotected(title, dataSet.getString("id"),resTypeId2);
											if(flag3==true){
											
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
											<pg:cell colName="name" />
											<input name="priority<%=rid%>" value="<pg:cell colName="priority" defaultValue=""/>" type="hidden">
										<%}else if(accesscon.isExcluded(title, dataSet.getString("id"),resTypeId2)==true){%>
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
												value="<%=roleId%>;<pg:cell colName="id"/>" onclick="changebox(this,'<%=rid%>','<pg:cell colName="priority" defaultValue=""/>','<%=roleId%>;<pg:cell colName="id"/>')"  disabled="true">
											<pg:cell colName="name" />
											<input name="priority<%=rid%>" value="<pg:cell colName="priority" defaultValue=""/>" type="hidden">
										<%}else{%>
											<input name="opId<%=rid%>" type="checkbox"
												<%
									        	String opId = dataSet.getString("id");//System.out.println(resId2+"|"+opId+"|"+resTypeId2);
									        	if(!accesscontroler.checkPermission(resId2,opId,resTypeId2))
									        	{
			      									out.print(" disabled=\"true\"" );
			      								}
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
												value="<%=roleId%>;<pg:cell colName="id"/>" onclick="changebox(this,'<%=rid%>','<pg:cell colName="priority" defaultValue=""/>','<%=roleId%>;<pg:cell colName="id"/>')" >
											<pg:cell colName="name" />
											<input name="priority<%=rid%>" value="<pg:cell colName="priority" defaultValue=""/>" type="hidden">
											<%}%>
										</pg:list>
									</td>
								</TR>
							<%}
							}%>
						</pg:list>
						<tr>
							<td colspan="2" align="right">
								��<pg:rowcount/>����¼ <pg:index />
							</td>
						</tr>
					</table>
				</pg:pager>
			</FORM>

		</div>
	</body>
</html>
