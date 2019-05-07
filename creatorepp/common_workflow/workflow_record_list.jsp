<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String procInsId = request.getParameter("procInsId");
%>
<html>
	<head>
		<title></title>
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js"
			type="text/javascript"></script>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/sysmanager/include/pager.js"
			type="text/javascript"></script>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/sysmanager/scripts/common.js"
			type="text/javascript"></script>
		<script language="JavaScript">
function viewPic(){
	 window.open("<%=request.getContextPath()%>/CreateGraphServlet?proID=<%=procInsId%>",""
        ,"height=630,width=850,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes");
    //     window.open("view_workflow_pic.jsp?procInsId=<%=procInsId%>",""
    //    ,"height=630,width=850,status=yes,toolbar=no,menubar=no,location=no");
}
</script>
	<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" scrolling="no">
		<div id="contentborder" align="center">
			<FORM name="work" action="" method="post">
				<TABLE width="100%" cellpadding="1" cellspacing="1"
					bordercolor="#EEEEEE" class="thin">
					<pg:listdata dataInfo="com.chinacreator.commonworkflow.list.SHKWorkRecordList"
						keyName="SHKWorkRecordList" />
					<pg:pager maxPageItems="30" scope="request"
						data="SHKWorkRecordList" isList="false">
						<pg:param name="" />
						<td nowrap class="headercolor">
							活动
						</td>
						<td nowrap class="headercolor">
							执行人
						</td>
						<td nowrap class="headercolor">
							接收时间
						</td>
						<td nowrap class="headercolor">
							处理时间
						</td>
						<td nowrap class="headercolor">
							到期时间
						</td>
						<td nowrap class="headercolor">
							是否超期
						</td>
						<td nowrap class="headercolor">
							状态
						</td>						
						<pg:list>
							<tr class="labeltable_middle_tr_01"
								onMouseOver="this.className='mousestyle1'"
								onMouseOut="this.className= 'mousestyle2'">
								<td class="tablecells" width="15%">
									<pg:cell colName="actName" />
								</td>
								<td class="tablecells" width="15%">
									<pg:cell colName="curUserName" />
								</td>
								<td class="tablecells" nowrap width="15%">
									<pg:cell colName="activatedTime" />
								</td>
								<td class="tablecells" nowrap width="15%">
									<pg:cell colName="laststatetime" />
								</td>
								<td class="tablecells" nowrap width="15%">
									<pg:cell colName="limitTime" />
								</td>
								<td class="tablecells" nowrap width="15%">
									<pg:cell colName="isOverTime" />
								</td>
								<td class="tablecells" nowrap width="15%">
									<pg:cell colName="state" />
								</td>
							</tr>
						</pg:list>
					</pg:pager>
					<tr>
						<td colspan=16 align='center' nowrap="nowrap">
							<input class="input" type="button" name="but_back" value="查看图片"
								onClick="viewPic()">
						</td>
					</tr>
				</TABLE>
			</FORM>
		</div>
	</body>
</html>
