<%
/*
 * <p>Title: �û�������Ϣҳ��</p>
 * <p>Description: �û�������Ϣҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-22
 * @author liangbing.tao
 * @version 1.0
 */
%>


<%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.OrgManager"%>				
<%@ page import="com.chinacreator.security.*"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.*"%>
<%@ page import="com.chinacreator.resource.ResourceManager" %>
<%@ page import="com.chinacreator.config.ResourceInfoQueue" %>
<%@ page import="com.chinacreator.config.model.ResourceInfo" %>
<%@ page import="java.util.List"%>
<%@ page import="com.chinacreator.security.authentication.EncrpyPwd"%>
<%@ page import="com.chinacreator.security.AccessControl,
				com.chinacreator.config.ConfigManager"%>




<%     
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkManagerAccess(request,response);
    
    //�û���¼��ʽ true-֧���û�����¼�����û�ʵ��ͬʱ��¼��ʽ false-��֧���û���¼��ʽ
	String userloginmode = ConfigManager.getInstance().getConfigValue(
			"userloginmode");
    
	String currOrgId = (String) request.getParameter("orgId");
	String userId = request.getParameter("userId");
	
	String userName = "";
	String userRealName = "";
	User user = null;
	UserManager userManager = SecurityDatabase.getUserManager();
	
	if(userId != null)
	{
		 user = userManager.getUserById(userId);
     	 userRealName= user.getUserRealname();
     	 userName = user.getUserName();
     	 //ȡ�û���Ϣ��ʱ����������
     	 user.setUserPassword(user.getUserPassword());
	}	
	
	request.setAttribute("currUser",user);
	
	String ou="";
	OrgManager orgMgr = SecurityDatabase.getOrgManager();
	List list = orgMgr.getOrgList(user);
	boolean flag = false;
	for(int i=0;i<list.size();i++){
		Organization o = (Organization)list.get(i);
		if(flag)
			ou += "," + o.getOrgName();
		else
		{
			ou += o.getOrgName();
			flag = true;
		}
	}
	
	String restext = (String)request.getParameter("restext");
	String resvalue = (String)request.getParameter("resvalue");
	String restext1 = (String)request.getParameter("restext1");
	String resvalue1 = (String)request.getParameter("resvalue1");
	String resna = (String)request.getParameter("resna");
	String resna1 = (String)request.getParameter("resna1");
	
	//�ָ�����
	boolean renewPwdState = false;
	String actionType = request.getParameter("actionType");
	if(actionType != null && "renewUserPwd".equals(actionType)){
		User renewUser = userManager.getUserById(request.getParameter("renewUserId"));
		renewUser.setUserPassword("123456");
		renewPwdState = userManager.updateUserPassword(renewUser);
	}
	
	//�Ƿ����  "�Ƿ�˰��Ա" ��ѡ��
	boolean istaxmanager = ConfigManager.getInstance().getConfigBooleanValue("istaxmanager", false);
%>
<html>
	<head>
		<title>�û�[<%=userRealName%>]������Ϣ</title>
	    <tab:tabConfig />
	    <script language="JavaScript" src="../../scripts/calender_date.js" ></script>
		<script language="JavaScript" src="../../scripts/common.js" type="text/javascript"></script>
		<script language="javascript" src="../../scripts/selectTime.js"></script>
		<SCRIPT language="JavaScript" SRC="../../scripts/validateForm.js"></SCRIPT>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
	    <style type="text/css">
	    	.notice_STYLE{color: #FF0000;display : none }
        	.STYLE1 {color: #FF0000}
        </style>
</head>


<script language="JavaScript">

//�û�����ָ��Ƿ�ɹ���ʾ��Ϣ
var renewPwdState = "<%=renewPwdState%>";
if(renewPwdState=="true"){
	alert("�����ɹ����û�����ָ�Ϊ��ʼ���룡");
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
   		document.all("userName").disabled = false;
   		document.all("userRealname").disabled = false;
   		document.all("resave").disabled = true;
   		document.all("calc").disabled = true;
   		document.all("default").disabled = true;
   		document.all("Submit32").disabled = true;
   		divProcessing.style.display="";
   		
   		
		document.UserInfoForm.action="updateUser.jsp?userId=<%=userId%>&istaxmanager="+document.UserInfoForm.istaxmanager.value;
		document.UserInfoForm.submit();
	}
}
function defaultpass()//�ָ��û���ʼ����
{
	var userId= document.forms[0].userId.value;
	//alert(userId);
	document.UserInfoForm.target="userInfo";
	UserInfoForm.userPassword.value="123456";
	document.UserInfoForm.action="userInfo_tab_update.jsp?renewUserId="+userId+"&actionType=renewUserPwd";
	document.UserInfoForm.submit();	
}

function closed()
{
	window.returnValue = "ok";
	window.close();
}

function window_onload() 
{
	//notice.style.display="none";  
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
			}
			else{
			document.userresList.resname1.value = "";
			document.all("restype1").options[0].selected = true ;
			//�����û�ȫ��������Դ
			var tablesFrame= document.getElementsByName("userself");
			tablesFrame[0].src = "userself_popedom.jsp?userId=<%=userId%>";
			}
		}

</script>


<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no" onload="window_onload();renewPassword()" >
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
					<input type="text" name="userName" onchange="checkUser()" value="<pg:cell colName="userName"  defaultValue=""/>" validator="string" cnname="��½��" disabled="true" >
					<span class="STYLE1">*</span>				
				</td>
				<td height="25" class="detailtitle" width="20%"> ��ʵ����</td>						
				<td height="25">
					<%if("true".equals(userloginmode.trim())){ %>
					<input type="text" name="userRealname" value="<pg:cell colName="userRealname"  defaultValue=""/>" validator="string" cnname="��ʵ����" maxlength="100" disabled="true">
					<%}else{ %>
					<input type="text" name="userRealname" value="<pg:cell colName="userRealname"  defaultValue=""/>" validator="string" cnname="��ʵ����" maxlength="100" >
					<%} %>
					<span class="STYLE1">*</span>
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
					<input type="text" name="userWorktel" value="<pg:cell colName="userWorktel"  defaultValue=""/>"  validator="phone" cnname="��λ�绰" maxlength="13"></td>
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
							<input type="text" name="homePhone" value="<pg:cell colName="userHometel"  defaultValue=""/>"  validator="phone" cnname="��ͥ�绰" maxlength="13"></td>				
				<td height="25" class="detailtitle"> �����ʼ�</td>
				<td height="25">
							<input type="text" name="mail" value="<pg:cell colName="userEmail"  defaultValue=""/>" validator="emailNull" cnname="�����ʼ�" maxlength="40"></td>
				
			</tr>
			
			<tr>
				<td height="25" class="detailtitle"> �ƶ��绰1</td>
				<td height="25">
							<input type="text" name="mobile" value="<pg:cell colName="userMobiletel1"  defaultValue=""/>" validator="phone" cnname="�ƶ��绰" maxlength="13"></td>
				<td height="25" class="detailtitle"> �ƶ��绰1������</td>
				<td height="25">
							<input type="text" name="remark4" value="<pg:cell colName="remark4"  defaultValue=""/>" validator="stringNull" cnname="�ƶ��绰1������" maxlength="100"></td>
				
			</tr>
			
			<tr><td height="25" class="detailtitle"> �ƶ��绰2</td>
				<td height="25">
					<input type="text" name="userMobiletel2" value="<pg:cell colName="userMobiletel2"  defaultValue=""/>" validator="phone" cnname="�ƶ��绰2" maxlength="13"></td>
				<td height="25" class="detailtitle"> �ƶ��绰2������</td>
				<td height="25">
							<input type="text" name="remark5" value="<pg:cell colName="remark5"  defaultValue=""/>" validator="stringNull" cnname="�ƶ��绰2������" maxlength="100"></td>
				
		   </tr>
		   <tr>
		   <td height="25" class="detailtitle"> ��֯����</td>
				<td height="25">
							<input type="text" name="ou" readonly="true" value="<%=ou%>" validator="stringNull" cnname="��֯����" maxlength="100"></td>
		   <td height="25" class="detailtitle"> ƴ��</td>
				<td height="25">
							<input type="text" name="userPinyin" value="<pg:cell colName="userPinyin"  defaultValue=""/>" validator="stringNull" cnname="ƴ��" maxlength="100"></td>
				
	       </tr>   
		   <tr><td height="25" class="detailtitle"> �û�����</td>
			   <td height="25">
			   		<%if(accesscontroler.isAdmin(userName) || "1".equals(userId) || userId.equals(accesscontroler.getUserID())){%>
					<dict:select type="userType" name="userType" expression="{userType}" disabled="true"  />
					<input type=hidden name="userType" value="<pg:cell colName="userType" defaultValue="0"/>">
					<%}else{%>
					<dict:select type="userType" name="userType" expression="{userType}"  />
					<%}%>
			   </td>					
			   <td height="25" class="detailtitle"> ��������</td>
			   <td height="25">
							<input type="text" name="postalCode" value="<pg:cell colName="userPostalcode"  defaultValue=""/>" validator="intNull" cnname="��������" maxlength="7"></td>						
			   
		   </tr>
					<tr>
						<td height="25" class="detailtitle">
							 ����
						</td>
						<td height="25">
							<input type="text" name="userFax" value="<pg:cell colName="userFax"  defaultValue=""/>" validator="phone" cnname="����" maxlength="40">
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
							<%if(accesscontroler.isAdmin(userName) || "1".equals(userId) || userId.equals(accesscontroler.getUserID())){%>
							<dict:select type="isvalid" name="userIsvalid" expression="{userIsvalid}" disabled="true" />
							<input type=hidden name="userIsvalid" value="<pg:cell colName="userIsvalid" defaultValue="0"/>">
							<%}else{%>
							<dict:select type="isvalid" name="userIsvalid" expression="{userIsvalid}" />
						<%}%>							
						</td>
						
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							 ע������
						</td>
						<td height="25">
							<%if(accesscontroler.isAdmin(userName) || "1".equals(userId) || userId.equals(accesscontroler.getUserID())){%>
							<input type="text" name="userRegdate"  readonly="true" value="<pg:cell colName="userRegdate"  defaultValue="" />" validator="stringNull" cnname="ע������" maxlength="40" disabled>
							<input type=hidden name="userRegdate" value="<pg:cell colName="userRegdate"  defaultValue="" />"/>
							<%}else{%>
							<input type="text" name="userRegdate"  readonly="true" value="<pg:cell colName="userRegdate"  defaultValue="" />" validator="stringNull" cnname="ע������" maxlength="40">
							<%}%>
						</td>
						<td height="25" class="detailtitle">
							 �ֻ��̺���
						</td>
						<td height="25">
							<input type="text" name="shortMobile" value="<pg:cell colName="remark2"  defaultValue=""/>" validator="phone"  cnname="�ֻ��̺���" maxlength="40">
						</td>
						
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							 �û������
						</td>
						<td height="25">
							<%if(accesscontroler.isAdmin(userName) || "1".equals(userId) || userId.equals(accesscontroler.getUserID())){%>
							<input type="text" name="userSn" value="<pg:cell colName="userSn"  defaultValue="" />" validator="intNull" cnname="�û������" maxlength="40" readOnly=true>
							<%}else{%>
							<input type="text" name="userSn" value="<pg:cell colName="userSn"  defaultValue="" />" validator="intNull" cnname="�û������" maxlength="40">
							<%}%>
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
					<% 
					if(istaxmanager){
					%>
					<tr>
						<td height="25" class="detailtitle" colspan="2">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr><td width='10%'>
						<%if(accesscontroler.isAdmin(userName) || "1".equals(userId) || userId.equals(accesscontroler.getUserID())){%>
						<input type="checkbox" name=istaxmanager value="<pg:cell colName="istaxmanager" defaultValue="1"/>" disabled/>
						<input type="hidden" name=istaxmanager value="<pg:cell colName="istaxmanager" defaultValue="1"/>"/>
						<%}else{%>
						<input type="checkbox" name="istaxmanager" <pg:equal colName="istaxmanager" value="1">checked</pg:equal>>
						<%}%>						
						</td><td width='150px'><div class='label'>�Ƿ�˰��Ա</div></td>
						</tr>
						</table>
						</td>
					</tr>	
					<% 
					}else{
					%>	
					<input type="hidden" name=istaxmanager value="0" >	
					<% 
					}
					%>	
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
									<input name="resave" type="button" class="input" value="����" onClick="storeUser()">									
								
								<input name="calc" type="button" onClick="UserInfoForm.reset()" class="input" value="����">
								
								</div>
							</td>
							 
							<td>
								<div align="center">
											<input name="default" type="button" onClick="defaultpass()" class="input" value="����ָ�">
										
								</div>
							</td>
						
							<td>
								<div align="center">
									<input name="Submit32" type="button" class="input" value="����" onClick="closed();">
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
					<table cellspacing="1" cellpadding="0"  width="98%" class="thin" height="100%" >
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
					<table cellspacing="1" cellpadding="0"  width="98%" class="thin" height="100%" >
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
	                               // }		                            
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
<div id=divProcessing style="width:200px;height:30px;position:absolute;left:300px;top:450px;display:none">
	<table border="0" cellpadding="0" cellspacing="1" bgcolor="#000000" width="100%" height="100%">
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
</html>