<%@ include file="../../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page
	import="com.chinacreator.security.AccessControl,
	com.chinacreator.sysmgrcore.entity.Job,
	com.chinacreator.sysmgrcore.manager.JobManager,
	com.chinacreator.sysmgrcore.manager.SecurityDatabase,
	com.chinacreator.sysmgrcore.manager.UserManager,java.util.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);
	String jobId=request.getParameter("jobId");
	JobManager jm = SecurityDatabase.getJobManager();
	Job job = jm.getJobById(jobId);
	String jobName = job.getJobName();
%>
<html>
<head>    
 <title>��������</title>
<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>		
<script language="JavaScript" src="../../include/pager.js" type="text/javascript"></script>
<SCRIPT language="javascript">
	function checkAll(totalCheck,checkName){	//��ѡ��ȫ��ѡ��
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
	//����ѡ�и�ѡ��
	function checkOne(totalCheck,checkName){
	   var selectAll = document.getElementsByName(totalCheck);
	   var o = document.getElementsByName(checkName);
		var cbs = true;
		for (var i=0;i<o.length;i++){
			if(!o[i].disabled){
				if (o[i].checked==false){
					cbs=false;
				}
			}
		}
		if(cbs){
			selectAll[0].checked=true;
		}else{
			selectAll[0].checked=false;
		}
	}		
	function dealRecord(dealType) {
	    var isSelect = false;
	    var outMsg;
	    
	    for (var i=0;i<orgForm.elements.length;i++) {
			var e = orgForm.elements[i];
			
			if (e.name == 'ID'){
				if (e.checked){
			       		isSelect=true;
			       		break;
			    }
			}
	    }
	    if (isSelect){
	    	if (dealType==1){
	    		outMsg = "��ȷ��Ҫɾ����(ɾ�����ǲ������ٻָ���)��";
	        	if (confirm(outMsg)){
	        	orgForm.action="<%=rootpath%>/jobmanager/job.do?method=deletesuborg";
				orgForm.submit();
		 		return true;
			    }
			} 
	    }else{
	    	alert("����Ҫѡ��һ����¼��");
	    	return false;
	   }
  		return false;
	}
</SCRIPT>
<!--<link rel="stylesheet" type="text/css" href=" ../../css/contentpage.css">-->
<!--<link rel="stylesheet" type="text/css" href=" ../../css/tab.winclassic.css">-->
<!--<link href="../../css/windows.css" rel="stylesheet" type="text/css">-->
<!--<link rel="stylesheet" type="text/css" href=" ../../sysmanager/css/contentpage.css">-->
<!--<link rel="stylesheet" type="text/css" href=" ../../sysmanager/css/tab.winclassic.css">-->
<!--<link href="../../sysmanager/css/windows.css" rel="stylesheet" type="text/css">-->
<link rel="stylesheet" type="text/css" href="../../css/windows.css">
<link rel="stylesheet" type="text/css" href="../../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../../css/tab.winclassic.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">


<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">

<div id="contentborder" align="center">
	
    <form name = "orgForm" method="post" action="">	
    <input type="hidden" name="jobId" value ="<%=request.getParameter("jobId")%>">
	<table width="100%" border="0"  cellpadding="0" cellspacing="1" class="thin">
	<tr><td height='40' class="detailtitle" align=center colspan=5><b>��λ(<%=jobName%>)���������б�</b></td></tr>
		<pg:listdata dataInfo="JobSubList1" keyName="JobSubList1"/>
		<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
		<pg:pager maxPageItems="10"
				  scope="request"  
				  data="JobSubList1" 
				  isList="false">
			      <tr class="labeltable_middle_td">
			      <!--���÷�ҳ��ͷ-->
			      <td class="headercolor" align=center>
				  	<input type="checkBox" name="checkBoxAll" onClick="checkAll('checkBoxAll','ID')">
				  </td>
				  <td height='20' class="headercolor">��������</td>
			   	  <td height='20' class="headercolor">�������</td>
				  <td height='20' class="headercolor">��������</td>
				  <td height='20' class="headercolor">��������</td>
				  			
			      </tr>
			      <pg:param name="jobId"/>
			     		      
				  <!--��⵱ǰҳ���Ƿ��м�¼-->
		       	  <pg:notify>
			      <tr height="18px" >
			      	<td class="detailcontent" colspan=100 align='center'>��ʱû�л���</td>
			      </tr>
			      </pg:notify>			      
			      			    
			      <!--list��ǩѭ�����ÿ����¼-->			      
			      <pg:list>	
			      		<tr class="labeltable_middle_tr_01" onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'">	      				
							
			      		    <td class="tablecells" align=center><input onClick="checkOne('checkBoxAll','ID')" type="checkbox" name="ID" value="<pg:cell colName="orgId" defaultValue=""/>"></td>					
							<td class="tablecells" align=left>
							<pg:null colName="remark5"><pg:cell colName="orgName"/></pg:null>
							<pg:notnull colName="remark5">
							<pg:equal colName="remark5" value=""><pg:cell colName="orgName"/></pg:equal>
							<pg:notequal colName="remark5" value=""><pg:cell colName="remark5"/></pg:notequal>
							</pg:notnull>
							</td>
							<td class="tablecells" align=left><pg:cell colName="orgnumber" defaultValue=""/></td>
							<td class="tablecells" align=left><pg:cell colName="orgSn" defaultValue=""/></td>
							<td class="tablecells" align=left><pg:cell colName="orgdesc" defaultValue="û������"/></td>																											    					    							    				    		
					  	</tr>			      		
			      </pg:list>
			   <tr height="18px" >
			      	<td class="detailcontent" colspan=4 align='center'>��<pg:rowcount/>����¼ <pg:index/><input type="hidden" name="queryString" value="<pg:querystring/>"></td>
			      	<td class="detailcontent" align='left'>
			      	
					  	
					 <input type="button" value="ɾ��" class="input"
								onclick="javascript:dealRecord(1); return false;">
								
				</td>
        </tr>   			   	      
		</pg:pager>
		
	</table>	
</form>	
</div>

</body>

</html>