<%
	/**
	  * ֱ���û��б�
	  */
%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@page import="com.chinacreator.security.AccessControl,
				com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl,
				com.chinacreator.sysmgrcore.manager.OrgAdministrator"%>
<%
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkAccess(request,response);
	String orgId=request.getParameter("orgId");
	String curUserId = accessControl.getUserID();
	OrgAdministrator orgAdministrator = new OrgAdministratorImpl();
	orgId= orgId == null ? "" : orgId;
	boolean state = orgAdministrator.isOrgAdmin(curUserId,orgId);
	//System.out.println("isAdmin = " + state);
%>
<html>
<head>    
 <title>�û��б�</title>
 <script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>		
 <script src="<%=request.getContextPath()%>/cms/inc/js/func.js"></script>
 <script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/include/pager.js" type="text/javascript"></script>
 <SCRIPT language="javascript">
	
	var jsAccessControl = new JSAccessControl("#ff0000","#ffffff","#eeeeee");
	function getOrgInfo(e,orgId){
	jsAccessControl.setBackColor(e);
	document.all("selectId").value = orgId;
	}
	//�½��ӻ���
	function createorg()
	{
		var urlstr ="<%=rootpath%>/orgmanager/org.do?method=newsubOrg&orgId=<%=orgId%>&iscms=iscms";
		openWin(urlstr,500,400);
	}
	//ɾ������
	function deleteorg(){
		if(window.confirm("��ȷ��Ҫɾ����(ɾ��������ɾ���ӻ������Ҳ������ٻָ�)")){	
			var urlstr ="<%=rootpath%>/orgmanager/org.do?method=deleteOrg&orgId=<%=orgId%>&iscms=iscms";
			var hello = openWin(urlstr,0,0);
			if(hello)
			{
				alert("ɾ���ɹ���");
			}
			
		}
	}
	//�޸Ļ���
	function modifyorg(){
		var urlstr ="<%=rootpath%>/orgmanager/org.do?method=modifyOrgInfo&orgId=<%=orgId%>&iscms=iscms";
		openWin(urlstr,500,400);
	}
	//��ɫ����
	function orgroles()
	{
		var urlstr ="<%=rootpath%>/orgmanager/orgrole.do?method=getRoleList&orgId=<%=orgId%>&iscms=iscms";
		openWin(urlstr,600,480);
		window.location.href=window.location.href;
	}
	//new �û�
	function createuser()
	{
		openWin("<%=request.getContextPath()%>/cms/orgManage/addUser.jsp?orgId=<%=orgId%>",780,580);
		//document.location.href = "userInfo.jsp?orgId=<%=orgId%>";
		
		window.document.location.href = window.document.location.href ;
	}
	//del �û�
	function deluser()
	{
		//openWin("userInfo.jsp?orgId=<%=orgId%>",780,580);
		var isSelect = false;
		var outMsg;
			
		for (var i=0;i<userForm.elements.length;i++) {
			var e = userForm.elements[i];
				
			if (e.name == 'checkBoxOne'){
				if (e.checked){
					isSelect=true;
					break;
				}
			}
		}
		if (isSelect){
			outMsg = "��ȷ��Ҫɾ����(ɾ�����ǲ������ٻָ���)��";
			if (confirm(outMsg)){
				userForm.target="theIframe"
				userForm.action="<%=request.getContextPath()%>/sysmanager/user/userManager.do?method=deleteUser&disuser=1&isRes=2";
				userForm.submit();
				return true;
			}
		}else{
			alert("����Ҫѡ��һ����¼��");
			return false;
    }
	return false;
	}
	function back()
	{
		getPropertiesContent().location.href="<%=request.getContextPath()%>/orgmanager/org.do?method=getOrgInfo&orgId=<%=orgId%>";  
		
	}
	function orgRess(){
		openWin('<%=request.getContextPath()%>/cms/userManage/orgResFrame.jsp?orgId=<%=orgId%>',screen.availWidth-50,screen.availHeight-100);
	}
	
	//�����û�
	function folduser(){
		var win;
		win = window.showModalDialog("<%=request.getContextPath()%>/cms/orgManage/folduser_frame.jsp?orgId=<%=orgId%>",window,"dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no");
		if(win=="ok"){
			window.location.reload();
		}
	}
	
	//���ò��Ź���Ա
	function changeorgadmin(){
		var win;
		win = window.showModalDialog("<%=request.getContextPath()%>/sysmanager/orgmanager/orgAdmin.jsp?orgId=<%=orgId%>",window,"dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no");
		if(win=="ok"){
			window.location.reload();
		}
	}
	
	//������
	var isMain = "<%=request.getParameter("isMain")%>";
	if(isMain=="main"){
		alert("ɾ�����ɹ�����ǰ�������û�(<%=request.getParameter("userNameMain")%>)�������������û�����������������ʱ����ɾ��������������Ϊ�û�ָ��һ����������");
	}
	var isSuccess = "<%=request.getParameter("isSuccess")%>";
	if(isSuccess=="1"){
		alert("ɾ���û��ɹ���");
		var str = document.location.href;
		parent.window.document.location.href = str.substring(0,str.indexOf("isSuccess"));
	}
</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="<%=request.getContextPath()%>/cms/inc/css/cms.css" rel="stylesheet" type="text/css">

<body class="contentbodymargin" scroll="auto">

  <%if(!"".equals(orgId)) { //��û��ѡ���κλ���ʱ������ʾ��Ϣ %>
<div id="contentborder" align="center">
    <form name = "userForm" method="post" action="">	
    <input type="hidden" name="orgId" value ="<%=request.getParameter("orgId")%>">
	<input type="hidden" name="delcmsuser" value="delcmsuser" /><!--���ڱ�ʶCMS�е��û�����-->
	<table width="100%" border="1" align=center cellpadding="3" cellspacing="0" bordercolor="#B7CBE4"  class="Datalisttable" >
		<tr style="align:left">
			<td height='40' align="left" colspan=8>
			<%
			 if(request.getParameter("resName")!=null)
			{
			%>
			<div align="left">&nbsp;<b>
			<%=request.getParameter("resName")==null?"":request.getParameter("resName")%></b>&nbsp;>>&nbsp;
			<%
			if(accessControl.checkPermission(orgId,"orgroleset",AccessControl.ORGUNIT_RESOURCE))
			{
			%>
			<a href="#" onclick="orgroles()"><u>��ɫ����</u></a> | 
			<%
			}
			%>
			<%
			if(accessControl.checkPermission(orgId,"orgresset",AccessControl.ORGUNIT_RESOURCE))
			{
			%>
			<a href="#" onclick="orgRess()"><u>Ȩ������</u></a> |
			<%
			}
			%>
			<%
			if(accessControl.checkPermission(orgId,"editsuborg",AccessControl.ORGUNIT_RESOURCE))
			{
			%>
			<a href="#" onclick="modifyorg()"><u>�޸Ļ���</u></a> | 
			<%
			}
			%>
			<%
			if(accessControl.checkPermission(orgId,"deletesuborg",AccessControl.ORGUNIT_RESOURCE) && !state)
			{
			%>
			<a href="#" onclick="deleteorg()"><u>ɾ������</u></a> | 
			<%
			}
			%>
			<%
			if(accessControl.checkPermission(orgId,"addsuborg",AccessControl.ORGUNIT_RESOURCE))
			{
			%>
			<a href="#" onclick="createorg()"><u>�½��ӻ���</u></a> |
			<%
			}
			%>
			<%
			if(accessControl.checkPermission(orgId,"adduser",AccessControl.ORGUNIT_RESOURCE))
			{
			%>
			<a href="#" onclick="createuser()"><u>�����û�</u></a> |
			<%
			}
			%>
			<!--
			<%
			if(accessControl.checkPermission(orgId,"deleteuser",AccessControl.ORGUNIT_RESOURCE))
			{
			%>
			<a href="#" onclick="deluser();return false;"><u>����ɾ��</u></a> |
			<%
			}
			%>
			-->
			<%
			if(accessControl.checkPermission(orgId,"adduser",AccessControl.ORGUNIT_RESOURCE))
			{
			%>
			<a href="#" onclick="folduser()"><u>�����û�</u></a> 
			<%
			}
			%>
			<%
			//if(accessControl.checkPermission(orgId,"changeorgadmin",AccessControl.ORGUNIT_RESOURCE))
			//{
			%>
			<!-- <a href="#" onclick="changeorgadmin()"><u>���ù���Ա</u></a></div>-->
			<%
			//}
			%>
			<%}%>
			<hr size="1">
			<div align="left">&nbsp;
			 <!--| 
			<a href="#" onclick="createorg()"><u>����û�</u></a>--></div>
			</td>
		</tr>
		<pg:listdata dataInfo="OrgSubUserList" keyName="OrgSubUserList"/>
		<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
		<pg:pager maxPageItems="15"
				  scope="request"  
				  data="OrgSubUserList" 
				  isList="false">
			      <tr class="cms_report_tr">
			      <!--���÷�ҳ��ͷ-->
			 		<!-- <td class="headercolor" width="7"> -->
					<!-- 	<input type="checkBox" name="checkBoxAll" onClick="checkAll('checkBoxAll','checkBoxOne')" width="10"> -->
					<!-- </td>	  -->    
			      	<td class="headercolor" height='30'>��¼��</td>	<input class="text" type="hidden" name="selectId">
			      	
			      	<td class="headercolor" height='30'>�û���</td>
			      	<td class="headercolor" height='30'>�Ա�</td>
			      	<td class="headercolor" height='30'>��ǰ״̬</td>
			      	<td class="headercolor" height='30'>�û�����</td>
			      	
			      </tr>
			      <pg:param name="orgId"/>
				  <pg:param name="resName"/>
			     		      
				  <!--��⵱ǰҳ���Ƿ��м�¼-->
		       	  <pg:notify>
			      <tr height="18px" >
			      	<td class="detailcontent" colspan=100 align='center'>��ʱû���û�</td>
			      </tr>
			      </pg:notify>			      
			      			    
			      <!--list��ǩѭ�����ÿ����¼-->			      
			      <pg:list>	
			      <% //��ʾ�û������
			                  //baowen.liu 2008-4-25
			                  String  userid =dataSet.getString("userId");
			                  //�ж��û��Ƿ�Ϊ��ǰ���ŵĹ���Ա
			                  boolean isOrgManager = orgAdministrator.isOrgAdmin(userid,orgId);
			                  //�ж��Ƿ���г�������Ա��ɫ
			                  boolean isRoleAdmin = accessControl.isAdminByUserid(userid);
			                  String isRoleAdminOrOrgManager = "";//�Ƿ�ӵ�г�������Ա��ɫ�벿�Ź���Ա��ɫ
							if(isOrgManager && isRoleAdmin){
								isRoleAdminOrOrgManager = "(����Ա����������Ա��ɫ)";
							}else if(isRoleAdmin){
								isRoleAdminOrOrgManager = "(��������Ա��ɫ)";
							}else if(isOrgManager){
								isRoleAdminOrOrgManager = "(����Ա)";
							}
				%>
			      		<tr class="cms_data_tr" onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'" )" >	      				
							<!-- <td class="tablecells" nowrap="nowrap" width="6"> -->
							<!-- 	<input type="checkBox" name="checkBoxOne" onClick="checkOne('checkBoxAll','checkBoxOne')" value="<pg:cell colName="userId" defaultValue=""/>" width="10"> -->
							<!-- </td>	-->
			 				<td class="tablecells" align=center><pg:cell colName="userName" defaultValue=""/><%=isRoleAdminOrOrgManager%></td>
							
							<td class="tablecells" align=center><pg:cell colName="userRealname" defaultValue=""/></td>																											    					    							    				    		
					  		<td class="tablecells" align=center >
					  		<dict:itemname type="sex" expression="{userSex}" />
					  		<!--
					  		<pg:equal colName="userSex" value="F">Ů</pg:equal>
					  		<pg:equal colName="userSex" value="M">��</pg:equal>																										    					    							    				    		
					  		<pg:equal colName="userSex" value="-1">δ֪</pg:equal>
					  		-->
					  		</td>
					  		<td class="tablecells" align=center >
					  		 <dict:itemname type="isvalid" expression="{user_isvalid}" />
					  		 <!--
					  		 <pg:equal colName="user_isvalid" value="0">��ɾ��</pg:equal>
					         <pg:equal colName="user_isvalid" value="1">������</pg:equal>
					         <pg:equal colName="user_isvalid" value="2">�ѿ�ͨ</pg:equal>
					         <pg:equal colName="user_isvalid" value="3">ͣ��</pg:equal>
					         -->
					  		</td>	
					  		<td class="tablecells" align=center >
					  		 <dict:itemname type="userType" expression="{userType}" />
					  		</td>
					  	</tr>			      		
			      </pg:list>
			   <tr height="18px" >
			      	<td class="Data_List_Table_Bottom" colspan=7 align='center'>
					��&nbsp;<pg:rowcount/>&nbsp;����¼&nbsp;<pg:index/>
					<input type="hidden" name="queryString" value="<pg:querystring/>">
					</td>
			      	
			      </tr>   			   	      
		</pg:pager>
		
	</table>	
</form>	
</div>

 <%}else {out.println("<br><br><div align=center height=30><font size=3>��ѡ����ߵ�һ���������в�����</font></div>");}%>
 
<IFRAME name="theIframe" width="0" height="0"></IFRAME>
<IFRAME name="delIframe" width="0" height="0"></IFRAME>
</body>

</html>