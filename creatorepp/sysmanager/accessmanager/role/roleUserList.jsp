<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ include file="../../base/scripts/panes.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.ResourceAction"%>
<%@ page import="com.chinacreator.resource.ResourceManager,com.chinacreator.sysmgrcore.manager.OperManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.OrgManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Organization"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.*"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Role"%>
<%@ page import="java.util.List,java.util.ArrayList"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<% 
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkManagerAccess(request,response);
	String roleId = (String) session.getAttribute("currRoleId");
%>
<html > 
      

<head>				
	<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>		
    <script language="JavaScript" src="../../include/pager.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="../../css/windows.css">
	<link rel="stylesheet" type="text/css" href="../../css/contentpage.css">
	<link rel="stylesheet" type="text/css" href="../../css/tab.winclassic.css">
	<link rel="stylesheet" type="text/css" href="../../sysmanager/css/windows.css">
	<link rel="stylesheet" type="text/css" href="../../sysmanager/css/contentpage.css">
	<link rel="stylesheet" type="text/css" href="../../sysmanager/css/tab.winclassic.css">
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
<div id="contentborder">
		
		<FORM name="userForm" method="post" action="">			    
		   	<INPUT name="roleId" value="<%=roleId%>" type="hidden">
			<TABLE width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
			<TR><TD class="detailtitle" align="center" colspan="8"><br><B>��ɫ��������û��б�</B></TD></TR>
				<pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.RoleUserList" keyName="RoleUserList" />
				<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
				<pg:pager maxPageItems="4" id="RoleUserList" scope="request" data="RoleUserList" isList="false">
				<pg:param name="roleId"/>
						  <!--��⵱ǰҳ���Ƿ��м�¼-->					      			    
					      <!--list��ǩѭ�����ÿ����¼-->			      
					      <TR class="labeltable_middle_td">
					      <!--���÷�ҳ��ͷ-->
										      
					      	<td class="headercolor">��¼��</td>	
					      	<INPUT class="text" type="hidden" name="selectId">
					      	
					      	<td class="headercolor">�û���</td>
					      	<td class="headercolor" colspan="2">�Ա�</td>
							<td class="headercolor">���ڻ����Լ���λ</td>	
					      	
					      </TR><pg:param name="roleId" /><pg:notify>
					      <TR height="18px">
					      	<TD class="detailcontent" colspan="100" align="center">��ʱû�������û�</TD>
					      </TR>
					      </pg:notify><pg:list>	
					      		<TR class="labeltable_middle_tr_01" onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'">	      				
									<TD class="tablecells" align="left"><pg:cell colName="userName" defaultValue="" /></TD>
									<TD class="tablecells" align="left"><pg:cell colName="userRealname" defaultValue="" /></TD>																											    					    							    				    		
							  		<TD class="tablecells" align="left" colspan="2">
							  			<pg:equal colName="userSex" value="F">Ů</pg:equal>
							  			<pg:equal colName="userSex" value="M">��</pg:equal>																										    					    							    				    		
							  			<pg:equal colName="userSex" value="-1">δ֪</pg:equal>
							  		</TD>			
									<TD class="tablecells">
										<pg:cell colName="orgName" defaultValue="" />
									</TD>							  		
							  	</TR>			      		
					      </pg:list>
					   <TR height="18px">
					      	<TD class="detailcontent" colspan="5" align="center" nowrap="nowrap">
					      	��<pg:rowcount/>����¼ 
					      	<pg:index /><INPUT type="hidden" name="queryString" value="<pg:querystring/>"></TD>
					   </TR>   			   	      
				</pg:pager>
				
		   </TABLE>	
		</FORM>	
</div>
</body>
</html>