<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page
	import="com.chinacreator.security.AccessControl,
	com.chinacreator.sysmgrcore.entity.Job,
	com.chinacreator.sysmgrcore.manager.JobManager,
	com.chinacreator.sysmgrcore.manager.SecurityDatabase,
	com.chinacreator.sysmgrcore.manager.UserManager,java.util.*"%>
<%
	//String orgid = request.getParameter("orgId");
	String orgId1 = request.getParameter("orgId1");
	String jobId = request.getParameter("jobId");
	JobManager jm = SecurityDatabase.getJobManager();
	Job job = jm.getJobById(jobId);
	String jobName = job.getJobName();
	
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
   //��ӵ����û�
   var userIds = "";
   var flag1 = false;		
   var n=document.all("userIds").options.length-1;
   	 	
   for(var i=0;i<document.all("allist").options.length;i++){
   		
   
   var op=document.all("allist").options[i];
   
  
	   if(op.selected)
	   {
	   		 userIds = op.value;
	   		 addone(op.text,op.value,n);
	   	
	   }
  	   
   }
   
   	 var jobId="<%=jobId%>";
	 var orgId="<%=orgId1%>";
	 var flag ="1";
	   
	 send_request('<%=rootpath%>/sysmanager/orgmanager/savaUJO.jsp?jobId='+jobId+'&userId='+userIds+'&orgId='+orgId+'&flag='+flag);
  
  //changebox();
}
function addone(name,value,n){

   for(var i=n;i>=0;i--){
		if(value==document.all("userIds").options[i].value){
		  return;
		}
	}
   var op=new Option(name,value);
   document.all("userIds").add(op);
   
}

function addall(){
	//��������û�
    var userIds = "";
    var flag1 = false;	
	var n=document.all("userIds").options.length-1;
	var p=document.all("allist").options.length-1;		  
     for(var i=0;i<document.all("allist").options.length;i++){
     var op=document.all("allist").options[i];
     if(flag1)
		{
			
			userIds += "," + op.value;
		}
		else
		{
			userIds += op.value;
			flag1 = true;
		}
    
     addone(op.text,op.value,n);  
   }
     var jobId="<%=jobId%>";
	 var orgId="<%=orgId1%>";
	 var flag ="1";
	   
	 send_request('<%=rootpath%>/sysmanager/orgmanager/savaUJO.jsp?jobId='+jobId+'&userId='+userIds+'&orgId='+orgId+'&flag='+flag);
   
   //changebox();
}

function deleteall(){
	//ɾ�������û�
	var userIds = "";
	var flag1 = false;
	var len=document.all("userIds").options.length;
	 if(len == 0)
	 {
		alert("û�п�ɾ�����û���");
		return;
	 }	
	for (var m=document.all("userIds").options.length-1;m>=0;m--)
	{
		var option = document.all("userIds").options[m];
		if(flag1)
		{
			
			userIds += "," + option.value;
		}
		else
		{
			userIds += option.value;
			flag1 = true;
		}
		document.all("userIds").options[m]=null;
		
	}
	
	 		
	 if(window.confirm("��ȷ��Ҫȫ��ɾ����"))
	 {	
		 var jobId="<%=jobId%>";
		 var orgId="<%=orgId1%>";
		 var flag = "0";
		 send_request('<%=rootpath%>/sysmanager/orgmanager/savaUJO.jsp?jobId='+jobId+'&userId='+userIds+'&orgId='+orgId+'&flag='+flag);
	}
  	
	    
    //changebox();
      
}

function deleterole(){
	//ɾ�������û�
	var userIds = "";
	var flag1 = false;
 	for (var m=document.all("userIds").options.length-1;m>=0;m--){
 	
 		var option = document.all("userIds").options[m];
 		
 		if(document.all("userIds").options[m].selected)
 		{
			userIds = option.value;
	        document.all("userIds").options[m]=null;
	        flag1 = true;
	    }
 		
 	}
 	//if(!flag1)
 	//{
 	//	alert("��ѡ��Ҫɾ�����û���");
 	//	return;
 	//}
 	 var jobId="<%=jobId%>";
	 var orgId="<%=orgId1%>";
	 var flag = "0";
	 send_request('<%=rootpath%>/sysmanager/orgmanager/savaUJO.jsp?jobId='+jobId+'&userId='+userIds+'&orgId='+orgId+'&flag='+flag);
 	
	 //changebox();
}


function okadd(){
		var len1=document.all("allist").options.length;	
		var len=document.all("userIds").options.length;
	
		if(len1 ==0 && len == 0){
		alert("��û��ѡ�����");
		return;
		}	
		 alert("��Ա�����ɹ���");
         parent.window.opener.location = parent.window.opener.location;
         parent.window.close();
}
//---------------------------------------
var http_request = false;
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
					//alert(http_request.status);
					if(http_request.status == 200){
						//alert(http_request.responseText);
					}
					else{
						alert("�Բ��𣬷���������");
					}
				}
			}
			
			function changebox(){				 
			   	 var len=document.all("userIds").options.length;			  	 	
        		
        		 var jobId="<%=jobId%>";
        		 var orgId="<%=orgId1%>";
        		 var flag ="1";
        		 var userIds=new Array(len)
        		 for (var i=0;i<len;i++){	      
        		   userIds[i]=document.all("userIds").options[i].value;
         		 }   
         		send_request('<%=rootpath%>/sysmanager/orgmanager/savaUJO.jsp?jobId='+jobId+'&userId='+userIds+'&orgId='+orgId+'&flag='+flag);
				
			}
</SCRIPT>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
		<div id="contentborder" align="center">
			<center>
				<form name="OrgJobForm" action="" method="post">
					<table width="80%" border="0" cellpadding="0" cellspacing="1" class="table">
					<tr class="tabletop">
						    <td width="40%" align="center">&nbsp;</td>
						    <td width="20%" align="center">&nbsp;</td>
						    <td width="40%" align="center">&nbsp;</td>
						  </tr>
						<tr class="tr">
							<td class="td" width="40%" align="center">
								�����¿�ѡ�û�
							</td>
							<td width="20%" class="td" align="center">
								&nbsp;
							</td>
							<td width="40%" align="center" class="td">
								�������λ(<%=jobName%>)���û�
							</td>
						</tr>
						<tr class="tabletop">
						    <td width="40%" align="center">&nbsp;</td>
						    <td width="20%" align="center">&nbsp;</td>
						    <td width="40%" align="center">&nbsp;</td>
						  </tr>
						<tr class="tr">
							<td class="td" align="center" >
								<select class="select" name="allist"  style="width:90%" onDBLclick="addRole()" size="18">
									<pg:list requestKey="allUser" needClear="false">
										<option value="<pg:cell colName="userId"/>">
											<pg:cell colName="userRealname" />(<pg:cell colName="userName" />)
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
							<td class="td" align="center" >
								<select class="select" name="userIds"  style="width:90%" onDBLclick="deleterole()" size="18">
									<pg:list requestKey="existUser" needClear="false">
										<option value="<pg:cell colName="userId"/>">
											<pg:cell colName="userRealname" />(<pg:cell colName="userName" />)
										</option>
									</pg:list>
								</select>

							</td>

						</tr>
						<tr class="tabletop">
						    <td  align="center">&nbsp;</td>
						  </tr>
						<tr class="tr">
							<td colspan="3" class="td" align="center">
								

							</td>
						</tr>
						
					    <tr class="tr">
						    <td colspan="3" class="td" align="center">
							    <input name="add" type="button" class="input" value="ȷ��" onclick="okadd()">
							    <input name="exit" type="button" class="input" value="ȡ��" onclick="parent.window.close();">
							    
    						</td>
					    </tr>
					</table>
					<pg:beaninfo requestKey="userRoleForm">
						
						<input type="hidden" name="uid" value="<pg:cell colName="userId"  defaultValue=""/>" />
					</pg:beaninfo>
				</form>
			</center>
		</div>
	</body>
</html>
