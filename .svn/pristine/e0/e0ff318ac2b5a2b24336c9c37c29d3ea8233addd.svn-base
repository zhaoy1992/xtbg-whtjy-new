<%
/*
 * <p>Title: 机构下的用户的操作主页面</p>
 * <p>Description: 机构下的用户的操作主页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-20
 * @author liangbing.tao
 * @version 1.0
 */
%>
 
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>
<%@ page import="com.chinacreator.resource.ResourceManager"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>

<%
	
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	
	String path = request.getContextPath();
	ResourceManager resManager = new ResourceManager();
    String resId = resManager.getGlobalResourceid(AccessControl.ORGUNIT_RESOURCE);
	String curOrgId = request.getParameter("orgId");
	
	if(curOrgId == null)
	{
		curOrgId = (String)request.getAttribute("orgId");
	}
	
	String reFlush = "false";
	if (request.getAttribute("reFlush") != null) 
	{
		reFlush = "true";
	}
	
	String userNamesNo = String.valueOf(session.getAttribute("promptString"));
	session.removeAttribute("promptString");
	//System.out.println(userNamesNo);
	Integer currUserId = (Integer)session.getAttribute("currUserId");
	
	if(currUserId == null)
	{
		currUserId = Integer.valueOf("-1");
	}
	
	
	String desc = (String)request.getParameter("pager.desc");	
	String intervalType = (String)request.getParameter("intervalType");
	String taxmanager = (String)request.getParameter("taxmanager");
	String ischecked="";
	
	if((String)request.getAttribute("ischecked")==null)
	{
		ischecked ="";
	}
	else
	{
		ischecked =(String)request.getAttribute("ischecked");
	}
	
	//岗位操作开关
	boolean isJobOpen = ConfigManager.getInstance().getConfigBooleanValue("enablejobfunction", false);
	
	//是否出现  "是否税管员" 复选框
	boolean istaxmanager = ConfigManager.getInstance().getConfigBooleanValue("istaxmanager", false);
	
	// 判断是否平台
	boolean isEgp = accesscontroler.getCurrentSystemID().equals("module")?true:false; 
	
	//是否允许用户存在多个机构下
	boolean isUserOrgs = ConfigManager.getInstance().getConfigBooleanValue("sys.user.enablemutiorg", false);

  	//判断是否禁用机构用户增删改菜单开关
  	//minghua.guo[2010-12-13]
  	boolean orguser_modify_forbidden = ConfigManager.getInstance().getConfigBooleanValue("orguser.modify.forbidden",false);
  	
  	// 应用下是否有新增、编辑用户功能
  	// 彭盛 2011-10-25
  	boolean isappnewuser = ConfigManager.getInstance().getConfigBooleanValue("orguser.isappnewuser",false);
%>
<html>
	<head>
		<title>属性容器</title>
		<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
		<script language="JavaScript" src="../../scripts/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../../scripts/pager.js" type="text/javascript"></script>
		<script language="javascript">
			var featrue = "dialogWidth=600px;dialogHeight=500px;scroll=yes;status=no;titlebar=no;toolbar=no;maximize=yes;minimize=0;help=0;dialogLeft="+(screen.availWidth-600)/2+";dialogTop="+(screen.availHeight-500)/2;
			var win;
			var isSucceed = '<%=request.getParameter("isSucceed")%>';
			var delSucceed = '<%=request.getParameter("delSucceed")%>';
			var isMain = '<%=request.getParameter("isMain")%>';
			var isRes = '<%=request.getParameter("isRes")%>';
			var istaxmanager = '<%=request.getParameter("istaxmanager")%>';
			var taxmanagerName = '<%=request.getParameter("taxmanagerName")%>';
			var userNamesNo = '<%=userNamesNo%>';
			
			//提示新增用户是否成功
			if(isSucceed=="1")
			{
				alert("新增用户成功！");
				var str = document.location.href;
				parent.window.document.location.href = str.substring(0,str.indexOf("isSucceed"));
			}
			
			//提示移除（删除）用户是否成功
			if(delSucceed=="2")
			{
				if(userNamesNo != "" && userNamesNo != "null"){
					alert("以下用户删除失败: \n"+userNamesNo);
				}
				else
				{
					alert("操作成功！");
				}
				var str = document.location.href;
				parent.window.document.location.href = str.substring(0,str.indexOf("delSucceed"));
			}
			
			//税管员提示
			if(istaxmanager=="true")
			{
				alert("用户"+taxmanagerName+"为税管员不能删除！");
			}
			
			//主机构
			if(isMain=="main")
			{
				alert('移除不成功！当前机构是用户(<%=request.getParameter("userNameMain")%>)的主机构，当用户还有其他隶属机构时不能从当前主机构中移除，必须为用户指定一个主机构（选择隶属机构指定主机构）！');
			}
			
			
			var reFlush = "<%=reFlush%>";
			var isSelf = "<%=request.getParameter("isSelf")%>";
			
			if(isSelf == "true")
			{
				alert("不能移除自己与系统管理员！");
			}
			
			function getUserInfo(e,userId)
			{
				
			}
			
			function dealRecord(dealType) 
			{
			    var isSelect = false;
			    var outMsg;
				    
			    for (var i=0;i<userList.elements.length;i++) 
			    {
					var e = userList.elements[i];	
					if (e.name == 'checkBoxOne')
					{
						if (e.checked)
						{
				       		isSelect=true;
				       		break;
					    }
					}
			    }
			    
			    if (isSelect)
			    {
			    	if (dealType==1)
			    	{
			    		<%
			    			if(ConfigManager.getInstance().getConfigBooleanValue("sys.user.enablemutiorg", true))
			    			{
			    		%>
			    			outMsg = "您确认移除吗？（移除后该用户在没有其他隶属机构的情况下将做为离散用户管理）";
			    			
			        			if (confirm(outMsg))
			        			{
									userList.action="../user/userManager.do?orgId=<%=curOrgId%>&method=deleteUser&flag=3&isRes=2";
									//userList.action="../user/userList.jsp?flag=3";
									userList.target = "deluser";
									userList.submit();
						 			return true;
								}
						<%
							}
							else
							{
						%>
						
								if(confirm("您确认移除吗？"))
								{
									outMsg = "该用户将变为离散用户，选择'确定'：用户拥有的角色，用户拥有的资源，用户所属的组关系，该用户的部门管理员角色、用户可管理的机构关系将被删除；选择'取消'将保留用户拥有的角色，用户拥有的资源，用户所属的组关系。而用户的部门管理员角色、用户可管理的机构关系将被删除。";
					        		if (confirm(outMsg))
					        		{
										userList.action="../user/userManager.do?orgId=<%=curOrgId%>&method=deleteUser&flag=3&isRes=3";
										//userList.action="../user/userList.jsp?flag=3";
										userList.target = "deluser";
										userList.submit();
							 			return true;
									}
									else
									{
										userList.action="../user/userManager.do?orgId=<%=curOrgId%>&method=deleteUser&flag=3&isRes=2";
										//userList.action="../user/userList.jsp?flag=3";
										userList.target = "deluser";
										userList.submit();
							 			return true;
									}
								}
						<%
							}
						%>
					} 
					if (dealType==2)//彻底删除用户,da.wei
					{
						outMsg = "您确认删除吗？（删除后该用户将不存在！）";
			        	if (confirm(outMsg))
			        	{
							userList.action="../user/userManager.do?orgId=<%=curOrgId%>&method=deleteUser&flag=3&isRes=4";
							userList.target = "deluser";
							userList.submit();
				 			return true;
						}			
					}
			    }
			    else
			    {
			    	alert("至少要选择一条记录！");
			    	return false;
			    }
				return false;
			}
			
			function roleUser(type) 
			{
				var checks = "";
			    var arr = new Array();
			    arr = document.frames[0].document.getElementsByName("checkBoxOne");
			    var count = 0;
			    for(var i = 0; i < arr.length; i++)
			    {
			    	if(arr[i].checked)
			    	{
			    		if(checks=="")
			    		{
			    			checks = arr[i].value;
			    		}
			    		else
			    		{
			    			checks += "," + arr[i].value;
			    		}
			    		count++;
			    	}
			    }
			    //if(count < 2){
			    //	alert("");
			    //}
			    var winRole;
			    if(checks.split(",").length > 1)
			    {
			    	if (type==1)
			    	{
			    		userList.target = "deluser";
			    		var url = "../user/alotUserRole.jsp?orgId=<%=curOrgId%>&checks="+checks;
			    		winRole = window.showModalDialog(url,window,"dialogWidth:"+(850)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no");
			    		if(winRole=="ok")
			    		{
			    			window.location.reload();
			    		}
					} 
			    }
			    else
			    {
			    	alert("至少要选择两条记录！");
			    	return false;
			    }
				return false;
			}
				
			function sortBy(byName)
			{
				var desc = "false";
			
				if ( "<%=desc%>"  == desc ) desc = "true";
				userList.action="../user/userList.jsp?orgId=<%=curOrgId%>&pager.offset=0&pager.sortKey="+byName+"&pager.desc="+desc;
				userList.submit();
			}
				
			function actionOnmouseover(e)
			{	
				e.style.backgroundColor = "#8080FF";
			}
			
			function actionOnmouseup(e)
			{
				e.style.backgroundColor = "#BEC0C2";
			}
			
			function newUser()
			{
				var winuser;
				var urlnewUser = "../user/userInfo.jsp?orgId=<%=curOrgId%>&isNewUser=true";
				winuser = window.showModalDialog(urlnewUser,window,"dialogWidth:"+(850)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0");
				if(winuser=="ok")
				{
					window.location.reload();
				}
			}
			
			function queryUser()
			{	
				var intervalType = document.all("intervalType").value;
				var userName = document.all("userName").value;
				var userRealname = document.all("userRealname").value;
				var userIsvalid = document.all("userIsvalid").value;
				var userSex = document.all("userSex").value;
				var taxmanager = document.all("taxmanager").value;
				var userType = document.all("userType").value;
				var isOrgManager = "";
				if("true"=="<%=isEgp%>"){				
					if(document.all("isOrgManager").checked)
					{
						isOrgManager = "orgManager";
					}
				}
				var tablesFrame = document.getElementsByName("orgUserList");
			
				tablesFrame[0].src = "org_userlistIframe.jsp?orgId=<%=curOrgId%>&intervalType="+intervalType+"&userSex="+userSex
								+"&userRealname="+userRealname+"&userName="+userName+"&userIsvalid="+userIsvalid+"&taxmanager="+taxmanager+"&isOrgManager="+isOrgManager+"&userType="+userType;
				//userList.action="org_userlist.jsp?orgId=<%=curOrgId%>&intervalType="+intervalType;
				//userList.submit();	
			}
			function querytype(e){
			    queryUser();
			}
			
			function advQueryUser()
			{	
				history.back();	
			}
			
			//批量岗位授予
			function jobUser(type) 
			{
			    var arr = new Array();
			    arr = document.frames[0].document.getElementsByName("checkBoxOne");
			    var checks = "";
				var count = 0;
				
			    for(var i = 0; i < arr.length; i++)
			    {
			    	if(arr[i].checked)
			    	{
			    		if(checks=="")
			    		{
			    			checks = arr[i].value;
			    		}
			    		else
			    		{
			    			checks += "," + arr[i].value;
			    		}
			    	}
			    }
			    
			    var winjob;
			    if(checks.split(",").length > 1)
			    {
			    	if(type==1)
			    	{
				    	var url = "../user/allJobFrame.jsp?orgId=<%=curOrgId%>&checks="+checks;
				    	winjob = window.showModalDialog(url,window,"dialogWidth:"+(850)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0");
						if(winjob=="ok")
						{
							window.location.reload();
						}
				    } 
			    }
			    else
			    {
			    	alert("至少要选择两条记录！");
			    	return false;
			    }
				return false;
			}
			
			//批量机构授予
			function orgUser(type) 
			{
			        var isSelect = false;
				    var outMsg;
					var userList = document.userList; 
					
					//选择两个或更多的用户进行批量处理,da.wei
					var count = 0;
					for (var j=0;j<userList.elements.length;j++)
					{
						if(userList.elements[j].checked)
						{
							count++;
						}
					}
					if(count<2)
					{
						alert("请选择两个或更多的用户进行批量处理!");
						return;
					}
					   
				    for (var i=0;i<userList.elements.length;i++) 
				    {
						var e = userList.elements[i];
							
						if (e.name == 'checkBoxOne')
						{
							if (e.checked)
							{
					       		isSelect=true;
					       		break;
						    }
						}
				    }
				    if (isSelect)
				    {
				    	if (type==1)
				    	{
				    		    userList.action="../user/userOrg.do?orgId=<%=curOrgId%>&method=getAllOrgList";
				    		    userList.submit();
							    return true;
						} 
				    }
				    else
				    {
				    	alert("至少要选择一条记录！");
				    	return false;
				    }
					return false;
			}
			//批量资源操作授予
			function operUser(type) 
			{
			    var arr = new Array();
			    arr = document.frames[0].document.getElementsByName("checkBoxOne");
			    var checks = "";
			    var count = 0;
			    for(var i = 0; i < arr.length; i++)
			    {
			    	if(arr[i].checked)
			    	{
			    		if(checks == "")
			    		{
			    			checks = arr[i].value;
			    		}
			    		else
			    		{
			    			checks += "," + arr[i].value;
			    		}
			    		count++;
			    	}
			    }
			    var winRes;
			    if(checks.split(",").length > 1)
			    {
			    	if (type==1)
			    	{   
			    		var url = "../../grantmanager/userBatch_resFrame.jsp?orgId=<%=curOrgId%>&checks="+checks;
			    		//window.open(url);
						winRes = window.showModalDialog(url,window,"dialogWidth:"+screen.availWidth+";dialogHeight:"+screen.availHeight+";help:no;scroll:auto;status:no;maximize=yes;minimize=0");
						if(winRes=="ok")
						{
							window.location.reload();
						}
						queryUser();
					} 
			    }
			    else
			    {
			    	alert("至少要选择两条记录！");
			    	return false;
			    }
				return false;
			}
			
			//批量用户权限回收
			function purviewReclaimUsers()
			{
			    var arr = new Array();
			    arr = document.frames[0].document.getElementsByName("checkBoxOne");
			    var checks = "";
			    var count = 0;
			    for(var i = 0; i < arr.length; i++)
			    {
			    	if(arr[i].checked)
			    	{
			    		if(checks == "")
			    		{
			    			checks = arr[i].value;
			    		}
			    		else
			    		{
			    			checks += "," + arr[i].value;
			    		}
			    		count++;
			    	}
			    }
			    var winRes;
			    if(checks.split(",").length > 1)
			    {    	
					var url = "../../reclaimManager/reclaimUserRes.jsp?userIds="+checks+"&&orgId=<%=curOrgId%>";
					//window.open(url);
					winRes = window.showModalDialog(url,window,"dialogWidth:"+(400)+"px;dialogHeight:"+(300)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0");
					if(winRes=="ok")
					{
						queryUser();
					}
					queryUser();
					 
			    }
			    else
			    {
			    	alert("至少要选择两条记录！");
			    	return false;
			    }
				return false;
			}
			//var winOpen
			function orderUser()
			{
				var winOpen;
				winOpen = window.showModalDialog("../user/user_order_ajax.jsp?orgId=<%=curOrgId%>",window,"dialogWidth:"+(616)+"px;dialogHeight:"+(500)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0");
				if(winOpen=="ok")
				{
					queryUser();
					//window.location.href = window.location.href;
				}
			}
			
			var timer;
			function isClosed()
			{
			    if(winOpen.closed==true)
			    {
			        window.location.href = window.location;
			        window.clearInterval(timer);
			    }
			}
			
			function foldUser()
			{
				var win;
				//调入用户
				var url = "folduser_frame.jsp?orgId=<%=curOrgId%>";
				var stylee = "dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0";
				//window.open(url);
				win = window.showModalDialog(url,window,stylee);
				if(win=="ok"){
					window.location.reload();
				}
			}
			
			function addorg(dealType) 
			{
			    var outMsg;
			    var checks = "";
			    var state = false;
			    var obj = document.frames[0].document.getElementsByName("checkBoxOne");
			    if(obj.length==0)
			    {
			    	alert("没有可调出的用户！");
			    	return;
			    }
			    for(var j=0; j < obj.length; j++)
			    {
			    	if(obj[j].checked)
			    	{
			    		if(state)
			    		{
			    			checks += ","+obj[j].value;
			    		}
			    		else
			    		{
			    			checks = "" + obj[j].value;
			    			state = true;
			    		}
			    	}
			    }
			    if(checks != "")
			    {
				    if(dealType==1)
				    {
						var winaddorg;
						var url = "userChangeOrg.jsp?checkBoxOne="+checks + "&orgId=<%=curOrgId%>";
						winaddorg = window.showModalDialog(url,window,"dialogWidth:"+(400)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0");
						if(winaddorg=="ok")
						{
							window.location.reload();
						}
					}
				}
				else
				{
			    	alert("至少要选择一条记录！");
			    	return false;
			    }
				return false;
			}
			
			//彻底删除用户
			function quiteDelUser()
			{
				var arr = new Array();
				var arr = document.frames[0].document.getElementsByName("checkBoxOne");
				var checks = "";
				for(var i = 0; i < arr.length; i++)
				{
					if(arr[i].checked)
					{
						if(checks == "")
						{
							checks = arr[i].value;
						}else{
							checks += "," + arr[i].value;
						}
					}
				}
				
				if(checks == "")
				{
					alert("请选择要删除的用户！");
					return false;
				}
				else
				{
					outMsg = "您确认删除吗？（删除后该用户将不存在！）";
			        if (confirm(outMsg))
			        {
						document.userList.target = "deluser";
						document.userList.action = "../user/quiteDelUser.jsp?checks="+checks+"&orgId=<%=curOrgId%>";
						win = window.showModelessDialog("<%=path%>/purviewmanager/common/doing.jsp","",featrue);
						document.userList.submit();
					}
				}
			}
			
			function userResList(userId)
			{
				var typeName = "USER";
				window.showModalDialog("/sysmanager/user/userres_queryframe.jsp?orgId=<%=curOrgId%>&userId="+ userId+"&typeName="+typeName,"","dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0");
			}		
			</SCRIPT>		
			<%@ include file="/epp/css/cssControl.jsp"%><body  >
				<form name="userList" method="post" onkeydown="if(event.keyCode==13)queryUser();">
				<input type="hidden" name="orgId" value="<%=curOrgId%>"/>
					<table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% class="thin">
         				<tr style="align:left">
         					<td height='40' style="align:left" colspan=8>
         					<div align="left">
         					<%
         						if(isEgp){
         						//判断是否禁用机构用户增删改菜单开关
	         				  	//minghua.guo[2010-12-13]
         						if(!orguser_modify_forbidden && accesscontroler.checkPermission("orgunit",
			                         		"newdeluser", AccessControl.ORGUNIT_RESOURCE)){
         					%>
         						<a href="#" onClick="newUser()"><u>新增用户</u></a> |
         						<a href="#" onClick="quiteDelUser()"><u>删除用户</u></a> | 
         					<%
         						}
         					%>        						
								<a href="#" onClick="orderUser()"><u>用户排序</u></a> 	|
							<%
         						//判断是否禁用机构用户增删改菜单开关
	         				  	//minghua.guo[2010-12-13]
         						if(!orguser_modify_forbidden && accesscontroler.checkPermission("orgunit",
			                         		"usermanager", AccessControl.ORGUNIT_RESOURCE)&&isUserOrgs){
         					%>							
								<%--<a href="#" onClick="foldUser()"><u>用户调入</u></a> |--%>
								<%-- <a href="#" onClick="addorg(1)"><u>用户调出</u></a> |--%>
							<%
								}
							%>
								
								<%}else{ 
									// 应用下是否有新增、编辑用户功能
									if(isappnewuser && accesscontroler.checkPermission("orgunit",
			                         		"newdeluser", AccessControl.ORGUNIT_RESOURCE)){
								%>
								<a href="#" onClick="newUser()"><u>新增用户</u></a> |
								<%	
								}
								%>
								<a href="#" onClick="roleUser(1)"><u>批量角色授予</u></a> | 
								<%if(isJobOpen){ %>
								<a href="#" onClick="jobUser(1)"><u>批量岗位授予</u></a> |
								<% }%>
							<%
         						if(accesscontroler.checkPermission("orgunit",
			                         		"purset", AccessControl.ORGUNIT_RESOURCE)){
         					%>	
								<a href="#" onClick="operUser(1)"><u>批量权限授予</u></a> |
								<a href="#" onClick="purviewReclaimUsers()"><u>批量权限回收</u></a>	
							<%
								}}
							%>				 							
							</div>
							</td>
						</tr>
         				<tr>
           				    <td width="12%">
           				    	<div align="center">
           				    		登陆名称：
           				    		<input type="text" name="userName" size="17">
           				    	</div>
           				    </td>
           				    <td width="12%">
           				    	<div align="center">
           				    		用户实名：
           				    		<input type="text" name="userRealname" size="17">
           				    	</div>
           				    </td>
           				    <td width="12%">
           				    	<div align="center">
           				    		用户类型：
           				    		
	           				    	<dict:select textValue="------请选择------" type="userType" 
	           				    					name="userType" expression="{userType}"/>
								</div>
           				    </td>
           				</tr>
           				<tr>
           				    <td width="12%">
           				    	<div align="center">
           				    		用户性别：
	           				    	<dict:select textValue="------请选择------" type="sex" name="userSex" expression="{userSex}"/>
								</div>
           				    </td>
							<td width="12%">
           				    	<div align="center">
           				    		当前状态：
           				    		<dict:select textValue="------请选择------" type="isvalid" name="userIsvalid" expression="{user_isvalid}"  />
           				    	</div>
           				    </td>
           				    <td width="12%">
           				    	<div align="center">
           				    	
           				    		查询方式：
	           				    	<select name="intervalType" class="select"> 
           								<option value="0" selected>不递归机构查询</option>          						
           								<option value="1">递归机构查询</option>
								    </select>
								</div>
           				    </td>
           				</tr>
           				<tr>
						<tr>
           					<td width="12%">
           						<!--
           							增加用户类型的查询
           							liangbing.tao
           							2008-5-27
           						-->
           						<% 
           						if(istaxmanager){
           						%>
           						<div align="center">
           				    		税管人员：
	           				    	<select name="taxmanager" class="select">
           							<option value="2" selected>-------请选择-------</option>
           							<option value="1">税管员</option>
           							<option value="0">非税管员</option>
           						  </select>
								</div>
           				    	<% 
           				    	}else{
           				    	%>
           				    	<input type="hidden" name="taxmanager" value="2">
           				    	<% 
           				    	}
           				    	%>
           				    </td>
           				    
							<td colspan="5" align="right">
								<%if(!isEgp){ %>
								<input type="checkbox" name="isOrgManager" value="on" />
								<STRONG>管理员查询</STRONG>
								<%}else{ %>
								<div style="display: none;"><input type="checkbox" name="isOrgManager" value="on" /></div>
								<%} %>
								&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
           				    	<input name="search" type="button" class="input" value="查询" onClick="queryUser()">&nbsp;&nbsp;
           				    	<input name="searchReset" type="button" class="input" value="清空" onClick="userList.reset()">
           				    </td>
						</tr>
						</tr>
         			</table>
         			<table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% class="thin" height="70%">
         				<tr>
         					<td><br><iframe name="orgUserList" src="org_userlistIframe.jsp?orgId=<%=curOrgId%>" style="width:100%" height="100%" scrolling="auto" frameborder="0" marginwidth="1" marginheight="1"></iframe>
         					<br></td>
         				</tr>
				  	</table>
				</form>
				
				<form name="form2" method="POST"></form>
			<iframe name="deluser" height="0" width="0"></iframe>
	</body>
</html>