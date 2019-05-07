<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%
	String orgId = StringUtil.deNull(request.getParameter("org_id"));
	String orgName = StringUtil.deNull(request.getParameter("org_name"));
	String mb_mc = StringUtil.deNull(request.getParameter("mb_mc"));
	
	String parmjson = "{'template_name':'"+mb_mc+"','org_id':'"+orgId+"','org_name':'"+orgName+"'}";
%>


<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>模板列表</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../jquery1.6/jquery-1.6.min.js"></script>
<script language="javascript"
	src="../../js/util/public.js "> </script>
<link href="../../../outnetwork/resources/css/red/se.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
	
	function getSelectRadioValue(){
		return $("input:checked").val();
	}
	
	function doReturnOK(){
		alert("操作成功");
		document.location.reload();
	}
	//确定
	function onOk() {
		var returnObj = new Object();
		returnObj.mbid = "word"+$("input:checked").val();
		window.returnValue = returnObj;
		window.close();
	}

	//取消
	function onCancel() {
		window.returnValue = false;
		window.close();
	}

</script>
</head>
<body>

<TABLE cellSpacing=0 cellPadding=0 width="99%" align=center border=0 
	class="Ktable_2">
	<pg:listdata
		dataInfo="com.chinacreator.xtbg.pub.wordtemplate.list.WordTemplateList"
		keyName="WordTemplateList" />
	<pg:pager data="WordTemplateList" scope="request" isList="false"
		maxPageItems="120">
		<pg:param name="org_id" value="<%=orgId %>" />
		<pg:param name="mb_mc" value="<%=mb_mc %>"/>
		<pg:header>
			<td align="center" class="bj1 " width="5%"  style="border-right: 1px solid #cbd2c4;">单选</td>
			<td align="center" class="bj1 " width="25%" style="border-right: 1px solid #cbd2c4;">名称</td>
		    <td align="center" class="bj1 " width="15%" style="border-right: 1px solid #cbd2c4;">创建者</td>
		    <td width="15%" align="center"  class="bj1 "  style="border-right: 1px solid #cbd2c4;">创建时间</td>
		    <td width="40%" align="center"  class="bj1 "  style="border-right: 1px solid #cbd2c4;">备注</td>
		</pg:header>

		<pg:list>
			<tr>

				<td align="center" style="border-right: 1px solid #fff;"><input type="radio" name="radio" value="<pg:cell colName = "mb_id" defaultValue = ""/>"/> <input
					type="hidden" name="mb_id"
					value="<pg:cell colName = "mb_id" defaultValue = ""/>" /></td>
				<td align="center" title="<pg:cell colName = "mb_mc" defaultValue = ""/>"
				 style="border-right: 1px solid #fff;">
				<pg:cell colName="mb_mc" defaultValue="" maxlength="20"
					replace="..." /></td>
				<td align="center" title="<pg:cell colName = "mb_cjz" defaultValue = ""/>"
				 style="border-right: 1px solid #fff;">
				<pg:cell colName="mb_cjz" defaultValue="" maxlength="20"
					replace="..." /></td>
				<td align="center" title="<pg:cell colName = "mb_cjsj" defaultValue = ""/>"
				 style="border-right: 1px solid #fff;">
				<pg:cell colName="mb_cjsj" defaultValue="" maxlength="20"
					replace="..." /></td>
				<td align="center" title="<pg:cell colName = "mb_remark" defaultValue = ""/>" 
				style="border-right: 1px solid #fff;">
				<pg:cell colName="mb_remark" defaultValue="" maxlength="20"
					replace="..." /></td>
			</tr>
		</pg:list>
		<%-- <tr>
			<td align="center" colspan="12" class="pagefoot"><!-- 分页提示 -->
			<div>共<pg:rowcount />条记录&nbsp;&nbsp;<pg:index
				export="00000001" /></div>
			<!-- 分页提示 --></td>
		</tr> --%>
	</pg:pager>
	<tr>
			<td align=center  colspan=5>
			<input type="button"  id=btnOK class="Submit" onclick="onOk()" value="确定"></input>
			<input type="button"  id=btnCancel class="Submit" onclick="onCancel()" value="取消"></input>
			</td>
		</tr>
</TABLE>

<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>