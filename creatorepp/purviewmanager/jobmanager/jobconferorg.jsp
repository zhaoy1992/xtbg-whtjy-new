<%
/*
 * <p>Title: Ϊ��λѡ�����ҳ��</p>
 * <p>Description: Ϊ��λѡ�����ҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-25
 * @author baowen.liu
 * @version 1.0
 */
%>


<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page
	import="com.chinacreator.security.AccessControl,
	javax.servlet.http.HttpServletRequest,
    javax.servlet.http.HttpServletResponse,
	com.chinacreator.sysmgrcore.entity.Job,
    com.chinacreator.sysmgrcore.entity.Organization,
    com.chinacreator.sysmgrcore.manager.OrgManager,
	com.chinacreator.sysmgrcore.manager.JobManager,
	com.chinacreator.sysmgrcore.manager.SecurityDatabase,
	com.chinacreator.sysmgrcore.manager.UserManager,java.util.*,
	com.chinacreator.sysmgrcore.web.struts.action.JobManagerAction,
	java.util.List"%>
<%	
	  AccessControl control = AccessControl.getInstance();
	  control.checkManagerAccess(request,response);
      String jobId = (String)request.getParameter("jobId");
	  JobManager jm = SecurityDatabase.getJobManager();
	  Job job = jm.getJobById(jobId);
	  String jobName = job.getJobName();
      //System.out.println("orgId="+orgId);
     
		request.setAttribute("jobId", jobId);

		String orgId = (String)request.getParameter("orgId");
		//System.out.println("orgId="+orgId);
		if (orgId == null)
			orgId = "0";
		OrgManager orgManager = SecurityDatabase.getOrgManager();
		
		
		
		String existOrgSql = "select * from td_sm_organization a,td_sm_orgjob b " + 
				"where a.org_id=b.org_id and job_id='"+job.getJobId()+"' and b.org_id='" +
				orgId + "'";
		List existOrg = null;
		if(control.isAdmin()){
			existOrg = orgManager.getOrgList(job); // �ø�λ��������
		}else{
			existOrg = orgManager.getOrgListBySql(existOrgSql);
		}
		List allOrg;
		Organization org = new Organization();
		org.setOrgId(orgId);
		orgManager.isContainChildOrg(org);// ���ָ���Ļ����Ƿ�����ӻ���
		if (orgManager.isContainChildOrg(org)) {
			allOrg = orgManager.getOrgListBySql("select * from td_sm_organization o where o.parent_id='"
							+ orgId + "'  or o.org_id='" + orgId + "'");
		} else {
			allOrg = orgManager.getOrgListBySql("select * from td_sm_organization o where o.org_id='" + orgId
							+ "'");
		}
		request.setAttribute("existOrg", existOrg);
		request.setAttribute("allOrg", allOrg);
  
	
%>
<html>
<head>    
  <title>��������</title>
  		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/treeview.css">
	
  
<SCRIPT LANGUAGE="JavaScript"> 
	//��ӵ�����λ
	function addOrg(){	
	   //alert("dfasd");
	   //������Ļ����б�
	   var alreadyOrgArr = document.all("orgId") ;
       var n=document.all("orgId").options.length-1; 
   	   var count=0;	
   	   var orgIds = "";
   	   var alreadyJobs = "";  
	   for(var i=0;i<document.all("allist").options.length;i++){
	      var op=document.all("allist").options[i];
	      if(op.selected){
	        //flag��ֵΪfalse�򲻰������������
	        var flag = false;
	        //�ж�������Ļ����б����Ƿ������ѡ�еĻ���
	        for(var j = 0; j < alreadyOrgArr.length; j++){
	   	   	   if(op.text==alreadyOrgArr.options[j].text){
	   	   	   		flag = true;
	   	   	   }
		    }
		    //���ѡ�еĻ����ڲ���������Ļ����б���
		    if(!flag){
		   		addone(op.text,op.value,n);
				if(orgIds=="") orgIds = orgIds + op.value;
				else orgIds = orgIds + "," + op.value;
		    }
		    //���ѡ�еĻ�����������Ļ����б���
		    else{
		   		if(alreadyJobs=="") alreadyJobs = alreadyJobs + op.text;
				else alreadyJobs = alreadyJobs + "\n" + op.text;
		    }
	      }
	   }
   
	    if(orgIds != ""){
	  	  send_request('savaJobOrg.jsp?jobId=<%=jobId%>&orgId='+orgIds+'&flag=1');
	    }else if(alreadyJobs != ""){
	  	  alert("���»����Ѿ����ã�\n" + alreadyJobs);
	  	  return;
	    }else{
	  	  alert("��ѡ��Ҫ���õĻ���!");
	  	  return;
	    }
    }
    
	function addone(name,value,n){
	
	   for(var i=n;i>=0;i--){
			if(value==document.all("orgId").options[i].value){
			  return;
			}
		}
	   var op=new Option(name,value);
	   document.all("orgId").add(op);
	   
	}
	//ɾ�����и�λ
	 function deleteall(){
	   var orgIds = "";
	   var k=document.all("orgId").options.length;
	   if(k<1){
			alert("û�п�ѡ�Ļ���!");
			return;
	   }
	   if(window.confirm("��ȷ��Ҫɾ����ѡ��λ��(ɾ����Ӱ��ø�λ�µ����н�ɫ���û�!)")){
		   for(var m=document.all("orgId").options.length-1;m>=0;m--){
	   			if(orgIds==""){
	   		    	orgIds = document.all("orgId").options[m].value;
	   		    }else{
	   		    	orgIds += "," + document.all("orgId").options[m].value;
	   		    }
	   			document.all("orgId").options[m]=null;
		   }
		   send_request('savaJobOrg.jsp?jobId=<%=jobId%>&orgId='+orgIds+'&flag=0');
	   }
	   
	}
	   //������еĸ�λ
	 function addall(){
	 	//������Ļ����б�
	   var alreadyOrgArr = document.all("orgId") ;
       var n=document.all("orgId").options.length-1; 
   	   var count=0;	
   	   var orgIds = "";
   	   var alreadyJobs = "";  
	   for(var i=0;i<document.all("allist").options.length;i++){
	      var op=document.all("allist").options[i];
	      
	        //flag��ֵΪfalse�򲻰������������
	        var flag = false;
	        //�ж�������Ļ����б����Ƿ������ѡ�еĻ���
	        for(var j = 0; j < alreadyOrgArr.length; j++){
	   	   	   if(op.text==alreadyOrgArr.options[j].text){
	   	   	   		flag = true;
	   	   	   }
		    }
		    //���ѡ�еĻ����ڲ���������Ļ����б���
		    if(!flag){
		   		addone(op.text,op.value,n);
				if(orgIds=="") orgIds = orgIds + op.value;
				else orgIds = orgIds + "," + op.value;
		    }
		    //���ѡ�еĻ�����������Ļ����б���
		    else{
		   		if(alreadyJobs=="") alreadyJobs = alreadyJobs + op.text;
				else alreadyJobs = alreadyJobs + "\n" + op.text;
		    }
	      
	   }
   
	    if(orgIds != ""){
	  	  send_request('savaJobOrg.jsp?jobId=<%=jobId%>&orgId='+orgIds+'&flag=1');
	    }else if(alreadyJobs != ""){
	  	  alert("���»����Ѿ����ã�\n" + alreadyJobs);
	  	  return;
	    }
	}
	//ɾ��������λ
	function deleteorg(){
	   var orgIds = "";
	   var n=document.all("orgId").options.length;
	   if(n<1){
			alert("û�п�ѡ�Ļ���!");
			return;
	   }
	   if(document.all("orgId").selectedIndex==-1){
			alert("��ѡ��Ҫɾ���Ļ�����");
			return;
	   }
	   if(window.confirm("��ȷ��Ҫɾ����(ɾ����Ӱ��ø�λ�µ����н�ɫ���û�!)")){
		   for(var m=document.all("orgId").options.length-1;m>=0;m--){
		   		if(document.all("orgId").options[m].selected){
		   			if(orgIds==""){
		   		    	orgIds = document.all("orgId").options[m].value;
		   		    }else{
		   		    	orgIds += "," + document.all("orgId").options[m].value;
		   		    }
		   			document.all("orgId").options[m]=null
		   		}
		   }
		   send_request('savaJobOrg.jsp?jobId=<%=jobId%>&orgId='+orgIds+'&flag=0');
	   }
	}

//---------------------------------------
	//��ʼ����ָ������ĺ�������������ĺ���
	function send_request(url){
	    document.all.divProcessing.style.display="block";
	    
	    document.all.button1.disabled = true;
	    document.all.button2.disabled = true;
	    document.all.button3.disabled = true;
	    document.all.button4.disabled = true;
	    document.all.button5.disabled = true;
		
		document.RoleOrgForm.action = url;
		document.RoleOrgForm.target = "hiddenFrame";
		document.RoleOrgForm.submit();
	}
			
	function changebox(){				 
	   	 var len=document.all("orgId").options.length;			  	 	
	     		 //var roleId = document.all("roleId").value;
	     		 var jobId="<%=jobId%>";
	     	
	     		 var orgId=new Array(len)
	     		 for (var i=0;i<len;i++){	      
	     		   orgId[i]=document.all("orgId").options[i].value;
	      		 }   
	      		
		 send_request('savaJobOrg.jsp?jobId=<%=jobId%>'+'&orgId='+orgId);
	}
</SCRIPT>
  <link rel="stylesheet" type="text/css" href="../css/windows.css">
  <link rel="stylesheet" type="text/css" href="../css/treeview.css">
  <script language="javascript" src="<%=request.getContextPath()%>/include/dragdiv.js"></script>
 <%@ include file="/epp/css/cssControl.jsp"%>
<body class="contentbodymargin" onload="loadDragDiv()">
<div id="contentborder">
<center>
<form name="RoleOrgForm" action="" method="post" >
<table width="80%" border="0" cellpadding="0" cellspacing="1">
<tr class="tabletop">
    <td width="40%" align="center">&nbsp;</td>
    <td width="20%" align="center">&nbsp;</td>
    <td width="40%" align="center">&nbsp;</td>
  </tr>
  <tr class="tabletop">
    <td width="40%" align="center">��ѡ����</td>
    <td width="20%" align="center">&nbsp;</td>
    <td width="40%" align="center">��<%=jobName%>��������Ļ���</td>
  </tr>
  <tr class="tabletop">
    <td width="40%" align="center">&nbsp;</td>
    <td width="20%" align="center">&nbsp;</td>
    <td width="40%" align="center">&nbsp;</td>
  </tr>
  <tr >
     <td  align="right">
     <div class="win" id="dd_1" align="left" title="����ѡ�����ұ߿��������϶�">
     <select name="allist"  multiple style="width:98%" onDBLclick="addOrg()"  size="18" title="����ѡ�����ұ߿��������϶�">
		  <pg:list requestKey="allOrg">
			<option value="<pg:cell colName="orgId"/>">
			<pg:null colName="remark5"><pg:cell colName="remark5"/></pg:null>
			<pg:notnull colName="remark5">
				<pg:equal colName="remark5" value=""><pg:cell colName="remark5"/></pg:equal>
				<pg:notequal colName="remark5" value=""><pg:cell colName="remark5"/></pg:notequal>
			</pg:notnull>
			</option>
		  </pg:list>			
	</select>
	</div>
	</td>				  
		  	
    <td align="center"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="center"><input name="button1" type="button" class="input" value="&gt;" onclick="addOrg()"></td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
      </tr>
      <tr>
        <td align="center"><input name="button2" type="button" class="input" value="&gt;&gt;" onclick="addall()"></td>
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
        <td align="center"><input name="button4" type="button" class="input" value="&lt;" onclick="deleteorg()"></td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
      </tr>
    </table></td>
    <td >
    <div class="win" id="dd_2" align="left" title="����ѡ�����ұ߿��������϶�">
     <select name="orgId"  multiple style="width:98%" onDBLclick="deleteorg()"  size="18" title="����ѡ�����ұ߿��������϶�">
				  <pg:list requestKey="existOrg">
					
					<option value="<pg:cell colName="orgId"/>">
					<pg:null colName="remark5"><pg:cell colName="remark5"/></pg:null>
					<pg:notnull colName="remark5">
					<pg:equal colName="remark5" value=""><pg:cell colName="remark5"/></pg:equal>
					<pg:notequal colName="remark5" value=""><pg:cell colName="remark5"/></pg:notequal>
					</pg:notnull>
					</option>
				  </pg:list>			
	 </select>				
	</div>				
	</td>				 
				  
  </tr>
  <tr class="tabletop">
    <td width="40%" align="center">&nbsp;</td>
    
  </tr>
  <tr><td colspan="3" align="center">
  
  
  </td> </tr>
 </table>

	<input type="hidden" name="jobId" value="<%=jobId%>"/>
	
	<input type="button" name="button5" value="����" class="input" onclick="window.close();">
	
	</form>
	</center>
	</div>
	
   <div id=divProcessing style="width:200px;height:30px;position:absolute;left:170px;top:400px;display:none">
			<table align="center" border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%">
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