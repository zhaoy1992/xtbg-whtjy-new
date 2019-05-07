<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.text.DateFormat,java.text.SimpleDateFormat,java.util.Calendar,java.util.Date"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	//当前的时间
	String riqi;
	java.text.SimpleDateFormat df = new java.text.SimpleDateFormat(
			"yyyy-MM-dd");
	Date currentDate = new Date();
	/**当前时间*/
	riqi = df.format(currentDate);
	String operUser = request.getParameter("operUser");
	String type = request.getParameter("type");
	String oper = request.getParameter("oper");
	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");
	operUser = operUser == null ? "" : operUser;
	type = type == null ? "" : type;
	oper = oper == null ? "" : oper;
	startDate = startDate == null ? "" : startDate;
	endDate = endDate == null ? "" : endDate;
	if (startDate == null || startDate == "") {
		startDate = riqi;
	}
	if (endDate == null || endDate == "") {
		endDate = riqi;
	}
	String rootpath = request.getContextPath();
%>
<html >
      

<head>
		<title>属性容器</title>
		
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
	
	
		
	
		
	function logState(status,id){
	outMsg = "您确定要更改该模块的日志记录状态吗？";
    	if (confirm(outMsg)){
    		LogModuleForm.action="<%=rootpath%>/sysmanager/logmanager/submitLog_do.jsp?status="+ status +"&id="+id+"&flag=1";
			LogModuleForm.submit();
		}else{
			LogModuleForm.submit();
		}
	  
	}		
	
</script>
<%@ include file="/epp/css/cssControl.jsp"%><body >
		
				<table width="100%" border="0"   cellpadding="0" cellspacing="1" class="thin">
					<tr valign='top'>
           					<td height='30'valign='middle' colspan="5"><img src='<%=rootpath%>/sysmanager/images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;
           					<strong>模块列表</strong></td>
         			</tr>
				
			  </table>
			

				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">

					
					<pg:listdata dataInfo="LogModuleList" keyName="LogModuleList" />
					<!--分页显示开始,分页标签初始化-->
					<pg:pager maxPageItems="15" scope="request" data="LogModuleList" isList="false">
						<tr class="labeltable_middle_td">
							<!--设置分页表头-->
							
				    		<td height='20' class="headercolor" align=left>模块名称</td>
				    		<td height='20' class="headercolor" align=left>模块描述</td>
							<td height='20' class="headercolor" align=left>操作该模块时是否记录日志</td>
							
					</tr>
						
						
						
						<!--检测当前页面是否有记录-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									暂时没有模块记录
								</td>
							</tr>
						</pg:notify>

						<!--list标签循环输出每条记录-->
						<form name="LogModuleForm" action="" method="post">
						<pg:list>
					 
							<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
								<td height='20' align=left class="tablecells"><pg:cell colName="LOGMODULE" defaultValue="" /></td>
								<td height='20' align=left class="tablecells"><pg:cell colName="MODULE_DESC" defaultValue="" /></td>
								<td height='20' align=left class="tablecells">
								<INPUT type="checkbox" name="status" 
								<pg:equal colName="STATUS" value="0">checked
								</pg:equal>
								<pg:equal colName="STATUS" value="1">
								</pg:equal>
								onClick="logState('<pg:cell colName="STATUS" defaultValue=""/>','<pg:cell colName="id" defaultValue="" />')" value="<pg:cell colName="STATUS" defaultValue="0" />">
								<pg:equal colName="STATUS" value="0">记录日志
								</pg:equal>
								<pg:equal colName="STATUS" value="1">不记录日志
								</pg:equal>
								</td>
													      				
							</tr>
						
						</pg:list>
						</form> 
						<tr height="30" class="labeltable_middle_tr_01">
							<td colspan=100 align='center'><div align="right">
						
							
							    </div>
							  <pg:index />
							</td>
						</tr>
					</pg:pager>

				</table>

	          <div align="center"></div>
<iframe src="" name="deleteLogs" width=0 height=0 style="display:none"></iframe>
</body>
</html>
