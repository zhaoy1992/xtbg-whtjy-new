<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	String path = request.getContextPath();
	//String orgId = StringUtil.deNull(request.getParameter("org_id"));
	String orgName = StringUtil.deNull(request.getParameter("org_name"));
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	
	String orgId = control.getChargeOrgId();
%>


<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>模板列表</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>	

<!-- 引入jGrid -->
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript" charset="utf-8"></script>

<!-- 引入其它 -->
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script src="js/wordtemplatelist.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>

<script type="text/javascript">
	var org_id = "<%=orgId%>";
	var org_name = "<%=orgName%>";
	var path = "<%=path%>";
</script>
</head>
<body>
<form name="form1" method="post">
<table width="100%" id="queryTable">
	<tr>
		<td>			
			<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
					<tr>
						<td>
							<!-- 固定查询 -->
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
								<tr>
									<th width="90" class="input_cx_title_th" >模版名称：</th>
									<td width="296"  class="cx_title_td">
									<input name="mb_mc" id="mb_mc" type="text" class="input_cx_title_283" /></td>
									<td width="385"  colspan="2"  >
									<input name="Input2" value="搜索" type="button" 
									onclick="userSearch()" class="but_y_01"/>
									</td>
								</tr>
							</table>
							<!-- 固定查询 end-->
						</td>
					</tr>
			</table>
		<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
						
		</td>
		</tr>

<tr><td>
	<div class="cGridArea">
		<table id="gridTable"></table>
		<div id="gridPager"></div>
	</div>
	
	</td></tr>
</table>

<iframe name="hiddenFrame" width=0 height=0></iframe>

</form>
</body>
</html>