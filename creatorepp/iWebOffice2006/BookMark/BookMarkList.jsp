<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.util.*,
                 com.chinacreator.security.AccessControl" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%
  AccessControl control = AccessControl.getInstance();
  control.checkAccess(request,response);
%> 
<html>
<head>
<title>标签管理</title>
<!-- link rel='stylesheet' type='text/css' href='../test.css'-->
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
		<META HTTP-EQUIV="Expires" CONTENT="0">

		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/sysmanager/applymanager/common.js"
			type="text/javascript"></script>
		<script language="JavaScript" src="<%=request.getContextPath()%>/include/pager.js"
			type="text/javascript"></script>
<script language="javascript">
		function ConfirmDel(bookMarkID){
		var url = 'BookMarkDel.jsp?BookMarkID='+bookMarkID;
	        if (confirm('是否确定删除该标签！')){
	                location.href=url;
	        }
	    }
        function cmd_ok(){
			    var check_num = setRadioSelect();
			    if(check_num==0){
			         return;
			    }
			    var obj1=document.all.selectId;
			    var url=obj1.value;
			    parent.close();
			    window.returnValue=url;
		}
		function Modify(bookMarkID){
			var url = "BookMarkEditFrm.jsp?BookMarkID="+bookMarkID;
			location.href=url;
		}
</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%>
<body class="contentbodymargin">

<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
        <tr>
			<td height='30' class="detailtitle" align="center" colspan="9">
				<b>标签管理</b>
			</td>
		</tr>
        <tr>
                <td colspan=5 height='20' nowrap align="right">
                  <input type=button class="input" name="Add" value="增加标签"  onclick="javascript:location.href='BookMarkAddFrm.jsp'">
                  <!-- input type=button name="Return" value="返 回"  onclick="javascript:location.href='../DocumentList.jsp';"-->
                </td>
                
        </tr>
        <tr>
                <td nowrap align=center class="headercolor" height="20" width="10%">编号</td>
                <td nowrap align=center class="headercolor" width="30%">标签名称</td>
                <td nowrap align=center class="headercolor" width="30%">标签说明</td>
                <td nowrap align=center class="headercolor" width="20%">标签备注</td>
		<td nowrap align=center class="headercolor">操作</td>
        </tr>
<pg:listdata dataInfo="com.chinacreator.iWebOffice2006.BookMarkList" keyName="com.chinacreator.iWebOffice2006.BookMarkList" />
<!--分页显示开始,分页标签初始化-->
	<pg:pager maxPageItems="10" scope="request" data="com.chinacreator.iWebOffice2006.BookMarkList" isList="false">
		<!--检测当前页面是否有记录-->
		<pg:notify>
			<tr height='25' class="labeltable_middle_tr_01">
				<td colspan=100 align='center'>
					暂时没有文件
				</td>
			</tr>
		</pg:notify>
	<pg:list>
      <tr class="labeltable_middle_tr_01" onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'">
      <input class="text" type="hidden" name="selectId" value="">
      <input name="delSingle" type="hidden" validator="string" maxlength="100" value="false">
         <td height='20' align=center class="tablecells"><pg:cell colName="bookMarkID" defaultValue=""/>&nbsp;</td>
         <td height='20' align=center class="tablecells"><pg:cell colName="bookMarkName" defaultValue=""/>&nbsp;</td>
         <td height='20' align=center class="tablecells"><pg:cell colName="bookMarkDesc" defaultValue=""/>&nbsp;</td>
         <td height='20' align=center class="tablecells"><pg:cell colName="bookMarkText" defaultValue=""/>&nbsp;</td>
         <td height='20' align=center class="tablecells" width=148 nowrap><input class='input' type="button" name="Edit" value="修改" onclick=Modify('<pg:cell colName="bookMarkID" defaultValue=""/>') /><input class='input' type="button" name="Del" value="删除" onclick=ConfirmDel('<pg:cell colName="bookMarkID" defaultValue=""/>') />
         </td>
	</tr>
<!--检测当前页面是否有记录-->
		
	</pg:list>
		<tr height="30" class="labeltable_middle_tr_01">
			<td colspan=100 align='right'>
				共
			<pg:rowcount />
			条记录
			<pg:index />
			<input name="Submit" type="button" class="input" value="确定" onClick="cmd_ok()">
			</td>
	</tr>
	</pg:pager>
</table>

</body>
</html>
