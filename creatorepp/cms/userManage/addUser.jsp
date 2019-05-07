
<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.config.ConfigManager" %>
				
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>


<%
	//AccessControl control = AccessControl.getInstance();
	//control.checkAccess(request,response);	
	response.setHeader("Cache-Control", "no-cache"); 
    response.setHeader("Pragma", "no-cache"); 
    response.setDateHeader("Expires", -1);  
    response.setDateHeader("max-age", 0);
	//UserInfoForm user = (UserInfoForm)request.getAttribute("currUser");
	int i = 0;
	//String orgName =(String) session.getAttribute("orgName");
	//String orgId = (String) session.getAttribute("orgId");
	//if(orgId==null || orgId==""){
	//	orgId="";
	//	orgName="";
	//}
	//else{
	//	session.setAttribute("orgName",null);
	//	session.setAttribute("orgId",null);
	//}
	//�û���¼���ĳ���--order by gao.tang
	String userNamelength = ConfigManager.getInstance().getConfigValue("userNameLength");
	String userType = request.getParameter("userType");
	if(userType==null){
		userType="0";
	}
%>
<html>
<head>
	<title>����û�</title>
	<script language="JavaScript" src="<%=request.getContextPath()%>/public/datetime/calender_date.js" ></script>
	<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
	<script src="../inc/js/func.js"></script>
	<SCRIPT language="JavaScript" SRC="../../sysmanager/user/validateForm.js"></SCRIPT>
	<tab:tabConfig/>
	<script language="javascript">
		function storeUser()
		{
				if(document.UserInfoForm.userName.value.length<1)
				{
		   		   alert("��½������Ϊ�գ������룡");
		   		   return;
		        }
		        
		        if(document.UserInfoForm.userName.value.search(/\W/g)!=-1 )
		        {
					alert("��½��ֻ��Ϊ���֡���ĸ���»���!");
					document.UserInfoForm.userName.focus();
					return false;
				}
		        
		        if(document.UserInfoForm.userRealname.value.length<1){
		   		   alert("��ʵ���Ʋ���Ϊ�գ������룡");
		   		   return;
		        }
		        
				if(document.UserInfoForm.userPassword.value.length<1)
				{
		   		   alert("�����벻��Ϊ�գ������룡");
		   		   return;
		        }
		        
		      if(document.UserInfoForm.userPassword1.value.length<1)
		      {
		   		   alert("��ȷ�������룡");
		   		   return;
		      }  
		      if(document.UserInfoForm.userPassword.value!=document.UserInfoForm.userPassword1.value)
		      {
		   		   alert("�������������벻���,���������룡");
		   		   return;
		      }
	        if(document.UserInfoForm.ou.value.length<1)
	        {
	   		   alert("��������Ϊ�գ������룡");
	   		   return;
	        } 
	        
	        if(document.UserInfoForm.userIdcard.value != "")
	        {
	        	var value = document.UserInfoForm.userIdcard.value ;
	        	
	        	if(!/(^[^\$\*&'=<#>%\^@~\s]+$)|(^$)/.test(value))
	        	{
	        		alert("��Ҫ������ �����֤���롱�����ݣ�\n���ݱ���Ϊ���Ϸ����ַ���������$*&'=<#>%^@~ ��");
	        		return false ;
	        	}
	        
	        	var len = document.UserInfoForm.userIdcard.value.length;	
	        	if(len != 15 && len != 18)
	        	{
	        		alert("���֤�����λ��ֻ����15λ��18λ!");
	        		return false ;
	        	}
	        }
		        
	        if (validateForm(UserInfoForm) )
	        {
			  	if(document.UserInfoForm.remark3.checked)
		    		document.UserInfoForm.remark3.value="��";
				else document.UserInfoForm.remark3.value="��";
				document.UserInfoForm.target = "saveuser"; 	
				document.UserInfoForm.action="../userManage/userManager.do?method=storeUser";
				document.UserInfoForm.submit();	
			}	
				
		}
		
		  
			function back(){
				window.close();
			}
			
			function showOrg(obj,param){
		        
		        var x=offsetLeft(obj)
		        var y=offsetTop(obj)*1-50;
		        var p=location.href;
		        var i=0;
		        //while(p.indexOf("/")>=0){
		        //    p=p.replace("/","");
		        //    i=i+1;
		        //}
		        //i=i-4;
		        //p="";
		   //   for (var j=0;j<i ;j++ )
		   //   {
		        //  p=p+"../"
		   //   }
		        window.showModalDialog( "<%=request.getContextPath()%>/cms/userManage/orgList.jsp?orgIdName="+param,window,'dialogheight:500px;dialogwidth:180px;dialogLeft:'+x+';dialogTop:'+y+'status:no;help:no');
		        //openWin('../userManage/orgList.jsp',200,400,x,y);
		        return;
		    }
		</script>
	</head>
	<body  bgcolor="#F7F8FC" >
	
		
			
				    <form name="UserInfoForm" method="post">
	
			
			<table width="90%" border="0" cellpadding="0" cellspacing="0" class="" align=center>
				
				<tr>						
					<td height="25" class="detailtitle">
						<strong></strong>��½��:<span class="STYLE1">*</span>
					</td>
					<td height="25">
						<input type="text" name="userName" value="" validator="string" cnname="��½��" maxlength="<%=userNamelength%>">
					</td>
					<td height="25" class="detailtitle">
								<STRONG></STRONG>��ʵ����:<span class="STYLE1">*</span></td>
						<td height="25">
						<input type="text" name="userRealname" value="" validator="string" cnname="��ʵ����" maxlength="100">
					</td>					
				</tr>
				<tr>						
					<td height="25" class="detailtitle">
								<STRONG></STRONG>����:<span class="STYLE1">*</span>	</td>
					<td height="25">
						<input type="password" name="userPassword" value="" validator="string" cnname="����" maxlength="100">
					</td>
					<td height="25" class="detailtitle">
								<STRONG></STRONG>ȷ������:<span class="STYLE1">*</span></td>
						<td height="25">
						<input type="password" name="userPassword1" value="" validator="string" cnname="ȷ������" maxlength="100">
					</td>					
				</tr>
				<tr>						
					
			        <td height="25" class="detailtitle">
			        	<strong></strong>��������:<span class="STYLE1">*</span>
			        </td>
					<td height="25">
							<input type="hidden" name="orgId" value="" />
							<input type="text" name="ou" value="" onclick="showOrg(this,document.all('orgId').value+';'+document.all('ou').value)" readonly="true" validator="string" cnname="��֯����" maxlength="100">
					</td>		  
					<td height="25" class="detailtitle">
								<STRONG> </STRONG>���֤����:
					</td>
					<td height="25">
						<input type="text" name="userIdcard" value=""   maxlength="18">
					</td>					
				</tr>
				
				<tr>
							<td height="25" class="detailtitle">
								<STRONG> </STRONG>��λ�绰:</td>						
					<td height="25">
						<input type="text" name="userWorktel" value=""  validator="intNull" cnname="��λ�绰" maxlength="13"></td>
					<td height="25" class="detailtitle">
								<STRONG> </STRONG>�Ա�:</td>
					<td height="25">					  					    
						    <dict:select type="sex" name="userSex" defaultValue="-1" textValue="--��ѡ���Ա�--"/>
					</tr>
				
				<tr>
							<td height="25" class="detailtitle">
								<STRONG> </STRONG>��ͥ�绰:</td>
					<td height="25">
								<input type="text" name="homePhone" value=""  validator="intNull" cnname="��ͥ�绰" maxlength="13"></td>				
					<td height="25" class="detailtitle">
								<STRONG> </STRONG>�����ʼ�:</td>
					<td height="25">
								<input type="text" name="mail" value="" validator="emailNull" cnname="�����ʼ�" maxlength="40"></td>
				</tr>
				
				<tr>
					<td height="25" class="detailtitle">
								 �ƶ��绰1:
							</td>
					<td height="25">
								<input type="text" name="mobile" value="" validator="intNull" cnname="�ƶ��绰" maxlength="13"></td>
					<td height="25" class="detailtitle"><STRONG> </STRONG>�ƶ��绰1������:</td>
					<td height="25">
								<input type="text" name="remark4" value="" validator="stringNull" cnname="�ƶ��绰1������" maxlength="100"></td>
				</tr>
				
				<tr><td height="25" class="detailtitle"> �ƶ��绰2</td>
					<td height="25">
						<input type="text" name="userMobiletel2" value="" validator="intNull" cnname="�ƶ��绰2" maxlength="13"></td>
					<td height="25" class="detailtitle"> �ƶ��绰2������:</td>
					<td height="25">
								<input type="text" name="remark5" value="" validator="stringNull" cnname="�ƶ��绰2������" maxlength="100"></td>
			   </tr>
			      
			   <tr><td height="25" class="detailtitle"> �û�����:</td>
				   <td height="25">
								<dict:select type="userType" name="userType" defaultValue="<%=userType%>" textValue="��ѡ���û�����"/></td>						
				   <td height="25" class="detailtitle"> ��������:</td>
				   <td height="25">
								<input type="text" name="tlb" value="" validator="intNull" cnname="��������" maxlength="7"></td>	
			   </tr>
						<tr>
							<td height="25" class="detailtitle">
								 ����:
							</td>
							<td height="25">
								<input type="text" name="userFax" value="" validator="intNull" cnname="����" maxlength="40">
							</td>
							<td height="25" class="detailtitle">
								 OICQ:
							</td>
							<td height="25">
								<input type="text" name="userOicq" value="" validator="intNull" cnname="OICQ" maxlength="13">
							</td>
						</tr>
						<tr>
							<td height="25" class="detailtitle">
								 ����:
							</td>
							<td height="25">
								<input type="text" name="userBirthday" onclick="showdate(document.all('userBirthday'))" readonly="true" value="" validator="stringNull" cnname="����" maxlength="40">
							</td>
							<td height="25" class="detailtitle">
								 �û���ַ:
							</td>
							<td height="25">
								<input type="text" name="userAddress" value="" validator="stringNull" cnname="�û���ַ" maxlength="200">
							</td>
						</tr>					
						<tr>
							<td height="25" class="detailtitle">
								<STRONG> </STRONG>�ֻ��̺���:
							</td>
							<td height="25">
								<input type="text" name="shortMobile" value="" validator="intNull"  cnname="�ֻ��̺���" maxlength="40">
							</td>
							<td height="25" class="detailtitle">
								��ͨ�û�
							</td>
							<td height="25">
								<dict:select type="isvalid" name="userIsvalid" expression="{userIsvalid}" />
							</td>
						</tr>
						<tr>
						<td height="25" class="detailtitle" colspan="4">
					
							<input type="checkbox" name="remark3" value="on">
							������Ϣ�Ƿ���
						
						</td>	
						</tr>							
			</table>
			 
			</form>
	
		
			<table width="100%"  cellpadding="2" cellspacing="0" >
				<tr>
					<td>
	
					<div align="center">
						<input name="resave" type="button" class="cms_button" value="����" onClick="storeUser()">
						<input name="resave" type="button" class="cms_button" value="�ر�" onClick="back()">									
					</div>
							
					</td>
				</tr>
			</table>
				
	  <iframe name="saveuser" width="0" height="0"></iframe>
	</body>
</html>
