<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.ResourceAction"%>
<%@ page import="com.chinacreator.resource.ResourceManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleManager,com.chinacreator.sysmgrcore.manager.OperManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Roleresop"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.*"%>
<%@ page import="java.util.List,java.util.ArrayList"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.web.tag.OperList" %>
<%@ page import="com.chinacreator.cms.channelmanager.*"%>
<%@ page import="com.chinacreator.cms.sitemanager.*"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld"%>

<%//http://localhost:8081/creatorcms/cms/siteManage/res_manager.jsp?resId2=200&resTypeId2=site&resTypeName=�����������Ż���վ(��ɾ!)&title=�����������Ż���վ(��ɾ!)
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	String resTypeId2 = request.getParameter("resTypeId2");
	String resId2 = request.getParameter("resId2");
	String resTypeName = request.getParameter("resTypeName");
	String title = request.getParameter("title");
	if (resId2 == null) {
		resId2 = (String) request.getAttribute("resId2");
	}
	if (resTypeId2 == null) {
		resTypeId2 = (String) request.getAttribute("resTypeId2");
	}
	OperManager operManager = SecurityDatabase.getOperManager();
	UserManager userManager = SecurityDatabase.getUserManager();
	ResourceManager resManager = new ResourceManager();
	List operList = null;
	List hasOper = null;//
	
	String userid = request.getParameter("userid");//�û�
	String username = request.getParameter("username");
	String roleids = request.getParameter("roleids");//��ɫ
	String rolename = request.getParameter("rolename");
	String userOrRole = request.getParameter("userOrRole");//���û����ǽ�ɫ��ʶλ

	String[] usersStr = null;//�û�
	String[] roleStr = null;//��ɫ
	
	SiteManager sitem = new SiteManagerImpl();
	usersStr = sitem.getUsersOfSite(resId2);
	roleStr = sitem.getRolesOfSite(resId2);

	String useridsStr = usersStr[0];//�û�
	String usernamesStr = usersStr[1];
	String userType = usersStr[2];
	String roleidsStr = roleStr[0];//��ɫ
	String rolenamesStr = roleStr[1];
	String roleType = roleStr[2];
	//String userOrRoleStr = usersStr[2];

	if(userid!=null&&!userid.equals(""))//�û�
	{
		String[] eids = userid.split(",");
		String[] enames = username.split(",");

		if(useridsStr!=null&&!useridsStr.equals(""))
		{
			for(int i=0;i<eids.length;i++)
			{
				if((","+useridsStr).indexOf(","+eids[i]+",")==-1)
				{
					useridsStr += eids[i] + ",";
					usernamesStr += enames[i] + ",";
					userType += "user" + ",";
				}
			}
		}
		else
		{
			useridsStr = userid;
			usernamesStr = username;
			userType = "";
			for(int i=0;i<eids.length;i++)
			{
				userType += "user" + ",";
			}
		}
	}
	if(roleids!=null&&!roleids.equals(""))//��ɫ
	{
		String[] eids = roleids.split(",");
		String[] enames = rolename.split(",");

		if(roleidsStr!=null&&!roleidsStr.equals(""))
		{
			for(int i=0;i<eids.length;i++)
			{
				if((","+roleidsStr).indexOf(","+eids[i]+",")==-1)
				{
					roleidsStr += eids[i] + ",";
					rolenamesStr += enames[i] + ",";
					roleType += "role" + ",";
				}
			}
		}
		else
		{
			roleidsStr = roleids;
			rolenamesStr = rolename;
			roleType = "";
			for(int i=0;i<eids.length;i++)
			{
				roleType += "role" + ",";
			}
		}
	}
	String[] users = useridsStr.split(",");//������Ȩ�޵��û�
	String[] usernames = usernamesStr.split(",");
	String[] usertypes = userType.split(",");
	String[] roles = roleidsStr.split(",");//������Ȩ�޵Ľ�ɫ
	String[] rolenames = rolenamesStr.split(",");
	String[] roletypes = roleType.split(",");
	int idCount = 0;//

	%>
<html>
	<head>
		<title>���ݹ���Ȩ�޹���</title>
		<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
		<tab:tabConfig/>
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../../sysmanager/include/pager.js" type="text/javascript"></script>
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
					else{//alert(http_request.status);
						alert("�Բ��𣬷���������");
					}
				}
			}

			function changebox(currCheck,rid,priority,opid,userOrRole,restypeid){
				var resid = document.forms[0].resId.value;
				//var restypeid = document.forms[0].resTypeId.value;
				var urlstr = "";
				//�жϱ�������û����ǽ�ɫ
				if(userOrRole == "role")
					urlstr = '../../sysmanager/resmanager/saveRoleOp.jsp?resId=';
				if(userOrRole == "user")
					urlstr = "../../sysmanager/resmanager/saveRoleOpOfUser.jsp?resId=";
				//checked
				if(currCheck.checked){
					send_request(urlstr+resid+'&resTypeId='+restypeid+'&opId='+opid+"&checked=1&title=<%=title%>&resTypeName=<%=resTypeName%>");
				}
				//not checked
				else{
					send_request(urlstr+resid+'&resTypeId='+restypeid+'&opId='+opid+"&checked=0&title=<%=title%>&resTypeName=<%=resTypeName%>");
				}

				setCheck(currCheck,rid,priority,userOrRole,restypeid);
			}

			function changebox2(opid,checked,userOrRole,restypeid){
				var resid = document.forms[0].resId.value;
				//var restypeid = document.forms[0].resTypeId.value;
				var urlstr = "";
				//�жϱ�������û����ǽ�ɫ
				if(userOrRole == "role")
					urlstr = '../../sysmanager/resmanager/saveRoleOp.jsp?resId=';
				if(userOrRole == "user")
					urlstr = "../../sysmanager/resmanager/saveRoleOpOfUser.jsp?resId=";

			send_request(urlstr+resid+'&resTypeId='+restypeid+'&opId='+opid+"&checked="+checked+"&title=<%=title%>&resTypeName=<%=resTypeName%>");
			}

			function setCheck(currCheck,rid,priority,userOrRole,restypeid)
			{
			   	var o = document.getElementsByName(currCheck.name);
				var prioritylist = document.getElementsByName("priority"+rid);
				
				if (currCheck.checked==true && priority.length >1 && (priority.match(/[0-9]/))){
					for (var i=0;i<prioritylist.length;i++){
						var v = prioritylist[i].value;

						if (v.length >1 && (v.match(/[0-9]/)) && priority.substring(0,1) > v.substring(0,1)&& priority.substring(1,2) == v.substring(1,2) )
						{
							o[i].checked=true;
							changebox2(o[i].value,1,userOrRole,restypeid);
							//alert("3:"+o[i].value);
							//o[i].disabled=true;
						}
					}

					for (var i=0;i<prioritylist.length;i++){
						var v = prioritylist[i].value;
						if (v.length >1 && (v.match(/[0-9]/)) && priority.substring(1,2) != v.substring(1,2) )
						{
							o[i].checked=false;
							changebox2(o[i].value,0,userOrRole,restypeid);
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
			//add user
			function addUsers()
			{
				window.open('../../sysmanager/schedularmanage/selectexecutor.jsp?displayNameInput=username&displayValueInput=userid','newWin','scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250');
			}
			//del user
			function delUsers()
			{
			}
			//changeRows()
			function changeRows()
			{
				document.forms[0].submit();
			}
			//add user
			function addRoles()
			{
				window.open('../../sysmanager/accessmanager/role/roleList_cms.jsp?displayNameInput=username&displayValueInput=userid','newWin','scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250');
			}
			//checkAll();
			function checkAll(cur,page,rows,id)
			{
				if(cur.checked)
				{
					var all = document.getElementsByName("opId"+(page*rows+id));
					for(var j=0;j<all.length;j++)
					{
						if(!all[j].checked)
							all[j].click();
					}
				}
				else
				{
					var all = document.getElementsByName("opId"+(page*rows+id));
					for(var j=0;j<all.length;j++)
					{
						if(all[j].checked)
							all[j].click();
					}
				}
			}
			//del
			function del(rows,id)
			{
				for(var i=0;i<5;i++)
				{
					var all = document.getElementsByName("opId"+(i*rows+id));
					for(var j=0;j<all.length;j++)
					{
						if(all[j].checked)
						{
							all[j].click();
						}
					}
				}
				for(var i=0;i<2000000;i++){}//��ʱ
				document.location.href = document.URL;
			}

		</SCRIPT>
		<style type="text/css">
<!--
body{background-color: #ffffff;
scrollbar-face-color: #C9D1E4; 
scrollbar-shadow-color: #6B74B7; 
scrollbar-highlight-color: white; 
scrollbar-3dlight-color: #E100E1; 
scrollbar-darkshadow-color:#E100E1; 
scrollbar-arrow-color:#003492; 
scrollbar-base-color: #E100E1; 
scrollbar-track-color: #E9EDF3;}
.STYLE1 {padding:4px; font-size:14px; font-weight:bold; color:#ffffff}
-->
        </style>
	</head>
	<body scroll="auto">
		<div id="contentborder" align="center">
			<FORM name="roleList" method="post">
				<input type="hidden" name="resTypeName" value="<%=resTypeName%>" />
				<input type="hidden" name="restypeId" value="<%=resTypeId2%>" />
				<input name="resTypeId" type="hidden" value="<%=resTypeId2%>">
				<input name="resId" type="hidden" value="<%=resId2%>">
				<input name="title" type="hidden" value="<%=title%>">
				<input type="hidden" name="userid" value="<%=useridsStr.equals("")?"":useridsStr.substring(0,useridsStr.length()-1)%>" onpropertychange="changeRows();"/>
				<input type="hidden" name="username" value="<%=usernamesStr.equals("")?"":usernamesStr.substring(0,usernamesStr.length()-1)%>"/>
				<input type="hidden" name="roleids" value="<%=roleidsStr.equals("")?"":roleidsStr.substring(0,roleidsStr.length()-1)%>" onpropertychange="changeRows();"/>
				<input type="hidden" name="rolename" value="<%=rolenamesStr.equals("")?"":rolenamesStr.substring(0,rolenamesStr.length()-1)%>"/>
				<tab:tabContainer id="res-manager" selectedTabPaneId="res-manager-site">
					<tab:tabPane id="res-manager-site" tabTitle="վ����Ȩ��">
						<table cellspacing="0" cellpadding="3" border="0" width="100%" class="Datalisttable">
							<%
								operList = resManager.getOperations("site");
								if (operList == null) {
									operList = new ArrayList();
								}
								request.setAttribute("operList", operList);
						    %>
							<TR>
								<td height="30" colspan="<%=operList.size()+3%>" align="center" bgcolor="#ACC1D4" class="authority_title" style="color:#fff">��<%=resTypeName%>��վ��&nbsp;����Ȩ���б�(ֱ��ѡ��ѡ�򼴿ɣ�ϵͳʵʱ����)</td>
							</TR>
							<tr>
								<td height='25' colspan="<%=operList.size()+3%>" background="../images/data_list_tHeadbg.jpg" style="text-align:left; background:url(../images/data_list_tHeadbg.jpg) repeat-y center #B7BDD7">
								<a style="cursor:hand" onClick="addUsers()"><div class="DocumentOper"><img 
											class="operStyle" src="../../sysmanager/images/plan.gif">����û�</div></a>
								</td>
							</tr>

							<TR class="cms_report_tr">
								<td height='30' class="headercolor">
									<strong>ȫѡ</strong>
								</td>
								<td height='30' class="headercolor">
									<strong>ɾ��</strong>
								</td>
								<td height='30' class="headercolor">
									<strong>�û�</strong>
								</td>
								<%
									for(int num=0;num<operList.size();num++){
								%>
									<td class="headercolor" align="center">
										<strong><%=((com.chinacreator.config.model.Operation)operList.get(num)).getName()%></strong>
									</td>
								<%}%>
							</TR>
							<%
						for(int aa=0;aa<users.length;aa++)
						{
							if(users[aa]==null||users[aa].equals(""))
								continue;

							String roleid = users[aa];

							hasOper = operManager.getOperResRoleList(usertypes[aa],roleid,resId2,"site");
							if(hasOper == null){
								hasOper = new ArrayList();
							}
						%>
						<tr class="cms_data_tr" onMouseOver="this.style.background='#E9EDF3'" onMouseOut="this.style.background='#FFFFFF'">
						<td align="center">
							<input type="checkbox" id="<%=aa%>" hideFocus onClick="checkAll(this,0,<%=users.length+roles.length%>,<%=aa%>)"/>
						</td>
						<td align="center">
							<a href="#" onclick="del(<%=users.length+roles.length%>,<%=aa%>)"><u>ɾ��</u></a>
						</td>
						<td align="center">
						<input type="hidden" name="curuserid" value="<%=users[aa]%>"/>
						<%=usernames[aa]%>
						</td>
						
						<pg:list requestKey="operList" needClear="false">
							<td align="center">
							<%
								String rid = rowid;
								String opId = dataSet.getString(Integer.parseInt(rowid),"id");
								
							%>
							<input name="opId<%=idCount+aa%>" type="checkbox" 
							<%
								if(AccessControl.isAdmin(userManager.getUserById(users[aa]).getUserName()))
								{
									out.print(" disabled=\"true\" checked ");
								}
								else
								{//System.out.println(resId2+"|"+opId+"|"+resTypeId2);
									if(!accesscontroler.checkPermission(resId2,opId,resTypeId2) 
									|| accesscontroler.getUserID().equals(users[aa]))
									{
										out.print(" disabled=\"true\" ");
									}//System.out.println(" disabled=\"true\" " + users[aa]);
									for(int i = 0; i < hasOper.size(); i ++)
									{
										RoleresopKey id = (RoleresopKey)hasOper.get(i);
										if(id.getOpId().equals(opId) && id.getRoleId().equals(users[aa]))
										{
											out.println(" checked ");
											break;
										}
											
									}
								}
							%>
							value="<%=roleid%>;<pg:cell colName="id"/>" onclick="changebox(this,'<%=idCount+aa%>','<pg:cell colName="priority" defaultValue=""/>','<%=users[aa]%>;<pg:cell colName="id"/>','<%=usertypes[aa]%>','site')">
							<input name="priority<%=idCount+aa%>" value="<pg:cell colName="priority" defaultValue=""/>" type="hidden">
							</td>
						  </pg:list>
						  
					   </tr>
					   <%
						   } 
						   idCount += users.length;//
					   %>
					   <!--��ɫ-->
					   <tr>
							<td height='25' colspan="<%=operList.size()+3%>" background="../images/data_list_tHeadbg.jpg" style="text-align:left; background:url(../images/data_list_tHeadbg.jpg) repeat-y center #B7BDD7">
							<a style="cursor:hand" onClick="addRoles()"><div class="DocumentOper"><img 
										class="operStyle" src="../../sysmanager/images/plan.gif">��ӽ�ɫ</div></a>
							</td>
						</tr>
					   <TR class="cms_report_tr">
							<td height='30' class="headercolor">
								<strong>ȫѡ</strong>
							</td>
							<td height='30' class="headercolor">
								<strong>ɾ��</strong>
							</td>
							<td height='30' class="headercolor">
								<strong>��ɫ</strong>
							</td>
							<%
								for(int num=0;num<operList.size();num++){
							%>
								<td class="headercolor" align="center">
									<strong><%=((com.chinacreator.config.model.Operation)operList.get(num)).getName()%></strong>
								</td>
							<%}%>
							</TR>
							<%
						for(int aa=0;aa<roles.length;aa++)
						{
							if(roles[aa]==null||roles[aa].equals(""))
								continue;

							String roleid = roles[aa];

							hasOper = operManager.getOperResRoleList(roletypes[aa],roleid,resId2,"site");
							if(hasOper == null){
								hasOper = new ArrayList();
							}
						%>
						<tr class="cms_data_tr" onMouseOver="this.style.background='#E9EDF3'" onMouseOut="this.style.background='#FFFFFF'">
						<td align="center">
							<input type="checkbox" id="<%=users.length+aa%>" hideFocus onClick="checkAll(this,0,<%=users.length+roles.length%>,<%=users.length+aa%>)"/>
						</td>
						<td align="center">
							<a href="#" onclick="del(<%=users.length+roles.length%>,<%=users.length+aa%>)"><u>ɾ��</u></a>
						</td>
						<td align="center">
						<input type="hidden" name="curuserid" value="<%=roles[aa]%>"/>
						<%=rolenames[aa]%>
						</td>
						
						<pg:list requestKey="operList" needClear="false">
							<td align="center">
							<%
								String rid = rowid;
								String opId = dataSet.getString(Integer.parseInt(rowid),"id");
								
							%>
							<input name="opId<%=idCount+aa%>" type="checkbox"
							<%
								for(int i = 0; i < hasOper.size(); i ++)
								{
									RoleresopKey id = (RoleresopKey)hasOper.get(i);
									if(id.getOpId().equals(opId) && id.getRoleId().equals(roles[aa]))
									{
										out.println("checked");
										break;
									}
										
								}
							%>
							value="<%=roleid%>;<pg:cell colName="id"/>" onclick="changebox(this,'<%=idCount+aa%>','<pg:cell colName="priority" defaultValue=""/>','<%=roles[aa]%>;<pg:cell colName="id"/>','<%=roletypes[aa]%>','site')">
							<input name="priority<%=idCount+aa%>" value="<pg:cell colName="priority" defaultValue=""/>" type="hidden">
							</td>
						  </pg:list>
						  
					   </tr>
					   <%
						   } 
						   idCount += roles.length;//
					   %>
					  </table>
					</tab:tabPane>
					<tab:tabPane id="res-manager-channl" tabTitle="Ƶ����Ȩ��">
						<table cellspacing="0" cellpadding="3" border="0" width="100%" class="Datalisttable">
							<%
								operList = resManager.getOperations("channel");
								if (operList == null) {
									operList = new ArrayList();
								}
								request.removeAttribute("operList");
								request.setAttribute("operList", operList);
						    %>
							<TR>
								<td height="30" colspan="<%=operList.size()+3%>" align="center" bgcolor="#ACC1D4" class="authority_title" style="color:#fff">��<%=resTypeName%>��վ��&nbsp;����Ȩ���б�(ֱ��ѡ��ѡ�򼴿ɣ�ϵͳʵʱ����)</td>
							</TR>
							<tr>
								<td height='25' colspan="<%=operList.size()+3%>" background="../images/data_list_tHeadbg.jpg" style="text-align:left; background:url(../images/data_list_tHeadbg.jpg) repeat-y center #B7BDD7">
								<a style="cursor:hand" onClick="addUsers()"><div class="DocumentOper"><img 
											class="operStyle" src="../../sysmanager/images/plan.gif">����û�</div></a>
								</td>
							</tr>

							<TR class="cms_report_tr">
								<td height='30' class="headercolor">
									<strong>ȫѡ</strong>
								</td>
								<td height='30' class="headercolor">
									<strong>ɾ��</strong>
								</td>
								<td height='30' class="headercolor">
									<strong>�û�</strong>
								</td>
								<%
									for(int num=0;num<operList.size();num++){
								%>
									<td class="headercolor" align="center">
										<strong><%=((com.chinacreator.config.model.Operation)operList.get(num)).getName()%></strong>
									</td>
								<%}%>
							</TR>
							<%
						for(int aa=0;aa<users.length;aa++)
						{
							if(users[aa]==null||users[aa].equals(""))
								continue;

							String roleid = users[aa];

							hasOper = operManager.getOperResRoleList(usertypes[aa],roleid,resId2,"site.channel");
							if(hasOper == null){
								hasOper = new ArrayList();
							}
						%>
						<tr class="cms_data_tr" onMouseOver="this.style.background='#E9EDF3'" onMouseOut="this.style.background='#FFFFFF'">
						<td align="center">
							<input type="checkbox" id="<%=aa%>" hideFocus onClick="checkAll(this,1,<%=users.length+roles.length%>,<%=aa%>)"/>
						</td>
						<td align="center">
							<a href="#" onclick="del(<%=users.length+roles.length%>,<%=aa%>)"><u>ɾ��</u></a>
						</td>
						<td align="center">
						<input type="hidden" name="curuserid" value="<%=users[aa]%>"/>
						<%=usernames[aa]%>
						</td>
						
						<pg:list requestKey="operList" needClear="false">
							<td align="center">
							<%
								String rid = rowid;
								String opId = dataSet.getString(Integer.parseInt(rowid),"id");
								
							%>
							<input name="opId<%=idCount+aa%>" type="checkbox"
							<%
								if(AccessControl.isAdmin(userManager.getUserById(users[aa]).getUserName()))
								{
									out.print(" disabled=\"true\" checked ");
								}
								else
								{//System.out.println(resId2+"|"+opId+"|"+resTypeId2);
									if(!accesscontroler.checkPermission(resId2,opId,resTypeId2) 
									|| accesscontroler.getUserID().equals(users[aa]))
									{
										out.print(" disabled=\"true\" ");
									}//System.out.println(" disabled=\"true\" " + users[aa]);
									for(int i = 0; i < hasOper.size(); i ++)
									{
										RoleresopKey id = (RoleresopKey)hasOper.get(i);
										if(id.getOpId().equals(opId) && id.getRoleId().equals(users[aa]))
										{
											out.println(" checked ");
											break;
										}
											
									}
								}
							%>
							value="<%=roleid%>;<pg:cell colName="id"/>" onclick="changebox(this,'<%=idCount+aa%>','<pg:cell colName="priority" defaultValue=""/>','<%=users[aa]%>;<pg:cell colName="id"/>','<%=usertypes[aa]%>','site.channel')">
							<input name="priority<%=idCount+aa%>" value="<pg:cell colName="priority" defaultValue=""/>" type="hidden">
							</td>
						  </pg:list>
						  
					   </tr>
					   <%
						   } 
						   idCount += users.length;//
					   %>
					   <!--��ɫ-->
					   <tr>
							<td height='25' colspan="<%=operList.size()+3%>" background="../images/data_list_tHeadbg.jpg" style="text-align:left; background:url(../images/data_list_tHeadbg.jpg) repeat-y center #B7BDD7">
							<a style="cursor:hand" onClick="addRoles()"><div class="DocumentOper"><img 
										class="operStyle" src="../../sysmanager/images/plan.gif">��ӽ�ɫ</div></a>
							</td>
						</tr>
					   <TR class="cms_report_tr">
							<td height='30' class="headercolor">
								<strong>ȫѡ</strong>
							</td>
							<td height='30' class="headercolor">
								<strong>ɾ��</strong>
							</td>
							<td height='30' class="headercolor">
								<strong>��ɫ</strong>
							</td>
							<%
								for(int num=0;num<operList.size();num++){
							%>
								<td class="headercolor" align="center">
									<strong><%=((com.chinacreator.config.model.Operation)operList.get(num)).getName()%></strong>
								</td>
							<%}%>
							</TR>
							<%
						for(int aa=0;aa<roles.length;aa++)
						{
							if(roles[aa]==null||roles[aa].equals(""))
								continue;

							String roleid = roles[aa];

							hasOper = operManager.getOperResRoleList(roletypes[aa],roleid,resId2,"site.channel");
							if(hasOper == null){
								hasOper = new ArrayList();
							}
						%>
						<tr class="cms_data_tr" onMouseOver="this.style.background='#E9EDF3'" onMouseOut="this.style.background='#FFFFFF'">
						<td align="center">
							<input type="checkbox" id="<%=users.length+aa%>" hideFocus onClick="checkAll(this,1,<%=users.length+roles.length%>,<%=users.length+aa%>)"/>
						</td>
						<td align="center">
							<a href="#" onclick="del(<%=users.length+roles.length%>,<%=users.length+aa%>)"><u>ɾ��</u></a>
						</td>
						<td align="center">
						<input type="hidden" name="curuserid" value="<%=roles[aa]%>"/>
						<%=rolenames[aa]%>
						</td>
						
						<pg:list requestKey="operList" needClear="false">
							<td align="center">
							<%
								String rid = rowid;
								String opId = dataSet.getString(Integer.parseInt(rowid),"id");
								
							%>
							<input name="opId<%=idCount+aa%>" type="checkbox"
							<%
								for(int i = 0; i < hasOper.size(); i ++)
								{
									RoleresopKey id = (RoleresopKey)hasOper.get(i);
									if(id.getOpId().equals(opId) && id.getRoleId().equals(roles[aa]))
									{
										out.println("checked");
										break;
									}
										
								}
							%>
							value="<%=roleid%>;<pg:cell colName="id"/>" onclick="changebox(this,'<%=idCount+aa%>','<pg:cell colName="priority" defaultValue=""/>','<%=roles[aa]%>;<pg:cell colName="id"/>','<%=roletypes[aa]%>','site.channel')">
							<input name="priority<%=idCount+aa%>" value="<pg:cell colName="priority" defaultValue=""/>" type="hidden">
							</td>
						  </pg:list>
						  
					   </tr>
					   <%
						   } 
						   idCount += roles.length;//
					   %>
					  </table>
					</tab:tabPane>
					<tab:tabPane id="res-manager-templat" tabTitle="ģ����Ȩ��">
						<table cellspacing="0" cellpadding="3" border="0" width="100%" class="Datalisttable">
							<%
								operList = resManager.getOperations("sitetpl");
								if (operList == null) {
									operList = new ArrayList();
								}
								request.removeAttribute("operList");
								request.setAttribute("operList", operList);
						    %>
							<TR>
								<td height="30" colspan="<%=operList.size()+3%>" align="center" bgcolor="#ACC1D4" class="authority_title" style="color:#fff">��<%=resTypeName%>��վ��&nbsp;����Ȩ���б�(ֱ��ѡ��ѡ�򼴿ɣ�ϵͳʵʱ����)</td>
							</TR>
							<tr>
								<td height='25' colspan="<%=operList.size()+3%>" background="../images/data_list_tHeadbg.jpg" style="text-align:left; background:url(../images/data_list_tHeadbg.jpg) repeat-y center #B7BDD7">
								<a style="cursor:hand" onClick="addUsers()"><div class="DocumentOper"><img 
											class="operStyle" src="../../sysmanager/images/plan.gif">����û�</div></a>
								</td>
							</tr>

							<TR class="cms_report_tr">
								<td height='30' class="headercolor">
									<strong>ȫѡ</strong>
								</td>
								<td height='30' class="headercolor">
									<strong>ɾ��</strong>
								</td>
								<td height='30' class="headercolor">
									<strong>�û�</strong>
								</td>
								<%
									for(int num=0;num<operList.size();num++){
								%>
									<td class="headercolor" align="center">
										<strong><%=((com.chinacreator.config.model.Operation)operList.get(num)).getName()%></strong>
									</td>
								<%}%>
							</TR>
							<%
						for(int aa=0;aa<users.length;aa++)
						{
							if(users[aa]==null||users[aa].equals(""))
								continue;

							String roleid = users[aa];

							hasOper = operManager.getOperResRoleList(usertypes[aa],roleid,resId2,"sitetpl");
							
							if(hasOper == null){
								hasOper = new ArrayList();
							}
						%>
						<tr class="cms_data_tr" onMouseOver="this.style.background='#E9EDF3'" onMouseOut="this.style.background='#FFFFFF'">
						<td align="center">
							<input type="checkbox" id="<%=aa%>" hideFocus onClick="checkAll(this,2,<%=users.length+roles.length%>,<%=aa%>)"/>
						</td>
						<td align="center">
							<a href="#" onclick="del(<%=users.length+roles.length%>,<%=aa%>)"><u>ɾ��</u></a>
						</td>
						<td align="center">
						<input type="hidden" name="curuserid" value="<%=users[aa]%>"/>
						<%=usernames[aa]%>
						</td>
						
						<pg:list requestKey="operList" needClear="false">
							<td align="center">
							<%
								String rid = rowid;
								String opId = dataSet.getString(Integer.parseInt(rowid),"id");
								
							%>
							<input name="opId<%=idCount+aa%>" type="checkbox" 
							<%
								if(AccessControl.isAdmin(userManager.getUserById(users[aa]).getUserName()))
								{
									out.print(" disabled=\"true\" checked ");
								}
								else
								{//System.out.println(resId2+"|"+opId+"|"+resTypeId2);
									if(!accesscontroler.checkPermission(resId2,opId,resTypeId2) 
									|| accesscontroler.getUserID().equals(users[aa]))
									{
										out.print(" disabled=\"true\" ");
									}//System.out.println(" disabled=\"true\" " + users[aa]);
									for(int i = 0; i < hasOper.size(); i ++)
									{
										RoleresopKey id = (RoleresopKey)hasOper.get(i);
										if(id.getOpId().equals(opId) && id.getRoleId().equals(users[aa]))
										{
											out.println(" checked ");
											break;
										}
											
									}
								}
							%>
							value="<%=roleid%>;<pg:cell colName="id"/>" onclick="changebox(this,'<%=idCount+aa%>','<pg:cell colName="priority" defaultValue=""/>','<%=users[aa]%>;<pg:cell colName="id"/>','<%=usertypes[aa]%>','sitetpl')">
							<input name="priority<%=idCount+aa%>" value="<pg:cell colName="priority" defaultValue=""/>" type="hidden">
							</td>
						  </pg:list>
						  
					   </tr>
					   <%
						   } 
						   idCount += users.length;//
					   %>
					   <!--��ɫ-->
					   <tr>
							<td height='25' colspan="<%=operList.size()+3%>" background="../images/data_list_tHeadbg.jpg" style="text-align:left; background:url(../images/data_list_tHeadbg.jpg) repeat-y center #B7BDD7">
							<a style="cursor:hand" onClick="addRoles()"><div class="DocumentOper"><img 
										class="operStyle" src="../../sysmanager/images/plan.gif">��ӽ�ɫ</div></a>
							</td>
						</tr>
					   <TR class="cms_report_tr">
							<td height='30' class="headercolor">
								<strong>ȫѡ</strong>
							</td>
							<td height='30' class="headercolor">
								<strong>ɾ��</strong>
							</td>
							<td height='30' class="headercolor">
								<strong>��ɫ</strong>
							</td>
							<%
								for(int num=0;num<operList.size();num++){
							%>
								<td class="headercolor" align="center">
									<strong><%=((com.chinacreator.config.model.Operation)operList.get(num)).getName()%></strong>
								</td>
							<%}%>
							</TR>
							<%
						for(int aa=0;aa<roles.length;aa++)
						{
							if(roles[aa]==null||roles[aa].equals(""))
								continue;

							String roleid = roles[aa];

							hasOper = operManager.getOperResRoleList(roletypes[aa],roleid,resId2,"sitetpl");
							if(hasOper == null){
								hasOper = new ArrayList();
							}
						%>
						<tr class="cms_data_tr" onMouseOver="this.style.background='#E9EDF3'" onMouseOut="this.style.background='#FFFFFF'">
						<td align="center">
							<input type="checkbox" id="<%=users.length+aa%>" hideFocus onClick="checkAll(this,2,<%=users.length+roles.length%>,<%=users.length+aa%>)"/>
						</td>
						<td align="center">
							<a href="#" onclick="del(<%=users.length+roles.length%>,<%=users.length+aa%>)"><u>ɾ��</u></a>
						</td>
						<td align="center">
						<input type="hidden" name="curuserid" value="<%=roles[aa]%>"/>
						<%=rolenames[aa]%>
						</td>
						
						<pg:list requestKey="operList" needClear="false">
							<td align="center">
							<%
								String rid = rowid;
								String opId = dataSet.getString(Integer.parseInt(rowid),"id");
								
							%>
							<input name="opId<%=idCount+aa%>" type="checkbox"
							<%
								for(int i = 0; i < hasOper.size(); i ++)
								{
									RoleresopKey id = (RoleresopKey)hasOper.get(i);
									if(id.getOpId().equals(opId) && id.getRoleId().equals(roles[aa]))
									{
										out.println("checked");
										break;
									}
										
								}
							%>
							value="<%=roleid%>;<pg:cell colName="id"/>" onclick="changebox(this,'<%=idCount+aa%>','<pg:cell colName="priority" defaultValue=""/>','<%=roles[aa]%>;<pg:cell colName="id"/>','<%=roletypes[aa]%>','sitetpl')">
							<input name="priority<%=idCount+aa%>" value="<pg:cell colName="priority" defaultValue=""/>" type="hidden">
							</td>
						  </pg:list>
						  
					   </tr>
					   <%
						   } 
						   idCount += roles.length;//
					   %>
					  </table>
					</tab:tabPane>
					<tab:tabPane id="res-manager-tplview" tabTitle="�ĵ���Ȩ��">
						<table cellspacing="0" cellpadding="3" border="0" width="100%" class="Datalisttable">
							<%
								operList = resManager.getOperations("channeldoc");
								if (operList == null) {
									operList = new ArrayList();
								}
								request.removeAttribute("operList");
								request.setAttribute("operList", operList);
						    %>
							<TR>
								<td height="30" colspan="<%=operList.size()+3%>" align="center" bgcolor="#ACC1D4" class="authority_title" style="color:#fff">��<%=resTypeName%>��վ��&nbsp;����Ȩ���б�(ֱ��ѡ��ѡ�򼴿ɣ�ϵͳʵʱ����)</td>
							</TR>
							<tr>
								<td height='25' colspan="<%=operList.size()+3%>" background="../images/data_list_tHeadbg.jpg" style="text-align:left; background:url(../images/data_list_tHeadbg.jpg) repeat-y center #B7BDD7">
								<a style="cursor:hand" onClick="addUsers()"><div class="DocumentOper"><img 
											class="operStyle" src="../../sysmanager/images/plan.gif">����û�</div></a>
								</td>
							</tr>

							<TR class="cms_report_tr">
								<td height='30' class="headercolor">
									<strong>ȫѡ</strong>
								</td>
								<td height='30' class="headercolor">
									<strong>ɾ��</strong>
								</td>
								<td height='30' class="headercolor">
									<strong>�û�</strong>
								</td>
								<%
									for(int num=0;num<operList.size();num++){
								%>
									<td class="headercolor" align="center">
										<strong><%=((com.chinacreator.config.model.Operation)operList.get(num)).getName()%></strong>
									</td>
								<%}%>
							</TR>
							<%
						for(int aa=0;aa<users.length;aa++)
						{
							if(users[aa]==null||users[aa].equals(""))
								continue;

							String roleid = users[aa];

							hasOper = operManager.getOperResRoleList(usertypes[aa],roleid,resId2,"site.doc");
							
							if(hasOper == null){
								hasOper = new ArrayList();
							}
						%>
						<tr class="cms_data_tr" onMouseOver="this.style.background='#E9EDF3'" onMouseOut="this.style.background='#FFFFFF'">
						<td align="center">
							<input type="checkbox" id="<%=aa%>" hideFocus onClick="checkAll(this,3,<%=users.length+roles.length%>,<%=aa%>)"/>
						</td>
						<td align="center">
							<a href="#" onclick="del(<%=users.length+roles.length%>,<%=aa%>)"><u>ɾ��</u></a>
						</td>
						<td align="center">
						<input type="hidden" name="curuserid" value="<%=users[aa]%>"/>
						<%=usernames[aa]%>
						</td>
						
						<pg:list requestKey="operList" needClear="false">
							<td align="center">
							<%
								String rid = rowid;
								String opId = dataSet.getString(Integer.parseInt(rowid),"id");
								
							%>
							<input name="opId<%=idCount+aa%>" type="checkbox"
							<%
								if(AccessControl.isAdmin(userManager.getUserById(users[aa]).getUserName()))
								{
									out.print(" disabled=\"true\" checked ");
								}
								else
								{//System.out.println(resId2+"|"+opId+"|"+resTypeId2);
									if(!accesscontroler.checkPermission(resId2,opId,resTypeId2) 
									|| accesscontroler.getUserID().equals(users[aa]))
									{
										out.print(" disabled=\"true\" ");
									}//System.out.println(" disabled=\"true\" " + users[aa]);
									for(int i = 0; i < hasOper.size(); i ++)
									{
										RoleresopKey id = (RoleresopKey)hasOper.get(i);
										if(id.getOpId().equals(opId) && id.getRoleId().equals(users[aa]))
										{
											out.println(" checked ");
											break;
										}
											
									}
								}
							%>
							value="<%=roleid%>;<pg:cell colName="id"/>" onclick="changebox(this,'<%=idCount+aa%>','<pg:cell colName="priority" defaultValue=""/>','<%=users[aa]%>;<pg:cell colName="id"/>','<%=usertypes[aa]%>','site.doc')">
							<input name="priority<%=idCount+aa%>" value="<pg:cell colName="priority" defaultValue=""/>" type="hidden">
							</td>
						  </pg:list>
						  
					   </tr>
					   <%
						   } 
						   idCount += users.length;//
					   %>
					   <!--��ɫ-->
					   <tr>
							<td height='25' colspan="<%=operList.size()+3%>" background="../images/data_list_tHeadbg.jpg" style="text-align:left; background:url(../images/data_list_tHeadbg.jpg) repeat-y center #B7BDD7">
							<a style="cursor:hand" onClick="addRoles()"><div class="DocumentOper"><img 
										class="operStyle" src="../../sysmanager/images/plan.gif">��ӽ�ɫ</div></a>
							</td>
						</tr>
					   <TR class="cms_report_tr">
							<td height='30' class="headercolor">
								<strong>ȫѡ</strong>
							</td>
							<td height='30' class="headercolor">
								<strong>ɾ��</strong>
							</td>
							<td height='30' class="headercolor">
								<strong>��ɫ</strong>
							</td>
							<%
								for(int num=0;num<operList.size();num++){
							%>
								<td class="headercolor" align="center">
									<strong><%=((com.chinacreator.config.model.Operation)operList.get(num)).getName()%></strong>
								</td>
							<%}%>
							</TR>
							<%
						for(int aa=0;aa<roles.length;aa++)
						{
							if(roles[aa]==null||roles[aa].equals(""))
								continue;

							String roleid = roles[aa];

							hasOper = operManager.getOperResRoleList(roletypes[aa],roleid,resId2,"site.doc");
							if(hasOper == null){
								hasOper = new ArrayList();
							}
						%>
						<tr class="cms_data_tr" onMouseOver="this.style.background='#E9EDF3'" onMouseOut="this.style.background='#FFFFFF'">
						<td align="center">
							<input type="checkbox" id="<%=users.length+aa%>" hideFocus onClick="checkAll(this,3,<%=users.length+roles.length%>,<%=users.length+aa%>)"/>
						</td>
						<td align="center">
							<a href="#" onclick="del(<%=users.length+roles.length%>,<%=users.length+aa%>)"><u>ɾ��</u></a>
						</td>
						<td align="center">
						<input type="hidden" name="curuserid" value="<%=roles[aa]%>"/>
						<%=rolenames[aa]%>
						</td>
						
						<pg:list requestKey="operList" needClear="false">
							<td align="center">
							<%
								String rid = rowid;
								String opId = dataSet.getString(Integer.parseInt(rowid),"id");
								
							%>
							<input name="opId<%=idCount+aa%>" type="checkbox"
							<%
								for(int i = 0; i < hasOper.size(); i ++)
								{
									RoleresopKey id = (RoleresopKey)hasOper.get(i);
									if(id.getOpId().equals(opId) && id.getRoleId().equals(roles[aa]))
									{
										out.println("checked");
										break;
									}
										
								}
							%>
							value="<%=roleid%>;<pg:cell colName="id"/>" onclick="changebox(this,'<%=idCount+aa%>','<pg:cell colName="priority" defaultValue=""/>','<%=roles[aa]%>;<pg:cell colName="id"/>','<%=roletypes[aa]%>','site.doc')">
							<input name="priority<%=idCount+aa%>" value="<pg:cell colName="priority" defaultValue=""/>" type="hidden">
							</td>
						  </pg:list>
						  
					   </tr>
					   <%
						   } 
						   idCount += roles.length;//
					   %>
					  </table>
					</tab:tabPane> 
					<tab:tabPane id="res-manager-tplfile" tabTitle="�ļ���ͼ��Ȩ��">
						<table cellspacing="0" cellpadding="3" border="0" width="100%" class="Datalisttable">
							<%
								operList = resManager.getOperations("sitefile");
								if (operList == null) {
									operList = new ArrayList();
								}
								request.removeAttribute("operList");
								request.setAttribute("operList", operList);
						    %>
							<TR>
								<td height="30" colspan="<%=operList.size()+3%>" align="center" bgcolor="#ACC1D4" class="authority_title" style="color:#fff">��<%=resTypeName%>��վ��&nbsp;����Ȩ���б�(ֱ��ѡ��ѡ�򼴿ɣ�ϵͳʵʱ����)</td>
							</TR>
							<tr>
								<td height='25' colspan="<%=operList.size()+3%>" background="../images/data_list_tHeadbg.jpg" style="text-align:left; background:url(../images/data_list_tHeadbg.jpg) repeat-y center #B7BDD7">
								<a style="cursor:hand" onClick="addUsers()"><div class="DocumentOper"><img 
											class="operStyle" src="../../sysmanager/images/plan.gif">����û�</div></a>
								</td>
							</tr>

							<TR class="cms_report_tr">
								<td height='30' class="headercolor">
								<strong>ȫѡ</strong>
							</td>
							<td height='30' class="headercolor">
								<strong>ɾ��</strong>
							</td>
								<td height='30' class="headercolor">
									<strong>�û�</strong>
								</td>
								<%
									for(int num=0;num<operList.size();num++){
								%>
									<td class="headercolor" align="center">
										<strong><%=((com.chinacreator.config.model.Operation)operList.get(num)).getName()%></strong>
									</td>
								<%}%>
							</TR>
							<%
						for(int aa=0;aa<users.length;aa++)
						{
							if(users[aa]==null||users[aa].equals(""))
								continue;

							String roleid = users[aa];

							hasOper = operManager.getOperResRoleList(usertypes[aa],roleid,resId2,"sitefile");
							
							if(hasOper == null){
								hasOper = new ArrayList();
							}
						%>
						<tr class="cms_data_tr" onMouseOver="this.style.background='#E9EDF3'" onMouseOut="this.style.background='#FFFFFF'">
						<td align="center">
							<input type="checkbox" id="<%=aa%>" hideFocus onClick="checkAll(this,4,<%=users.length+roles.length%>,<%=aa%>)"/>
						</td>
						<td align="center">
							<a href="#" onclick="del(<%=users.length+roles.length%>,<%=aa%>)"><u>ɾ��</u></a>
						</td>
						<td align="center">
						<input type="hidden" name="curuserid" value="<%=users[aa]%>"/>
						<%=usernames[aa]%>
						</td>
						
						<pg:list requestKey="operList" needClear="false">
							<td align="center">
							<%
								String rid = rowid;
								String opId = dataSet.getString(Integer.parseInt(rowid),"id");
								
							%>
							<input name="opId<%=idCount+aa%>" type="checkbox"
							<%
								if(AccessControl.isAdmin(userManager.getUserById(users[aa]).getUserName()))
								{
									out.print(" disabled=\"true\" checked ");
								}
								else
								{//System.out.println(resId2+"|"+opId+"|"+resTypeId2);
									if(!accesscontroler.checkPermission(resId2,opId,resTypeId2) 
									|| accesscontroler.getUserID().equals(users[aa]))
									{
										out.print(" disabled=\"true\" ");
									}//System.out.println(" disabled=\"true\" " + users[aa]);
									for(int i = 0; i < hasOper.size(); i ++)
									{
										RoleresopKey id = (RoleresopKey)hasOper.get(i);
										if(id.getOpId().equals(opId) && id.getRoleId().equals(users[aa]))
										{
											out.println(" checked ");
											break;
										}
											
									}
								}
							%>
							value="<%=roleid%>;<pg:cell colName="id"/>" onclick="changebox(this,'<%=idCount+aa%>','<pg:cell colName="priority" defaultValue=""/>','<%=users[aa]%>;<pg:cell colName="id"/>','<%=usertypes[aa]%>','sitefile')">
							<input name="priority<%=idCount+aa%>" value="<pg:cell colName="priority" defaultValue=""/>" type="hidden">
							</td>
						  </pg:list>
						  
					   </tr>
					   <%
						   } 
						   idCount += users.length;//
					   %>
					   <!--��ɫ-->
					   <tr>
							<td height='25' colspan="<%=operList.size()+3%>" background="../images/data_list_tHeadbg.jpg" style="text-align:left; background:url(../images/data_list_tHeadbg.jpg) repeat-y center #B7BDD7">
							<a style="cursor:hand" onClick="addRoles()"><div class="DocumentOper"><img 
										class="operStyle" src="../../sysmanager/images/plan.gif">��ӽ�ɫ</div></a>
							</td>
						</tr>
					   <TR class="cms_report_tr">
							<td height='30' class="headercolor">
								<strong>ȫѡ</strong>
							</td>
							<td height='30' class="headercolor">
								<strong>ɾ��</strong>
							</td>
							<td height='30' class="headercolor">
								<strong>��ɫ</strong>
							</td>
							<%
								for(int num=0;num<operList.size();num++){
							%>
								<td class="headercolor" align="center">
									<strong><%=((com.chinacreator.config.model.Operation)operList.get(num)).getName()%></strong>
								</td>
							<%}%>
							</TR>
							<%
						for(int aa=0;aa<roles.length;aa++)
						{
							if(roles[aa]==null||roles[aa].equals(""))
								continue;

							String roleid = roles[aa];

							hasOper = operManager.getOperResRoleList(roletypes[aa],roleid,resId2,"sitefile");
							if(hasOper == null){
								hasOper = new ArrayList();
							}
						%>
						<tr class="cms_data_tr" onMouseOver="this.style.background='#E9EDF3'" onMouseOut="this.style.background='#FFFFFF'">
						<td align="center">
							<input type="checkbox" id="<%=users.length+aa%>" hideFocus onClick="checkAll(this,4,<%=users.length+roles.length%>,<%=users.length+aa%>)"/>
						</td>
						<td align="center">
							<a href="#" onclick="del(<%=users.length+roles.length%>,<%=users.length+aa%>)"><u>ɾ��</u></a>
						</td>
						<td align="center">
						<input type="hidden" name="curuserid" value="<%=roles[aa]%>"/>
						<%=rolenames[aa]%>
						</td>
						
						<pg:list requestKey="operList" needClear="false">
							<td align="center">
							<%
								String rid = rowid;
								String opId = dataSet.getString(Integer.parseInt(rowid),"id");
								
							%>
							<input name="opId<%=idCount+aa%>" type="checkbox"
							<%
								for(int i = 0; i < hasOper.size(); i ++)
								{
									RoleresopKey id = (RoleresopKey)hasOper.get(i);
									if(id.getOpId().equals(opId) && id.getRoleId().equals(roles[aa]))
									{
										out.println("checked");
										break;
									}
										
								}
							%>
							value="<%=roleid%>;<pg:cell colName="id"/>" onclick="changebox(this,'<%=idCount+aa%>','<pg:cell colName="priority" defaultValue=""/>','<%=roles[aa]%>;<pg:cell colName="id"/>','<%=roletypes[aa]%>','sitefile')">
							<input name="priority<%=idCount+aa%>" value="<pg:cell colName="priority" defaultValue=""/>" type="hidden">
							</td>
						  </pg:list>
						  
					   </tr>
					   <%}%>
					  </table>
					</tab:tabPane>
				</tab:tabContainer>
			</FORM>
		</div>
	</body>
</html>
