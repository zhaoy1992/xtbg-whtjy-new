<%-- 
描述：督办
作者：jie.xiao
版本：1.0
日期：2013-12-11
 --%>
<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.entity.InstanceBean"%>
<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao"%>
<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.dao.impl.FlowUtilDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="org.apache.velocity.runtime.directive.Foreach"%>
<%@page contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.dssave.service.impl.DsCRUDServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.dssave.service.DsCRUDService"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>

<html>
<head>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	
	String ins_id = request.getParameter("ins_id");
	DsCRUDService Service = new DsCRUDServiceImpl();
	
	String chief_endtime = StringUtil.deNull(request.getParameter("chief_endtime"));
	if(StringUtil.isBlank(chief_endtime)){
		chief_endtime = Service.getChiefConfig(ins_id);
		if(StringUtil.isBlank(chief_endtime)){
			chief_endtime =DateUtil.getCurrentDateTime();
		}else{
			chief_endtime=chief_endtime.substring(0,19);
		}
	}
	
	String nowtime=DateUtil.getCurrentDateTime();
%>
<title>督办页面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入其它 -->
<script type="text/javascript" src="../../resources/util/public.js" ></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">

jQuery(function() {
	jQuery("#chief_endtime").val("<%=chief_endtime%>");
});

function savechief_endtime(){
	var chief_endtime = jQuery("#chief_endtime").val();
	getParentWindow("windowIds").isChiefConfigReset(chief_endtime);
	removeAlertWindows('windowIds',true);
}



//关闭
function closew(){
	getParentWindow("windowIds").closeAlertWindow();
	removeAlertWindows('windowIds',true);
}
</script>

</head>
<body style="width: 600px;">
<button id=button4 class="but_y_01" onclick="savechief_endtime()">保存</button>
<button id=button8 class="but_y_01" onclick="closew()">关闭</button>
<form id="form1" action="" method="post">
<!-- 表格    -->
<div id="vcenter" style="float: left; width: 600px;"  >
	<div style="float: left; width: 575px;">
		<div class="content_02_box" style="width: 575px">
			<div class="content_02_box_div" style="width: 575px">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					id="content_02_box_div_table_02">
					<tr>
					   <th class="content_02_box_div_table_th">督办结束时间：</th>
			           <td class="content_02_box_div_table_td">
			           	<input type="hidden" id="nowtime" name="nowtime" value='<%=nowtime %>'  />
				       	<input class="validate[required] date_120 Wdate" style="width: 180px; height: 24px;" type="text" id="chief_endtime" name="chief_endtime" value="" onclick="WdatePicker({minDate:'#F{$dp.$D(\'nowtime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
					   </td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
</form>
<iframe name="hiddenFrame" width=0 height=0 ></iframe>
</body>
</html>