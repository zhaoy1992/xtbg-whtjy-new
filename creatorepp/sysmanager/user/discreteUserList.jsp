<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>

<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.resource.ResourceManager,
				 com.chinacreator.sysmgrcore.manager.UserManager,
				 com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenuTag"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenu"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenuImpl"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.Menu"%>
<%
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkAccess(pageContext); 

	Integer currUserId = (Integer)session.getAttribute("currUserId");
	if(currUserId == null){
		currUserId = Integer.valueOf("-1");
	}
	String desc = (String)request.getParameter("pager.desc");
	String curOrgId = (String)session.getAttribute("orgId");
	
	String QueryuserName = null;
	String QueryuserRealname = null;
	if(request.getParameter("userName")==null){
		QueryuserName = "";
	}else{
		QueryuserName = request.getParameter("userName");
	}
	if(request.getParameter("userRealname")==null){
		QueryuserRealname = "";
	}else{
		QueryuserRealname = request.getParameter("userRealname");
	}

    ResourceManager resManager = new ResourceManager();
    String resId = resManager.getGlobalResourceid(AccessControl.ORGUNIT_RESOURCE);
%>
<html>
	<head>
		<title>��������</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		
<script language="JavaScript" src="common.js" type="text/javascript"></script>
<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
<SCRIPT language="Javascript">
var isSucceed = <%=request.getParameter("delSucceed")%>;
if(isSucceed=="3"){
	alert("ɾ���û��ɹ���");
	var str = document.location.href;
	parent.window.document.location.href = str.substring(0,str.indexOf("delSucceed"));
}
</SCRIPT>
<SCRIPT language="javascript">	
var jsAccessControl = new JSAccessControl("#DAE0E9","#F6F8FB","#F6F8FB");
var isAdmin = "<%=request.getParameter("isAdmin")%>";
if(isAdmin == "true")
{
	alert("����ɾ��ϵͳ����Ա��");
}

function getUserInfo(e,userId,qstring)
{
	if (jsAccessControl.setBackColor(e))
	{		
		getPropertiesToolbar().location.href="discreteUser.jsp?userId="+userId+"&qstring="+qstring;
	}
}

function dealRecord(dealType) {
    var isSelect = false;
    var outMsg;
    var obj=document.getElementsByName("checkBoxOne");
	if(obj.length==0){
		alert("û�п�ɾ�����û���");
		return;
	}   
    for (var i=0;i<userList.elements.length;i++) {
		var e = userList.elements[i];
			
		if (e.name == 'checkBoxOne'){
			if (e.checked){
	       		isSelect=true;
	       		break;
		    }
		}
    }
    if (isSelect){
    	if (dealType==1){
    		outMsg = "��ȷ��Ҫɾ����(ɾ�����ǲ������ٻָ���)��";
        	if (confirm(outMsg)){
				userList.action="../user/userManager.do?method=deleteUser&disuser=1&delSucceed=3";
				userList.target="delDisperse";
				userList.submit();
	 			return true;
			}
		} 
    }else{
    	alert("����Ҫѡ��һ����¼��");
    	return false;
    }
	return false;
}
	

function actionOnmouseover(e){	
	e.style.backgroundColor = "#8080FF";
}

function actionOnmouseup(e){
	e.style.backgroundColor = "#BEC0C2";
}


function queryUser()
{	
	//if(document.userList.userName.value.length < 1 && document.userList.userRealname.value.length < 1){
	//	alert("�û����ƺ��û�ʵ����������һ��!!!");
	//	return;
	//}
	userList.action="../user/discreteUserList.jsp"
	userList.submit();	
}

//�����������
function addorg(dealType) {
    var isSelect = false;
    var outMsg;
    var checks;
    var state = false;
    var obj = document.getElementsByName("checkBoxOne");
    if(obj.length==0){
    	alert("û�пɵ�����û���");
    	return;
    }
    for(var j=0; j < obj.length; j++){
    	if(obj[j].checked){
    		if(state){
    			checks += ","+obj[j].value;
    		}else{
    			checks = "" + obj[j].value;
    			state = true;
    		}
    	}
    }
    for (var i=0;i<userList.elements.length;i++) {
		var e = userList.elements[i];	
		if (e.name == 'checkBoxOne'){
			if (e.checked){
	       		isSelect=true;
	       		break;
		    }
		}
    }
    if (isSelect){
    	if (dealType==1){
    		if(checks != ""){
				//userList.action="../user/userManager.do?method=addAllOrg";
				var winaddorg;
				var url = "../user/allorg2discrete.jsp?checkBoxOne="+checks;
				//window.open(url);
				winaddorg = window.showModalDialog(url,window,"dialogWidth:"+(400)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no");
				if(winaddorg=="ok"){
					window.location.reload();
				}
				//userList.submit();
	 			//return true;
 			}else{
 				alert("û��Ҫ������û���");
 				return;
 			}
		} 
    }else{
    	alert("����Ҫѡ��һ����¼��");
    	return false;
    }
	return false;
}

<!-- gao.tang 2007.11.05 start �Ҽ��˵���ת·��  -->
function userInfo(userId){ 
	//�û�������Ϣ userInfo3.jsp
	var winbasic;
	var url="../user/userManager.do?method=getUser&dUserInfo=1&userId="+userId;
	winbasic = window.showModalDialog(url,window,"dialogWidth:"+(850)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no");
	if(winbasic=="ok"){
		window.location.reload();
	}
}

</SCRIPT>		
			<%@ include file="/epp/css/cssControl.jsp"%><body >
				<form name="userList" method="post" >
					<table cellspacing="1" cellpadding="0" border="0" width=98%  class="thin">
         				<tr valign='top'>
           					<td height='30'valign='middle' colspan="5"><img src='../images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;<strong>��ɢ�û��б�</strong>
           					</td>
         				</tr>
         				<tr >
           					
           					<td colspan="4" height='30' valign='middle' align="left">�û����ƣ�<input type="text" name="userName" value="<%=QueryuserName%>" >
           					�û�ʵ����<input type="text" name="userRealname" value="<%=QueryuserRealname%>" ></td>
           					
           					<td height='30'valign='middle' align="center">
           						<input name="search" type="button" class="input" value="��ѯ" onClick="queryUser()">           						
           						<input name="reset" type="button" class="input" value="���" onClick="javascript:document.userList.userName.value='';document.userList.userRealname.value='';"> 
           					</td>
         				</tr>
						<pg:listdata dataInfo="DiscreteUserList" keyName="DiscreteUserList" />
						<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
						<pg:pager maxPageItems="15" scope="request" data="DiscreteUserList" isList="false">
							<tr>
								<!--���÷�ҳ��ͷ-->
								<td class="headercolor" width="10">
									<input type="checkBox" name="checkBoxAll" onClick="checkAll('checkBoxAll','checkBoxOne')" width="10">
								</td>
								<td class="headercolor" >�û���½����	</td>
								<td class="headercolor" >�û�ʵ��</td>
								<td class="headercolor" >�û�����</td>
								<td class="headercolor" >�����ַ</td>								
								
							</tr>
							<pg:param name="orgId" />
							<pg:param name="userName" />
							<pg:param name="userRealname" />

							<!--��⵱ǰҳ���Ƿ��м�¼-->
							<pg:notify>
								<tr height="18px" class="labeltable_middle_tr_01">
									<td colspan=100 align='center'>
										��ʱû����ɢ�û�
									</td>
								</tr>
							</pg:notify>
							<%
								ContextMenu contextmenu = new ContextMenuImpl();
					 		%>
							<!--list��ǩѭ�����ÿ����¼-->
							<pg:list>		
							<%	
								int userId = dataSet.getInt("userId");
											
	
								Menu menu = new Menu();
								menu.setIdentity("opuser_"+userId);
								
								
								//�û�������Ϣ
								
				 				if (accessControl.checkPermission(resId,
	                         		"lisanuseredit", AccessControl.ORGUNIT_RESOURCE))
	            				{
									Menu.ContextMenuItem menuitem2 = new Menu.ContextMenuItem();
									menuitem2.setName("�û�������Ϣ");
									menuitem2.setLink("javascript:userInfo("+userId+")");
									menuitem2.setIcon(request.getContextPath() +"/sysmanager/images/new.gif");
									menu.addContextMenuItem(menuitem2);
								}
								
								contextmenu.addContextMenu(menu);
								request.setAttribute("opuser",contextmenu);
							%>						
							<pg:contextmenu enablecontextmenu="true" context="opuser" scope="request"/> 
							<%if(userId!=1){%>	
								<tr onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'" onclick="getUserInfo(this,'<pg:cell colName="userId" defaultValue=""/>','<pg:querystring/>')" >
									<td class="tablecells" nowrap="nowrap" width="9%">
										<input type="checkBox" name="checkBoxOne" onClick="checkOne('checkBoxAll','checkBoxOne')" value="<pg:cell colName="userId" defaultValue=""/>" width="10">
									</td>
									<td class="tablecells" nowrap="nowrap" width="18%">
										<pg:cell colName="userName" defaultValue="" />
									</td>
									<td id="opuser_<%=userId%>" class="tablecells" nowrap="nowrap" width="26%" bgcolor="#F6FFEF">
										<pg:cell colName="userRealname" defaultValue="" />
									</td>									
									<td class="tablecells" nowrap="nowrap" width="20%">
										<dict:itemname type="userType" expression="{userType}" />
									</td>
									<td class="tablecells" nowrap="nowrap" width="27%">
										<pg:null colName="userEmail">û������</pg:null>
										<pg:notnull colName="userEmail">
											<pg:equal colName="userEmail" value="">û������</pg:equal>
											<pg:notequal colName="userEmail" value=""><pg:cell colName="userEmail"/></pg:notequal>
										</pg:notnull>
									</td>	
								</tr>
							<%}else{%>
								<tr onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'" onclick="getUserInfo(this,'<pg:cell colName="userId" defaultValue=""/>','<pg:querystring encode="true"/>')" >
									<td class="tablecells" nowrap="nowrap" width="9%">
										<font color="#0000FF"><input type="checkBox" name="checkBoxOne" onClick="checkOne('checkBoxAll','checkBoxOne')" value="<pg:cell colName="userId" defaultValue=""/>" width="10"></font>
									</td>
									<td class="tablecells" nowrap="nowrap" width="24%">
										<font color="#0000FF"><pg:cell colName="userName" defaultValue="" /></font>
									</td>
									<td id="opuser_<%=userId%>" class="tablecells" nowrap="nowrap" width="20%" bgcolor="#0066FF">
										<pg:cell colName="userRealname" defaultValue="" />
									</td>									
									<td class="tablecells" nowrap="nowrap" width="20%">
										<font color="#0000FF"><dict:itemname type="userType" expression="{userType}" /></font>
									</td>
									<td class="tablecells" nowrap="nowrap" width="27%"><font color="#0000FF">
										<pg:null colName="userEmail">û������</pg:null>
										<pg:notnull colName="userEmail">
											<pg:equal colName="userEmail" value="">û������</pg:equal>
											<pg:notequal colName="userEmail" value=""><pg:cell colName="userEmail"/></pg:notequal>
										</pg:notnull></font>
									</td>	
								</tr>
							<%}%>
							</pg:list>
							<tr height="18px" class="labeltable_middle_tr_01">
								<td colspan=6 align='center'>
									��<pg:rowcount/>����¼ <pg:index />
								</td>
							</tr>
							<tr>
								<td colspan=6 align='right'>
								<%
								 if (accessControl.checkPermission(resId,
					                         "lisanuserdelete", AccessControl.ORGUNIT_RESOURCE))
					            {%>
								<input type="submit" value="ɾ��" class="input" onclick="javascript:dealRecord(1); return false;">
								<%}%>
								<%
								 if (accessControl.checkPermission(resId,
					                         "lisanusertoorg", AccessControl.ORGUNIT_RESOURCE))
					            {%>
								<input type="submit" value="�û��������" class="input" onclick="javascript:addorg(1); return false;">
								<%}%>
								</td>
							</tr>
							<input name="queryString" value="<pg:querystring/>" type="hidden">
						</pg:pager>

				  </table>
				</form>
<script language="JavaScript">
	var jsAccessControl = new JSAccessControl("#DAE0E9","#F6F8FB","#F6F8FB");
	var thisUserId = "<%=currUserId.toString()%>";
    for (var i=0;i<userList.elements.length;i++) {
		var e = userList.elements[i];

		if (e.name == "checkBoxOne"){
			if (e.value == thisUserId ){
				var obj = e.parentElement;
				var tableObj = obj.parentElement;
				tableObj.style.backgroundColor = jsAccessControl.heightLightColor;
				break;
		    }
		}
    }	

</script>
<%@ include file="../sysMsg.jsp"%>
<IFRAME name="delDisperse" height="0" width="0"></IFRAME>
			</body>
			<center>
</html>