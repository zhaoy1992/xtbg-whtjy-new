<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>

<%
	String orgId = StringUtil.deNull(request.getParameter("org_id"));
	String orgName = StringUtil.deNull(request.getParameter("org_name"));
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
	

	//确定
	function onOk() {
		var returnObj = new Object();
		returnObj.mbid = "word"+document.frames["wordtemplatelistForm"].getSelectRadioValue();
		window.returnValue = returnObj;
		window.close();
	}

	//取消
	function onCancel() {
		window.returnValue = false;
		window.close();
	}


	function queryMB(){
		var mb_mc = $("#mb_mc").val();
		mb_mc = mb_mc.replaceAll("%","%25");//处理sql查询中%
		var url = "wordtemplateviewlist.jsp?org_id=<%=orgId%>&org_name=<%=orgName %>&mb_mc="+escape(escape(mb_mc));
		document.frames["wordtemplatelistForm"].location =url;
	}
	function resetMB(){
		$("#mb_mc").val("");
	}
</script>
</head>
<body>

<table style="margin-top: 5px" width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="tol">
		<TR>
			<TD>
			<table  width="100%" border="0" align="center" cellpadding="0" cellspacing="2"  style="margin-top:2px;">

					<TR>
						<TD  width="15%">模版名称1</TD>
						<TD width="85%"><INPUT type="text"  id=mb_mc
							class="r_ss" style="width: 400px"></TD>
					</TR>

			</table>
			</TD>
		</TR>
		<tr>
			<td align=center>
			<input type="button"  id="btnQuery" class="Submit" onclick="queryMB()" value="查询"/>
			<input type="button"  id=btnReset class="Submit" onclick="resetMB()" value="重置"/>
			</td>
		</tr>
		<tr>  
			<td><iframe src="wordtemplateviewlist.jsp?org_id=<%=orgId%>&org_name=<%=orgName %>" 
				width="100%" name="wordtemplatelistForm" id="wordtemplatelistForm"
				scrolling="no" frameborder="0"  height="570px"></iframe></td>
		</tr>
		<tr>
			<td align=center>
			<input type="button"  id=btnOK class="Submit" onclick="onOk()" value="确定"></input>
			<input type="button"  id=btnCancel class="Submit" onclick="onCancel()" value="取消"></input>
			</td>
		</tr>
</table>

</body>
</html>