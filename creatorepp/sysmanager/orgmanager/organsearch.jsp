<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%><%@ include file="../include/global1.jsp"%>

<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%
AccessControl accessControl = AccessControl.getInstance();
accessControl.checkAccess(pageContext);
String orgId=request.getParameter("orgId");
String remark5 = request.getParameter("remark5");
String orgnumber = request.getParameter("orgnumber");
if(remark5 == null)remark5="";
if(orgnumber == null)orgnumber="";

//��ǰ�û��Ƿ�ӵ�г�������ԱȨ���벿�Ź���ԱȨ��
boolean isAdminOrOrgManager = false;
//�Ƿ��ǹ���Ա
boolean isOrgManager = new com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl().isOrgManager(accessControl.getUserID());
boolean isAdmin = accessControl.isAdmin();
if(isAdmin || isOrgManager){
	isAdminOrOrgManager = true;
}
%>
<html>
<head>    
 <title>��������</title>

<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>		
<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
<script language="JavaScript">
	var jsAccessControl = new JSAccessControl("#DAE0E9","#F6F8FB","#F6F8FB");
	function getOrgInfo(e,orgId){
	jsAccessControl.setBackColor(e);
	document.all("selectId").value = "<%=orgId%>";
	}
	function getOrg(){
	var orgId = document.all("selectId").value;
	window.location.href="<%=rootpath%>/orgmanager/org.do?method=getOrgInfo&orgId="+orgId;
	}
	function resetSearch()
	{
		document.all.remark5.value = "";
		document.all.orgnumber.value = "";
	}
</script>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
<%if(isAdminOrOrgManager){ %>
<div id="contentborder" align="center" >
<form name="Org" action="" method="post">

<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
  <tr>
    <td>��������</td>
    <td class="detailcontent"><input type="text" name="remark5" value="<%=remark5%>"></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td >�������</td>
    <td class="detailcontent"><input type="text" name="orgnumber" value="<%=orgnumber%>"></td>
    <td>
    	<div align="center">
            <input name="Submit4" type="submit" class="input" value="��ѯ">                
            <input name="Submit22" type="button" class="input" value="����" onclick="resetSearch()" >
        </div>
    </td>
  </tr>      
</table>
<hr width="100%">	    
	<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
	<tr><td height='30' align=center colspan=4><b>�����б�</b></td></tr>
		<pg:listdata dataInfo="OrgSearchList" keyName="OrgList"/>
		<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
		<pg:pager maxPageItems="15"
				  scope="request"  
				  data="OrgList" 
				  isList="false">
			      <tr >
			      <!--���÷�ҳ��ͷ-->
			      	<td class="headercolor">��������</td>
			      	<input class="text" type="hidden" name="selectId">
			      	<td class="headercolor">�������</td>
			      	<td class="headercolor">���������</td>
			      	<td class="headercolor">��������</td>
			      	
			     
			      </tr>
			      <pg:param name="orgName"/>
			      <pg:param name="code"/>
			      <pg:param name="remark5"/>
			      <pg:param name="orgnumber"/> 		      
				  <!--��⵱ǰҳ���Ƿ��м�¼-->
		       	  <pg:notify>
			      <tr height="18px" >
			      	<td colspan=100 align='center'>��ʱû�н��յ�λ</td>
			      </tr>
			      </pg:notify>			      
			      			    
			      <!--list��ǩѭ�����ÿ����¼-->			      
			      <pg:list>	
			      		<tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'" onDBLclick="" >	      				
										
							<td  align=left class="tablecells">
							<pg:null colName="remark5"><pg:cell colName="orgName"/></pg:null>
							<pg:notnull colName="remark5">
							<pg:equal colName="remark5" value=""><pg:cell colName="orgName"/></pg:equal>
							<pg:notequal colName="remark5" value=""><pg:cell colName="remark5"/></pg:notequal>
							</pg:notnull></td>
							<td  align=left class="tablecells"><pg:cell colName="orgnumber" defaultValue=" "/></td>
							<td  align=left class="tablecells"><pg:cell colName="orgSn" defaultValue=" "/></td>							
							<td  align=left class="tablecells">
							<pg:notnull colName="orgdesc"><pg:cell colName="orgdesc" defaultValue=" "/></pg:notnull>
							
							<pg:null colName="orgdesc">û������</pg:null>
							<pg:equal colName="orgdesc" value="">û������</pg:equal>
							</td>							
																																		    					    							    				    		
					  	</tr>			      		
			      </pg:list>
			   <tr height="18px" >
			      	<td colspan=100 align='center' class="detailcontent">
			      	��<pg:rowcount/>����¼  
			      	<pg:index/><input type="hidden" name="queryString" value="<pg:querystring/>"></td>
        </tr>   			   	      
		</pg:pager>
		
	</table>	
  </form> 
</div>
<%}else{ %>
	<div align="center">û��Ȩ�ޣ�����ϵͳ����Ա��ϵ</div>
<%} %>
</body>

</html>