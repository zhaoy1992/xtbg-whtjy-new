<%
/**
 * <p>Title: ������λ����</p>
 * <p>Description: ������λ����</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-17
 * @author da.wei
 * @version 1.0
 **/
 %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.JobManager"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.form.OrgJobForm
				,com.chinacreator.sysmgrcore.entity.Organization
				,com.chinacreator.sysmgrcore.entity.Job
				,com.chinacreator.sysmgrcore.manager.db.OrgCacheManager"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>

<%

	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkManagerAccess(request,response);
	
	//Ҫ��ʹ��ajax���userjoborg.jsp�����frameҲû�ĵ�������struts config�����forward
	String orgId = request.getParameter("orgId");
	if(orgId == null){
		orgId=(String)request.getAttribute("orgId");
	}
	
	OrgJobForm object = (OrgJobForm)session.getAttribute("orgjobForm");

	Organization organization = new Organization();
	organization = OrgCacheManager.getInstance().getOrganization(object.getOrgId());
    	String jobId=(String)request.getAttribute("curjobid");
    	if(jobId ==null){
    		jobId = "";
    	}
    JobManager jobManager = SecurityDatabase.getJobManager();
    
	List joblist = jobManager.getJobList();
	
	
	
    
    //���ֻ������Ȩ�޽��л�����λ����ĸ�λ : �Լ�����ĸ�λ �� ��������ĸ�λ
    List list1 = new ArrayList();
    String popedomJobIds = "";
    if(joblist != null)
    {
    	for(int i=0;i<joblist.size();i++)
    	{
    		Job job = (Job)joblist.get(i);
    		if(accessControl.checkPermission(job.getJobId(), "jobset", AccessControl.JOB_RESOURCE))
    		{
    			list1.add(job);
    			if("".equals(popedomJobIds)){
    				popedomJobIds = job.getJobId();
    			}else{
    				popedomJobIds += "," + job.getJobId();
    			}
    		}
    	}
    }
    
    //���Լ���Ȩ�޵ĸ�λ��������
    List orgjoblist = jobManager.getJobList(organization);
    
    List list2 = new ArrayList();
    
    if(orgjoblist != null)
    {
    	for(int i=0; i<orgjoblist.size(); i++)
    	{
    		Job job =(Job) orgjoblist.get(i);
    		
    		if(accessControl.checkPermission(job.getJobId(), "jobset", AccessControl.JOB_RESOURCE))
    		{
    			list2.add(job);
    		}
    	}
    }
    
    //��Ȩ�޵ĸ�λID
    String[] popedomJobId = popedomJobIds.split(",");
     
	request.setAttribute("joblist1",list1);
	request.setAttribute("orgjoblist1",list2);
	
    
%>
<html>
<head>    
  	<title>��������</title>
	<SCRIPT LANGUAGE="JavaScript">
	
	var http_request = false;
	//��ʼ����ָ������ĺ�������������ĺ���
	function send_request(url){
	    document.all.divProcessing.style.display="block";
	    
	    document.all.button1.disabled = true;
	    document.all.button2.disabled = true;
	    document.all.button3.disabled = true;
	    document.all.button4.disabled = true;
	    document.all.button11.disabled = true;
	    document.all.button22.disabled = true;
	    document.all.button33.disabled = true;
	    document.all.button44.disabled = true;
	    document.all.button55.disabled = true;
	    document.all.button111.disabled = true;
	    document.all.button222.disabled = true;
	    document.all.button333.disabled = true;
		
		document.OrgJobForm.action = url;
		document.OrgJobForm.target = "hiddenFrame";
		document.OrgJobForm.submit();
	}
	
	/*
	function processRequest(){
		if(http_request.readyState == 4){
			if(http_request.status == 200){
				//alert(http_request.responseText);
			}
			else{
				alert("�Բ��𣬷���������");
			}
		}
	} 
	*/
	function addone(name,value,n,orgId){
	   var jobSn=document.all("jobId").options.length+1;
	   for(var i=n;i>=0;i--){
			if(value==document.all("jobId").options[i].value){
			  return;
			}
		}
	   var op=new Option(name,value);
	   document.all("jobId").add(op);	   
	}
	
	function addjob(){	
	   //�����õĸ�λ
	   var alreadyJobArr = document.all("jobId") ;
	   var n=document.all("jobId").options.length-1;
	   var orgId = document.all("orgId").value;	
	   var jobSn = n+2;
	   var jobIds = "";
	   var alreadyJobs = "";   	 	
	   for(var i=0;i<document.all("allist").options.length;i++){
		   var op=document.all("allist").options[i];
		   if(op.selected){	
		   	   var flag = false;
		   	   for(var j = 0; j < alreadyJobArr.length; j++){
		   	   	   if(op.text==alreadyJobArr.options[j].text){
		   	   	   		flag = true;
		   	   	   }
			   }
			   if(!flag){
			   		addone(op.text,op.value,n,orgId);
					if(jobIds=="") jobIds = jobIds + op.value;
					else jobIds = jobIds + "," + op.value;
			   }else{
			   		if(alreadyJobs=="") alreadyJobs = alreadyJobs + op.text;
					else alreadyJobs = alreadyJobs + "\n" + op.text;
			   }
		   }
		   
	  }
	  if(jobIds != ""){
	  	send_request('orgjobchange.jsp?jobId='+jobIds+'&orgId='+orgId+'&jobSn='+jobSn);
	  }else if(alreadyJobs != ""){
	  	alert("���¸�λ�Ѿ����ã�\n" + alreadyJobs);
	  	return;
	  }else{
	  	alert("��ѡ��Ҫ��ӵĸ�λ����!");
	  	return;
	  }
	  
	}	
	
	function deleteall()
	{
			var orgId = document.all("orgId").value;
			var jobIds = "";
			var returnJobInfo = "";
			var flag = false;   	 
			for (var m=document.all("jobId").options.length-1;m>=0;m--){
	    		op = document.all("jobId").options[m];
	    		<%for(int i = 0; i < popedomJobId.length; i++){
	        		String popedomJobIdStr = popedomJobId[i];
	        	%>
	        	if(op.value=="<%=popedomJobIdStr%>"){
	        		flag = true;
					jobIds += op.value + ",";
				}
				<%}%>
				if(!flag){
		        	if(returnJobInfo==""){
						returnJobInfo = op.text;
					}else{
						returnJobInfo += "\n" + op.text;
					}
				}
				flag = false;
	   		}
	   		
	   		if(returnJobInfo!="")
	   		{
	        	alert("�����¸�λû��Ȩ�ޡ�\n"+returnJobInfo);
	        	return false;
	        }
	        
	         if(jobIds != "")
	        {
	        	if(window.confirm("��ȷ��Ҫɾ�����и�λ��(ɾ����Ӱ��ø�λ�µ����н�ɫ���û�!)"))
	        	{
		         	for (var n=parent.frames[1].document.all("userList").options.length-1;n>=0;n--)
		         	{
		    			parent.frames[1].document.all("userList").options[n]=null;
		    		}
		    		
		    		for (var m=document.all("jobId").options.length-1;m>=0;m--)
		    		{
		    			document.all("jobId").options[m] = null;
		    		}
		    		
			         send_request('orgjobchange.jsp?jobId='+jobIds+'&orgId='+orgId+'&jobSn=-1');	    	
			    }
	        }
	        else
	        {
	        	alert("��ѡ��Ҫɾ���ĸ�λ����!");
	        }	
	        
	}
	function addsuborg()
	{
		var orgId = document.all("orgId").value;
		var joblen = document.all("jobId").options.length;
		var jobIds = "";
		var returnJobInfo = "";
		var flag = false;
		var isSelectedJob = false;
		for(var i=0;i<joblen;i++)
		{       
        	if(document.all("jobId").options[i].selected){ 
        		var op = document.all("jobId").options[i];
        		isSelectedJob = true;
        	<%for(int i = 0; i < popedomJobId.length; i++){
        		String popedomJobIdStr = popedomJobId[i];
        	%>
        		if(op.value=="<%=popedomJobIdStr%>"){
        			jobIds += op.value + ",";
        			flag = true;
        		}
        	<%}%>
        		if(!flag){
		        	if(returnJobInfo==""){
						returnJobInfo = op.text;
					}else{
						returnJobInfo += "\n" + op.text;
					}
				}
				flag = false;
	   		}
        }
        if(jobIds.indexOf(",") != -1)
        	jobIds = jobIds.substring(0,jobIds.length - 1);
        if(returnJobInfo!=""){
        	alert("�����¸�λû��Ȩ�ޡ�\n"+returnJobInfo);
        }
        if(!isSelectedJob)
        {
        	alert("��ӡ������ø�λ��ѡ��Ҫ�ݹ������ӻ����ĸ�λ��");
        	return false;
        }
        if(jobIds!=""){
			send_request("orgjobchange.jsp?orgId=" + orgId + "&jobIds=" + jobIds);
		}else{
			alert("��ѡ��Ҫ��ӵĸ�λ����!");
		}
	}
	
	     
	function addall(){
		//�����õĸ�λ
	   var alreadyJobArr = document.all("jobId") ;
		var orgId = document.all("orgId").value;
		var jobSn=document.all("jobId").options.length+1;
		var n=document.all("jobId").options.length-1;
		var p=document.all("allist").options.length-1;	
		var jobIds = "";
		var alreadyJobs = "";	  
	    for(var i=0;i<document.all("allist").options.length;i++){
	         var op=document.all("allist").options[i];
	         var jobId = op.value;
	         var flag = false;
		   	   for(var j = 0; j < alreadyJobArr.length; j++){
		   	   	   if(op.text==alreadyJobArr.options[j].text){
		   	   	   		flag = true;
		   	   	   }
			   }
			   if(!flag){
			   		addone(op.text,op.value,n,orgId); 
			         if(jobIds=="") jobIds = jobIds + jobId;
					 else jobIds = jobIds + "," + jobId;
			   }else{
			   		if(alreadyJobs=="") alreadyJobs = alreadyJobs + op.text;
					else alreadyJobs = alreadyJobs + "\n" + op.text;
			   }
	   }
	   if(jobIds !=""){
		   send_request('orgjobchange.jsp?jobId='+jobIds+'&orgId='+orgId+'&jobSn='+jobSn); 
	   }else if(alreadyJobs != ""){
	   	   alert("���¸�λ�Ѿ����ã�\n" + alreadyJobs);
	  		return;
	   }
	}
	function deletejob(){
		
			var jobId = false;
			var jobIds = "";
			var orgId = document.all("orgId").value;
			var returnJobInfo = "";
			var flag = false;
	 		for (var m=document.all("jobId").options.length-1;m>=0;m--){
		    	if(document.all("jobId").options[m].selected){
	         		op = document.all("jobId").options[m];
	         		<%for(int i = 0; i < popedomJobId.length; i++){
		        		String popedomJobIdStr = popedomJobId[i];
		        	%>
		        	if(op.value=="<%=popedomJobIdStr%>"){
		        		flag = true;
						//document.all("jobId").options[m]=null;
						if(jobIds==""){
							jobIds = op.value;
						}else{
							jobIds += "," + op.value;
						}
					}
					<%}%>
					if(!flag){
						if(returnJobInfo==""){
							returnJobInfo = op.text;
						}else{
							returnJobInfo += "\n" + op.text;
						}
					}
					flag = false;
	         	}
	        }
	        if(returnJobInfo!=""){
	        	alert("�����¸�λû��Ȩ�ޡ�\n"+returnJobInfo);
	        	return false;
	        }
	        
	        if(jobIds != "")
	        {
	        	if(window.confirm("��ȷ��Ҫɾ����ѡ��λ��(ɾ����Ӱ��ø�λ�µ����н�ɫ���û�!)"))
	        	{
		         	for (var n=parent.frames[1].document.all("userList").options.length-1;n>=0;n--)
		         	{
		    			parent.frames[1].document.all("userList").options[n]=null;
		    		}
		    		
		    		for (var m=document.all("jobId").options.length-1;m>=0;m--)
		    		{
		    			if(document.all("jobId").options[m].selected)
		    			{
		    				document.all("jobId").options[m] = null;
		    			}
		    		}
	    		
			         send_request('orgjobchange.jsp?jobId='+jobIds+'&orgId='+orgId+'&jobSn=-1');	    	
			    }
	        }
	        else
	        {
	        	alert("��ѡ��Ҫɾ���ĸ�λ����!");
	        }
	}
	
	function deletesuborg(){
		
			var jobId = false;
			var jobIds = "";
			var orgId = document.all("orgId").value;
			var returnJobInfo = "";
			var flag = false;
			var isSelectedJob = false;
	 		for (var m=document.all("jobId").options.length-1;m>=0;m--){
		    	if(document.all("jobId").options[m].selected){
		    		var op = document.all("jobId").options[m];
		    		isSelectedJob = true;
		    		<%for(int i = 0; i < popedomJobId.length; i++){
		        		String popedomJobIdStr = popedomJobId[i];
		        	%>
		        	if(op.value=="<%=popedomJobIdStr%>"){
		        		flag = true;
						document.all("jobId").options[m]=null;
						if(jobIds==""){ 
							jobIds = op.value;
						}else{
							jobIds += "," + op.value;
						}
					}
					<%}%>
					if(!flag){
						if(returnJobInfo==""){
							returnJobInfo = op.text;
						}else{
							returnJobInfo += "\n" + op.text;						
						}
					}
					flag = false;
	         	}
	         }
	        if(returnJobInfo!=""){
	        	alert("�����¸�λû��Ȩ�ޡ�\n"+returnJobInfo);
	        }
	        if(!isSelectedJob){
	        	alert("��ӡ������ø�λ��ѡ��Ҫ�ݹ������ӻ����ĸ�λ��");
	        	return false;
	        }
         	for (var n=parent.frames[1].document.all("userList").options.length-1;n>=0;n--)
    			parent.frames[1].document.all("userList").options[n]=null;
    		if(jobIds!=""){
    			if(window.confirm("��ȷ��Ҫɾ����(ɾ����Ӱ��ø�λ�µ����н�ɫ���û���)")){
            		send_request('orgjobchange.jsp?jobId='+jobIds+'&orgId='+orgId+'&jobSn=-2');	    	
            	}
            }else{
            	alert("��ѡ��Ҫɾ���ĸ�λ����!");
            }
	}
	
	
	function sendJob(){     
       var orgId = document.all("orgId").value;
       var len=document.all("jobId").options.length;
       var jobId=new Array()
       for (var i=0;i<len;i++){       
         jobId[i]=document.all("jobId").options[i].value;
        }   
	   send_request('jobsnchange.jsp?orgId='+orgId+'&jobId0='+jobId);
   }
	
	
	
	function up1() {
		var len=document.all("jobId").options.length;
		var isselected = 0;
		for (var i=0;i<len;i++){
			var op=document.all("jobId").options[i];
	   		if(op.selected){   			
	   			isselected = 1;
	   		}
	   	}
	   	if(isselected == 0){
	   		alert("����ѡ��һ����λ�ٽ��д˲���");
	   		return;
	   	}
		for (var i=0;i<len;i++){
			var op=document.all("jobId").options[i];
	   		if(op.selected){   			
	   			var tmp = new Option(op.text,op.value);
	   			if(i>0){
	   				var jobId1 = tmp.value;	   				
	   				var orgId = document.all("orgId").value;
	   				var dest = document.all("jobId").options[i-1];
	   				var jobId2 = dest.value;
	   				var jobSn = i;
	   				document.all("jobId").options[i-1] = tmp;
	   				document.all("jobId").options[i] = dest;
	   				document.all("jobId").options[i-1].selected=true;
	   				send_request('jobsnchange.jsp?jobId1='+jobId1+'&jobId2='+jobId2+'&orgId='+orgId+'&jobSn='+jobSn);
	   			}
	   		}
	    }
	}
	function upall() {
		var len=document.all("jobId").options.length;	
		var isselected = 0;
		for (var i=0;i<len;i++){
			var op=document.all("jobId").options[i];
	   		if(op.selected){   			
	   			isselected = 1;
	   		}
	   	}
	   	if(isselected == 0){
	   		alert("����ѡ��һ����λ�ٽ��д˲���");
	   		return;
	   	}
		for (var i=0;i<len;i++){
			var op=document.all("jobId").options[i];
	   		if(op.selected){   			
	   			var tmp = new Option(op.text,op.value);
	   			op.selected = false;   			
	   			var j=i;   			
	   			for(;j>=1;j--){     				
	   				var atmp =  document.all("jobId").options[j-1];   				
	   				var btmp = new Option(atmp.text,atmp.value);   				
	   				document.all("jobId").options[j] = btmp;
	   			}   			
	   			document.all("jobId").options[0] = tmp;
	   			break;	
	   		}
	    }  
	    sendJob();
	    document.all("jobId").options[0].selected=true;
	}
	
	function down1() {
		var len=document.all("jobId").options.length;
		var isselected = 0;
		for (var i=0;i<len;i++){
			var op=document.all("jobId").options[i];
	   		if(op.selected){   			
	   			isselected = 1;
	   		}
	   	}
	   	if(isselected == 0){
	   		alert("����ѡ��һ����λ�ٽ��д˲���");
	   		return;
	   	}
		var flag = 0;
		for (var i=0;i<len;i++){
			var op=document.all("jobId").options[i];
	   		if(op.selected){   			
	   			var tmp = new Option(op.text,op.value);   			
	   			op.selected=false;
	   			if(i == len-1){
	   				flag = len-2;
	   			}
	   			else {
	   				flag = i;
	   			}
	   			if(i<len-1){
	   				var dest = document.all("jobId").options[i+1];
	   				var jobId2 = tmp.value;	   				
	   				var orgId = document.all("orgId").value;
	   				var jobId1 = dest.value;
	   				var jobSn = i;
	   				document.all("jobId").options[i+1] = tmp;
	   				document.all("jobId").options[i] = dest;
	   				send_request('jobsnchange.jsp?jobId1='+jobId1+'&jobId2='+jobId2+'&orgId='+orgId+'&jobSn='+jobSn);
	   			}
	   		}
	    }
	    document.all("jobId").options[flag+1].selected=true;
	}
	
	function downall() {
		var len=document.all("jobId").options.length;
		var isselected = 0;
		for (var i=0;i<len;i++){
			var op=document.all("jobId").options[i];
	   		if(op.selected){   			
	   			isselected = 1;
	   		}
	   	}
	   	if(isselected == 0){
	   		alert("����ѡ��һ����λ�ٽ��д˲���");
	   		return;
	   	}	
		for (var i=0;i<len;i++){
			var op=document.all("jobId").options[i];
	   		if(op.selected){   			
	   			var tmp = new Option(op.text,op.value);
	   			op.selected = false;   			
	   			var j=i;   			
	   			for(;j<len-1;j++){     				
	   				var atmp =  document.all("jobId").options[j+1];   				
	   				var btmp = new Option(atmp.text,atmp.value);   				
	   				document.all("jobId").options[j] = btmp;   				
	   			}   			
	   			document.all("jobId").options[len-1] = tmp;	
	   		}
	    }
	    sendJob();
	    document.all("jobId").options[len-1].selected=true;
	}
	//��ʾ�ұ߿�ܵ��û��б�
	function showUserList(){
			
		var curjobId;
		//�����ø�λ����
		var len=document.all("jobId").options.length;
		var isnew = 0;
		var orgId = document.all("orgId").value;
		var jobSn=0;
		for (var i=0;i<len;i++){
	      	if(document.all("jobId").options[i].selected){      		
	        	curjobId = document.all("jobId").options[i].value;
	        	jobSn++;
	        	//var strs = curjobId.split(";");
	        	//û�б���ĸ�λ
	        	//if(strs.length == 2){
	        	//	isnew = "1";
	        	//	parent.frames[1].document.forms[0].button1.disabled=true;
	        	//	parent.frames[1].document.forms[0].button2.disabled=true;
	        	//	parent.frames[1].document.forms[0].button3.disabled=true;
	        	//	parent.frames[1].document.forms[0].button4.disabled=true;
	        		//parent.frames[1].document.forms[0].button11.disabled=true;
	        		//parent.frames[1].document.forms[0].button22.disabled=true;
	        		//parent.frames[1].document.forms[0].button33.disabled=true;
	        		//parent.frames[1].document.forms[0].button44.disabled=true;
	        		//parent.frames[1].document.forms[0].button55.disabled=true;
	        		//parent.frames[1].document.forms[0].button111.disabled=true;
	        		//parent.frames[1].document.forms[0].button222.disabled=true;
	        		//parent.frames[1].document.forms[0].button333.disabled=true;	        		
	        	//	for (var n=parent.frames[1].document.all("userList").options.length-1;n>=0;n--)
	    		//		parent.frames[1].document.all("userList").options[n]=null;
	        	//	alert("���ȱ���");
	        	//	return;
	        	//}
	        }
	    }
	    if(jobSn == 1){
	    	document.all("jobId").disabled = true;
	    	document.all.divProcessing.style.display="block";
			parent.frames[1].location.href="rusersys_ajax.jsp?curjobid="+curjobId+"&orgId="+orgId+"&jobSn="+jobSn;
		}
		
	}
	
	//������λ��ɫ����
	function roleset(){
		var len=document.all("jobId").options.length;
		var isselected = 0;
		for (var i=0;i<len;i++){
			var op=document.all("jobId").options[i];
		   	if(op.selected){   			
		   		isselected = 1;
		   	}
		}
		if(isselected == 0){
			alert("����ѡ��һ����λ�ٽ��д˲���");
			return;
		}
		var jobIdValue = document.all("jobId").value;
		var url = "jobList_ajax.jsp?orgId=<%=organization.getOrgId()%>&jobId=" + jobIdValue;
		window.showModalDialog(url,"","dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no");
		showUserList();
	}
    </SCRIPT>
    <link rel="stylesheet" type="text/css" href="../../css/windows.css">
	<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
    <script language="javascript" src="../../scripts/dragdiv.js"></script>
    <script language="JavaScript" src="../../../include/querySelect.js" type="text/javascript"></script>
<%@ include file="/epp/css/cssControl.jsp"%><body  onload="loadDragDiv();">
<form name="OrgJobForm" target="hiddenFrame" action="" method="post" >

<table width="100%" border="0" cellpadding="1" cellspacing="1">
	<input name="popedomJobIds" value="<%=popedomJobIds%>" type="hidden">
  <tr >
    <!--<td width="40%" align="center" class="detailtitle">��ѡ��λ</td>-->
    <td width="40%" align="left" >��ѡ��λ</td>
    <td width="20%" align="center" >&nbsp;</td>
    <td width="40%" align="right" >�����ø�λ</td>
    <td width="20%" align="center" >&nbsp;</td>
  </tr>
   <tr>
  	<td width="40%" align="left">
  		<input name="selectRoles" type="text" value="" onkeydown="enterKeydowngo()" onpropertychange="onBlurryQueryChange()" ondblclick=""  />
  		<input name="que" type="button" value="��ѯ" onclick="blurryQuary()" class="input" />
  		<input name="nextQue" style="display:none" type="button" value="������һ��" onclick="nextQuery()" class="input" />
  	</td>
    <td width="20%" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td width="40%" align="right">
    	
    </td>
  </tr>
  <tr >
     <td class="detailcontent" align="left"><div class="win" id="dd_1" align="left" style="width:150" title="����ѡ�����ұ߱߿���������϶�">
     <select name="allist"  multiple style="width:98%" onDBLclick="addjob()" size="18" title="����ѡ�����ұ߱߿���������϶�">
		 <pg:list requestKey="joblist1">
			<option value="<pg:cell colName="jobId"/>"><pg:cell colName="jobName"/></option>
		 </pg:list>			
	</select>
	</div></td>				  
		  	
    <td align="center" class="detailcontent"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="center" class="detailcontent"><input name="button1" type="button" class="input" value="&gt;" onClick="addjob()"></td>
      </tr>
      <tr>
        <td align="center" class="detailcontent">&nbsp;</td>
      </tr>
      <tr>
        <td align="center"><input name="button2" type="button" class="input" value="&gt;&gt;" onClick="addall()"></td>
      </tr>
      <tr>
        <td align="center" class="detailcontent">&nbsp;</td>
      </tr>
      <tr>
        <td align="center" class="detailcontent"><input name="button3" type="button" class="input" value="&lt;&lt;" onClick="deleteall()"></td>
      </tr>
      <tr>
        <td align="center" class="detailcontent">&nbsp;</td>
      </tr>
      <tr>
        <td align="center" class="detailcontent"><input name="button4" type="button" class="input" value="&lt;" onClick="deletejob()"></td>
      </tr>
      <tr>
        <td align="center" class="detailcontent">&nbsp;</td>
      </tr>
    </table></td>
    <td class="detailcontent" align="right"><div class="win" id="dd_2" align="left" style="width:150" title="����ѡ�����ұ߱߿���������϶�">
     <select name="jobId"  multiple style="width:98%" onChange="showUserList()" onDBLclick="deletejob()" size="18" title="����ѡ�����ұ߱߿���������϶�">
	  <pg:list requestKey="orgjoblist1">
		<option value="<pg:cell colName="jobId"/>"><pg:cell colName="jobName"/></option>
	  </pg:list>			
 	</div></select>
	</td>
	<td>
	<table align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
        <td align="center" class="detailcontent"><input name="button11" type="button" class="input" value="��ɫ����" onClick="roleset()"></td>
      </tr>
      <tr>
        <td align="center" class="detailcontent">&nbsp;</td>
      </tr>
      <tr>
        <td align="center" class="detailcontent"><input name="button22" type="button" class="input" value="������" onClick="upall()"></td>
      </tr>
      <tr>
        <td align="center" class="detailcontent">&nbsp;</td>
      </tr>
      <tr>
        <td align="center"><input name="button33" type="button" class="input" value="������" onClick="up1()"></td>
      </tr>
      <tr>
        <td align="center" class="detailcontent">&nbsp;</td>
      </tr>
      <tr>
        <td align="center" class="detailcontent"><input name="button44" type="button" class="input" value="������" onClick="down1()"></td>
      </tr>
      <tr>
        <td align="center" class="detailcontent">&nbsp;</td>
      </tr>
      <tr>
        <td align="center" class="detailcontent"><input name="button55" type="button" class="input" value="���ײ�" onClick="downall()"></td>
      </tr>
      <tr>
        <td align="center" class="detailcontent">&nbsp;</td>
      </tr>
    </table>
	
	</td>
  <tr>
  	<td>&nbsp;</td>
  </tr>	
  <tr>
    <td align="center" colspan="4"><input name="button111" type="button" class="input" value="�ݹ������ӻ�����λ" onClick="addsuborg();"></td>
  </tr>		
  <tr>
  	<td>&nbsp;</td>
  </tr>	
  <tr>
    <td align="center" colspan="4"><input name="button222" type="button" class="input" value="�ݹ�ȡ���ӻ�����λ" onClick="deletesuborg();"></td>
  </tr> 
  <tr>
    <td align="center" colspan="4">
    	<br>
	  	<br>
	  	<br>
	  	<br>
    	<input name="button333" type="button" class="input" value="����" onclick="window.close();">
    </td>
  </tr>  
  </tr>
  </table>
<pg:beaninfo sessionKey="orgjobForm">
<input type="hidden"  name="orgId" value="<pg:cell colName="orgId"  defaultValue=""/>"/>
</pg:beaninfo>
</form>
<div id=divProcessing style="width:200px;height:30px;position:absolute;left:175px;top:420px;display:none">
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