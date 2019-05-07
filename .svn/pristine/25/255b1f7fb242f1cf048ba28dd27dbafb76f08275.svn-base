<%@page import="com.chinacreator.sysmgrcore.purviewmanager.Escape"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DataControlUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.Date"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	String user_id = accesscontroler.getUserID();
	String busi_id = request.getParameter("busi_id");
	String ins_id = request.getParameter("ins_id");
	String action_form = request.getParameter("action_form");
	String title  = request.getParameter("title");
	//解码
    title =DataControlUtil.replaceStr(title);
    title = Escape.unescape(title);
	title=title.replace("\n","");
	String busiTypeCode  = StringUtil.deNull(request.getParameter("busiTypeCode"));
	String template_id  = StringUtil.deNull(request.getParameter("template_id"));
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>文件传阅</title>
<script  type="text/javascript" src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js" charset="utf-8"></script>
<script src="../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<script src="../resources/util/public.js" type="text/javascript"></script>

<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">

jQuery(function(){
	jQuery("#circularize_title").focus();
	jQuery("#circularize_title").val("<%=title%>");
});

//AJAX完成分发
function dispense(){
	var busi_id = jQuery("#busi_id").val();
	var ins_id = jQuery("#ins_id").val();
	var action_form = jQuery("#action_form").val();
	var circularize_title = jQuery("#circularize_title").val();
	var receive_userid = jQuery("#receive_userid").val();
	var send_userid = jQuery("#send_userid").val();
	//getParentWindow("").jQuery("#receive_userid").val(jQuery("#receive_userid").val());
	var busiTypeCode = jQuery("#busiTypeCode").val();
	var template_id = jQuery("#template_id").val();
	
	var okF = function(){
		var url="circularizedo.jsp";
		var params = {'busi_id':busi_id,'ins_id':ins_id,'action_form':action_form,'circularize_title':circularize_title,'receive_userid':receive_userid,'send_userid':send_userid,'busiTypeCode':busiTypeCode,'template_id':template_id};
		jQuery.ajax({
			url: url,
			type: 'POST',
			dataType:'json',
			data: params,
			async:false,
			success: function(data){
				if(data.result==true){
					var okF11 = function(){
						var pwindows = getParentWindow("windowIds");
						removeAlertWindows('windowIds',true);
						pwindows.removeAlertWindows('windowIds',true);
						pwindows.location.reload();
					}
					var p={
							headerText:'提示',
							okName:'确认',
							okFunction:okF11
						};
					alert("操作成功!",p);
				} else {
					alert("操作失败!");
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				debugger;
				alert("操作失败!");
			}
		})
	}
	
	var p={
		headerText:'提示',
		okName:'确认',
		okFunction:okF,
		cancelName:'取消'
	};
	alert('确认要分发吗？',p);
	
}

function saveBack(){
	removeAlertWindows('windowId',true);
}

function resetting(){
	jQuery("#receive_name").val('');
	jQuery("#receive_userid").val('');
	jQuery("#receive_name").val('');
}

var chooseReportUnits = function(){
	var s = new jQuery.z_tree_leftRigth();
	  s.treeID='button_envelop_username';
	  s.isShowSeacher="aa";
	  s.treeName="选取人员";
	  s.headerName="选取人员";
	  s.titelText = "选择人员";
	  s.rightHeaderText="已添加机构和人员";
	  s.returnFunction=function(orgObj){
		  if(IsSpace(orgObj.ps) || null ==orgObj.ps )
		  	{
			  	  jQuery('#receive_name').val('');
			  	  jQuery('#receive_userid').val('');
			 }else
			 {
				 jQuery('#receive_userid').val(orgObj.ps.id);
				  jQuery('#receive_name').val(orgObj.ps.name);
				}
	  }
	  s.isNewCommonUse=true;
	  s.treeList=
			  [{
				  leftHeaderText:'按人员选择',
				  valueKey:'ps',
				  selectedIds:jQuery('#receive_userid').val(),
				  type:"APERSON"
		},{
			  leftHeaderText:'常用分组',
			  item_id :'org_id',
			  isType:'dept', 
			  valueKey:'dept',
			  selectedIds:'',
			  isGroup:true,
			  type:"A3"
		}];
	  s.init();	
}

//关闭
function closew(){
	getParentWindow("windowIds").closeAlertWindow();
	removeAlertWindows('windowIds',true);
}
</script>
</head>

<body>
<form action="" name="form1" id="form1"  method="post" target="submitArchivesIfram">
<input type="hidden" name="busi_id" id="busi_id" value="<%=busi_id %>" />
<input type="hidden" name="ins_id" id="ins_id" value="<%=ins_id %>" />
<input type="hidden" name="action_form" id="action_form" value="<%=action_form %>" />
<input type="hidden" name="busiTypeCode" id="busiTypeCode" value="<%=busiTypeCode %>" />
<input type="hidden" name="template_id" id="template_id" value="<%=template_id %>" />

 <table width="100%" border="0" cellspacing="0" cellpadding="0">
 	<tr>
		<th width="5" class="content_02_box_div_table_th"><span style="color: red">*</span>传阅标题:
		</th>
		<td class="content_02_box_div_table_03_n_td">
		<input type="text" class="input_160" id="circularize_title" name="circularize_title" style="width: 530px" value=""/>
		</td>
	</tr>
	<tr>
		<th width="5" class="content_02_box_div_table_th"><span style="color: red">*</span>接收人:
		</th>
		<td class="content_02_box_div_table_03_n_td">
		<input readonly="readonly" onmouseover="this.title=this.value"
           type="text" class="input_160" id="receive_name" name="receive_name" style="width: 530px"
			 value="" onclick="chooseReportUnits();"/>
			 <input name="" type="button" value="" class="but_x" onclick="chooseReportUnits();" />
			 <input type="hidden" name="receive_userid" id="receive_userid" value=""/>
		</td>
	</tr>
	</table>
	<div class="cue_box_foot">
		<input type="button" value='关闭' onclick="closew()" class="but_y_01"/>
		<!--<input type="button" class="but_y_01" onClick="resetting();" value="重置"/>  -->
		<input type="button" class="but_y_01" onClick="dispense()" value="保存"/>
  	</div>
  	</form>
  	
  	
  	<iframe name="submitArchivesIfram" id="submitArchivesIfram" width=0 height=0></iframe>

</body>
</html>