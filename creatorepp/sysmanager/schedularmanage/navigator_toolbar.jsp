<%@include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<html>
<head>

<title>������������</title>
<link rel="stylesheet" type="text/css" href="../css/toolbar.css">
<jsp:include page="../base/scripts/panes.jsp" />
<script language="javascript" src="../scripts/toolbar.js"></script>
<script language="javascript">
function showToday()
{
var day="";
var month="";
var ampm="";
var ampmhour="";
var myweekday="";
var year="";
mydate=new Date();
myweekday=mydate.getDay();
mymonth=mydate.getMonth()+1;
myday= mydate.getDate();
myyear= mydate.getYear();
year=(myyear > 200) ? myyear : 1900 + myyear;
if(myweekday == 0)
weekday="��";
else if(myweekday == 1)
weekday="һ";
else if(myweekday == 2)
weekday="��";
else if(myweekday == 3)
weekday="��";
else if(myweekday == 4)
weekday="��";
else if(myweekday == 5)
weekday="��";
else if(myweekday == 6)
weekday="��";
document.write("<font color= #FFFFFF size=2 align=middle>"+year+"��"+mymonth+"��"+myday+"�� ����"+weekday+"</font>");
}
</script>
<style type="text/css">
<!--
.style3 {color: #FFFFFF}
-->
</style>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="toolbarbodymargin">
<div id="toolbarborder">
<div id="toolbar" ondblclick="switchFrameworks(<%=Framework.SWITCH_NAVIGATOR%>,<%=Framework.SWITCH_SCOPE_PERSPECTIVEMAIN%>,document.all.doubleclickcolumn);">

<table width="100%" height=25 cellpadding=0 cellspacing=0 border=0>
	<tr>
	<td valign="middle" align="center" width=25 height=25><img
			class="normal" src="../base/images/base_perspective_enabled.gif" width=16 height=16></td>
	<td id="doubleclickcolumn" recover="˫���ָ�" maxtitle="˫�����" title="˫�����" valign="middle" align="left"
			width="*" height=25 nowrap class="text">
					  
			<script language="javascript">showToday();</script>
			
		</td>
</tr>
	
</table>
</div>
</div>
</body>
</html>
