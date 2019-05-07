
<%@page import="com.chinacreator.security.AccessControl"%><%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.OrgManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.*" %>

<%
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkAccess(request,response);
	String dealType = request.getParameter("dealType");
	if(dealType==null)dealType="";
	String orgId = request.getParameter("orgId");
	OrgManager orgManager = SecurityDatabase.getOrgManager();
	Organization org = orgManager.getOrgById(orgId);
	String orgName = org.getRemark5(); 
	String parentId = org.getParentId();
	
	
%>
<html>
<head>    
 <title>��������</title>
 <script language="JavaScript" src="../scripts/common.js" type="text/javascript"></script>
<SCRIPT language="javascript">
	
	//var jsAccessControl = new JSAccessControl("#ff0000","#ffffff","#eeeeee");
	function getOrgInfo(e,orgId){

		document.all("selectId").value = orgId;
	}	
	function dealRecord(dealType) {
	    var isSelect = false;
	    var outMsg;
	    document.forms[0].dealType.value=dealType;
	    for (var i=0;i<Organzition.elements.length;i++) {
			var e = Organzition.elements[i];
			
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
	        	//getNavigatorContent().location.href ="<%=rootpath%>/sysmanager/orgmanager/navigator_content.jsp?anchor=<%=orgId%>&collapse=<%=orgId%>&request_scope=session";
	        	//modify by ge.tao
	        	//2008-01-14
	        	Organzition.action="<%=rootpath%>/orgmanager/org.do?method=deletesuborg";
				Organzition.submit();
				
		 		return true;
			    }
			} 
	    }else{
	    	alert("����Ҫѡ��һ����¼��");
	    	return false;
	   }
  		return false;
	}
	function updateAfter(){
		//getNavigatorContent().location.href ="<%=rootpath%>/sysmanager/orgmanager/navigator_content.jsp?anchor=<%=orgId%>&collapse=<%=orgId%>&request_scope=session";
		//modify by ge.tao
	    //2008-01-14
	    //�ؼ��� parentId
	    getPropertiesContent().location.href = "<%=rootpath%>/sysmanager/orgmanager/orginfo.jsp?orgId=<%=orgId%>&action=update&parentId=<%=parentId%>&resName=";
	    
	    
	}
</SCRIPT>
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" onLoad="<%=dealType.equals("1")?"updateAfter()":""%>" scroll="no">
<div id="contentborder" align="center">
	<form name = "Organzition" method="post" action="">	
    <input type="hidden" name="dealType" value="">
    <input type="hidden" name="orgId" value="<%=orgId%>">
	<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
	<tr><td  class="detailtitle" align=center colspan=5><b>[<%=orgName%>] ���ӻ����б�</b></td></tr>
		<pg:listdata dataInfo="SbOrgList" keyName="SubOrgList"/>
		<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
		<pg:pager maxPageItems="18"
				  scope="request"  
				  data="SubOrgList" 
				  isList="false">
			      <tr >
			      <!--���÷�ҳ��ͷ-->
			       <td class="headercolor" width="10">
				  	<input type="checkBox" name="checkBoxAll" onClick="checkAll('checkBoxAll','ID')">
				  </td>
			     <!--  <pg:header>			      	
	     		    <pg:title className="tablecells" title="���" align="left" />	     		  
			    	<pg:title className="tablecells" title="��������" align="left"/>
			    	<pg:title className="tablecells" title="��������" align="left"/> 
			      </pg:header>-->
			     <input class="text" type="hidden" name="selectId">
			      <td class="headercolor">��������</td>
			      <td class="headercolor" colspan="2">�������</td>
			     
			      </tr>
			      <pg:param name="orgId"/>
			     		      
				  <!--��⵱ǰҳ���Ƿ��м�¼-->
		       	  <pg:notify>
			      <tr height="18px" >
			      	<td class="detailcontent" colspan=100 align='center'>��ʱû��ֱ���ӻ���</td>
			      </tr>
			      </pg:notify>			      
			      			    
			      <!--list��ǩѭ�����ÿ����¼-->			      
			      <pg:list>	
			      		<tr class="labeltable_middle_tr_01" onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'" >	      				
						
			      		    <td class="tablecells" align="left"><input onClick="checkOne('checkBoxAll','ID')" type="checkbox" name="ID" value="<pg:cell colName="orgId" defaultValue=""/>"></td>										
							<td class="tablecells" align="left">
							
							<pg:null colName="remark5"><pg:cell colName="orgName"/></pg:null>
							<pg:notnull colName="remark5">
							<pg:equal colName="remark5" value=""><pg:cell colName="orgName"/></pg:equal>
							<pg:notequal colName="remark5" value=""><pg:cell colName="remark5"/></pg:notequal>
							</pg:notnull>
						
							</td>
							<td class="tablecells" align="left" colspan="2"><pg:cell colName="orgnumber" defaultValue=""/></td>																											    					    							    				    		
					  	</tr>			      		
			      </pg:list>
			   <tr height="18px" >
			      	<td class="detailcontent" colspan=3 align='center'>��<pg:rowcount/>����¼ <pg:index/><input type="hidden" name="queryString" value="<pg:querystring/>"></td>
			      	<td class="detailcontent" align='left'>
			      	
				<% 
					if(accessControl.isAdmin()){
				%>
					<input type="button" value="ɾ��" class="input"
								onclick="javascript:dealRecord(1)">
				<%} %>
								
				</td>
			
			      </tr>   			   	      
		</pg:pager>
		
	</table>	
</form>	
</div>   

</body>

</html>
