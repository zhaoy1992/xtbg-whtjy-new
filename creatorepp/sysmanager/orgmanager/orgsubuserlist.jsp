<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%String orgId=request.getParameter("orgId");
%>
<html>
<head>    
 <title>��������</title>
 <script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>		
 
 <script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
 <SCRIPT language="javascript">
	
	var jsAccessControl = new JSAccessControl("#ff0000","#ffffff","#eeeeee");
	function getOrgInfo(e,orgId){
	jsAccessControl.setBackColor(e);
	document.all("selectId").value = orgId;
	}
	function createorg()
	{
		getPropertiesContent().location.href="../user/userInfo1.jsp?orgId=<%=orgId%>";   
		
	}
	function back()
	{
		getPropertiesContent().location.href="<%=request.getContextPath()%>/orgmanager/org.do?method=getOrgInfo&orgId=<%=orgId%>";  
		
	}
	
</SCRIPT>
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">

<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">

<div id="contentborder" align="center">
    <form name = "userForm" method="post" action="">	
    <input type="hidden" name="orgId" value ="<%=request.getParameter("orgId")%>">
	<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" class="thin" >
	<tr><td height='40' class="detailtitle" align=center colspan=4><b>ֱ���û��б�</b></td></tr>
		<pg:listdata dataInfo="OrgSubUserList" keyName="OrgSubUserList"/>
		<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
		<pg:pager maxPageItems="18"
				  scope="request"  
				  data="OrgSubUserList" 
				  isList="false">
			      <tr class="labeltable_middle_td">
			      <!--���÷�ҳ��ͷ-->
			 			      
			      	<td class="headercolor" height='30'>��¼��</td>	<input class="text" type="hidden" name="selectId">
			      	<td class="headercolor" height='30'>��¼����</td>
			      	<td class="headercolor" height='30'>�û���</td>
			      	<td class="headercolor" height='30'>�Ա�</td>
			      	
			      </tr>
			      <pg:param name="orgId"/>
			     		      
				  <!--��⵱ǰҳ���Ƿ��м�¼-->
		       	  <pg:notify>
			      <tr height="18px" >
			      	<td class="detailcontent" colspan=100 align='center'>��ʱû���û�</td>
			      </tr>
			      </pg:notify>			      
			      			    
			      <!--list��ǩѭ�����ÿ����¼-->			      
			      <pg:list>	
			      		<tr class="labeltable_middle_tr_01" onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'" )" >	      				
								
			 				<td class="tablecells" align=center><pg:cell colName="userName" defaultValue=""/></td>
							<td class="tablecells" align=center>******</td>
							<td class="tablecells" align=center><pg:cell colName="userRealname" defaultValue=""/></td>																											    					    							    				    		
					  		<td class="tablecells" align=center >
					  		<pg:equal colName="userSex" value="F">Ů</pg:equal>
					  		<pg:equal colName="userSex" value="M">��</pg:equal>																										    					    							    				    		
					  		<pg:equal colName="userSex" value="-1">δ֪</pg:equal>
					  		</td>	
					  	</tr>			      		
			      </pg:list>
			   <tr height="18px" >
			      	<td class="detailcontent" colspan=3 align='center'><pg:index/><input type="hidden" name="queryString" value="<pg:querystring/>"></td>
			      	<td class="detailcontent" align='left'>
			      	
				 		<input type="button" value="�����û�" class="input"
								onclick="createorg()">
						<input type="button" value="����" class="input"
								onclick="back()">		
					</td>
			      </tr>   			   	      
		</pg:pager>
		
	</table>	
</form>	
</div>
<%@ include file="../sysMsg.jsp"%>
</body>

</html>