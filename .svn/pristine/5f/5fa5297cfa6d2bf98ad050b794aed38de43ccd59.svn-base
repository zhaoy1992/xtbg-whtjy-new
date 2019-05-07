<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 公共部分引用结束 -->
<script type="text/javascript">
	jQuery(function(){
		 jQuery("#phonecontent").val(getParentWindow("windowId").jQuery("#phonecontent").val());
		});
	function save(){
		var phoneLook = jQuery('#phonecontent').val();
		getParentWindow("windowId").jQuery("#phonecontent").val(phoneLook);
		removeAlertWindows('windowId',true);
	}
	function resetting()
	{
		jQuery('#phonecontent').val('');
	}
	
</script>
</head>
<body>

 <table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
	<th width="191" class="content_02_box_div_table_th">
	<span style="font-size: 15px">短信内容</span>
	
	</th>
	<td >
	<textarea id=phonecontent name="phonecontent" rows="1" cols="1" 
	style="DISPLAY: block;width: 320px;height: 105px;overflow-y:auto;"></textarea>
	</td>
	</tr>
	</table>
<div class="cue_box_foot">
		<input type="button" value='关闭' onclick="removeAlertWindows('',true)" class="but_y_01"/>
		<input type="button" class="but_y_01" onClick="resetting();" value="重置"/>
		<input type="button" class="but_y_01" onClick="save()" value="保存"/>
  	</div>
</body>
</html>