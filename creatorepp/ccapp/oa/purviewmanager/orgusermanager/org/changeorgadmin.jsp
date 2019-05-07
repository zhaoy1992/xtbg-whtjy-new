<%-- 
������������ɫ��Ȩ����ҳ��
���ߣ�����ƽ
�汾��1.0
���ڣ�2013-05-24
 --%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page
	import="java.util.List
		   ,com.chinacreator.sysmgrcore.manager.UserManager
		   ,com.chinacreator.sysmgrcore.manager.OrgAdministrator
		   ,com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl
		   ,com.chinacreator.sysmgrcore.manager.SecurityDatabase
		   ,com.chinacreator.sysmgrcore.entity.User
		   ,com.chinacreator.security.AccessControl"%>
<%@ page
	import="com.chinacreator.sysmgrcore.purviewmanager.usercheckorg.api.UserCheckOrgFactory"%>
<%AccessControl accessControl = AccessControl.getInstance();
			accessControl.checkManagerAccess(request,response);

			String orgId = request.getParameter("orgId"); //ѡ��Ļ���
			String orgId1 = request.getParameter("orgId1"); //���û�������Ա�Ļ���
			String roleId = "3"; //���Ź���Ա��ɫ��ID:3

			UserManager userManager = SecurityDatabase.getUserManager();
			OrgAdministrator orgAdministrator = new OrgAdministratorImpl();
			List allUser = userManager.getOrgUserList(orgId); //��ȡ��ǰ�������û��б�
			List existUser = orgAdministrator.getAdministorsOfOrg(orgId1); //��ȡ�����ı������Ź���Ա

			//�����б�Ҫ���ε�ǰ�����û�
			//���α�����û�  ��ʢ 2011-3-10
			if ((allUser != null) && (allUser.size() > 0)) {
				for (int i = 0; i < allUser.size(); i++) {
					if (accessControl.getUserID().toString() == ((User) allUser
							.get(i)).getUserId().toString()
							|| accessControl.getUserID().toString().equals(
									((User) allUser.get(i)).getUserId()
											.toString())
											|| UserCheckOrgFactory.getIUserCheckOrgInstance().isSecondUserByOrgIDToMess(((User) allUser.get(i)).getUserId()
											.toString(),orgId,null)) {
						allUser.remove(i);
					}
				}
			}
			if ((existUser != null) && (existUser.size() > 0)) {
				for (int i = 0; i < existUser.size(); i++) {
					if (accessControl.getUserID().toString() == ((User) existUser
							.get(i)).getUserId().toString()
							|| accessControl.getUserID().toString().equals(
									((User) existUser.get(i)).getUserId()
											.toString())) {
						existUser.remove(i);
					}
				}
			}

			request.setAttribute("allUser", allUser);
			request.setAttribute("existUser", existUser);
%>
<html>
	<head>
		<title>���Ź���Ա��ɫ�����û�</title>
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
 		<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
		<SCRIPT LANGUAGE="JavaScript"> 
		
		function closethisdog()
		{
			window.returnValue = "okay";
			window.close();
		}
		
		function addUser(){	
      		var n=document.all("userIds").options.length-1;   	 	
      		var selectUsers = "";
   			for(var i=0;i<document.all("allist").options.length;i++){
   				var op=document.all("allist").options[i];
   				if(op.selected)
   				{
   				
   					if(addone(op.text,op.value,n))
   					{
	   					if(selectUsers == "")
	   					{
	   						selectUsers = op.value;   						
	   					}
	   					else
	   					{
	   						selectUsers += "," + op.value;
	   					}
	   				}
   					
   				}
  			}
  			if(selectUsers != "" )
  			{
  				send_request("changeOrgAdmin_do.jsp?userId="+selectUsers+"&orgId=<%=orgId%>&tag=add");
  			}
  			
  			//changebox();
		}
		function addone(name,value,n){
   			for(var i=n;i>=0;i--){
				if(value==document.all("userIds").options[i].value){
		  			return false;
				}
			}
   			var op=new Option(name,value);
   			document.all("userIds").add(op);
   			return true;
   			
   			
		}
		function deleteall(){
			var selectUsers = "";
			for (var m=document.all("userIds").options.length-1;m>=0;m--)
			{
				if(selectUsers == "")
				{
					selectUsers = document.all("userIds").options[m].value;   						
				}
				else
				{
					selectUsers += "," + document.all("userIds").options[m].value;
				}
				
				document.all("userIds").options[m]=null;//ɾ��һ��ȥ��һ��option
			}
			if(selectUsers != "" )
			{
				send_request("changeOrgAdmin_do.jsp?userId="+selectUsers+"&orgId=<%=orgId%>&tag=delete");
			}
    			
    		//changebox();
		}      
		function addall(){
		
			var n=document.all("userIds").options.length-1;
			var p=document.all("allist").options.length-1;		  
			var selectUsers = "";
     		for(var i=document.all("allist").options.length-1;i>=0;i--){
     			var op=document.all("allist").options[i];
     			if(addone(op.text,op.value,n))  
   				{	
   					if(selectUsers == "")
   					{
   						selectUsers = op.value;   						
   					}
   					else
   					{
   						selectUsers += "," + op.value;
   					}
   				}
   			}
   			if(selectUsers != "" )
  			{
  				send_request("changeOrgAdmin_do.jsp?userId="+selectUsers+"&orgId=<%=orgId%>&tag=add");
  			}
   			//changebox();
		}
		function deleterole(){
			var selectUsers = "";
 			for (var m=document.all("userIds").options.length-1;m>=0;m--)
 			{
	      		if(document.all("userIds").options[m].selected)
	      		{
		      		if(selectUsers == "")
   					{
   						selectUsers = document.all("userIds").options[m].value;;   						
   					}
   					else
   					{
   						selectUsers += "," + document.all("userIds").options[m].value;;
   					}
	      			
	      			document.all("userIds").options[m]=null;
	      		}
	      	}
	      	if(selectUsers != "")
	      	{
	      		send_request("changeOrgAdmin_do.jsp?userId="+selectUsers+"&orgId=<%=orgId%>&tag=delete");
	      	}
         			
         	//changebox();
		}

//---------------------------------------
		var http_request = false;
		//function send_request(url){
		//	http_request = false;
		//	//��ʼ��ʼ��XMLHttpRequest����
		//	if(window.XMLHttpRequest){//Mozilla
		//		http_request = new XMLHttpRequest();
		//		if(http_request.overrideMimeType){//����MIME���
		//			http_request.overrideMimeType("text/xml");						
		//		}
		//	}
		//	else if(window.ActiveXObject){//IE
		//		try{
		//			http_request = new ActiveXObject("Msxml2.XMLHTTP");
		//		}catch(e){
		//			try{
		//				http_request = new ActiveXObject("Microsoft.XMLHTTP");							
		//			}catch(e){
		//			}
		//		}
		//	}
		//	if(!http_request){
		//		alert("���ܴ���XMLHttpRequest����");
		//		return false;
		//	}
		//	http_request.onreadystatechange = processRequest;
		//	http_request.open("GET",url,true);
		//	http_request.send(null);
		//}
		
		function send_request(url){
			document.all.divProcessing.style.display = "block";
			document.all.button1.disabled = true;
			document.all.button2.disabled = true;
			document.all.button3.disabled = true;
			document.all.button4.disabled = true;
			document.all.button5.disabled = true;
			document.OrgAdminForm.action = url;
			document.OrgAdminForm.target = "hiddenFrame";
			document.OrgAdminForm.submit();
		}
			
		function processRequest(){
			if(http_request.readyState == 4){
				//alert(http_request.status);
				if(http_request.status == 200){
					//alert(http_request.responseText);
				}
				else{
					alert("�Բ��𣬷���������");
				}
			}
		}
			
		function changebox(tag, userIds){				 
		   	 var len=document.all("userIds").options.length;		
    		 var roleId="<%=roleId%>";
    		 var orgId="<%=orgId%>";
    		 var userIds=new Array(len)
    		 for (var i=0;i<len;i++){	      
    		   userIds[i]=document.all("userIds").options[i].value;
     		 }    
     		 //��Ҫ�޸�        		
			 send_request('changeOrgAdmin_do.jsp?roleId='+roleId+'&userId='+userIds+'&orgId='+orgId);
		}
</SCRIPT>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
		<div id="contentborder" align="center">
			<center>
				<form name="OrgAdminForm" action="" method="post">
					<table class="table">
						<tr>
							<td align=center nowrap>
								<font color=red>���²����б�����ʾ��ǰ�û�<font> <br>
							</td>
						</tr>
					</table>
					<table width="100%" border="0" cellpadding="0" cellspacing="1" class="table">
						<tr class="tabletop">
							<td width="45%" align="center"></td>
							<td width="10%" align="center">
								&nbsp;
							</td>
							<td width="45%" align="center">
								&nbsp;
							</td>
						<tr class="tr">
							<td class="td" width="45%" align="center">
								��ѡ�û�
							</td>
							<td width="10%" class="td" align="center">
								&nbsp;
							</td>
							<td width="45%" align="center" class="td">
								�������û�
							</td>
						</tr>
						<tr class="tabletop">
							<td width="45%" align="center">
								&nbsp;
							</td>
							<td width="10%" align="center">
								&nbsp;
							</td>
							<td width="45%" align="center">
								&nbsp;
							</td>
						</tr>
						<tr class="tr">
							<td class="td" align="center">
								<select class="select" name="allist" multiple style="width:100%" onDBLclick="addUser()" size="18">
									<pg:list requestKey="allUser" needClear="false">
										<option value="<pg:cell colName="userId"/>">
											<pg:cell colName="userRealname" />
											(
											<pg:cell colName="userName" />
											)
										</option>
									</pg:list>
								</select>
							</td>

							<td align="center" class="td">
								<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr class="tr">
										<td align="center" class="td">
											<input name="button1" type="button" class="input" value="&gt;" onclick="addUser()">
										</td>
									</tr>
									<tr class="tr">
										<td align="center" class="td">
											&nbsp;
										</td>
									</tr>
									<tr class="tr">
										<td align="center" class="td">
											<input name="button2" type="button" class="input" value="&gt;&gt;" onclick="addall()">
										</td>
									</tr>
									<tr class="tr">
										<td align="center" class="td">
											&nbsp;
										</td>
									</tr>
									<tr class="tr">
										<td align="center" class="td">
											<input name="button3" type="button" class="input" value="&lt;&lt;" onclick="deleteall()">
										</td>
									</tr>
									<tr class="tr">
										<td align="center" class="td">
											&nbsp;
										</td>
									</tr>
									<tr class="tr">
										<td align="center" class="td">
											<input name="button4" type="button" class="input" value="&lt;" onclick="deleterole()">
										</td>
									</tr>
									<tr class="tr">
										<td align="center" class="td">
											&nbsp;
										</td>
									</tr>
								</table>
							</td>
							<td class="td" align="center">
								<select class="select" name="userIds" multiple style="width:100%" onDBLclick="deleterole()" size="18">
									<pg:list requestKey="existUser" needClear="false">
										<option value="<pg:cell colName="userId"/>">
											<pg:cell colName="userRealname" />
											(
											<pg:cell colName="userName" />
											)
										</option>
									</pg:list>
								</select>
							</td>
						</tr>
					</table>
					<table width="100%" border="0" cellpadding="0" cellspacing="1" class="table">
						<tr class="tr">
							<td align="center" class="td">
								<br>
								<input name="button5" type="button" class="input" value="�ر�" onclick="closethisdog()">
							</td>
						</tr>
					</table>
					<input type="hidden" name="orgId" value="<%=orgId%>" />
					<input type="hidden" name="orgId1" value="<%=orgId1%>">
				</form>
			</center>
		</div>
		<div id=divProcessing style="width:200px;height:30px;position:absolute;left:120px;top:360px;display:none">
			<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%">
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
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</html>
