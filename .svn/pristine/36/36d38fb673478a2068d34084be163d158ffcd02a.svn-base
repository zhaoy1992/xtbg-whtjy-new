<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.WordArchiveService"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.impl.WordArchiveServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.archive.entity.OaWordNumberBean"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String subid = request.getParameter("subid");
	String bus_id = request.getParameter("bus_id");
	if(bus_id == null || "".equals(bus_id)){
		bus_id = DaoUtil.getUUID();
	}
	String file_code = StringUtil.deNull(request.getParameter("file_code"));
	if(file_code != null){
		file_code = java.net.URLDecoder.decode(file_code , "UTF-8");
	}
	WordArchiveService service = new WordArchiveServiceImpl();
	OaWordNumberBean oaWordNumberBean = service.getNumber(file_code);
	if(oaWordNumberBean!=null){
		file_code = oaWordNumberBean.getNumber_title();
	} else {
		file_code = "";
	}
	String user_id = accesscontroler.getUserID();
	String dept_id = accesscontroler.getChargeOrgId();
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>指标文拆分导入</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	
<!-- 引入formvValidatetion -->
<link rel="stylesheet" href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
</head>
<script>
	var subid = "<%=subid%>";
	$(function() {
		
	});
	function Ok(){
		var uploadFile = $("#filepath").get(0).value+"";
		if(uploadFile.length <= 1 || uploadFile.indexOf(".xls")<0){
			alert("请选择拆分的文件,支持xls格式文件");
			return;
		}
		if($("#annual").val().length != 4){
			alert("请输入正确的年份数据！");
			return ;
		} 
		if($("#template_type").val() == 0){
			alert("请选择模板！");
			return ;
		}
		if(!validateForm()){
			return;
		}
		$("#form1").attr("target","hiddenFrame");
		form1.action="budgetfileimportdo.jsp";
		$("#sel").attr("disabled","disabled");
		$("#backTo").attr("disabled","disabled");
		$("#outStr").append("正在导入数据....");
		$("#form1").submit();
	}
	window.onload = function () {
		//adaptationWH("_top","vcenter","0");
	}
	function setOutStr(str){
		$("#sel").removeAttr("disabled");
		$("#backTo").removeAttr("disabled");
		$("#outStr").html("").append(str+"<br/>");
		//刷新iframe
		var iframeurl = $("#detaillist").attr("src");
		$("#detaillist").attr("src",iframeurl);
	}
	function validateForm(){
		if(jQuery("#form1").validationEngine("validateform")){
			return true;
		}else{
			return false;
		}
	}
	function back(){
		//从公文那边过来的弹出层
		if(subid == "import_file_from_iweb"){
			getParentWindow("<%=subid%>").closeAlertWindow();
			removeAlertWindows("<%=subid%>",true);	
		} else {
			removeAlertWindows("<%=subid%>",true);	
		}
	}
	function flushList(){
		
	}
</script>
<body style="overflow-y:hidden;overflow-x:hidden;" class="vcenter">
<form id="form1" action="" method="post" class="formular" enctype="multipart/form-data">	
	<input type="hidden" name="bus_id" value="<%=bus_id %>">
	<input type="hidden" name="user_id" value="<%=user_id %>">
	<input type="hidden" name="dept_id" value="<%=dept_id %>">
	<input type="hidden" name="file_code" value="<%=file_code %>">
	<!-- 操作按钮  -->
	<div style="overflow: hidden;">
		<div class="content_02_top"  id="_top">
			<div class="content_02_top"  id='content_02_top'>
				<input class="but_y_01" type="button" id="sel"  value="导入拆分" onClick="Ok()"/>
				<input class="but_y_01" type="button" id="backTo"  value="关闭" onClick="back()"/>
			</div>
		</div>
	</div>
	<div id="vcenter" style="float:left; width:100%;overflow-x: hidden;" >
		<div style="float: left; width: 900px; ">
			<div class="content_02_box_div" style="width: 900px">
				<table width="100%" cellpadding="0" cellspacing="0" >
					<tr>
						<th class="content_02_box_div_table_th" width="15%"><FONT style="COLOR: red">*</FONT>选择拆分文件：</th>
						<td class="content_02_box_div_table_td" width="35%">
							<input type="file" id="filepath" name="filepath" class="input_188" style="width: 300px;" value="">
						</td>
						<th class="content_02_box_div_table_th" width="15%"><FONT style="COLOR: red">*</FONT>选择模板：</th>
						<td class="content_02_box_div_table_td" width="35%" >
							<select id="template_type" name="template_type" style="width:45%">
								<option value="0">--请选择--</option>
								<option value="1">市州模板</option>
								<option value="2">市州区县模板</option>
							</select>
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th" width="15%"><FONT style="COLOR: red">*</FONT>该excel的标题行：</th>
						<td class="content_02_box_div_table_td" width="35%" >
							<input type="text" id="header_row" name="header_row" class="input_188 validate[required,custom[number]]" style="width: 300px;" value="">
						</td>
						<th class="content_02_box_div_table_th" width="15%"><FONT style="COLOR: red">*</FONT>年份：</th>
						<td class="content_02_box_div_table_td" width="35%">
							<input class="date_120 validate[required,custom[number]]" readonly="readonly" type="text" id="annual" name="annual" onFocus="WdatePicker({dateFmt:'yyyy'})" />
						</td>
					</tr>
				</table>
				<table width="100%">
					<tr class="content_02_box_div_table_th">
						<td  class="content_02_box_div_table_td" width="100%">
							<div id="outStr" style="width:100%;height: 180px;overflow: auto;" >
								<p style="color: #ff0000">注意：输入的excel的标题行即是固定不动的行，拆分后的文件都带此标题行，可以是一行或多行！</p>
								<p style="color: #ff0000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;excel文件格式必须是三列，【拆分单位】【金额】【备注】。金额必须是数字！</p>
							</div>
						</td>
					</tr >
				</table>
			</div>
		</div>
		<div style="width: 900px;height: 400px;float:left;margin-top: 0;border: none;">
			<iframe id="detaillist" src="budgetdetaillist.jsp?bus_id=<%=bus_id %>" style="width: 900px;height: 400px;border: none;margin-top: 0" scrolling="no" ></iframe>
		</div>
	</div>
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
<iframe id="impIfr" name="impIfr" width="0" height="0"></iframe>
</body>
</html>