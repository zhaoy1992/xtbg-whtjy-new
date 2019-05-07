<%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-template.tld" prefix="template"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@page import="com.chinacreator.sysmgrcore.entity.*,com.chinacreator.sysmgrcore.web.struts.form.*"%>
<%@ page import="com.chinacreator.security.*"%>
<%@page import="com.chinacreator.resource.ResourceManager" %>
<%@page import="com.chinacreator.config.ResourceInfoQueue" %>
<%@page import="com.chinacreator.config.model.ResourceInfo" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.OrgAdministrator,
				 com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl,
				 java.util.List,
				 java.util.ArrayList" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%     

	
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
	String currOrgId = (String) request.getParameter("orgId");
	String userId = (String)request.getAttribute("userId");
	String userName = (String)request.getAttribute("username");
	String restext = (String)request.getParameter("restext");
	String resvalue = (String)request.getParameter("resvalue");
	String restext1 = (String)request.getParameter("restext1");
	String resvalue1 = (String)request.getParameter("resvalue1");
	String resna = (String)request.getParameter("resna");
	String resna1 = (String)request.getParameter("resna1");
    //System.out.println("haha" + resna);
	//System.out.println("haha" + resvalue);
	
	if(userId == null)
	{
		 userId = request.getParameter("userId");
		 UserManager userManager = SecurityDatabase.getUserManager();
		 User user = userManager.getUserById(userId);
     	 userName= user.getUserRealname();
	}
	
	String reFlush = "true";
	if (request.getAttribute("reFlush") != null) {
		reFlush = "false";
	}
	String isUserExist = "false";
	if ( request.getAttribute("isUserExist") != null){
		isUserExist = "true";
	}
	String setDisbaled = "";
	if ( request.getAttribute("userNameDisable") != null ){
		setDisbaled = "disabled = true";
	}		
	
	
	UserInfoForm user = (UserInfoForm)session.getAttribute("currUserForm");
	if(userId == null || userId.equals(""))
	{
		userId = user.getUserId();
	}
	request.setAttribute("currUser",user);
	
	//if(user == null)
	//	user = new UserInfoForm(); 
		
	String isNew = (String)request.getAttribute("isNew");
	if(isNew == null ){
		isNew = "0";
	}

%>
<html>
	<head>
		<title>�û�[<%=userName%>]������Ϣ</title>
	    <tab:tabConfig />
	    <script language="JavaScript" src="<%=request.getContextPath()%>/public/datetime/calender_date.js" ></script>
		<script language="JavaScript" src="common.js" type="text/javascript"></script>
		<script language="javascript" src="../scripts/selectTime.js"></script>
		<SCRIPT language="JavaScript" SRC="validateForm.js"></SCRIPT>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
	    <style type="text/css">
	    	.notice_STYLE{color: #FF0000;display : none }
        	.STYLE1 {color: #FF0000}
        </style>
</head>

<script language="JavaScript">
var jsAccessControl = new JSAccessControl("#DAE0E9","#F6F8FB","#F6F8FB");
var reFlush = "<%=reFlush%>";
var userErr = 0;
	
var isUserExist = "<%=isUserExist%>";
if ( isUserExist == "true"){
	alert("��½���Ѵ��ڣ������������½��!");
}

//�ж��޸��Ƿ�ɹ�
var isUpade = "<%=request.getParameter("isUpdate")%>";
if(isUpade == "1"){
	alert("�޸��û��ɹ���");
	window.close();
	window.returnValue="ok";
}

function trim(string){
  var temp="";
  string = ''+string;
  splitstring = string.split(" ");
  for(i=0;i<splitstring.length;i++){
    temp += splitstring[i];
  } 
  return temp;
 }
function storeUser()
{
	
	document.UserInfoForm.userName.disabled = false;
	document.UserInfoForm.userType.disabled = false;
	document.UserInfoForm.userSex.disabled = false;
	document.UserInfoForm.userIsvalid.disabled = false;
	if (validateForm(UserInfoForm) )
	{
		var userName= document.forms[0].userName.value;
		if (trim(userName).length == 0 ){
    		alert("�������½����"); 
    		return false;
    	}
    	if(document.UserInfoForm.remark3.checked){
    		document.UserInfoForm.remark3.value="��";
    	}else{ 
			document.UserInfoForm.remark3.value="��";
		}
		if(document.UserInfoForm.istaxmanager.checked){
			document.UserInfoForm.istaxmanager.value="1";
		}else{
			document.UserInfoForm.istaxmanager.value="0";
		}	
   		document.UserInfoForm.target = "userInfo";
		document.UserInfoForm.action="../user/userManager.do?method=updateUser&isUpdate=1";
		document.UserInfoForm.submit();
	}
}
function defaultpass()//�ָ��û���ʼ����
{
	var userId= document.forms[0].userId.value;
	//alert(userId);
	document.UserInfoForm.target="userInfo";
	document.UserInfoForm.action="../user/userManager.do?method=defaultpass&renewPaw=true&userName="+userId;
	document.UserInfoForm.submit();	
	UserInfoForm.userPassword.value="123456";
}

function reloadUser(){
	document.UserInfoForm.submit();
}

function newUser()
{
	document.UserInfoForm.action="../user/userManager.do?method=newUser";
	document.UserInfoForm.submit();
}

function closed()
{
	//document.location.href="../user/userManager.do?method=getUserList&orgId=<%=currOrgId%>";
	window.returnValue = "ok";
	window.close();
}

function setDisable(v){
	v.disabled = false;
	if  ( document.UserInfoForm.userId.value != "" )
	{
		v.disabled = true;
	}
}

function window_onload() 
{
	notice.style.display="none";  
}

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
		//alert("���ܴ���XMLHttpRequest����");
		return false;
	}
	http_request.onreadystatechange = processRequest;
	http_request.open("GET",url,true);
	http_request.send(null);
}

function processRequest(){
	if(http_request.readyState == 4){
		if(http_request.status == 200){
			if(http_request.responseText == 0)
				//alert("�û����Ѵ���");
				notice.style.display="block";  
			else{
				userErr = 1;
				notice.style.display="none";  
				}
			
		}
		else{
			alert("�Բ��𣬷���������");
		}
	}
}

function checkUser(){
	var userName = document.forms[0].userName.value;	
	send_request('checkUser.jsp?userName='+userName);
}
//�鿴�û�Ȩ����Ϣ------------------------------------------------------------------		
function queryroleRes(name)
		{	
		 if(name == "resname"){
			if(document.roleresList.restype.value.length < 1 && document.roleresList.resname.value.length < 1){
				alert("��Դ�������ƺ���Դ���Ʊ�������һ��!!!");
				return;
			}
			
			for(var i=1;i<document.all("restype").options.length;i++){
			var op=document.all("restype").options[i];
			if(op.selected){
			var restext = op.text;
			var resvalue = op.value;
		
			   }
			}
			var resna = document.roleresList.resname.value;
			var tablesFrame= document.getElementsByName("userrole");
			tablesFrame[0].src = "userrole_popedom.jsp?userId=<%=userId%>&restype=" + resvalue + "&resname=" + resna;
			//roleresList.action="../user/userInfo_tab.jsp?restext=" + restext + "&resvalue=" + resvalue +"&resna=" + resna;
			//roleresList.submit();	
		  }else{
		  if(document.userresList.restype1.value.length < 1 && document.userresList.resname1.value.length < 1){
				alert("��Դ�������ƺ���Դ���Ʊ�������һ��!!!");
				return;
			}
			for(var i=1;i<document.all("restype1").options.length;i++){
			var opt=document.all("restype1").options[i];
			if(opt.selected){
			var restext1 = opt.text;
			var resvalue1 = opt.value;
		    }
			} 
			var resna1 = document.userresList.resname1.value;
			var tablesFrame= document.getElementsByName("userself");
			tablesFrame[0].src = "userself_popedom.jsp?userId=<%=userId%>&restype1="+resvalue1+"&resname1="+resna1;
			//userresList.action="../user/userInfo_tab.jsp?restext1=" + restext1 + "&resvalue1=" +resvalue1+"&resna1=" + resna1;
			//userresList.submit();
		  }
		}
		function queryroleResall(name1)
		{	
		if(name1 == "resname"){
		    document.roleresList.resname.value = "";
			document.all("restype").options[0].selected = true ;
			//�����û�ȫ����ɫ��Դ
			var tablesFrame= document.getElementsByName("userrole");
			tablesFrame[0].src = "userrole_popedom.jsp?userId=<%=userId%>";
		    //roleresList.action="../user/userInfo_tab.jsp"
			//roleresList.submit();	
			}
			else{
			document.userresList.resname1.value = "";
			document.all("restype1").options[0].selected = true ;
			//�����û�ȫ��������Դ
			var tablesFrame= document.getElementsByName("userself");
			tablesFrame[0].src = "userself_popedom.jsp?userId=<%=userId%>";
			//userresList.action="../user/userInfo_tab.jsp"
			//userresList.submit();
			}
		}

</script>


<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no" onload="window_onload();renewPassword()">
		<div id="contentborder" align="center">
<tab:tabContainer id="userinfo-container" selectedTabPaneId="userbase-tab">
	<tab:tabPane id="userbase-tab" tabTitle="�û�������Ϣ">
		<form name="UserInfoForm" method="post">
		
		
		<pg:beaninfo requestKey="currUser">
		<input type="hidden" name="remark1" value="<pg:cell colName="remark1"  defaultValue=""/>" />
		<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" class="thin">
			
			<tr>
				<td height="25" class="detailtitle" width="23%"> ��½��</td>						
				<td height="25">
					<input type="text" name="userName" onchange="checkUser()" value="<pg:cell colName="userName"  defaultValue=""/>" validator="string" cnname="��½��" maxlength="100" <%=setDisbaled%> onfocus="setDisable(this)">
					<span class="STYLE1">*</span>
					<div id=notice class="notice_STYLE">�û����Ѵ���</div>						</td>
				<td height="25" class="detailtitle" width="20%"> ��ʵ����</td>						
				<td height="25">
					<input type="text" name="userRealname" value="<pg:cell colName="userRealname"  defaultValue=""/>" validator="string" cnname="��ʵ����" maxlength="100"><span class="STYLE1">*</span>
				</td>											  
			</tr>
			
			<tr>						
				<td height="25" class="detailtitle"> ����</td>
				<td height="25">
					<input type="password" name="userPassword" readonly  value="<pg:cell colName="userPassword"  defaultValue="123456"/>" validator="string" cnname="����"  maxlength="40"><span class="STYLE1">*ȱʡ����Ϊ123456</span>
				</td>
				<td height="25" class="detailtitle"> ���֤����</td>
					<td height="25">
					<input type="text" name="userIdcard" value="<pg:cell colName="userIdcard"  defaultValue=""/>" validator="intNull" cnname="���֤����" maxlength="18">
				</td>
										
			</tr>
			
			<tr><td height="25" class="detailtitle"> ��λ�绰</td>						
				<td height="25">
					<input type="text" name="userWorktel" value="<pg:cell colName="userWorktel"  defaultValue=""/>"  validator="intNull" cnname="��λ�绰" maxlength="13"></td>
				<td height="25" class="detailtitle"> �Ա�</td>
				<td height="25">					  					    
				<%if("1".equals(request.getParameter("userId"))){%>
				<dict:select type="sex" name="userSex" expression="{userSex}" disabled="true"/>
				<%}else{%>
				<dict:select type="sex" name="userSex" expression="{userSex}"/>
				<%}%>
				</td>
			</tr>
			
			<tr><td height="25" class="detailtitle"> ��ͥ�绰</td>
				<td height="25">
							<input type="text" name="homePhone" value="<pg:cell colName="homePhone"  defaultValue=""/>"  validator="intNull" cnname="��ͥ�绰" maxlength="13"></td>				
				<td height="25" class="detailtitle"> �����ʼ�</td>
				<td height="25">
							<input type="text" name="mail" value="<pg:cell colName="mail"  defaultValue=""/>" validator="emailNull" cnname="�����ʼ�" maxlength="40"></td>
				
			</tr>
			
			<tr>
				<td height="25" class="detailtitle"> �ƶ��绰1</td>
				<td height="25">
							<input type="text" name="mobile" value="<pg:cell colName="mobile"  defaultValue=""/>" validator="intNull" cnname="�ƶ��绰" maxlength="13"></td>
				<td height="25" class="detailtitle"> �ƶ��绰1������</td>
				<td height="25">
							<input type="text" name="remark4" value="<pg:cell colName="remark4"  defaultValue=""/>" validator="stringNull" cnname="�ƶ��绰1������" maxlength="100"></td>
				
			</tr>
			
			<tr><td height="25" class="detailtitle"> �ƶ��绰2</td>
				<td height="25">
					<input type="text" name="userMobiletel2" value="<pg:cell colName="userMobiletel2"  defaultValue=""/>" validator="intNull" cnname="�ƶ��绰2" maxlength="13"></td>
				<td height="25" class="detailtitle"> �ƶ��绰2������</td>
				<td height="25">
							<input type="text" name="remark5" value="<pg:cell colName="remark5"  defaultValue=""/>" validator="stringNull" cnname="�ƶ��绰2������" maxlength="100"></td>
				
		   </tr>
		   <tr>
		   <td height="25" class="detailtitle"> ��֯����</td>
				<td height="25">
							<input type="text" name="ou" readonly="true" value="<pg:cell colName="ou"  defaultValue=""/>" validator="stringNull" cnname="��֯����" maxlength="100"></td>
		   <td height="25" class="detailtitle"> ƴ��</td>
				<td height="25">
							<input type="text" name="userPinyin" value="<pg:cell colName="userPinyin"  defaultValue=""/>" validator="stringNull" cnname="ƴ��" maxlength="100"></td>
				
	       </tr>   
		   <tr><td height="25" class="detailtitle"> �û�����</td>
			   <td height="25">
			   		<%if(accesscontroler.isAdminByUserid(userId) || userId.equals(accesscontroler.getUserID())){%>
					<dict:select type="userType" name="userType" expression="{userType}" disabled="true"  />
					<%}else{%>
					<dict:select type="userType" name="userType" expression="{userType}"  />
					<%}%>
			   </td>					
			   <td height="25" class="detailtitle"> ��������</td>
			   <td height="25">
							<input type="text" name="postalCode" value="<pg:cell colName="postalCode"  defaultValue=""/>" validator="intNull" cnname="��������" maxlength="7"></td>						
			   
		   </tr>
					<tr>
						<td height="25" class="detailtitle">
							 ����
						</td>
						<td height="25">
							<input type="text" name="userFax" value="<pg:cell colName="userFax"  defaultValue=""/>" validator="stringNull" cnname="����" maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							 OICQ
						</td>
						<td height="25">
							<input type="text" name="userOicq" value="<pg:cell colName="userOicq"  defaultValue=""/>" validator="intNull" cnname="OICQ" maxlength="13">
						</td>
						
						</tr>
					<tr>
						<td height="25" class="detailtitle">
							 ����
						</td>
						<td height="25">
							<input type="text" name="userBirthday" onclick="showdate(document.all('userBirthday'))" readonly="true" value="<pg:cell colName="userBirthday"  defaultValue=""  />" validator="stringNull" cnname="����" maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							 �û���ַ
						</td>
						<td height="25">
							<input type="text" name="userAddress" value="<pg:cell colName="userAddress"  defaultValue=""/>" validator="stringNull" cnname="�û���ַ" maxlength="200">
						</td>
						
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							 ��¼����
						</td>
						<td height="25">
							<input type="text" name="userLogincount" value="<pg:cell colName="userLogincount"  defaultValue="0"/>" validator="intNull" readonly cnname="��¼����" maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							 �Ƿ���Ч
						</td>
						<td height="25">
							<%
								if(accesscontroler.isAdminByUserid(userId) || userId.equals(accesscontroler.getUserID())){
							%>
							<dict:select type="isvalid" name="userIsvalid" expression="{userIsvalid}" disabled="true" />
							<%
								}else{
							%>
							<dict:select type="isvalid" name="userIsvalid" expression="{userIsvalid}" />
						<%}%>							
						</td>
						
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							 ע������
						</td>
						<td height="25">
							<input type="text" name="userRegdate" onclick="showdate(document.all('userRegdate'))" readonly="true" value="<pg:cell colName="userRegdate"  defaultValue="" />" validator="stringNull" cnname="ע������" maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							 �ֻ��̺���
						</td>
						<td height="25">
							<input type="text" name="shortMobile" value="<pg:cell colName="shortMobile"  defaultValue=""/>" validator="stringNull"  cnname="�ֻ��̺���" maxlength="40">
						</td>
						
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							 �û������
						</td>
						<td height="25">
							<input type="text" name="userSn" value="<pg:cell colName="userSn"  defaultValue="" />" validator="stringNull" cnname="�û������" maxlength="40">
						</td>
						<td height="25" class="detailtitle" colspan="2">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr><td width='10%'>
						<input type="checkbox" name="remark3" <pg:equal colName="remark3" value="��">checked</pg:equal>>
						</td><td width='150px'><div class='label'>������Ϣ�Ƿ���</div></td>
						</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle" colspan="2">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr><td width='10%'>
						<input type="checkbox" name="istaxmanager" <pg:equal colName="istaxmanager" value="1">checked</pg:equal>>
						</td><td width='150px'><div class='label'>�Ƿ�˰��Ա</div></td>
						</tr>
						</table>
						</td>
					</tr>				
					<input type="hidden" name="userId" value="<pg:cell colName="userId"  defaultValue=""/>" />
					<input name="orgId" value="<%=currOrgId%>" type="hidden" height="0">
		</table>
		  </pg:beaninfo>
		</form>

		<hr width="100%">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
					<table width="35%" border="0" align="right" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<div align="center">
								<%
								if(accesscontroler.getUserID().equals( userId) ||
								 accesscontroler.checkPermission(currOrgId,"edituser",AccessControl.ORGUNIT_RESOURCE))
								{%>
									<input name="resave" type="button" class="input" value="����" onClick="storeUser()">									
								<%}
								if(accesscontroler.getUserID().equals( userId) ||
									 accesscontroler.checkPermission(currOrgId,"edituser",AccessControl.ORGUNIT_RESOURCE))
								{%>
								<input name="calc" type="button" onClick="UserInfoForm.reset()" class="input" value="����">
								<%}
								%>	
								</div>
							</td>
							 
							<td>
								<div align="center">
									<%								
										if(accesscontroler.getUserID().equals(userId) ||
										 accesscontroler.checkPermission(currOrgId,"resetpassword",AccessControl.ORGUNIT_RESOURCE))
										{%>
											<input name="default" type="button" onClick="defaultpass()" class="input" value="����ָ�">
											<%
										}
									%>
								</div>
							</td>
						
							<td>
								<div align="center">
									<input name="Submit32" type="button" class="input" value="�ر�" onClick="closed();">
								</div>
							</td>
						
          		</tr>
					</table>
				</td>
			</tr>
		</table>
	</tab:tabPane>
<!-- --------------------------------------------------------------------------------------------->
	<tab:tabPane id="roleres-tab" tabTitle="�û���ɫȨ��">
		<form name="roleresList" method="post" >
					<input name="userId" value="<%=userId%>" type="hidden">
					<table cellspacing="1" cellpadding="0"  width=98% class="thin" height="100%" >
         				<tr valign='top'>
           					<td height='30'valign='middle' colspan="5">&nbsp;<%=userName%></td>
         				</tr>
         				<tr >
           					<td height='30' valign='middle' align="center">��Դ�������ƣ�<select name="restype" id="restype">
           					 <option selected>--��ѡ����Դ��������--</option>
           					 <%
	                          int count = 0;
	                          ResourceManager rsManager = new ResourceManager();
                              ResourceInfoQueue restypeall=rsManager.getResourceInfoQueue();
                              int restypelength =restypeall.size();
	                          for(int i=0;i<restypelength;i++)
	                            
	                          {    
	                                ResourceInfo restypeinfo=restypeall.getResourceInfo(i);
	                                String id = restypeinfo.getId();
	                                String name = restypeinfo.getName();
	                                //if(restypeinfo.isAuto())
	                                //{
		                                if(restext != null && resvalue != null && !restext.equals("undefined") && !resvalue.equals("undefined") && count == 0 && restext.equals(name) && resvalue.equals(id) ){
		                                    count++;
			                        	%>
			                           <option value='<%=resvalue%>' selected><%=restext%></option>
			                           <%}
			                           else 
			                           {
			                           %>
		                               <option value='<%=id%>'><%=name%></option>
		                               <%}
		                             //}
								}%>
           					 </td>
           					<td height='30'valign='middle' align="center">��Դ���ƣ�
           					<%
           					if(resna == null){
           					%>
           					<input type="text" name="resname" >
           					<%}
           					else{
           					%>
           					<input type="text" value='<%=resna%>' name="resname" >
           					<%}%>
           					</td>
           					<td height='30' valign='middle' align="center" colspan="2">
           						<input name="search" type="button" class="input" value="��ѯ" onClick='queryroleRes("resname")'>
           			
           						<input name="search1" type="button" class="input" value="�鿴����" onClick='queryroleResall("resname")'>
           				   </td>
           				 
           				</tr>
           				<tr><td colspan="4">
						    <iframe name="userrole" src="userrole_popedom.jsp?userId=<%=userId%>" style="width:100%" height="100%" scrolling="no" frameborder="0" marginwidth="1" marginheight="1"></iframe>
						</td></tr>
					</table>
	</form>
      </tab:tabPane>
      
 <!-- --------------------------------------------------------------------------------------------->
	<tab:tabPane id="userres-tab" tabTitle="�û�����Ȩ��">
		<form name="userresList" method="post" >
					<input name="userId" value="<%=userId%>" type="hidden">
					<table cellspacing="1" cellpadding="0"  width=98% class="thin" height="100%" >
         				<tr valign='top'>
           					<td height='30'valign='middle' colspan="4">&nbsp;<%=userName%></td>
         				</tr>
         				<tr >
           					<td height='30'valign='middle' align="center">��Դ�������ƣ�<select name="restype1" id="restype1">
           					<option selected>--��ѡ����Դ��������--</option>
           					<%
	                          int count1 = 0;
	                          ResourceManager rsManager1 = new ResourceManager();
                              ResourceInfoQueue restypeall1=rsManager1.getResourceInfoQueue();
                              int restypelength1 =restypeall1.size();
	                          for(int i=0;i<restypelength1;i++)
	                            
	                          {
	                                ResourceInfo restypeinfo1=restypeall1.getResourceInfo(i);
	                                String id1 = restypeinfo1.getId();
	                                String name1 = restypeinfo1.getName();
	                             //if(restypeinfo1.isAuto())
	                             //   {
	                                	if(restext1 != null && resvalue1 != null && !restext1.equals("undefined") && !resvalue1.equals("undefined") && count1 == 0 && restext1.equals(name1) && resvalue1.equals(id1)){
		                            	count1++;
				                        %>
				                        <option value='<%=resvalue1%>' selected><%=restext1%></option>
				                        <%}
				                        else
				                        {
				                        %>
			                            <option value='<%=id1%>'><%=name1%></option>
			                            <%}
	                              //  }		                            
                            }%>
                          </select>
           					 </td>
           					<td height='30'valign='middle' align="center">��Դ���ƣ�
           					<%
           					if(resna1 == null){
           					%>
           					<input type="text" name="resname1" >
           					<%}
           					else{
           					%>
           					<input type="text" value='<%=resna1%>' name="resname1" >
           					<%}%>
           					</td>
           					<td height='30'valign='middle' align="center">
           						<input name="search3" type="button" class="input" value="��ѯ" onClick='queryroleRes("resname1")'>
           						<input name="search4" type="button" class="input" value="�鿴����" onClick='queryroleResall("resname1")'>
           						</td>
           				
           				 
           				</tr>
           				<tr><td colspan="4">
						<iframe name="userself" src="userself_popedom.jsp?userId=<%=userId%>" style="width:100%" height="100%" scrolling="no" frameborder="0" marginwidth="1" marginheight="1"></iframe>
						</td></tr>
					</table>
	</form>
      </tab:tabPane>
</tab:tabContainer>

</div>
<iframe name="userInfo" width="0" height="0"></iframe>
<script>
//�ָ�����
function renewPassword(){
	var renewPaw = "<%=request.getParameter("renewPaw")%>";
	if(renewPaw == "true"){
		alert(" �����ɹ�,�û������ѻָ�Ϊ��ʼ���룡");
	}
}
</script>
</body> 
</html>