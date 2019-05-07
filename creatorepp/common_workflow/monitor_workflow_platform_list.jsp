<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
//String appName = accesscontroler.getCurrentSystemID();
String class_id = request.getParameter("class_id");
String busiTitle = request.getParameter("busiTitle");
String ecName = request.getParameter("ecName");
String appName = request.getParameter("appName");
String busiId = request.getParameter("busiId");

if (busiTitle == null) {
	busiTitle = "";
}
if (ecName == null) {
	ecName = "";
}
if (appName == null) {
	appName = "";
}
if (busiId == null) {
	busiId = "";
}
%>
<html>
	<head>
		<title></title>

		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/include/pager.js" type="text/javascript"></script>
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/scripts/common.js" type="text/javascript"></script>
		<script language="JavaScript">
	var jsAccessControl = new JSAccessControl("#ff0000","#ffffff","#eeeeee");
	function handle(procInsId){
        window.open("workflow_record_list.jsp?procInsId="+procInsId,""
        ,"height=630,width=850,status=yes,toolbar=no,menubar=no,location=no");
	}
	function search(){
		document.forms[0].submit();
	}
	function clearInput(){
		if(document.all.appName)document.all.appName.value="";
		if(document.all.busiTitle)document.all.busiTitle.value="";
		if(document.all.ecName)document.all.ecName.value="";
	}
	function resetForm(){
		var form = document.getElementById("work");
		var inputs = form.getElementsByTagName("input");
		
		for(var i=0;i<inputs.length;i++){
			var inputElement = inputs[i];
			if(inputElement.type=="text"){
				inputElement.value = "";
			}
		}
	}
	
</script>
	<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin"  scrolling="no">
		<div id="contentborder" align="center">
			<FORM name="work" id="work" action="monitor_workflow_platform_list.jsp" method="post">
			<hr width="100%">

				<table width="100%" cellpadding="0" cellspacing="0" border="1"
				bordercolorlight="#3B4D61" bordercolordark="#ffffff"
				style="padding:2">
				<tr>
				<td align="left" nowrap>
					应用名称:<input type="text" name="appName" size="25" value="<%=appName %>"/>
				</td>
				<td align="left" nowrap>
					业务类别:<input type="text" name="ecName" size="25" value="<%=ecName %>"/>
				</td>
				</tr>
				<tr>
				<td align="left" nowrap>
					业务名称:<input type="text" name="busiTitle" size="25" value="<%=busiTitle %>"/>
				</td>
				<td align="left" nowrap>
					业务编号:<input type="text" name="busiId" size="25" value="<%=busiId %>"/>
				</td>
				</tr>
				<tr>
				<td align="right" nowrap colspan=2>
					<INPUT type="button" class="input" name="bt_search" value="查询"
                                  onclick="search()">
	                 <INPUT type="button" class="input" name="bt_clear" value="重置" onclick="resetForm();search();">
	                 <!-- <input name="Submit23" type="button" class="input" value="清空" onclick="clearInputTextFormID('work')"> -->
				</td>
				</tr>
				</table>

				<TABLE width="100%" cellpadding="1" cellspacing="1" bordercolor="#EEEEEE" class="thin">
					<pg:listdata dataInfo="com.chinacreator.commonworkflow.list.SHKMonitorWorkForPlatformList" keyName="SHKMonitorWorkForPlatformList" />
					<pg:pager maxPageItems="20" scope="request" data="SHKMonitorWorkForPlatformList" isList="false">
                    <pg:param name="class_id" />
					<pg:param name="busiTitle" />
					<pg:param name="ecName" />
					<pg:param name="appName" />
					<pg:param name="busiId" />					
						<td nowrap class="headercolor">
							流程名称
						</td>
						<%if(appName.equals("module")){ %>
						<td nowrap class="headercolor">
							应用名称
						</td>
						<%} %>
						<td nowrap class="headercolor">
							业务名称
						</td>
						<td nowrap class="headercolor">
							业务类别
						</td>
                        <td nowrap class="headercolor">
                                业务编号
                        </td>
                        <td nowrap class="headercolor">
                                当前环节
                        </td>
                        <td nowrap class="headercolor">
                                上次执行时间
                        </td>
                         <td nowrap class="headercolor">
                          </td>
						<pg:list>
							<tr class="labeltable_middle_tr_01" onMouseOver="this.className='mousestyle1'"
							 onMouseOut="this.className= 'mousestyle2'"
                             ondblclick="handle('<pg:cell colName="procInsId"/>')">
								<td  class="tablecells" width="20%" >
									<pg:cell colName="procName"  />
								</td>
								<%if(appName.equals("module")){ %>
								<td  class="tablecells" width="20%" >
									<pg:cell colName="appName"  />
								</td>
								<%} %>
								<td class="tablecells" width="20%" >
									<pg:cell colName="busiTitle" />
								</td>
								<td class="tablecells" width="20%" >
									<pg:cell colName="ecName" />
								</td>
                                <td class="tablecells" width="20%" >
                                 <pg:cell colName="busiId" />
                                </td>
                                <td class="tablecells" width="20%" >
                                 <pg:cell colName="runActName" />
                                </td>
                                <td class="tablecells" nowrap width="20%" >
                                 <pg:cell colName="laststatetime" />
                                </td>
                                <td class="tablecells" width="15%" nowrap="nowrap">
                                 <INPUT type="button" class="input" name="handle_ass" value="查看"
                                  onclick="handle('<pg:cell colName="procInsId"/>')">
                                </td>
							</tr>
						</pg:list>
						<tr height="18px" class="labeltable_middle_tr_01">
							<td colspan=16 align='center' nowrap="nowrap">
								总共:<pg:rowcount />条记录  <pg:index />
							</td>
						</tr>
						<input name="queryString" value="<pg:querystring/>" type="hidden">
					</pg:pager>
				</TABLE>
			</FORM>
		</div>
	</body>
</html>
