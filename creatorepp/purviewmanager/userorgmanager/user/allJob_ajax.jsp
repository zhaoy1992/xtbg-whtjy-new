<%
/*
 * <p>Title: ��λ����ҳ��</p>
 * <p>Description: ��λ����ҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-21
 * @author liangbing.tao
 * @version 1.0
 */
 %>


<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>

<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.OrgManager" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.JobManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.*" %>
<%@ page import="com.chinacreator.security.AccessControl" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.db.OrgManagerImpl"%>


<%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>

<%	
	 AccessControl accessControl = AccessControl.getInstance();
     accessControl.checkManagerAccess(request,response);
     String checks = request.getParameter("checks");
     String[] id =checks.split(",");
     String orgId = request.getParameter("orgId");
     //��ǰ�û���������ID
     //String curUserOrgId = accessControl.getChargeOrgId(); 
     UserManager userManager = SecurityDatabase.getUserManager();
     OrgManager orgManager = SecurityDatabase.getOrgManager();
     JobManager jobManager = SecurityDatabase.getJobManager();
     Organization org = orgManager.getOrgById(orgId);
     
	 OrgManagerImpl orgImpl = new OrgManagerImpl();	
     String idStr = "";
     String usern = "";
     String userna = "";
     for(int i = 0;i < id.length; i++)
     {
     	idStr += id[i]+",";
     	User user = userManager.getUserById(id[i]);
     	usern= user.getUserRealname();
     	//System.out.println(usern);
     	userna += usern + ",";
     }
     if(idStr.length() > 1)
     idStr = idStr.substring(0,idStr.length()-1);
     if(userna.length() > 1)
     userna = userna.substring(0,userna.length()-1);
     //System.out.println(userna);
     List allJob = jobManager.getJobList(org);
     request.setAttribute("existJob", null);
     //List allJob = (List)request.getAttribute("allJob"); 
     
     //Ȩ�޹��ˣ� �ܽ��и�λ����ĸ�λ�����ǣ���ǰ��¼�û����������Ź���Ա���������Щ��λ�л������õ�Ȩ�ޡ�
     List myAllJob = new ArrayList();
     if(allJob != null)
     {
    	for(int i=0;i<allJob.size();i++)
    	{
    		Job job = (Job)allJob.get(i);
    		if(accessControl.checkPermission(job.getJobId(), "jobset", AccessControl.JOB_RESOURCE))
    		{
    			myAllJob.add(job);
    		}
    	}
     }
 	 request.setAttribute("myAllJob", myAllJob);
 	
 	 //����Ա���Լ����������ɫ
 	 /*
     DBUtil db = new DBUtil();
    
     boolean tag = false;
     boolean tagSelf = false;
     String adminUsers = "�����û����ܽ��и�λ����:\\n";
     for(int j=0;j<id.length; j++){
     	//String sqlUser ="select count(*) from td_sm_userrole where user_id ="+ id[j] +" and role_id='1'";
		//db.executeSelect(sqlUser);
		User adminUser = userManager.getUserById(id[j]);
		
		if(accessControl.isAdminByUserid(id[j])){//�й���Ա��ɫ		    
			tag = true;						
			adminUsers += adminUser.getUserName() + " �ǳ�������Ա\\n";
		}
		
		//û�й���Ա��ɫ, ���Ǹ��Լ���Ȩ
		if(accessControl.getUserID().equals(id[j])){
			tag = true;
			adminUsers += adminUser.getUserName() + " ���ܸ��Լ������ɫ\\n";
		}
		
		 //�ǲ��Ź���Ա, Ҳ��������Ȩ
		 // �����Ź���Ա�������ø�λ  baowen.liu 2008-3-21
	     boolean managerOrgs = orgImpl.isCurOrgManager(orgId, id[j]);
	      if(managerOrgs && curUserOrgId.equals(orgId) && !accessControl.isAdmin()){
	         tag = true;
		     adminUsers += adminUser.getUserName() + " �뵱ǰ�û���ͬ�ȼ����Ź���Ա\\n";
	     }
     }
     */
%>
<html>
<head>    
<title>��������</title>
<SCRIPT LANGUAGE="JavaScript">
var id = "<%=idStr%>";   
function addRole(){	
	   var n=document.all("roleId").options.length-1;
	   	 	
	   for(var i=0;i<document.all("allist").options.length;i++)
	   {
		   var op=document.all("allist").options[i];
		   if(op.selected)
		   addone(op.text,op.value,n);
	   }
	   changebox(); 
}
function addone(name,value,n){

   for(var i=n;i>=0;i--){
		if(value==document.all("roleId").options[i].value){
		  return;
		}
	}
   var op=new Option(name,value);
   document.all("roleId").add(op);
   
}
function deleteall(){
	var length=document.all("roleId").options.length;
	var i = 0;
	var orgId = <%=orgId%>;
	var roleDelId=new Array(length);
				
	for (var m=length-1;m>=0;m--)
	{
	      roleDelId[i++]=document.all("roleId").options[m].value;
          document.all("roleId").options[m]=null;
    } 
    
    if(i >0)
    {
  		send_request('delUserJobAlot.jsp?roleDelId='+roleDelId+'&id='+id+'&orgId='+orgId);    
  	}
  	else
  	{
  		return ;
  	}
	
}
      
function addall(flag){
		var n=document.all("roleId").options.length-1;
		var p=document.all("allist").options.length-1;		  
	     for(var i=0;i<document.all("allist").options.length;i++){
	     var op=document.all("allist").options[i];
	     addone(op.text,op.value,n);  
	   }
	    changebox();  
}
function deleterole(){
	var leng=document.all("roleId").options.length;
	var i = 0;
	var orgId = <%=orgId%>;
	var roleDelId=new Array();
		for (var m=leng-1;m>=0;m--){
		    if(document.all("roleId").options[m].selected)
		    {
		    roleDelId[i++]=document.all("roleId").options[m].value;
	        document.all("roleId").options[m]=null;
	        }
	 	}
	 	//alert("liumeiyu" + roleDelId[0]);
	 	if(i > 0)
	 	{
	 		send_request('delUserJobAlot.jsp?roleDelId='+roleDelId+'&id='+id+'&orgId='+orgId); 
	 	}
	 	else
	 	{
	 		return ;
	 	}
}


function changebox(){				 
	var len=document.all("roleId").options.length;			  	 	
    var roleId=new Array(len);
    var orgId = <%=orgId%>;
    for (var i=0;i<len;i++){	      
        roleId[i]=document.all("roleId").options[i].value;
    }  
    if(len > 0)
    {      		
		send_request('saveUserJobAlot.jsp?roleId='+roleId+'&id='+id+'&orgId='+orgId);
	}
	else
	{
		return ;
	}
}

function imp()
{
	var orgId = "<%=orgId%>";
	var url = "lusersys_ajax.jsp?orgId=" + orgId;  
	win = window.showModalDialog(url,window,"dialogWidth:"+560+"px;dialogHeight:"+480+"px;help:no;scroll:auto;status:no");
	if(win == "ok"){
		  window.location.href = "allJob_ajax.jsp?checks=<%=checks%>&orgId=<%=orgId%>";
	}
}

function send_request(url){

	http_request = false;
	if(window.XMLHttpRequest){//Mozilla
			http_request = new XMLHttpRequest();
			if(http_request.overrideMimeType){//??MIME??
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
				return false;
			}
			http_request.onreadystatechange = processRequest;
			http_request.open("GET",url,true);
			http_request.send(null);
			}
			
function processRequest(){
	if(http_request.readyState == 4){				
		if(http_request.status == 200){		
			alert("�����ɹ�!");
		}
		else{
			alert("�Բ���,����������!");
		}
		document.all("button1").disabled = false;
		document.all("button2").disabled = false;
		document.all("button3").disabled = false;
		document.all("button4").disabled = false;
		
		document.all("button31").disabled = false;
		document.all("button32").disabled = false;
		
		divProcessing.style.display="none";
		
	}else{
		document.all("button1").disabled = true;
		document.all("button2").disabled = true;
		document.all("button3").disabled = true;
		document.all("button4").disabled = true;
		
		document.all("button31").disabled = true;
		document.all("button32").disabled = true;
		
		divProcessing.style.display="";
		
	}	
}
</SCRIPT>
  <link rel="stylesheet" type="text/css" href="../../css/windows.css">
  <link rel="stylesheet" type="text/css" href="../../css/treeview.css">
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
<div id="contentborder">
<center>
<form name="AlotUserRoleForm" action="" method="post" >
<table width="80%" border="0" cellpadding="0" cellspacing="1">
<tr class="tabletop">
    <td width="40%" align="center">&nbsp;</td>
    <td width="20%" align="center">&nbsp;</td>
    <td width="40%" align="center">&nbsp;</td>
  </tr>
  <tr class="tabletop">
    <td width="40%" align="center">��ѡ��λ</td>
    <td width="20%" align="center">&nbsp;</td>
    <td width="40%" align="center">����<%=userna%>�����λ</td>
  </tr>
  
  <tr >
     <td  align="right" >
     <select name="allist"  multiple style="width:80%" 
     
                 onDBLclick="addRole(1)"
     size="15">
     
				  <pg:list requestKey="myAllJob">
					<option value="<pg:cell colName="jobId"/>"><pg:cell colName="jobName"/></option>
				  </pg:list>			
	</select>
	</td>				  
		  	
    <td align="center"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="center"><input name="button1" type="button" class="input" value="&gt;" onclick="addRole()">              
            </td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
      </tr>
      <tr>
        <td align="center"><input name="button2" type="button" class="input" value="&gt;&gt;" 
			 onclick="addall()">  </td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
      </tr>
      <tr>
        <td align="center"><input name="button3" type="button" class="input" value="&lt;&lt;" onclick="deleteall()"></td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
      </tr>
      <tr>
        <td align="center"><input name="button4" type="button" class="input" value="&lt;" onclick="deleterole()">  
</td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
      </tr>
    </table></td>
    <td >
     <select name="roleId"  multiple style="width:80%" onDBLclick="deleterole()"  size="15">
	 </select>
	 	 						
	</td>				 
	<tr>
        <td align="center">&nbsp;</td>
      </tr>
      		  
  <tr>
  	<!--���ӻ������ø�λ  2008.3.21 liangbing.tao-->
    <td align="center">
    	<div align="right">
			<input name="button31" type="button" class="input" value="�������ø�λ" onclick="imp()">
    	</div>
    </td>	
     <td align="center">&nbsp;</td>						
     <td>
		<div align="left">
			<input name="button32" type="button" class="input" value="����" onclick="window.close();window.returnValue='ok';">
		</div>
	</td>							
  </tr>
 </table>
</form>
</center>
</div>
<br/>
<div id=divProcessing style="width:200px;height:30px;position:absolute;left:300px;top:380px;display:none">
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
</html>
