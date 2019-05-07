<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<% 
	//日志ID
	String logId = request.getParameter("logId");
	
	String operTable = request.getParameter("operTable")==null?"":request.getParameter("operTable");
	String detailContent = request.getParameter("detailContent")==null?"":request.getParameter("detailContent");
%>
<html>
	<head>
		<title>日志明细查询</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<base target="_self"/>
	<script type="text/javascript">
		function resetwindow()
		{
			document.detailForm.action = window.location.href;	
			document.detailForm.target = "";
			
			document.detailForm.submit();
			
		}
		
		function queryDetail(){
			document.detailForm.target = "hiddenIframe";
			document.detailForm.action = "logDetailList.jsp";
			resetwindow();
		}
		
		function resetValue(){
			document.all.operTable.value = "";
			document.all.detailContent.value = "";
		}
	</script>
	</head>
<%@ include file="/epp/css/cssControl.jsp"%><body >

<form name="detailForm" method="post" />
<table class="thin"  width="100%" border="0" cellpadding="0" cellspacing="1" >
<caption>日志明细查询</caption>
<br/>
<tr>
<td align="center" width="15%">日志操作的表：</td>
<td align="center"><input name="operTable" type="text" value="<%=operTable %>" style="width:100%"/></td>
</tr>
<tr>
<td align="center" width="15%">操作记录内容：</td>
<td align="center"><input name="detailContent" type="text" value="<%=detailContent %>" style="width:100%"/></td>
</tr>
<tr>
<td></td>
<td align="right">
	<input type="button" value="查询" onclick="queryDetail()" class="input"/>
	<input type="button" value="重置" onclick="resetValue()" class="input"/> 
	<input type="button" value="关闭页面" onclick="window.close();" class="input"/> 
</td>
</tr>
</table>
<table class="thin" width="100%" border="0" cellpadding="0" cellspacing="1" >
	<pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.LogDetailSearchList" keyName="LogDetailSearchList" />
		<!--分页显示开始,分页标签初始化-->
		<pg:pager maxPageItems="12" scope="request" data="LogDetailSearchList" isList="false">
		<tr class="labeltable_middle_td">
			<td height='20' class="headercolor">日志操作的表</td>
			<td height='20' class="headercolor">操作表的主键ID值</td>
			<td height='20' class="headercolor">操作记录内容</td>
			<td height='20' class="headercolor">操作类型</td>
		</tr>
		<pg:param name="operTable"/>
		<pg:param name="detailContent"/>
		<pg:param name="logId"/>
		
		<!--检测当前页面是否有记录-->
		<pg:notify>
			<tr height='25' class="labeltable_middle_tr_01">
				<td colspan="100" align='center'>
					没有日志明细记录
				</td>
			</tr>
		</pg:notify>
		<pg:list>
			<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
				<td  height='20' align="left" class="tablecells"><pg:cell colName="operTable" defaultValue="" /></td>
				<td  height='20' align="left" class="tablecells"><pg:cell colName="operKeyID" defaultValue="" /></td>
				<td  height='20' align="left" class="tablecells"><pg:cell colName="detailContent" defaultValue="" /></td>
				<td  height='20' align="left" class="tablecells">
				<pg:equal colName="operType" value="0">无操作</pg:equal>
				<pg:equal colName="operType" value="1">新增</pg:equal>
				<pg:equal colName="operType" value="2">删除</pg:equal>
				<pg:equal colName="operType" value="3">修改</pg:equal>
				<pg:equal colName="operType" value="4">其他</pg:equal>	
				</td>
			</tr>
		</pg:list>
		<tr height="30" class="labeltable_middle_tr_01">
			<td colspan=100 align='center'>
			  每页12条&nbsp;&nbsp;共<pg:rowcount/>条记录&nbsp;&nbsp;<pg:index />
			<input type="hidden" name="querystring" value="<pg:querystring/>"></td>
		</tr>
	</pg:pager>
</table>
</form>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>