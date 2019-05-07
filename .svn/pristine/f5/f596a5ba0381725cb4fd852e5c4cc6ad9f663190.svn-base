
<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>


<%@ page import="com.chinacreator.workflow.IWorkFlow"%>
<%@ page import="com.chinacreator.workflow.WorkFlowFactory"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="org.enhydra.shark.SharkUtilities"%>
<%@ page import="org.enhydra.shark.swingclient.SharkClient"%>
<%@ page import="org.enhydra.shark.api.client.wfmodel.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.frameworkset.util.StringUtil" %>
<%@ page import="com.chinacreator.workflow.*" %>
 
<%			String pkgID = request.getParameter("pkgID");
			String pkgName = request.getParameter("pkgName");
			String proDefID = request.getParameter("proDefID");
			String proDefName = request.getParameter("proDefName");
			String proID = null;
			WfActivity[] allRunningActs = null;
			String[] acts = null;
			String proState = null;
			String State = null;    //中文的流程状态

			AccessControl accesscontroler = AccessControl.getInstance();
			HttpServletResponse res = null;
			accesscontroler.checkAccess(request, res);
%>
<script language="JavaScript" src="../scripts/selectTime.js" type="text/javascript"></script>
<script language="javascript">
function suspend(proID,proState)
{
	 if(proState != 'open.running'){
	 alert("此流程正处于非运行状态!不能挂起！");
	 }
	 else{
		 if(window.confirm("是否需要挂起！！")){
		 location.href="suspend.jsp?proID="+proID;
		 }
	 }
}

 function restart(proID,proState)
 {
  if(proState != 'open.not_running.suspended'){
  alert("此流程正处于非挂起状态!不能重启！")
  }
  else{
  if(window.confirm("重启流程？？")){
  location.href = "restart.jsp?proID="+proID;
  }
  }
 }

function abort(proID,proState)
 {
 if(proState != 'open.running' && proState != 'open.not_running.not_started' && proState != 'open.not_running.suspended'){
  alert("此流程正处于完成终止或放弃状态!不能放弃")
  }
 else{
 if(window.confirm("放弃流程？？"))
 {
  location.href = "abort.jsp?proID="+proID;
  }
  }
 }
 
function terminate(proID,proState)
 {
 if(proState !='open.running'&& proState != 'open.not_running.not_started' && proState != 'open.not_running.suspended'){
  alert("此流程正处于完成终止或放弃状态!不能终止")
  }
  else{
 if(window.confirm("终止流程？？"))
 {
  location.href='terminet.jsp?proID='+proID;
  }
  }
 }
 
 function historydisplay(proID)
 {
window.open('<%=request.getContextPath()%>/sysmanager/workflowmanager/ActivityList.do?procID='+proID,'newwindow','height=300,width=600,top=300,left=300,toolbar=no,menubar=no,scrollbars=yes, resizable=no,location=no, status=no');
 }
</script>

<html>
<head>
	<title>流程监控</title>
</head>

<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">

<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
<div id="contentborder">
<form name="processesForm" action="" method="post">
<input type="hidden" name="flag" value="query">
<input type="hidden" name="pkgID" value="<%=pkgID%>">
<input type="hidden" name="pkgName" value="<%=pkgName%>">
<input type="hidden" name="proDefName" value="<%=proDefName%>">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
  <tr>
    <td>业务id</td>
    <td class="detailcontent"><input type="text" name="businessid"></td>
    <td>业务名称</td>
    <td class="detailcontent"><input type="text" name="businessname"></td>
    <td>流程实例id</td>
    <td class="detailcontent"><input type="text" name="processId"></td>
  </tr>
  <tr>
    <td>流程定义id</td>
    <%
    if(proDefID !=null){
    %>
    <td class="detailcontent"><input type="text" name="proDefID" value = "<%=proDefID%>" readonly = "true"></td>
    <%
    }else{
    %>
    <td class="detailcontent"><input type="text" name="proDefID" readonly = "true"></td>
    <%}%>
    <td>流程定义名称</td>
    <td class="detailcontent"><input type="text" name="processDefName"></td>
    <td>活动实例id</td>
    <td class="detailcontent"><input type="text" name="activityId"></td>   
  </tr> 
  <tr>
	<td colspan="2">流程发起时间:</td>
	<td>起始时间</td>
    <td class="detailcontent"><input type="text" name="startTimeOfStartPro"><input type="button" value=".." onclick="selectTime('processesForm.startTimeOfStartPro',0)"></td>
    <td>结束时间</td>
    <td class="detailcontent"><input type="text" name="endTimeOfStartPro"><input type="button" value=".." onclick="selectTime('processesForm.endTimeOfStartPro',0)"></td>
  </tr>
  <tr>
  <td colspan="2">流程结束时间:</td>
	<td>起始时间</td>
    <td class="detailcontent"><input type="text" name="startTimeOfEndPro"><input type="button" value=".." onclick="selectTime('processesForm.startTimeOfEndPro',0)"></td>
    <td>结束时间</td>
    <td class="detailcontent"><input type="text" name="endTimeOfEndPro"><input type="button" value=".." onclick="selectTime('processesForm.endTimeOfEndPro',0)"></td>
  </tr>
  <td>流程状态</td>
  <td class="detailcontent">
  	<select name="processState" style="width:125">
  		<option value="">---</optiong>
  		<option value="open.running">运行</optiong>
  		<option value="open.not_running.not_started">开始未运行</optiong>
  		<option value="open.not_running.suspended">挂起</optiong>
  		<option value="closed.completed">完成</optiong>
  		<option value="closed.aborted">放弃</optiong>
  		<option value="closed.terminated">终止</optiong>
  	</select>
  </td>
  <td>流程发起人</td>
  <td class="detailcontent"><input type="text" name="startedPerson"></td>
  <td colspan="3"><div>
            <input name="Submit" type="submit" class="input" value="查询">                
            <input name="Reset" type="reset" class="input" value="重置">
          </div>             
  </tr>     
</table>
</form>
<hr width="100%">	
		
			<table width="100%" cellpadding="1" cellspacing="1" class="thin">
				<tr>
					<td class="detailtitle" align=center colspan=8>
					    <%if(proDefID == null ){%>
						<b>请选择流程！</b>
						<%}else {%>
						<b><%=pkgName%>的<%=proDefName%>的流程实例列表</b>
						<%}%>
					</td>
				</tr>
				<tr>
				<td class="headercolor" align="center" >流程实例名称</d>
				<td class="headercolor" align="center" colspan=6>操作</d>
				<td class="headercolor" align="center">状态</d>
				</tr>
				<pg:listdata dataInfo="ProcessList" keyName="ProcessList" />
				<!--分页显示开始,分页标签初始化-->
				<pg:pager maxPageItems="10" scope="request" data="ProcessList" isList="false">
					<pg:param name="pkgID" />
					<pg:param name="pkgName" />
					<pg:param name="proDefID" />
					<pg:param name="proDefName" />

					<!--检测当前页面是否有记录-->
					<pg:notify>
						<tr height="18px">
							<td class="detailcontent" colspan=100 align='center'>
								<%if(proDefID == null ){%>
						        <b></b>
						        <%}else if(proDefID != null){%>
						        <b><%=pkgName%>包的<%=proDefName%>的暂无流程列表</b>
						        <%}%>
								
							</td>
						</tr>
					</pg:notify>

					<!--list标签循环输出每条记录-->
					<pg:list>
						<tr class="labeltable_middle_tr_01" onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'")" >
							<%
							  proID = dataSet.getString("id");
							  proState = dataSet.getString("status");
                              String url = rootpath + "/CreateImage?proID=" + proID + "&pkgID=" + pkgID;
							  State = ProStateConstant.getState(proState);
							%>
							<td class="tablecells" align=center>
								<pg:cell colName="businessName" defaultValue="" />
							</td>						
							<td class="tablecells" align=center><input name="monitor" type="button" class="input" onClick="window.open('<%=url%>','monitor','height=650,width=850,scrollbars=yes')"  value="监视"></td>
							<td class="tablecells" align=center><input name="suspend" type="button" class="input" onClick="suspend('<%=proID%>','<%=proState%>')"  value="挂起"></td>
						    <td class="tablecells" align=center><input name="restart" type="button" class="input" onClick="restart('<%=proID%>','<%=proState%>')"  value="恢复"></td>
							<td class="tablecells" align=center><input name="abort" type="button" class="input" onClick="abort('<%=proID%>','<%=proState%>')"  value="放弃"></td>
							<td class="tablecells" align=center><input name="terminate" type="button" class="input" onClick="terminate('<%=proID%>','<%=proState%>')"  value="终止"></td>
							<td class="tablecells" align=center><input name="history" type="button" class="input" onClick="historydisplay('<%=proID%>')"  value="历史"></td>
							<td class="tablecells" align=center>状态：<%=State%></td>
						</tr>
					</pg:list>
					<tr height="18px">
						<td class="detailcontent" colspan=8 align='center'>
							<pg:index />
							<input type="hidden" name="queryString" value="<pg:querystring/>">
						</td>
					</tr>
				</pg:pager>
			</table>
</div>
<%@ include file="../sysMsg.jsp"%>
	</body>
</html>
