<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
%>
<html>
<head>    
 <title>��������</title>
<script language="JavaScript" src="../../../sysmanager/jobmanager/common.js" type="text/javascript"></script>		
<script language="JavaScript" src="../../include/pager.js" type="text/javascript"></script>

<link href="../../css/windows.css" rel="stylesheet" type="text/css">
<link href="../../css/contentpage.css" rel="stylesheet" type="text/css">
<link href="../../css/tab.winclassic.css" rel="stylesheet" type="text/css">
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
<div id="contentborder" align="center">
	<form name="roleform" action="" method="post">
		<table width="100%" border="0"  cellpadding="0" cellspacing="1" class="thin">	
			<pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.RoleResList" keyName="RoleResList"/> 
			<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
			<pg:pager maxPageItems="17" scope="request" data="RoleResList" isList="false">
			<tr class="labeltable_middle_td">
			<!--���÷�ҳ��ͷ-->
				<td height='20' class="headercolor" nowrap>��Դ����</td>
				<td height='20' class="headercolor" nowrap>��Դ��ʶ</td>
				<td height='20' class="headercolor" nowrap>��Դ����</td>
				<td height='20' class="headercolor" nowrap>��������</td>
				<!-- <td height='20' class="headercolor" nowrap>��ɫ��ʶ</td> -->
			</tr>
			<pg:param name="restypeId"/>
			<pg:param name="resId"/>
			<pg:param name="resName"/>
			<pg:param name="roleId"/>
			<pg:param name="opId"/>
			<pg:param name="resTypeName"/>
			
			<!--��⵱ǰҳ���Ƿ��м�¼-->
			<pg:notify>
			<tr height="18px" >
				<td class="detailcontent" colspan=100 align='center'>��ʱû����Դ</td>
			</tr>
			</pg:notify>			      
			<!--list��ǩѭ�����ÿ����¼-->			      
			<pg:list>	

			<tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'">	      	
				<td class="tablecells" align=left  nowrap><pg:cell colName="resTypeName" defaultValue=""/></td>							
				<td class="tablecells" align=left nowrap><pg:cell colName="resId" defaultValue=""/></td>
				<td class="tablecells" align=left nowrap><pg:cell colName="resName" defaultValue=""/></td>
				<td class="tablecells" align=left><pg:cell colName="opName" defaultValue=""/></td>
			</tr>
			</pg:list>
			<tr height="18px" >
				<td class="detailcontent" colspan=5 align='center'><pg:index/><input type="hidden" name="queryString" value="<pg:querystring/>"></td>
			</tr> 
			</pg:pager>
		</table>	
	</form>	
</div>
<iframe id="getopergroup" src="" border="0" height="0" width="0"></iframe>
</body>

</html>