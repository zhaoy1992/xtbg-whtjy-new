<%@ page language="java" contentType="text/html; charset=GBK"%>
<%
/**
 * 
 * <p>Title: ��Դ��������б�</p>
 *
 * <p>Description: ��Դ��������б�</p>
 *
 * <p>Copyright: Copyright (c) 2008</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2008-11-4
 * @author gao.tang
 * @version 1.0
 */
 %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl accessControl = AccessControl.getInstance();
	if(!accessControl.checkManagerAccess(request, response)){
		return;
	}
	
	//����Ķ����ѯ���������������û�����ɫ��������λ��  ��ѡ
	String type = request.getParameter("type");
%>
<html>
<head>
	<title>��Դ�������ѯ</title>
	<link rel="stylesheet" type="text/css" href="../../css/windows.css">
	<script type="text/javascript" language="Javascript">
	</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body >
<form action="" method="post" name="queryList">
	<table width="100%" border="0"   cellpadding="0" cellspacing="0" class="thin">
	  <pg:listdata dataInfo="com.chinacreator.sysmgrcore.purviewmanager.tag.ResQueryList" keyName="ResQueryList"/> 
	  <!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
	  <pg:pager maxPageItems="17" scope="request" data="ResQueryList" isList="false">
	  <tr class="labeltable_middle_td">
	  <!--���÷�ҳ��ͷ-->
	  	<%if(type.equals("user")){ %>
		<td height='20' class="headercolor" nowrap>�û����ڻ���</td>
		<td height='20' class="headercolor" nowrap>�û��ʻ�</td>
		<td height='20' class="headercolor" nowrap>�û�����</td>
		<%}else if(type.equals("role")){ %>
		<td height='20' class="headercolor" nowrap>��ɫ����</td>
		<td height='20' class="headercolor" nowrap>��ɫ��������</td>
		<td height='20' class="headercolor" nowrap>��ɫ������</td>
		<%}else if(type.equals("orgjob")){ %>
		<td height='20' class="headercolor" nowrap>��λ�����õĻ���</td>
		<td height='20' class="headercolor" nowrap>��λ����</td>
		<td height='20' class="headercolor" nowrap>��λ������</td>
		<%}else if(type.equals("org")){ %>
		<td height='20' class="headercolor" nowrap>������ʾ����</td>
		<%} %>
		<td height='20' class="headercolor" nowrap>��������</td>
		<td height='20' class="headercolor" nowrap>��Դ��Դ</td>
		<td height='20' class="headercolor" nowrap>��Ȩʱ��</td>
		<!-- <td height='20' class="headercolor" nowrap>��ɫ��ʶ</td> -->
	  </tr>
	  <pg:param name="restypeId"/>
	  <pg:param name="resId"/>
	  <pg:param name="resName"/>
	  <pg:param name="operategroup"/>
	  <pg:param name="type"/>
	  <pg:param name="selid"/>
	  <pg:param name="selname"/>
	  <pg:param name="isRecursion"/>
	  <!--��⵱ǰҳ���Ƿ��м�¼-->
	  <pg:notify>
	    <tr height="18px" >
		  <td class="detailcontent" colspan=100 align='center'>��ʱû�м�¼</td>
	    </tr>
	  </pg:notify>	
	  <!--list��ǩѭ�����ÿ����¼-->			      
	  <pg:list>
	  <tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'">	      	
	    <%if(type.equals("user")){ %>
		<td class="tablecells" align=left  nowrap><pg:cell colName="remark5" defaultValue=""/></td>							
		<td class="tablecells" align=left nowrap><pg:cell colName="userName" defaultValue=""/></td>
		<td class="tablecells" align=left nowrap><pg:cell colName="userRealname" defaultValue=""/></td>
		<%}else if(type.equals("role")){ %>
		<td class="tablecells" align=left  nowrap><pg:cell colName="roleName" defaultValue=""/></td>							
		<td class="tablecells" align=left nowrap><pg:cell colName="roleTypeName" defaultValue=""/></td>
		<td class="tablecells" align=left nowrap><pg:cell colName="userRealname" defaultValue=""/></td>
		<%}else if(type.equals("orgjob")){ %>
		<td class="tablecells" align=left  nowrap><pg:cell colName="remark5" defaultValue=""/></td>							
		<td class="tablecells" align=left nowrap><pg:cell colName="jobName" defaultValue=""/></td>
		<td class="tablecells" align=left nowrap><pg:cell colName="userRealname" defaultValue=""/></td>
		<%}else if(type.equals("org")){ %>
		<td class="tablecells" align=left  nowrap><pg:cell colName="remark5" defaultValue=""/></td>
		<%} %>
		<td class="tablecells" align=left><pg:cell colName="opName" defaultValue=""/></td>
		<td class="tablecells" align=left>
		<pg:cell colName="resResource" defaultValue=""/>
		</td>
		<td class="tablecells" align=left>
			<pg:cell colName="sDate" defaultValue="δ֪ʱ��" dateformat="yyyy-MM-dd HH:mm:ss"/>
		</td>
		<!-- <td class="tablecells" align=left nowrap><pg:cell colName="roleId" defaultValue=""/></td> -->
	</tr>
	  </pg:list>
	    <tr height="18px" >
		  <td class="detailcontent" colspan=6 align='center'>��<pg:rowcount/>����¼ <pg:index /><input type="hidden" name="queryString" value="<pg:querystring/>"></td>
        </tr> 
	  </pg:pager>
	</table>
</form>
</body>
</html>
