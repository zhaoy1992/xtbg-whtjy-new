<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%
	String dealType = request.getParameter("dealType");
	if(dealType==null)
		dealType="";
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
 <script language="JavaScript" src="../scripts/common.js" type="text/javascript"></script>
<SCRIPT language="javascript">
	
	var jsAccessControl = new JSAccessControl("#ff0000","#ffffff","#eeeeee");
	function getOrgInfo(e,jobId){

	document.all("selectId").value = jobId;
	}	
	function dealRecord(dealType) {
	  // document.forms[0].action="../workflowmanager/Usermapping.do?method=bindUser&userId="+ids;
      // document.forms[0].submit();
         
      // parent.window.close();
        var isSelect = false;
	    var outMsg;
	    document.forms[0].dealType.value=dealType;
	    for (var i=0;i<Job.elements.length;i++) {
			var e = Job.elements[i];
			
			if (e.name == 'ID'){
				if (e.checked){
			       		isSelect=true;
			       		break;
			       		
			    }
			}
	    }
	    if (isSelect){
	    		//window.setTimeout("reloadOpener()",3000) ;
	    		document.forms[0].action="../workflowmanager/Usermapping.do?method=bindJob";
        	    document.forms[0].submit();
	    		
         		
         		
         		
			  
			
	    }else{
	    	alert("����Ҫѡ��һ����¼��");
	    	return false;
	   }
  		return false;
	    
	}
	
	
</SCRIPT>
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin"  onLoad="<%=dealType.equals("1")?"updateAfter()":""%>" scroll="no">
<div id="contentborder" align="center">
	<form name = "Job" method="post" action="" target="">
	<input type="hidden" name="pkgId" value="<%=pkgId%>">
	<input type="hidden" name="procDefId" value="<%=procDefId%>">
	<input type="hidden" name="actorId" value="<%=actorId%>">
	<input type="hidden" name="procDefName" value="<%=procDefName%>">
	<input type="hidden" name="pkgName" value="<%=pkgName%>">
		
	<input type="hidden" name="dealType" value="">
    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
	<tr><td  class="detailtitle" align=center colspan=5><b>��λ�б�</b></td></tr>
		<pg:listdata dataInfo="JobSubList" keyName="JobSubList"/>
		<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
		<pg:pager maxPageItems="18"
				  scope="request"  
				  data="JobSubList" 
				  isList="false">
			      <tr >
			      <!--���÷�ҳ��ͷ-->
			       <td class="headercolor" width="10">
				  	<input type="checkBox" name="checkBoxAll" onClick="checkAll('checkBoxAll','ID')">
				  </td>
			 	  <input class="text" type="hidden" name="selectId">
			      <td class="headercolor">��λ����</td>
			      <td class="headercolor" colspan="2">��λ����</td>
			     
			      </tr>
			      <pg:param name="jobId"/>
			     		      
				  <!--��⵱ǰҳ���Ƿ��м�¼-->
		       	  <pg:notify>
			      <tr height="18px" >
			      	<td class="detailcontent" colspan=100 align='center'>��ʱû�и�λ</td>
			      </tr>
			      </pg:notify>			      
			      			    
			      <!--list��ǩѭ�����ÿ����¼-->			      
			      <pg:list>	
			      		<tr class="labeltable_middle_tr_01" onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'" >	      				
						
			      		    <td class="tablecells" align="left">
			      		    <input onClick="checkOne('checkBoxAll','ID')" type="checkbox" name="ID" 
			      		    	   value="<pg:cell colName="jobId" defaultValue=""/>"></td>										
							<td class="tablecells" align="left">
								<pg:cell colName="jobName" defaultValue=""/>
							</td>
							<td class="tablecells" align="left" colspan="2">
							<pg:cell colName="jobDesc" defaultValue=""/></td>																											    					    							    				    		
					  	</tr>			      		
			      </pg:list>
			   <tr height="18px" >
			      	<td class="detailcontent" colspan=3 align='center'><pg:index/><input type="hidden" name="queryString" value="<pg:querystring/>"></td>
			      	<td class="detailcontent" align='left'>
					<input type="button" value="ȷ��" class="input"
								onclick="javascript:dealRecord(1);">
					<input name="add" type="button" class="input" value="����" onclick="window.close();">
								
				</td>
			
			      </tr>   			   	      
		</pg:pager>
		
	</table>	
</form>	
</div>   

</body>

</html>