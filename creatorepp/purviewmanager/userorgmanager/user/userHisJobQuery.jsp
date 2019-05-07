<% 
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@page import="com.chinacreator.sysmgrcore.manager.db.UserManagerImpl"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%
/*
 * <p>Title: �û���ʷ��ְ���</p>
 * <p>Description: �û���ʷ��ְ���</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-9-9
 * @author gao.tang
 * @version 1.0
 */
 %>
 
<% 
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request, response);
	
	String userId = request.getParameter("userId");

		User user = new UserManagerImpl().getUserById(userId);
	
%>
<html>
<head>
	<base target="_self">
	<title>�û�<%out.print(user.getUserName()+"��"+user.getUserRealname()+"��"); %>��ʷ��ְ���</title>
	<link rel="stylesheet" type="text/css" href="../../css/windows.css">
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body >
<br/>
<form name="com.frameworkset.goform" method="post">
</form>

	<fieldset>
	<LEGEND align=left><strong>&nbsp;�û�<%out.print(user.getUserName()+"��"+user.getUserRealname()+"��"); %>����ʷ��ְ���&nbsp;</strong></LEGEND>
	<table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% class="thin">
		<pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.UserHisJobQuery" keyName="userHisJobQuery" />
		<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
		<pg:pager maxPageItems="15" scope="request" data="userHisJobQuery" isList="false">
		
		<tr>
			<td height='20' class="headercolor">��ʷ��ְ����</td>
			<td height='20' class="headercolor">��ʷ��ְ��λ</td>
			<td height='20' class="headercolor">��ְʱ��</td>
			<td height='20' class="headercolor">��ְʱ��</td>
		</tr>
		<pg:param name="userId"/>
		<!--��⵱ǰҳ���Ƿ��м�¼-->
		<pg:notify>
			<tr height='25' class="labeltable_middle_tr_01">
				<td colspan="100" align='center'>
					û�м�¼
				</td>
			</tr>
		</pg:notify>
		<!--list��ǩѭ�����ÿ����¼-->
		<pg:list>
			<tr>
				<td  height='20' align="left" class="tablecells">
					<pg:cell colName="orgid" defaultValue="" /> <pg:cell colName="remark5" defaultValue="" />
				</td>
				<td  height='20' align="left" class="tablecells">
					<pg:cell colName="jobid" defaultValue="" /> <pg:cell colName="jobname" defaultValue="" />
				</td>
				<td  height='20' align="left" class="tablecells">
					<pg:cell colName="JOB_STARTTIME" defaultValue="δ֪ʱ��"  dateformat="yyyy-MM-dd HH:mm:ss" />
				</td>
				<td  height='20' align="left" class="tablecells">
					<pg:cell colName="JOB_QUASHTIME"  defaultValue="δ֪ʱ��"  dateformat="yyyy-MM-dd HH:mm:ss" />
				</td> 
			</tr>
		</pg:list>
		<tr height="18px" class="labeltable_middle_tr_01" id="tests" name="tests">
			<td colspan=4 align='center'  nowrap> 
				��<pg:rowcount/>����¼ <pg:index />
				<input type="hidden" name="querystring" value="<pg:querystring/>">
			</td>								 
	    </tr>
		</pg:pager>
		</table>
		</fieldset>


</body>
</html>