<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.chinacreator.security.AccessControl,
				com.chinacreator.config.ConfigManager"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
//System.out.println("dddddddddddd =  " + request.getParameter("typeName"));
%>
<html>
<head>    
 <title>��������</title>
<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>		
<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
<SCRIPT language="javascript">

function getOperateType(id){
    getopergroup.location.href = "../user/resChange.jsp?restypeId="+id;
}
</SCRIPT>
<link href="../css/windows.css" rel="stylesheet" type="text/css">
<link href="../css/contentpage.css" rel="stylesheet" type="text/css">
<link href="../css/tab.winclassic.css" rel="stylesheet" type="text/css">
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
<div id="contentborder" align="center">
	
		<table width="100%" border="0"  cellpadding="0" cellspacing="1" class="thin">	
			 <pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.BrowseResList" keyName="BrowseResList"/> 
			<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
			<pg:pager maxPageItems="17" scope="request" data="BrowseResList" isList="false">
			<tr class="labeltable_middle_td">
			<!--���÷�ҳ��ͷ-->
				<td height='20' class="headercolor" nowrap>��Դ����</td>
				<td height='20' class="headercolor" nowrap>��Դ��ʶ</td>
				<td height='20' class="headercolor" nowrap>��Դ����</td>
				<td height='20' class="headercolor" nowrap>��������</td>
				<td height='20' class="headercolor" nowrap>��Դ��Դ</td>
				<td height='20' class="headercolor" nowrap>��Ȩʱ��</td>
				<% 
				if(ConfigManager.getInstance().getConfigBooleanValue("enablerresmanaer", false))
				{
				%>
					<td height='20' class="headercolor" nowrap>��Դ���</td>
				<% 
					}
				%>
				<!-- <td height='20' class="headercolor" nowrap>��ɫ��ʶ</td> -->
			</tr>
			<pg:param name="restypeId"/>
			<pg:param name="resId"/>
			<pg:param name="resName"/>
			<pg:param name="opId"/>
			<pg:param name="userId"/>
			<pg:param name="id"/>
			<pg:param name="orgjob"/>
			<pg:param name="type"/>
			<pg:param name="name"/>
			<pg:param name="typeName"/>
			<pg:param name="resResource"/>
			<pg:param name="orgId"/>
			<pg:param name="auto"/>

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
				
				<td class="tablecells" align=left>
				<pg:cell colName="resResource" defaultValue=""/>
				</td>
				<td class="tablecells" align=left>
					<pg:cell colName="sDate" defaultValue="δ֪ʱ��" dateformat="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<% 
					if(ConfigManager.getInstance().getConfigBooleanValue("enablerresmanaer", false))
					{
				%>
					<td class="tablecells" align=left>
						<pg:equal colName="auto" value="0" >ϵͳ��Դ</pg:equal>
						<pg:equal colName="auto" value="1" ><font color="#0000FF">�Զ�����Դ</font></pg:equal>
					</td>
				<% 
					}
				%>
				<!-- <td class="tablecells" align=left nowrap><pg:cell colName="roleId" defaultValue=""/></td> -->
			</tr>
			</pg:list>
			<tr height="18px" >
				<td class="detailcontent" colspan=7 align='center'>��<pg:rowcount/>����¼ <pg:index /><input type="hidden" name="queryString" value="<pg:querystring/>"></td>
			</tr> 
			</pg:pager>
		</table>	
	</form>	
</div>
<iframe id="getopergroup" src="" border="0" height="0" width="0"></iframe>
</body>

</html>