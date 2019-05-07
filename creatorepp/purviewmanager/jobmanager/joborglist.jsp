
<%@page import="com.chinacreator.sysmgrcore.manager.OrgManager"%>
<%@page import="java.util.Map"%><%
/*
 * <p>Title: ��λ���������б�</p>
 * <p>Description:��λ���������б�</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
 * @author liangbing.tao
 * @version 1.0
 */
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.JobManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Job"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenuTag"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenu"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenuImpl"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.Menu"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>


<%
			AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkManagerAccess(request,response);
			
			OrgManager orgManager = SecurityDatabase.getOrgManager();
			//��ǰ�û��ɹ������ID�������Լ���������
			Map map = orgManager.getSubOrgId(accesscontroler.getUserID(),accesscontroler.isAdmin());
			String jobId = request.getParameter("jobId");
			String orgName = request.getParameter("orgName");
			String orgnumber = request.getParameter("orgnumber");
			
			Job job = new Job();
			String jobName = "";
			if(jobId==null || jobId.equals(""))
			{
				jobId = "";
			}
			else
			{
				JobManager jm = SecurityDatabase.getJobManager();
				job = jm.getJobById(jobId);
				jobName = job.getJobName();
			}			
			if (orgName == null) 
			{
				orgName = "";
			}
			if (orgnumber == null) 
			{
				orgnumber = "";
			}
%>
<html>
	<head>
		<TITLE>��λ����</TITLE>
		<link href="../css/windows.css" rel="stylesheet" type="text/css">
		<link href="../css/treeview.css" rel="stylesheet" type="text/css">
		<script language="JavaScript" src="../scripts/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../scripts/pager.js" type="text/javascript"></script>
		<script language="JavaScript">
			function userResList(orgId)
			{
				var url = "jobList_ajax.jsp?jobId=<%=jobId%>&orgId=" + orgId;
				window.showModalDialog(url,"","dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no");
			}
		</script>
	</head>

	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
			<form name="joborgForm" action="" method="post">
				<input type=hidden name=orgName value="<%=orgName%>" />
				<input type=hidden name=orgnumber value="<%=orgnumber%>"/>
				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
					<pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.JobOrgList" keyName="JobOrgList" />
					<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
					<pg:pager maxPageItems="10" scope="request" data="JobOrgList" isList="false">
						<tr class="labeltable_middle_td">
							<td colspan="4" align="center">
								<strong>��λ(<%=jobName%>)���������б�</strong>
							</td>
						</tr>
						<tr class="labeltable_middle_td">
							<!--���÷�ҳ��ͷ-->
							<td height='20' class="headercolor" width="30%">
								��������
							</td>
							<td height='20' class="headercolor" width="20%">
								�������
							</td>
							<td height='20' class="headercolor" width="20%">
								��������
							</td>
							<td height='20' class="headercolor" width="30%">
								��������
							</td>
						</tr>
						<pg:param name="jobId" />
						<pg:param name="orgnumber" />
						<pg:param name="orgName" />
						<!--��⵱ǰҳ���Ƿ��м�¼-->
						<pg:notify>
							<tr height="18px">
								<td class="detailcontent" colspan=100 align='center'>
									��ʱû����Դ
								</td>
							</tr>
						</pg:notify>
						<%ContextMenu contextmenu = new ContextMenuImpl();%>
						<!--list��ǩѭ�����ÿ����¼-->
						<pg:list>
							<%
								String orgIdm = dataSet.getString("orgId");
								String bgcolor = "#BDD5F9";
								if(map.get(orgIdm) != null){
									bgcolor = "#F6FFEF";
									Menu menu = new Menu();
									menu.setIdentity("opuser_" + orgIdm);
									Menu.ContextMenuItem menuitem1 = new Menu.ContextMenuItem();
									menuitem1.setName("��ɫ����");
									menuitem1.setLink("javascript:userResList('" + orgIdm + "')");
									menuitem1.setIcon("../images/rightmenu_images/doc_fbyl.gif");
									menu.addContextMenuItem(menuitem1);
									contextmenu.addContextMenu(menu);
								}
							%>
							<tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'">
								<td id="opuser_<%=orgIdm%>" height='20' class="tablecells" align=left bgcolor="<%=bgcolor %>">
									<pg:null colName="remark5">
										<pg:cell colName="orgName" />
									</pg:null>
									<pg:notnull colName="remark5">
										<pg:equal colName="remark5" value="">
											<pg:cell colName="remark5" />
										</pg:equal>
										<pg:notequal colName="remark5" value="">
											<pg:cell colName="remark5" />
										</pg:notequal>
									</pg:notnull>
								</td>
								<td class="tablecells" align=left height='20'>
									<pg:cell colName="orgnumber" defaultValue="" />
								</td>
								<td class="tablecells" align=left height='20'>
									<pg:cell colName="orgSn" defaultValue="" />
								</td>
								<td class="tablecells" align=left height='20'>
									<pg:equal colName="orgdesc" value="">û������</pg:equal>
									<pg:notequal colName="orgdesc" value="">
										<pg:cell colName="orgdesc" />
									</pg:notequal>
								</td>
							</tr>
						</pg:list>
						<tr height="18px">
							<td class="detailcontent" colspan=4 align='center'>
								��
								<pg:rowcount />
								����¼
								<pg:index />
								<input type="hidden" name="queryString" value="<pg:querystring/>">
							</td>
						</tr>
						<%request.setAttribute("opuser", contextmenu);%>
						<pg:contextmenu enablecontextmenu="true" context="opuser" scope="request" />
					</pg:pager>
				</table>
			</form>
	</body>
</html>
