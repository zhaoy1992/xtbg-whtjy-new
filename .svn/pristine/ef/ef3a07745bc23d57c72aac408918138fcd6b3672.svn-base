<%-- 
描述：流水号
作者：shuqi.liu
版本：1.0
日期：2013-08-27
 --%>
<%@page contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.WordArchiveService"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.impl.WordArchiveServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.wordnumdef.entity.SerialNumberBean"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<html>
<head>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	
	String sernumrule = request.getParameter("sernumrule");
	String serId = request.getParameter("serId");
	
	WordArchiveService service = new WordArchiveServiceImpl();
	SerialNumberBean serialNumberBean = service.findSerialcode(sernumrule);
	
%>
<title>公文编号页面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入其它 -->
<script src="../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>

<script src="../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">


/*
作者:  shuqi.liu
时间:  2013-8-28
函数:  saveNumber
说明:  流水号保存
参数:   无
返回值: 无
*/
function saveNumber(){
	var s_code = jQuery("#s_code").val();
	var s_time = jQuery("#s_time").val();
	var s_lsh = jQuery("#s_lsh").val();
	//TODO 根据规则生成ALLCODE
	var s_allcode = s_code+s_time+s_lsh;
	getParentWindow("windowIds").serNumReset(s_code,s_time,s_lsh,s_allcode,'<%=serId%>');
	removeAlertWindows('windowIds',true);
}



//赋值公文编号
function setNumber(){
	var txtValue = getNumber();
	getParentWindow("windowIds").setNumber(txtValue);
	getParentWindow("windowIds").closeAlertWindow();
	removeAlertWindows('windowIds',true);
}

//关闭
function closew(){
	getParentWindow("windowIds").closeAlertWindow();
	removeAlertWindows('windowIds',true);
}
</script>

</head>
<body>
<button id=button4 class="but_y_01" onclick="saveNumber()">保存</button>
<button id=button8 class="but_y_01" onclick="closew()">关闭</button>
<form id="form1" action="" method="post">
<input id="jsonparam" name="jsonparam" type="hidden" />
<!-- 表格    -->
<div id="vcenter" style="float: left; width: 100%;"  >
	<div style="float: left; width: 775px;">
		<div class="content_02_box">
			<div class="content_02_box_div">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					id="content_02_box_div_table_02">
					<tr>
						<th class="content_02_box_div_table_th">流水号类型：</th>
			            <td class="content_02_box_div_table_td" style="width: 290px">
						 <input type="text" class="validate[maxSize[40]] input_160" style="width:187px"  readonly="readonly"  name="s_code" id="s_code" value ="<%=serialNumberBean.getS_code() %>" />
					    </td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">日期：</th>
			            <td class="content_02_box_div_table_td" style="width: 290px">
						 <input type="text" class="validate[maxSize[40]] input_160" style="width:187px" name="s_time" id="s_time" value ="<%=serialNumberBean.getS_time() %>" />
					    </td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">编号号码：</th>
			            <td  class="content_02_box_div_table_td" style="text-align: center;">
			            <input type="text" class="validate[maxSize[40]] input_160" style="width:187px" name="s_lsh" id="s_lsh" value ="<%=serialNumberBean.getS_lsh() %>" />
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