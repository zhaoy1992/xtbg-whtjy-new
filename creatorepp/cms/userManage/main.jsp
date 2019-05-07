

<%@page contentType="text/html; charset=GBK"%>

<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.util.*" %>
<%@page import="com.chinacreator.cms.sitemanager.*" %>
<%@page import="com.chinacreator.cms.flowmanager.*" %>
<%@page import="com.chinacreator.cms.templatemanager.*" %>
<%@page import="com.frameworkset.common.poolman.DBUtil" %>
<%@page import="com.chinacreator.cms.container.Template" %>
<%@page import="com.chinacreator.sysmgrcore.manager.db.OrgManagerImpl,
				com.chinacreator.sysmgrcore.entity.Organization,
				com.chinacreator.sysmgrcore.entity.RoleType,
				com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl" %>
<%@page import="java.util.*" %>
<%@page import="com.chinacreator.sysmgrcore.manager.RoleTypeManager" %>
<%@ page import="com.chinacreator.resource.ResourceManager"%>

<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>


<%    
    response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);


	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);	
	
	OrgAdministratorImpl orgAdministratorImpl = new OrgAdministratorImpl();
	//�õ���ǰ��½�û������ڻ����б�
	String userId = control.getUserID();
	OrgManagerImpl orgManagerImpl = new OrgManagerImpl();
	List userOrgList = orgManagerImpl.getOrgListOfUser(userId);
	
	
	String userType = request.getParameter("userType");
	if(userType==null||userType.equals("")){//Ĭ��Ϊ�ڲ��û�
	   userType="0";
	}
	
	String QueryuserName = null;
	if(request.getParameter("userName")==null){
		QueryuserName = "";
	}else{
		QueryuserName = request.getParameter("userName");
	}
	
	String QueryroleName = null;
	if(request.getParameter("roleName")==null){
		QueryroleName = "";
	}else{
		QueryroleName = request.getParameter("roleName");
	}
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
	<script src="../inc/js/func.js"></script>
	<tab:tabConfig/>
	<title>�û�����</title>

<script language="javascript">
	var isAdminOrSelf = "<%=request.getParameter("isAdminOrSelf")%>";
	if(isAdminOrSelf == "true")
	{
		alert("���ܶ�ϵͳ����Ա���Ź���Ա���Լ����в�����");
		window.location.href="main.jsp";
	}
	
	function changeType(){
	   
		form1.atcion="main.jsp?userType="+form1.userType.value;
		form1.submit();
		
		//window.location.href = "main.jsp?userType="+form1.userType.value;
		
	}

	function queryUser(id)
	{
		form1.action="main.jsp?id="+id;
		form1.submit();	 
	}
	
	function addUser(){
		openWin('../userManage/addUser.jsp?userType='+form1.userType.value,screen.availWidth-200,screen.availHeight-200);
		window.location.href = window.location.href;
	}
	
	 function execute(dealType){
	 	var isSelect = false;
	    var outMsg;
		var status = document.all.item("intervalType").value;
		
		//alert(status); 
	    for (var i=0;i<form1.elements.length;i++) {
			var e = form1.elements[i];
				
			if (e.name == 'checkBoxOne'){
				if (e.checked){
		       		isSelect=true;
		       		
		       		break;
			    }
			}
	    }
	    if (isSelect){
	    	if (dealType==1){
	    		if(status=="-1"){
					alert("��ѡ������");
					return;
				}
	    		outMsg = "��ȷ��Ҫִ����ѡ��Ĳ�����";
	        	if (confirm(outMsg)){
					form1.action="../userManage/userManager.do?method=userStatus&status="+status;
					form1.submit();
		 			return true;
				}
			} 
	    }else{
	    	alert("����Ҫѡ��һ����¼��");
	    	return false;
	    }
		return false;	
	 }
	
	 function checkAll(totalCheck,checkName){	
	   var selectAll = document.getElementsByName(totalCheck);
	   var o = document.getElementsByName(checkName);
	   if(selectAll[0].checked==true){
		   for (var i=0; i<o.length; i++){
	      	  if(!o[i].disabled){
	      	  	o[i].checked=true;
	      	  }
		   }
	   }else{
		   for (var i=0; i<o.length; i++){
	   	  	  o[i].checked=false;
	   	   }
	   }
	}
	
	 function onShowUserInfo(userId){
	 	form1.action=openWin("../userManage/userManager.do?method=getUser&userId="+userId,screen.availWidth-300,screen.availHeight-100);
		form1.submit();
	 
	 }
   //-----------------------------------------------------------------------------------------------------------------------------------------	
   function checkAll2(totalCheck,checkName){	
	   var selectAll = document.getElementsByName(totalCheck);
	   var o = document.getElementsByName(checkName);
	   if(selectAll[0].checked==true){
		   for (var i=0; i<o.length; i++){
	      	  if(!o[i].disabled){
	      	  	o[i].checked=true;
	      	  }
		   }
	   }else{
		   for (var i=0; i<o.length; i++){
	   	  	  o[i].checked=false;
	   	   }
	   }
	}
	function queryRole()
	{	
		form2.action="../userManage/main.jsp"
		form2.submit();	
	}
	function selectuser(roleId)
	{	
		form2.action="../userManage/selectuser.jsp?roleId="+roleId;
		form2.submit();	
	}
	function purviewRole(roleId)
	{	
		//form2.action="openWin('../userManage/resFrame.jsp?roleId='+roleId,screen.availWidth-600,screen.availHeight-300)";
		form2.action="../userManage/userResFrame.jsp?userId="+roleId;
		form2.submit();	
	}
	function deleteRole(dealType) {
	    var isSelect = false;
	    var outMsg;
		    
	    for (var i=0;i<form2.elements.length;i++) {
			var e = form2.elements[i];
				
			if (e.name == 'ID'){
				if (e.checked){
		       		isSelect=true;
		       		
		       		break;
			    }
			}
	    }
	    if (isSelect){
	    	if (dealType==1){
	    		outMsg = "��ȷ��Ҫɾ��ѡ����ɫ��(ɾ�����ǲ������ٻָ���)��";
	        	if (confirm(outMsg)){
					form2.action="../userManage/deleteRole.jsp";
					form2.submit();
		 			return true;
				}
			} 
	    }else{
	    	alert("����Ҫѡ��һ����¼��");
	    	return false;
	    }
		return false;
	}
	
	function popedomSet(roleId){
		if(roleId=="1"){
			alert("�˽�ɫ��ϵͳ����Ա�����ܽ��д��������");
			return false;
		}else if(roleId=="3"){
			alert("�˽�ɫ�ǻ�������Ա�����ܽ��д��������");
			return false;
		}else{
			openWin('resFrame.jsp?roleId='+roleId,screen.availWidth-50,screen.availHeight-100);
			return true;
		}
	}
	
	function grantRole(userId)
	{
		var flag = openWin("../../sysmanager/user/userRole.do?method=getRoleList&userId=" + userId ,screen.availWidth-300,screen.availHeight-100) ;
		if(flag == "ok")
		{
			window.location.href = window.location.href;
		}
	}
  
</script>
</head>
<body  bgcolor="#F7F8FC" >

	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
	    <tr height="10">
	       <td>
	       </td>
	    </tr>
		<tr >
			<td colspan="2" class="topDIV"  align="left" valign="top">
					<FONT color="#8080c0">�û�Ȩ�޹���</FONT>
				</td>
		</tr>
		<tr height="20">
	       <td>
	       </td>
	    </tr>
		<tr>
			<td colspan="2">
				<tab:tabContainer id="user-manage-update" selectedTabPaneId="user-manage">
					<tab:tabPane id="user-manage" tabTitle="�û�����">
					 <FORM id="form1" name="form1" method="post" onSubmit="">
					    <table  width="100%" height="30" >
					          <tr>
					          	<td align="left">
									�û����ͣ�
									<dict:select extend="onchange=changeType()" defaultValue="<%=userType%>" type="userType" name="userType" expression="{userType}"  />
									
									<!--
					          		<select name="userType" class="cms_select" onChange="changeType()" >
						                <option value="0" >
						                    ϵͳ�û�
					                   </option>
						               <option value="1" <%if(userType.equals("1")){%>selected<%}%>>
						                    �ⲿ��Ա
					                   </option>					                   
					                </select>
					                -->					                
					          	</td>
					          </tr>
						      <tr>
						      
						         <td  align="right">
						             <FONT color="#8080c0">��ѯ::::</FONT>�û�����
						             <input name="userName" type="text" size="20" value="<%=QueryuserName%>">
	                                 <input name="search" type="button" class="cms_button" value="��ѯ" onClick="queryUser('6')">
<!--	                                 &nbsp;&nbsp;&nbsp;&nbsp;-->
<!--	                                 <input type="Button" name="add"  class="cms_button" value="����û�" onClick="addUser()">-->
	                             </td>
	                           </tr>
	                           <tr>
	                           		<td  height="10" align=right >
						  			    <a style="cursor:hand" onClick="queryUser('7')">
						  			    <div class="DocumentOper"><img src="../images/new_doc.gif" class="operStyle">ȫ���û�</div></a>
										<a style="cursor:hand" onClick="queryUser('2')">
						  			    <div class="DocumentOper"><img src="../images/new_doc.gif" class="operStyle">�ѿ�ͨ</div></a>
										<a style="cursor:hand" onClick="queryUser('1')">
						  			    <div class="DocumentOper"><img src="../images/new_doc.gif" class="operStyle">������</div></a>
										<a style="cursor:hand" onClick="queryUser('3')">
						  			    <div class="DocumentOper"><img src="../images/new_doc.gif" class="operStyle">��ͣ��</div></a>
										<a style="cursor:hand" onClick="queryUser('0')">
						  			    <div class="DocumentOper"><img src="../images/new_doc.gif" class="operStyle">��ɾ��</div></a>
						  			    <a style="cursor:hand" onClick="queryUser('0')">
						  			    <div class="DocumentOper"><img src="../images/new_doc.gif" class="operStyle">��ɢ�û�</div></a>						  			    
						  			    <a style="cursor:hand" onClick="addUser()">						  			   
						  			    <div class="DocumentOper"><img src="../images/new_doc.gif" class="operStyle">����û�</div></a>
										
										</td>
	                           </tr>
						    </table>
					    
					    
					    <hr width="100%">
						<table width="100%" border="0" cellpadding="3" cellspacing="0" class="Templateedittable">
					    <pg:listdata dataInfo="User_List" keyName="User_List"/>
		                    <!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
		                    <pg:pager maxPageItems="10" scope="request" data="User_List" isList="false">
		                    <pg:param name="userName"/>
		                    <pg:param name="id"/>
		                    <pg:param name="userType"/>
							<tr>
								<td width="8%" height="24"   bgcolor="#EDEFF6">
								<input type="checkBox" name="checkBoxAll" onClick="checkAll('checkBoxAll','checkBoxOne')">
								ȫѡ</td>
								<td width="10%" height="24"   bgcolor="#EDEFF6">�û���</td>
								<td width="10%" height="24"   bgcolor="#EDEFF6">��ǰ״̬</td>
								<td width="12%" height="24"   bgcolor="#EDEFF6">��ʵ����</td>
								<td width="15%" height="24"   bgcolor="#EDEFF6">��֯����</td>
								<td width="13%" height="24"   bgcolor="#EDEFF6">����ʱ��</td>
								<td width="13%" height="24"   bgcolor="#EDEFF6">��ͨʱ��</td>
								<td width="4%" height="24"   bgcolor="#EDEFF6">Ȩ��</td>
								<td width="4%" height="24"   bgcolor="#EDEFF6">��ɫ</td>
								<td width="7%" height="24"   bgcolor="#EDEFF6">��������</td>
								<td width="4%" height="24"   bgcolor="#EDEFF6">�༭</td>								
							</tr>
							
		                    <!--��⵱ǰҳ���Ƿ��м�¼-->
		       	            <pg:notify>
			                <tr height="18px" class="labeltable_middle_tr_01">
			      	          <td colspan=100 align='center'>��ʱû���û�</td>
			                </tr>
			               </pg:notify>			      
			      			    
			               <!--list��ǩѭ�����ÿ����¼-->			      
			                <pg:list>	
			                
			               <% //��ʾ�û������
			                  //baowen.liu 2008-4-25
			                  String  userid =dataSet.getString("userId");
			                  boolean isOrgManager = orgAdministratorImpl.isOrgAdmin(userid,"");
			                  boolean isRoleAdmin = control.isAdminByUserid(userid);
			                  String isRoleAdminOrOrgManager = "";//�Ƿ�ӵ�г�������Ա��ɫ�벿�Ź���Ա��ɫ
							if(isOrgManager && isRoleAdmin){
								isRoleAdminOrOrgManager = "(����Ա����������Ա��ɫ)";
							}else if(isRoleAdmin){
								isRoleAdminOrOrgManager = "(��������Ա��ɫ)";
							}else if(isOrgManager){
								isRoleAdminOrOrgManager = "(����Ա)";
							}
			                %>
						     <tr class="cms_data_tr" id="<pg:cell colName="userId" defaultValue=""/>" onMouseOver="high(this)" onMouseOut="unhigh(this)">
						      
						        <td height='25' class="tablecells" >
						        <P align="left">
						        <input onClick="" type="checkbox" name="checkBoxOne" value="<pg:cell colName="userId" defaultValue=""/>">
						        </P>
						        </td>		      				
<!--							    <td height='25' class="tablecells" nowrap="nowrap">-->
<!--							    	<pg:cell colName="userName" defaultValue=""/>-->
<!--							    </td>-->

							    <td align=left onclick="var isOk = openWin('../userManage/userManager.do?method=getUser&userId=<pg:cell colName="userId" defaultValue=""/>',screen.availWidth-300,screen.availHeight-200); if(isOk=='ok'){changeType();}" style="cursor:hand">
								    <a class="BlackLine"  class="Black">
								    	<pg:cell colName="userName" defaultValue=""/> 
								    		<%=isRoleAdminOrOrgManager%>
								    </a>	
							    </td>
							    
							    <td height='25' class="tablecells">		
							    	 <dict:itemname type="isvalid" expression="{userIsvalid}" />	    
							    	 <!--     
							         <pg:equal colName="userIsvalid" value="0">��ɾ��</pg:equal>
							         <pg:equal colName="userIsvalid" value="1">������</pg:equal>
							         <pg:equal colName="userIsvalid" value="2">�ѿ�ͨ</pg:equal>
							         <pg:equal colName="userIsvalid" value="3">ͣ��</pg:equal>
							         -->
							     </td>
							    <td height='25' class="tablecells"><pg:cell colName="userRealname" defaultValue=""/></td>
							    <td height='25' class="tablecells"><pg:cell colName="orgs" defaultValue=""/></td>
							    <td height='25' class="tablecells"><pg:cell colName="user_Regdate" defaultValue=""/></td>
							    <td height='25' class="tablecells"><pg:cell colName="dredgeTime" defaultValue=""/></td>
							    
							    <td height='25' class="tablecells">
							    <%
				  			    boolean userressetTag = false;
				  			    for(int i=0;i<userOrgList.size();i++)
				  			    {
				  			    	Organization org = (Organization)userOrgList.get(i);
				  			    	if(control.checkPermission(org.getOrgId(),"userresset",AccessControl.ORGUNIT_RESOURCE))
				  			    	{
				  			    		userressetTag = true;
				  			    		break;
				  			    	}
				  			    }
								if(control.isAdmin() || userressetTag)
								{
								//onClick="openWin('../userManage/userResFrame.jsp?userId=<pg:cell colName="userId" defaultValue="" />',screen.availWidth-50,screen.availHeight-100)"
								%>	
							    	<a style="cursor:hand" onClick="openWin('../userManage/userResFrame.jsp?userId=<pg:cell colName="userId" defaultValue="" />',screen.availWidth-50,screen.availHeight-100)">
							    	<IMG src="../images/new_doc.gif" border="0">
								<%
								}
								%>
							    </td>
							    
							    <td height='25' class="tablecells">
							    <%
				  			    boolean userrolesetTag = false;
				  			    for(int i=0;i<userOrgList.size();i++)
				  			    {
				  			    	Organization org = (Organization)userOrgList.get(i);
						  			if(control.checkPermission(org.getOrgId(),"userroleset",AccessControl.ORGUNIT_RESOURCE))
				  			    	{
				  			    		userrolesetTag = true;
				  			    		break;
				  			    	}
				  			    }
								if(control.isAdmin() || userrolesetTag)
								{
								%>
						    		<a style="cursor:hand" onClick="grantRole(<pg:cell colName="userId" defaultValue="" />)">
						    		<IMG src="../images/new_doc.gif" border="0">
							    <%
								}
								%>
							    </td>
							    
							    <td height='25' class="tablecells">
							    <%
				  			    boolean userorgsetTag = false;
				  			    for(int i=0;i<userOrgList.size();i++)
				  			    {
				  			    	Organization org = (Organization)userOrgList.get(i);
						  			if(control.checkPermission(org.getOrgId(),"userorgset",AccessControl.ORGUNIT_RESOURCE))
				  			    	{
				  			    		userorgsetTag = true;
				  			    		break;
				  			    	}
				  			    }
								if(control.isAdmin() || userorgsetTag)
								{
								%>
						    		<a style="cursor:hand" onClick="openWin('userOrg_iframe.jsp?userId=<pg:cell colName="userId" defaultValue=""/>',screen.availWidth-300,screen.availHeight-100)">
						    		<IMG src="../images/new_doc.gif" border="0">
						    	<%
								}
								%>
							    </td>
							    
							    <td height='25' class="tablecells">
							    <%
				  			    boolean edituserTag = false;
				  			    for(int i=0;i<userOrgList.size();i++)
				  			    {
				  			    	Organization org = (Organization)userOrgList.get(i);
						  			if(control.checkPermission(org.getOrgId(),"edituser",AccessControl.ORGUNIT_RESOURCE))
				  			    	{
				  			    		edituserTag = true;
				  			    		break;
				  			    	}
				  			    }
								if(control.isAdmin() || edituserTag)
								{
								%>  
						    		<a style="cursor:hand" onClick="var isOk = openWin('../userManage/userManager.do?method=getUser&userId=<pg:cell colName="userId" defaultValue=""/>',screen.availWidth-300,screen.availHeight-100); if(isOk=='ok'){changeType();}">
						    		<IMG src="../images/new_doc.gif" border="0">
						    	<%
								}
								%>
							    </td>
							    
					  	      </tr>			      		
			                </pg:list>	
			                </table>
			                <table align=center width="100%">
			                <tr height="18px" class="labeltable_middle_tr_01">
			      	          <td colspan=4 align='center'>��<pg:rowcount/>����¼&nbsp;&nbsp;<pg:index/></td>			      	          
			                </tr>
			                 <tr height="18px" class="labeltable_middle_tr_01">
			      	          <td colspan=4 align='right'>������
			      	          	<select name="intervalType" class="cms_select">
						                <option value="-1" >
						                    ��ѡ��
					                   </option>
					                   
					                   	<%
						  			    boolean useropenaccountTag = false;
						  			    for(int i=0;i<userOrgList.size();i++)
						  			    {
						  			    	//Organization org = (Organization)userOrgList.get(i);
						  			    	if(control.checkPermission(userOrgList.get(i).toString(),"useropenaccount",AccessControl.ORGUNIT_RESOURCE))
						  			    	{
						  			    		useropenaccountTag = true;
						  			    		break;
						  			    	}
						  			    }
										if(control.isAdmin() || useropenaccountTag)
										{
										%>
						               <option value="2" >
						                    ��ͨ�ʺ�
					                   </option>
					                   <%
										}
										%>
					                   
					                   <%
						  			    boolean usercloseaccountTag = false;
						  			    for(int i=0;i<userOrgList.size();i++)
						  			    {
						  			    	//Organization org = (Organization)userOrgList.get(i);
						  			    	if(control.checkPermission(userOrgList.get(i).toString(),"usercloseaccount",AccessControl.ORGUNIT_RESOURCE))
						  			    	{
						  			    		usercloseaccountTag = true;
						  			    		break;
						  			    	}
						  			    }
										if(control.isAdmin() || usercloseaccountTag)
										{
										%>
					                   <option value="3" >
						                    ͣ���˺�
					                   </option>
					                   <%
										}
										%>
					                   
					                   <%
						  			    boolean cmsdeleteuserTag = false;
						  			    for(int i=0;i<userOrgList.size();i++)
						  			    {
						  			    	//Organization org = (Organization)userOrgList.get(i);
						  			    	if(control.checkPermission(userOrgList.get(i).toString(),"cmsdeleteuser",AccessControl.ORGUNIT_RESOURCE))
						  			    	{
						  			    		cmsdeleteuserTag = true;
						  			    		break;
						  			    	}
						  			    }
										if(control.isAdmin() || cmsdeleteuserTag)
										{
										%>
					                   <option value="0" >
						                    ɾ���û�
					                   </option>
					                   <%
										}
										%>
					                   
					                   <%
						  			    boolean deleteuserTag = false;
						  			    for(int i=0;i<userOrgList.size();i++)
						  			    {
						  			    	//Organization org = (Organization)userOrgList.get(i);
						  			    	if(control.checkPermission(userOrgList.get(i).toString(),"deleteuser",AccessControl.ORGUNIT_RESOURCE))
						  			    	{
						  			    		deleteuserTag = true;
						  			    		break;
						  			    	}
						  			    }
										if(control.isAdmin() || deleteuserTag)
										{
										%>
					                   <option value="4" >
						                    ����ɾ��
					                   </option>
					                    <%
										}
										%>
					                   
					                </select>
									<input name="search" type="button" class="cms_button" value="ִ��" onClick="javascript:execute(1); return false;">
			      	          </td>			      	          
			                </tr>   
			    	    </table>
					   </pg:pager>
					   </FORM>
					</tab:tabPane>
<!-- -------------------------------------------------------------------------------------------------------------------------------------------	-->
					<tab:tabPane id="group-manage" tabTitle="��������" lazeload="true">
						<tab:iframe id="groupmanage" src="../orgManage/org_main.jsp" frameborder="0" scrolling="yes" width="100%" height="520">
						</tab:iframe>
					</tab:tabPane>
					<tab:tabPane id="res-manage" tabTitle="��Դ����" lazeload="true">
						<tab:iframe id="resmanage" src="../resManager/res_main.jsp" frameborder="0" scrolling="yes" width="100%" height="520">
						</tab:iframe>
					</tab:tabPane>
<!-------------------------------------------------------------------------------------------------------------------------------->
					<tab:tabPane id="role-manage" tabTitle="��ɫ����">
					  <FORM id="form2" name="form2" method="post" onSubmit="">
						 <table  width="100%" height="30" >
						      <tr>
						      
						         <td  align="right">
						             <FONT color="#8080c0">��ѯ::::</FONT>��ɫ����
						             <input name="roleName" type="text" size="20" class="cms_text" value=<%=QueryroleName%>>
	                                 <input name="search" type="button" class="cms_button" value="��ѯ" onClick="queryRole()">
	                             </td>
	                           </tr>
	                           <tr>
	                           		<td  height="10" align=right >
	                           			
	                           			<%
										ResourceManager resManager = new ResourceManager();
										String resId = resManager.getGlobalResourceid(AccessControl.ROLE_RESOURCE);
										if (resId != null && !resId.equals("") && control.checkPermission(resId,
	                       							"add", AccessControl.ROLE_RESOURCE))
										{
										%>
						  			    <a style="cursor:hand" onClick="openWin('../userManage/addRole.jsp?flag=0',screen.availWidth-600,screen.availHeight-300)">
						  			    <div class="DocumentOper"><img src="../images/new_doc.gif" class="operStyle">�½���ɫ</div></a>
										<%}%>
										
										<%
										resManager = new ResourceManager();
										resId = resManager.getGlobalResourceid(AccessControl.ROLE_RESOURCE);
										if (resId != null && !resId.equals("") && control.checkPermission(resId,
	                       							"cmsdelete", AccessControl.ROLE_RESOURCE))
										{
										%>
										<a style="cursor:hand" onClick="javascript:deleteRole(1); return false;">
						  			    <div class="DocumentOper"><img src="../images/new_doc.gif" class="operStyle">ɾ��</div></a>
						  			    <%}%>

						 			</td>
	                           </tr>
						    </table>
					
						<hr width="100%">
						<table width="100%" border="0" cellpadding="3" cellspacing="0" class="Templateedittable">
						    <pg:listdata dataInfo="InnerRoleList" keyName="InnerRoleList" />
							<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
							<pg:pager maxPageItems="10" scope="request" data="InnerRoleList" isList="false">
							<tr>
								<td width="10%" height="24"   bgcolor="#EDEFF6">
									<input type="checkBox" name="checkBoxAll2" onClick="checkAll2('checkBoxAll2','ID')">ȫѡ
								</td>
								<td width="15%" height="24"   bgcolor="#EDEFF6">����</td>
								<td width="25%" height="24"   bgcolor="#EDEFF6">����</td>
								<td width="15%" height="24"   bgcolor="#EDEFF6">��ɫ����</td>
								<td width="10%" height="24"   bgcolor="#EDEFF6">�û���Ա</td>
								<td width="10%" height="24"   bgcolor="#EDEFF6">Ȩ��</td>
							</tr>
							<pg:param name="roleId" />
							<pg:param name="roleName" />
							<!--��⵱ǰҳ���Ƿ��м�¼-->
							<pg:notify>
								<tr height="18px" class="labeltable_middle_tr_01">
									<td colspan=100 align='center'>
										��ʱû�н�ɫ
									</td>
								</tr>
							</pg:notify>	
								
								<!--list��ǩѭ�����ÿ����¼-->
							<pg:list>
								<pg:param name="roleId"/>
								<tr class="cms_data_tr" id="<pg:cell colName="roleId" defaultValue=""/>" onMouseOver="high(this)" onMouseOut="unhigh(this)">
									<td height='25' class="tablecells" nowrap="nowrap">
										<%
											String idValue = dataSet.getString("roleId");
											
										%>
										<input onClick="" type="checkbox" name="ID" value="<pg:cell colName="roleId" defaultValue=""/>" <%if("1".equals(idValue) || "2".equals(idValue) || "3".equals(idValue) || "4".equals(idValue)){%>disabled="true"<%}%>>
									</td>
									<td height='25' class="tablecells" nowrap="nowrap">

										<a style="cursor:hand" onClick="openWin('../userManage/addRole.jsp?roleId=<pg:cell colName="roleId" defaultValue="" />&flag=1',screen.availWidth-600,screen.availHeight-300)">
						  			    <pg:cell colName="roleName" defaultValue="" />
						  			    </a>
									</td>
									<td height='25' class="tablecells" nowrap="nowrap">
										<pg:cell colName="roleDesc" defaultValue="" maxlength="25" replace="..."/>
									</td>
									<%
										 //���ӽ�ɫ���͵�����
										 //baowen.liu 2008-4-25
										String roleTypeId = dataSet.getString("roleType");
						                RoleTypeManager rtm = new RoleTypeManager();
						                RoleType roleType=rtm.getRoleType(roleTypeId);
						                String roleTypeName = roleType.getTypeName();		
										
									%>
									<td>
										<%=roleTypeName%>
									</td>									
									<td height='25' class="tablecells" nowrap="nowrap">
										<a style="cursor:hand" onClick="selectuser('<pg:cell colName="roleId" defaultValue=""/>')">
						  			   	�鿴
						  			    </a>
									</td>
									
									<%
										String roleId = dataSet.getString("roleId");
										if (roleId != null && !roleId.equals("") && control.checkPermission(roleId,
	                       							"cmspermission", AccessControl.ROLE_RESOURCE))
										{
									%>
									<td height='25' class="tablecells" nowrap="nowrap">
						  			    <a style="cursor:hand" onClick="popedomSet(<pg:cell colName="roleId" defaultValue="" />)">
						  			  	<IMG src="../images/new_doc.gif" border="0">
						  			    </a>
									</td>
									<%}else{%><td></td><%}%>
									
								</tr>
							</pg:list>
							<tr height="18px" class="labeltable_middle_tr_01">
								<td colspan=6 align='center'>
								��<pg:rowcount/>����¼	<pg:index />
								</td>
							</tr>
							<input name="queryString" value="<pg:querystring/>" type="hidden">
						</pg:pager>						
					  </table>	
					  </FORM>
					</tab:tabPane>
				</tab:tabContainer>			
			</td>
		</tr>
  </table>	

<iframe name="exeman" width="0" height="0" style="display:none"></iframe>
</body>
</html>
