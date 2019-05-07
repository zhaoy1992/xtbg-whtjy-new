<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>短信通知</title>
<%
	String unit_id = request.getParameter("unit_id");
%>
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
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../public/flowinfoconfig/resources/js/tree.js" charset="utf-8"></script>
<!-- 公共部分引用结束 -->
<script type="text/javascript">
var obj = getParentWindow("windowId");
	jQuery(function(){
		 jQuery("#phonecontent").val(getParentWindow("windowId").jQuery("#phonecontent").val());
		 jQuery("#use_id").val(getParentWindow("windowId").jQuery("#use_id").val());
		});
	function save(){ //保存并发送
		var phoneLook = jQuery('#phonecontent').val();
		var phoneid = jQuery('#use_id').val();
		phoneLooks=$.trim(phoneLook);
		if(phoneid.length==0||phoneid=="")
		{
			alert("请选择通知人员!");
			return false;
		}
		if(phoneLook.length==0||phoneLook=="")
		{
			alert("请输入短信内容!");
			return false;
		}
		if(phoneLooks.length==0||phoneLooks=="")
		{
			alert("短信内容不能全部为空格!");
			return false;
		}
		getParentWindow("windowId").jQuery("#phonecontent").val(phoneLook);
		getParentWindow("windowId").jQuery("#use_id").val(phoneid);
		removeAlertWindows('windowId',true);
		obj.saveinfo();
	}
	function resetting()
	{
		removeAlertWindows('windowId',true);
		obj.saveinfo();
	}
	function chooseReportUnits (){
		  var s = new jQuery.z_tree_leftRigth();
		  s.treeID='button_envelop_username';
		  s.isShowSeacher="aa";
		  s.treeName="选取人员";
		  s.headerName="选取人员";
		  s.titelText = "选择人员";
		  s.rightHeaderText="已添加机构和人员";
		  s.selectedIds=$('#use_id').val();
		  s.returnFunction=function(orgObj){
			  if(IsSpace(orgObj.ps) || null ==orgObj.ps )
			  	{
				   jQuery('#use_id').val('');
				   jQuery('#use_name').val('');
				 }else{
				 
					jQuery('#use_id').val(orgObj.ps.id);
					jQuery('#use_name').val(orgObj.ps.name);
				 }
		  }
		  s.treeList=
				  [{
					  leftHeaderText:'按人员选择',
					  valueKey:'ps',
					  selectedIds:jQuery('#use_id').val(),
					  type:'{"type":"107"}'
			}];
		  s.init();

	}
</script>
</head>
<body>

 <table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<th width="158" class="content_02_box_div_table_th"><span class="color_red">*</span>通知人员：</th>
		<td width="609" colspan="2" class="content_02_box_div_table_td">
			<input onMouseOver="this.title=this.value"  class="validate[required,maxSize[500]] input_150" style="width: 85%;border:0px" 
				id="use_name" name="use_name" onclick='chooseReportUnits()'></input>
			<input type="hidden" name="use_id" id="use_id">
			<input type="hidden" name="use_name" id="use_name">
	   		<input name="" type="button" value="" class="but_x" onClick="chooseReportUnits()"/>
	  </td>
	</tr>
	<tr>
	<th width="158" class="content_02_box_div_table_th">
		 <span class="color_red">*</span>短信内容：</th>
	<td >
		<textarea id=phonecontent name="phonecontent" rows="1" cols="1" 
		style="DISPLAY: block;width: 90%;height: 105px;overflow-y:auto;"></textarea>
	</td>
	</tr>
	</table>
<div class="cue_box_foot">
		<input type="button" value='取消' onClick="removeAlertWindows('',true)" class="but_y_01"/>
		<input type="button" class="but_y_01" onClick="resetting();" value="保存"/>
		<input type="button" class="but_y_01" onClick="save()" value="保存并发送"/>
  	</div>
</body>
</html>