<%@ include file="../../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../base/scripts/panes.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.ResManager,
				 com.chinacreator.resource.ResourceManager,
				 com.chinacreator.config.model.Operation"%>

<%
	ResourceManager resManager = new ResourceManager();
	String restypeId=request.getParameter("restypeId");
%>

<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>		
<script language="JavaScript" src="../../include/pager.js" type="text/javascript"></script>
<link href="../../css/windows.css" rel="stylesheet" type="text/css">
<link href="../../css/contentpage.css" rel="stylesheet" type="text/css">
<link href="../../css/tab.winclassic.css" rel="stylesheet" type="text/css">
<table width="100%" border="0"  cellpadding="0" cellspacing="1" class="thin">
			<pg:listdata dataInfo="RoleResList" keyName="RoleResList"/>
			<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
			<pg:pager maxPageItems="17" scope="request" data="RoleResList" isList="false">
			<tr class="labeltable_middle_td">
			<!--���÷�ҳ��ͷ-->
				<td height='20' class="headercolor">��Դ��ʶ</td>
				<td height='20' class="headercolor">��Դ����</td>
				<td height='20' class="headercolor">��������</td>
			</tr>
			<pg:param name="roleId"/>
			<pg:param name="restypeId"/>
			<!--��⵱ǰҳ���Ƿ��м�¼-->
			<pg:notify>
			<tr height="18px" >
				<td class="detailcontent" colspan=100 align='center'>��ʱû����Դ</td>
			</tr>
			</pg:notify>			      
			<!--list��ǩѭ�����ÿ����¼-->			      
			<pg:list>	
			<tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'">	
				<td class="tablecells" align=left><pg:cell colName="resId" defaultValue=""/></td>	      				
				<td class="tablecells" align=left><pg:cell colName="resName" defaultValue=""/></td>																																	    					    							    				    																																    					    							    				    		
				<td class="tablecells" align=left colspan="2">
				 <pg:cell colName="opName" defaultValue=""/>
				</td>
			</tr>
			</pg:list>
			<tr height="18px" >
				<td class="detailcontent" colspan=4 align='center'><pg:index/><input type="hidden" name="queryString" value="<pg:querystring/>"></td>
			</tr>   			   	      
			</pg:pager>
</table>