<%@ include file="../../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@page import="com.chinacreator.security.*"  %>
<%@ page import="java.util.List,java.util.ArrayList,com.chinacreator.sysmgrcore.manager.SecurityDatabase,com.chinacreator.sysmgrcore.manager.UserManager"%>
<%
		AccessControl accesscontrol = AccessControl.getInstance();
    	accesscontrol.checkManagerAccess(request,response);
    	String userId = accesscontrol.getUserID();
	   String roleId = (String) session.getAttribute("currRoleId");

		String orgid = request.getParameter("orgId");
		if (roleId == null) {
			out.println("û��ѡ���ɫ��");
			return ;
		}
		
		UserManager userManager = SecurityDatabase.getUserManager();
		List existUser = userManager.getUsersListOfRoleInOrg(roleId, orgid);
		if (existUser == null) {
			existUser = new ArrayList();
		}
		request.setAttribute("existUser", existUser);

		if (roleId != null && !roleId.equals("") && orgid != null && !orgid.equals("")) {
			//��ȡ�����µ��û��б����Ұ��ջ���/��λ��źͻ���/��λ/��Ա�������
			 List allUser = userManager.getOrgUserList(orgid, userId);			
			if (allUser == null) {
				allUser = new ArrayList();
			}
			request.setAttribute("allUser", allUser);			
		}
%>
<html>
	<head>
		<title>��������</title>
		<script language="javascript" src="<%=request.getContextPath()%>/include/dragdiv.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
		<SCRIPT LANGUAGE="JavaScript"> 
function refurbish(){
	parent.roleUserList.document.location.href = parent.roleUserList.document.location.href;
}
function addRole(){	
   var n=document.all("userIds").options.length-1;
    var selectusers = "";
    if(document.all("allist").options.length < 1){
    	alert("û��Ҫ��ӵ��û���");
    	return;
    }
   for(var i=0;i<document.all("allist").options.length;i++){
	   var op=document.all("allist").options[i];
	   if(op.selected)
	   {	
	   		if(op.value=="<%=userId%>" && op.value!="1"){
	   			alert("���棺���ܸ��Լ����ý�ɫ��");
	   			return;
	   		}
	    	var retvalue =addone(op.text,op.value,n);
	    	if(retvalue)
	    	{
	    		if(selectusers == "" )
	    		{
		    		selectusers  += retvalue;
		    	}
		    	else
		    	{
		    		selectusers  +="," + retvalue;
		    	}
		    		
	    	}else{
	    		alert("��������û���");
	    		return;
	    	}
	    	
	   }
   
  }
  if(selectusers != "")
  {
  	send_request('<%=rootpath%>/sysmanager/accessmanager/role/savaRoleUser.jsp?roleId='+<%=roleId%>+'&userId='+selectusers+'&tag=add');
  }else{
  	alert("��ѡ��Ҫ��ӵ��û���");
  }
  
}
function addone(name,value,n){
   for(var i=n;i>=0;i--){
		if(value==document.all("userIds").options[i].value){
		  return;
		}
	}
   var op=new Option(name,value);
   document.all("userIds").add(op);
   return value;
   
}
function deleteall(){
	var selectusers = "";
	if(document.all("userIds").options.length < 1){
    	alert("û��Ҫɾ�����û���");
    	return;
    }
	for (var m=document.all("userIds").options.length-1;m>=0;m--)
	{
		var retvalue = document.all("userIds").options[m].value
		if(retvalue=="1" && "<%=roleId%>"=="1"){
			alert("����ɾ��ϵͳ����Ա��");
			return;
		}
		if(retvalue=="<%=userId%>" && retvalue!="1"){
	   		alert("���棺��ɾ���Լ��Ľ�ɫ��");
	   		return;
	   	}
		if(selectusers == "" )
		{
    		selectusers  += retvalue;
    	}
    	else
    	{
    		selectusers  += "," + retvalue;
    	}
		document.all("userIds").options[m]=null;
	}
	if(selectusers != "")
	{
		send_request('<%=rootpath%>/sysmanager/accessmanager/role/savaRoleUser.jsp?roleId='+<%=roleId%>+'&userId='+selectusers+'&tag=delete');
	}
	else
	{
		alert("��ѡ��Ҫɾ�����û���");
	}
    //changebox();
}
function addall(){
	var n=document.all("userIds").options.length-1;
	if(document.all("allist").options.length < 1){
    	alert("û��Ҫ��ӵ��û���");
    	return;
    }
    var selectusers = "";
     for(var i=0;i<document.all("allist").options.length;i++){     
	     var op=document.all("allist").options[i];
	     if(op.value=="<%=userId%>" && op.value!="1"){
	   		alert("���棺���ܸ��Լ����ý�ɫ��");
	   		return;
	   	 }
	     var retvalue = addone(op.text,op.value,n); 
	     if(retvalue)
    	{
    		if(selectusers == "" )
    		{
	    		selectusers  += retvalue;
	    	}
	    	else
	    	{
	    		selectusers  +="," + retvalue;
	    	}	
    	}
    	 
	}
	
	if(selectusers != "")
	{
		send_request('<%=rootpath%>/sysmanager/accessmanager/role/savaRoleUser.jsp?roleId='+<%=roleId%>+'&userId='+selectusers+'&tag=add');
	}
   
}
function deleterole()
{
	var selectusers = "";
	if(document.all("userIds").options.length < 1){
    	alert("û��Ҫɾ�����û���");
    	return;
    }
	 for (var m=document.all("userIds").options.length-1;m>=0;m--)
	 {
	      if(document.all("userIds").options[m].selected)
	      {
		    var retvalue = document.all("userIds").options[m].value
		    if(retvalue=="1" && "<%=roleId%>"=="1"){
		    	alert("����ɾ��ϵͳ����Ա��");
		    	return;
		    }
		    if(retvalue=="<%=userId%>" && retvalue!="1"){
	   			alert("���棺��ɾ���Լ��Ľ�ɫ��");
	   			return;
	   		}
		   	if(selectusers == "" )
			{
	    		selectusers  += retvalue;
	    	}
	    	else
	    	{
	    		selectusers  += "," + retvalue;
	    	}
	    	document.all("userIds").options[m]=null;
	     }
		      
		 
	  }
	  if(selectusers != "")
	  {
	  	send_request('<%=rootpath%>/sysmanager/accessmanager/role/savaRoleUser.jsp?roleId='+<%=roleId%>+'&userId='+selectusers+'&tag=delete');
	  }
	  else
	  {
	  	alert("��ѡ��Ҫɾ�����û���");
	  }
      
}


			
		
			
	function send_request(url){
		document.all.divProcessing.style.display = "block";
		document.OrgJobForm.action = url;
		document.OrgJobForm.target = "hiddenFrame";
		document.OrgJobForm.submit();
	}
	
			
</SCRIPT>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" onload="loadDragDiv()">
		<div id="contentborder" align="center">
			<center>
				<form name="OrgJobForm" action="" method="post">
					<table width="100%" border="0" cellpadding="0" cellspacing="1" class="table">
					<tr class="tabletop">
						    <td width="45%" align="center">&nbsp;</td>
						    <td width="10%" align="center">&nbsp;</td>
						    <td width="45%" align="center">&nbsp;</td>
						  </tr>
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
						    <td width="45%" align="center">&nbsp;</td>
						    <td width="10%" align="center">&nbsp;</td>
						    <td width="45%" align="center">&nbsp;</td>
						  </tr>
						<tr class="tr">
							<td class="td" align="center" ><div class="win" id="dd_1" align="left">
								<select class="select" name="allist" multiple style="width:98%" onDBLclick="addRole()" size="18">
									<pg:list requestKey="allUser" needClear="false">
										<option value="<pg:cell colName="userId"/>">
											<pg:cell colName="userRealname" />(<pg:cell colName="userName" />)
										</option>
									</pg:list>
								</select></div>
							</td>

							<td align="center" class="td">
								<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr class="tr">
										<td align="center" class="td">
											<input name="button1" type="button" class="input" value="&gt;" onclick="addRole()">
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
							<td class="td" align="center" ><div class="win" id="dd_2" align="left">
								<select class="select" name="userIds" multiple style="width:98%" onDBLclick="deleterole()" size="18">
									<pg:list requestKey="existUser" needClear="false">
										<option value="<pg:cell colName="userId"/>">
											<pg:cell colName="userRealname" />(<pg:cell colName="userName" />)
										</option>
									</pg:list>
								</select></div>
							</td>

						</tr>
						<tr class="tabletop">
						    <td  align="center">&nbsp;</td>
						  </tr>
						<tr class="tr">
							<td colspan="3" class="td" align="center">
								

							</td>
						</tr>
					</table>
				</form>
			</center>
		</div>
		<div id=divProcessing style="width:200px;height:30px;position:absolute;left:150px;top:350px;display:none">
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