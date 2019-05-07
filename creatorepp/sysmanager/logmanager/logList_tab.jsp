<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@page import="com.chinacreator.sysmgrcore.manager.db.LogManagerImpl"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@page import="com.chinacreator.security.AccessControl,com.frameworkset.common.poolman.DBUtil"%>
<%@page import="java.util.Date"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
    //当前的时间
	String riqi ;		
	String curUserId = accesscontroler.getUserID();
	java.text.SimpleDateFormat   df=new   java.text.SimpleDateFormat("yyyy-MM-dd");
    Date currentDate = new Date(); 
    /**当前时间*/ 
    riqi = df.format(currentDate);
    
    String back = request.getParameter("back");
    String days = request.getParameter("days");
    boolean state = false;
    if(back != null && "1".equals(back)){
    	
    	new LogManagerImpl().backupLog(days);
    	state = true;
    }
    
	
String rootpath = request.getContextPath();
    /*
    String operUser=request.getParameter("operUser");    
    String type=request.getParameter("type"); 
    //String logModuel=request.getParameter("logModuel");       
    String oper=request.getParameter("oper");     
	String startDate=request.getParameter("startDate");
	String endDate = request.getParameter("endDate");
    operUser = operUser==null?"":operUser;
    type = type==null?"":type;
    oper = oper==null?"":oper;
    startDate = startDate==null?"":startDate;
    endDate = endDate==null?"":endDate;
	if(startDate==null || startDate==""){
		//startDate = riqi;
	}
	if(endDate==null || endDate==""){
		//endDate = riqi;
	}
   */
    
%>
<html >
      

<head>
		<title>日志管理</title>
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE6">
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
<tab:tabConfig/>		
<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>		
<script language="javascript" src="../scripts/selectTime.js"></script>

<script src="../inc/js/func.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/public/datetime/calender_date.js" ></script>
<script language="JavaScript" src="../../sysmanager/scripts/selectTime.js" type="text/javascript"></script>
<script type="text/javascript" src="../../public/datetime/calender.js" language="javascript"></script>
<script type="text/javascript" src="../../public/datetime/calender_date.js" language="javascript"></script>
<script language="JavaScript">
	var state = <%=state%>;
	if(state){
		<%if("0".equals(days)){%>
		alert("备份所有数据成功！");
		getNavigatorContent().location.reload();
		<%}else{%>
		alert("备份 <%=days%> 天前的数据成功！");
		getNavigatorContent().location.reload();
		<%}%>
	}

	var jsAccessControl = new JSAccessControl("#DAE0E9","#F6F8FB","#F6F8FB");
	function getLogInfo(e,logId){
	jsAccessControl.setBackColor(e);
	document.all("selectId").value = logId;
	}
	
	function queryUser(isHis)
	{	
		//查询
		if(LogForm.startDate.value>LogForm.endDate.value)
		{
			alert("开始时间不能大于结束时间！");
			return;
		}
		else{
		    //document.all.logGrid.src="logList.jsp?curUserId=<%=curUserId%>"
		    //+"&operUser="+document.all.operUser.value
		    //+"&oper="+document.all.oper.value
		    //+"&type="+document.all.type.value
		    //+"&startDate="+document.all.startDate.value
		    //+"&endDate="+document.all.endDate.value
		    //+"&logModuel="+document.all.logModuel.value
		    //+"&isHis="+isHis
		    //+"&opOrgid="+document.all.opOrgid.value;
		    var isRecursion = "0";
		    if(document.LogForm.isRecursion.checked){
		    	isRecursion = "1";
		    }
		    document.LogForm.target="logGrid"
		    document.LogForm.action="logList.jsp?isHis=n&isRecursion="+isRecursion;
		    document.LogForm.submit();
		    document.LogForm.target="";
		    
			//LogForm.action="logList_tab.jsp";
            //LogForm.action="logList_tab.jsp";
			//LogForm.submit();	
		}
	}
    
    function resetForm(){
        document.all("operUser").value = "";
        document.all("oper").value = "";
        document.all("startDate").value = "";
        document.all("endDate").value = "";
    }
    
    function backUp(){
    	var days = document.all.beforDay.value;
    	if(days.length == 0){
    		days = 0;
    	}else{
	    	if(days.search(/[^0-9]/g) != -1){
	    		alert("备份天数只能为整型数据！");
	    		return;
	    	}
    	}
    	document.LogForm.action = "logList_tab.jsp?back=1&days="+days;
    	document.LogForm.submit();
    	
    }
    
    function selectOrg(){
		var url = "../../sysmanager/dictmanager/orgSelectTree.jsp";
		var returnVal = window.showModalDialog(url,window,"dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0");
		if(typeof(returnVal) != "undefined" && returnVal != "" && returnVal.split("^")[0] != ""){
			document.all.opRemark5.value = returnVal.split("^")[0].split(" ")[1];
			document.all.opOrgid.value = returnVal.split("^")[0].split(" ")[0];
		}
	}
	
	function isValue(){
		var val = document.LogForm.opRemark5.value;
		if(val != ""){
			document.LogForm.isRecursion.disabled = false;
		}else{
			document.LogForm.isRecursion.disabled = true;
		}
	}
	
	function queryState(obj){
		window.showModalDialog("statLogmodule.jsp?isHis="+obj,window,"dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;scroll=yes;status=no;titlebar=no;toolbar=no;maximize=yes;minimize=0;");
	}
</script>
<%@ include file="/epp/css/cssControl.jsp"%><body >

<tab:tabContainer id="log-bar-container" selectedTabPaneId="loglist">
	<tab:tabPane id="loglist" tabTitle="在线日志查询" >
			<form name="LogForm" action="logList_tab.jsp"  method="post">
				<table width="95%" border="0"  align="center" cellpadding="0" cellspacing="1" class="thin">
					<tr valign='top'>
           					<td height='30'valign='middle' colspan="4"><img src='<%=rootpath%>/sysmanager/images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;
           					<strong>日志列表</strong></td>
           					<td align="right"><input type="button" value="日志模块统计查询" class="input" onclick="queryState('y')"/></td>
         			</tr>
					<tr>
						<td class="detailtitle" width="8%" align="center">
							操作人帐号
						</td>
						<td class="detailcontent" width="20%">
							<input type="text" name="operUser" value="" style="width:100%">
						</td>
						
					  	<td class="detailtitle" width="14%" align="center">所属机构:</td>
						<td width="35%">
							<input type="text" name="opRemark5" value="" style="width:100%" readonly="false" onclick="selectOrg()" >
							<input type="hidden" name="opOrgid" value="" style="width:100%">
						</td>
						<td>
							<input type="checkbox" name="isRecursion" title="当且仅当选择了所属机构才有效">递归查询子机构
					  </td>
					</tr>
					
					<tr>
						<td class="detailtitle" width="16%" align="center">
							日志内容
						</td>
						<td class="detailcontent" width="16%">
							<input type="text" name="oper" value="" style="width:100%">
						</td>
						<td>操作起止时间：
							
						</td>
						<td colspan="2">
							<input type="text" name="startDate" onclick="showdate(document.all('startDate'))" readonly="true" value="" validator="stringNull" cnname="开始时间" maxlength="40">
						     到
						     <input type="text" name="endDate" onclick="showdate(document.all('endDate'))" readonly="true" value="" validator="stringNull" cnname="终止时间" maxlength="40">
						
						</td>
						
					</tr>
					<tr>
					<td class="detailtitle"   align="center">
							日志模块
						</td>
						<td class="detailcontent">
							<select name="logModuel" class="cms_select" style="width:100%" onChange="">
								<option value="">所有模块</option>
							<!-- <pg:listdata dataInfo="LogModuleList" keyName="LogModuleList" />-->
							<!--分页显示开始,分页标签初始化-->
							<!--<pg:pager maxPageItems="15" scope="request" data="LogModuleList" isList="false">
							<pg:list>
							
								<option value="<pg:cell colName="LOGMODULE" defaultValue="" />"><pg:cell colName="LOGMODULE" defaultValue="" /></option>												
							
							</pg:list>
							</pg:pager> 下拉列表不应该用标签分页?weida-->
							<%
							try {
								DBUtil dbUtil = new DBUtil();
								String hsql ="select * from TD_SM_LOGMODULE order by logmodule";
								dbUtil.executeSelect(hsql);
								for(int i = 0; i < dbUtil.size(); i ++)
								{
									%>
									<option value="<%=dbUtil.getString(i,"LOGMODULE")%>"><%=dbUtil.getString(i,"LOGMODULE")%></option>
									<%
								}
							} catch (Exception e) {
								e.printStackTrace();
							}
							%>
							</select>
<!--							<input type="text" name="oper" style="width:100%">-->
						</td>
					
					
					<td class="detailtitle"  align="center">日志来源:</td>
					<td><input type="text" name="logVisitorial" value="" style="width:100%"></td>
					
					<td align="center">
								<input name="search" type="button" class="input" value="查询" onClick="queryUser('n')">
								<input name="Submit22" type="reset" class="input" value="重置" onClick="resetForm()">
					</td>
					</tr>
					<%if(accesscontroler.isAdmin()){ %>
					<tr>
					<td align="center">备份几天前的日志</td>
					<td><input name="beforDay" type="text" value="0"/></td>
					<td colspan="2"><input name="but" type="button" value="备份" class="input" onclick="backUp()"/>
					默认备份全部的日志（天数为0或不填写）
					</td>
					</tr>
					<%} %>
					</table>
					<table width="95%" border="0"  align="center" cellpadding="0" cellspacing="0" class="thin">
					<tr>
					<td>
						<img height="0" width="0"/>
				  <iframe src="logList.jsp?isHis=n" name="logGrid"  width="100%" height="430px" frameborder="0" style="display:inline"></iframe>				
					</td>
					</tr>
			  </table>
	          <div align="center"></div>
			</form>
		
	</tab:tabPane>
	
	<tab:tabPane id="log-his" tabTitle="历史日志查询"  lazeload="true" >
		
		<tab:iframe id="loghis" src="LogHisList.jsp" frameborder="0" width="100%" height="560px"/>
			
	</tab:tabPane>
<!--模块是否填写日志控制页面------------------------------------------------------------------>
<%if(accesscontroler.isAdmin()){ %>
	<tab:tabPane id="log-module" tabTitle="记录日志设定"  lazeload="true" >
		
		<tab:iframe id="logmodule" src="LogModuleList.jsp" frameborder="0" width="100%" height="505px"/>
			
	</tab:tabPane>
<%} %>
</tab:tabContainer>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
<script>

</script>
</html>
