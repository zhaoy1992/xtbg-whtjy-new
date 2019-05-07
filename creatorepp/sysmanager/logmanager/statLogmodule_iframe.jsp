<%     
  response.setHeader("Cache-Control", "no-cache"); 
  response.setHeader("Pragma", "no-cache"); 
  response.setDateHeader("Expires", -1);  
  response.setDateHeader("max-age", 0); 
%>
<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>



<html>
<head>
<title>模块日志数统计</title>
	<link rel="stylesheet" type="text/css" href="../css/windows.css">
</head>	
	
<%@ include file="/epp/css/cssControl.jsp"%><body >
<table class="thin"  width="100%" border="0" cellpadding="0" cellspacing="1" >
	<pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.LogModuleStat" keyName="LogDetailSearchList" />
		<!--分页显示开始,分页标签初始化
		statement="select count(log_id) as count, oper_module as module from td_sm_log group by oper_module" 
		dbname="bspf"
		-->
		<pg:pager maxPageItems="15" scope="request" 
		
		data="LogDetailSearchList" isList="false">
		<tr class="labeltable_middle_td">
			<td height='20' class="headercolor">模块名称</td>
			<td height='20' class="headercolor">日志记录数</td>
		</tr>
		<pg:param name="opRemark5"/>
		<pg:param name="isHis"/>
		<pg:param name="opOrgid"/>
		<pg:param name="isRecursion"/>
		<pg:param name="startDate"/>
		<pg:param name="endDate"/>
		<pg:param name="logVisitorial"/>
		
		<!--检测当前页面是否有记录-->
		<pg:notify>
			<tr height='25' class="labeltable_middle_tr_01">
				<td colspan="100" align='center'>
					没有模块操作记录
				</td>
			</tr>
		</pg:notify>
		<pg:list>
			<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
				<td  height='20' align="left" class="tablecells"><pg:cell colName="module" defaultValue="" /></td>
				<td  height='20' align="left" class="tablecells"><pg:cell colName="counts" defaultValue="" /></td>
			</tr>
		</pg:list>
		<tr height="30" class="labeltable_middle_tr_01">
			<td colspan=100 align='center'>
			  每页15条&nbsp;&nbsp;共<pg:rowcount/>条记录&nbsp;&nbsp;<pg:index />
			<input type="hidden" name="querystring" value="<pg:querystring/>"></td>
		</tr>
	</pg:pager>
</table>
</body>
</html>