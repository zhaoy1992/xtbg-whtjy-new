<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="java.util.List"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.User" %>

<%			
			String displayNameInput = request.getParameter("displayNameInput");
			String displayValueInput = request.getParameter("displayValueInput");
			String pkgId = request.getParameter("pkgId");
			String procDefId = request.getParameter("procDefId");
			String actorId = request.getParameter("actorId");
			String procDefName = request.getParameter("procDefName");
    if (procDefName == null)
        procDefName = (String) request.getAttribute("procDefName");
    String pkgName = request.getParameter("pkgName");
    if (pkgName == null)
        pkgName = (String) request.getAttribute("pkgName");
			

%>
<html>
	<head>
		<title>��������</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
		<SCRIPT LANGUAGE="JavaScript"> 
function addRole(){	
 	var selected = false;  
   for(var i=0;i < document.all("allist").options.length;i++)
   {
	   var op=document.all("allist").options[i];
	   
	   if(op.selected)
	   {
	   		addone("userIds",op.text,op.value);
	   		if(!selected)
	   			selected = true;
	    }   		    
   }
   if(!selected)
   		alert("��ѡ��ִ����");
}


function addone(inputname,name,value){
	
   for(var i= document.all(inputname).options.length - 1;i>=0;i--){
		if(value == document.all(inputname).options[i].value){
		  return;
		}
	}
	
   var op=new Option(name,value);
   
   op.setAttribute("optionname",name);
   document.all(inputname).add(op);
   
}


function deleteall(inputselect){
	for (var m=document.all(inputselect).options.length-1;m>=0;m--)
    document.all(inputselect).options[m]=null
}
      
function addall(){

	var p=document.all("allist").options.length-1;		  
     for(var i=0;i<document.all("allist").options.length;i++){
     var op=document.all("allist").options[i];
     addone("userIds",op.text,op.value);  
   }
}
function deleterole(){
 var selected = false;
 for (var m=document.all("userIds").options.length-1;m>=0;m--)
 {
      if(document.all("userIds").options[m].selected)
      {
     		document.all("userIds").options[m]=null;
     		if(!selected)
     			selected = true;
      }
 }
 if(!selected)
   		alert("��ѡ��Ҫɾ������");
}
function okadd(){	
	var len1=document.all("allist").options.length;	
	var len=document.all("userIds").options.length;	
	
	
	var ids = "";
	var names = "";
	var flag = false;
	
	for (var i=0;i<len;i++){	      
         document.all("userIds").options[i].selected = true;
     	 if(flag)
     	 {
	         ids += "," + document.all("userIds").options[i].value;
	         names += "," + document.all("userIds").options[i].optionname;
		 }
		 else
		 {
			 ids += document.all("userIds").options[i].value;
	         names += document.all("userIds").options[i].optionname;
	         flag = true;
		 }
        
     }
         
		
        
         document.forms[0].action="../workflowmanager/Usermapping.do?method=bindUser&userId="+ids;
         document.forms[0].submit();
         
         //parent.window.close();
         //parent.opener.location.href = parent.opener.location.href ;
}
function init()
{
	
         
	var displayNameInput = parent.window.opener.document.all.item("<%=displayNameInput%>").value ;

	
	var displayValueInput = parent.window.opener.document.all.item("<%=displayValueInput%>").value ;

	if(!displayNameInput || !displayValueInput)
	{
		return ;
	}

			var userNameArray = displayNameInput.split(",");		
			
			var userIdArray = displayValueInput.split(",");		
			
			deleteall("userIds");
			for(var i = 0; i < userNameArray.length; i ++ )
			{
				
				addone("userIds",userNameArray[i],userIdArray[i]);				
			}
	
}




</SCRIPT>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no" onload="init();" oncontextmenu="return false;">
		<div id="contentborder">

			<form name="OrgJobForm" action="" method="post" target="frame_bridge">
				<input type="hidden" name="pkgId" value="<%=pkgId%>">
				<input type="hidden" name="procDefId" value="<%=procDefId%>">
				<input type="hidden" name="actorId" value="<%=actorId%>">
				<input type="hidden" name="procDefName" value="<%=procDefName%>">
				<input type="hidden" name="pkgName" value="<%=pkgName%>">
				<div align="center">
					<table width="80%" border="0" cellpadding="0" cellspacing="1" class="table">
						<tr class="tabletop">
							<td width="40%" align="center">
								&nbsp;
							</td>
							<td width="20%" align="center">
								&nbsp;
							</td>
							<td width="40%" align="center">
								&nbsp;
							</td>
						</tr>
						<tr class="tr">
							<td class="td" width="40%" align="center">
								��ѡ��Ա
							</td>
							<td width="20%" class="td" align="center">
								&nbsp;

							</td>
							<td width="40%" align="center" class="td">
								��ѡ��
							</td>
						</tr>
						<tr class="tabletop">
							<td width="40%" align="center">
								&nbsp;
							</td>
							<td width="20%" align="center">
								&nbsp;
							</td>
							<td width="40%" align="center">
								&nbsp;
							</td>
						</tr>
						<tr class="tr">
							<td class="td" align="center">
								<select class="select" name="allist" id="allist" multiple style="width:90%" onDBLclick="addRole()" size="18">
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
											<input name="button3" type="button" class="input" value="&lt;&lt;" onclick="deleteall('userIds')">
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
								<select class="select" name="userIds" multiple style="width:90%" onDBLclick="deleterole()" size="18">
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
						<tr class="tabletop">
							<td align="center">
								&nbsp;
							</td>
						</tr>
						<tr class="tr">
							<td colspan="3" class="td" align="center">
								<input name="add" type="button" class="input" value="ȷ��" onclick="okadd()">
								<input name="add" type="button" class="input" value="����" onclick="parent.window.close();">

							</td>
						</tr>
					</table>
				</div>
				<div align="center"></div>
				<pg:beaninfo requestKey="userRoleForm">

					<input type="hidden" name="uid" value="<pg:cell colName="userId"  defaultValue=""/>" />
				</pg:beaninfo>
			</form>

		</div>
	</body>
</html>
