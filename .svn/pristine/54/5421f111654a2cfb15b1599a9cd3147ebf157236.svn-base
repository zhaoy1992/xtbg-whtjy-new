<%--
describe:表单属性控制页面
author:shuqi.liu
date: 2013-6-24
--%>
<%@page contentType="text/html; charset=utf-8"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.form.service.Formservice"%>
<%@page import="com.chinacreator.xtbg.core.form.service.impl.FormserviceImpl"%>
<%@page import="com.chinacreator.xtbg.core.form.entity.OaMdTableBean"%>
<%@page import="com.chinacreator.xtbg.core.form.entity.OaMdColumnsBean"%>
<%@page import="com.chinacreator.xtbg.core.form.entity.OaFormTagConfigBean"%>

<%	
	//AccessControl accesscontroler = AccessControl.getInstance();
	//accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String liid = request.getParameter("liid");//li控件ID
	String form_id = request.getParameter("form_id");//li控件ID
	String txt_form_id = request.getParameter("txt_form_id");//正文ID
	String from_ext_parm = request.getParameter("from_ext_parm");
	FormserviceImpl formserviceImpl = new FormserviceImpl();
	List<OaMdTableBean> oaMdTableBeanlist = formserviceImpl.getTableList();//获取表LIST

	
	OaFormTagConfigBean oaFormTagConfigBean = formserviceImpl.queryTagConfigInfo(liid);//获取TAG配置
	String table_id = "";  //表ID
	String column_id = ""; //字段ID
	String ctype = "";	//控件类型
	String action = "save"; //aciton 方法，默认保存
	String selectType ="";   //下拉框类型
	String selectText ="";   //下拉框类型
	String csstypetext ="";   //样式文本
	String defaultValue = "";//默认值
	String drag_in_value = "";//默认值
	if(oaFormTagConfigBean!=null){
		action="update";
		table_id = oaFormTagConfigBean.getTable_id();
		column_id = oaFormTagConfigBean.getColumn_id();
		ctype = oaFormTagConfigBean.getTag_type_id();
		selectType = oaFormTagConfigBean.getSelect_type();
		selectText= oaFormTagConfigBean.getSelect_text();
		csstypetext = oaFormTagConfigBean.getStyle_text();
		defaultValue =oaFormTagConfigBean.getDefault_value();
		drag_in_value =oaFormTagConfigBean.getDrag_in_value();
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- 引入jQuery -->
<script type="text/javascript" src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery_dialog -->
<script src="../resources/plug/jquery_dialog/jquery_dialog.js"></script>

<!-- 引入公共JS -->
<script src="../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript">
var liid = '<%=liid%>';
var form_id = '<%=form_id%>';
var path = "<%=path%>";//工程路径

//必填验证
function checkFromBeforeSubmit(){
	var tableparm = $("#tableparm").val();
	var columnparm = $("#columnparm").val();
	var ctype = $("#ctype").val();
	if(ctype!="afixlist" && ctype!="text"){
		if(!tableparm||!columnparm){
			alert("请选择表和字段");
			return false;	
		}
	}
	
	var ctype = $("#ctype").val();
	if(ctype == "input"){//如果是输入框
		var default_value = $("#default_value").val();//输入框默认值
		var drag_in_value = $("#drag_in_value").val();
		if(default_value&&drag_in_value){
			alert("默认值与内容类型最多填一个");
			return false;
		}
	}
	return true;
}
/**
 * 将{aaa} 改成 aaa
 */
function getChar(str){
	 return str.substring(1,str.length-1);
}
function onsubmitconfig(){ //点击确定
	if(!checkFromBeforeSubmit()){
		return false;
	}
	var ctype = $("#ctype").val();
	var tableparm = $("#tableparm").val();
	var columnparm = $("#columnparm").val();
	var displayHtml = "";//只是显示在设计表单上的HTML ，该代码是原生态的HTML标签，公文自定义标签将会保存在数据库中。
	var oaTagHtml = ""; //公文标签HTML，此HTML用于生成页面元素
	var cssType = "1";//暂时屏蔽 //$("input[name='cssType'][type='radio']:checked").val(); //获取样式
	var csstypetext =  $("#csstypetext").val();//获取样式文本
	var titles =  $("#titles").val();//获取标题
	var titlesadd = titles.replace(/ /g, '&nbsp;');
	var selectType = $("input[name='selectType'][type='radio']:checked").val();//获取下拉框模式
	var selectTypetext = $("#selectTypetext").val();//获取下拉框Option
	var default_value = $("#default_value").val();//输入框默认值
	var display_html = $("#display_html").val();//日期时间格式
	if(ctype == "input"){//如果是输入框
		var tmp = default_value;
		var drag_in_value = $("#select6 select[name='drag_in_value']").val();
		if(drag_in_value){
			tmp = drag_in_value;
			oaTagHtml="<input type='hidden' id='field_"+getChar(drag_in_value)+"' value='"+tableparm+"__"+columnparm+"'/>";
		}
		
		displayHtml = "<span style='float:left;padding-left:5px;padding-top:10px;'>"+titlesadd+" </span>" + "<input type='text' ";
		oaTagHtml +=	"<oa:input title='"+titles+"' type='text' column='"+columnparm+"' table='"+tableparm+"' ";
		if(cssType =="1"){
			displayHtml += "style= '"+csstypetext+"'";
			oaTagHtml += "style= '"+csstypetext+"'";
			//width: 90%;border: 0px;line-height:30px; height:30px;
		}
		displayHtml += " value = '"+tmp+"'/>";
		oaTagHtml += " value = '"+tmp+"'/>";
	}else if(ctype == "select"){//如果是下拉框
		displayHtml = "<span style='float:left;padding-left:5px;padding-top:10px;'>"+titlesadd+" </span>" + "<select id='' style ='"+csstypetext+"'>" 
		oaTagHtml =	" <oa:select column='"+columnparm+"' table='"+tableparm+"' style ='"+csstypetext+"' title ='"+titles+"'";
		if(selectType =="1"){
			 oaTagHtml += ">";
			 var options = selectTypetext.split(",");
			 for (var i=0 ; i< options.length ; i++){
				 var idtext = options[i].split(":");
				 displayHtml += "<option value='"+idtext[0]+"'>"+idtext[1]+"</option>";	 
				 oaTagHtml += "<oa:option optionName='"+idtext[1]+"' optionValue='"+idtext[0]+"' />";	 
			 } 
		}else{
			displayHtml += "<option>自定义SQL</option>";
			oaTagHtml += " optionsql= '"+$("#selectTypetext").val()+"' >";
		}
		displayHtml += "</select>";
		oaTagHtml += "</oa:select>"
		
	}else if(ctype == "textarea"){//如果是文本域
		displayHtml += "<span style='float:left;padding-left:5px;padding-top:10px;'>"+titlesadd+" </span>";
		displayHtml += "<textarea readonly='readonly'  style= '"+csstypetext+"'></textarea>";
		
		oaTagHtml += "<oa:textarea column='"+columnparm+"' table='"+tableparm+"' title ='"+titles+"' style='"+csstypetext+"'  />";

	}else if(ctype == "text"){//如果是文本
		if(cssType =="1"){
			displayHtml += "<span style='"+csstypetext+"' >"+titles+" </span>";
			oaTagHtml +=   "<oa:span style='"+csstypetext+"' column='"+columnparm+"'  table='"+tableparm+"' value= '"+titles+"' />";
			//font-size: 20px; color: #ff0000; padding-left:400px; line-height: 30px;
		}else{
			displayHtml += titles;
			oaTagHtml += titles;
		}
	}else if(ctype == "date"){//如果是日期控件
		
		displayHtml += "<span style='float:left;padding-left:5px;padding-top:10px;'>"+titlesadd+" </span>";
		displayHtml += "<input class='Wdate' type='text' style='"+csstypetext+"' onFocus='WdatePicker({dateFmt:\""+display_html+"\"})' />";
		
		oaTagHtml += "<oa:date dateFmt='"+display_html+"' column='"+columnparm+"' table='"+tableparm+"' title ='"+titles+"' style='"+csstypetext+"' other=\"class='Wdate'\"/>";
		
	}else if(ctype == "viewtext"){//如果是意见框
		displayHtml += "<span style='float:left;padding-left:5px;padding-top:10px;'>"+titlesadd+" </span>";
		displayHtml += "<input type='button' class='but_y_01'  value='填写意见'/>";
		displayHtml += "<textarea readonly='readonly'  style= '"+csstypetext+"'></textarea>";
		oaTagHtml += "<oa:view column='"+columnparm+"' table='"+tableparm+"' title ='"+titles+"' style='"+csstypetext+"' cntab='"+display_html+"' />";
		
		//border: 1; width: 95%; height:80%; overflow: auto;
	}else if(ctype == "afix"){//如果是附件
		var drag_in_value = '<%=FormserviceImpl.DRAG_IN_ATTACH_PG%>';
		//if(drag_in_value){
			oaTagHtml="<input type='hidden' id='field_"+getChar(drag_in_value)+"' value='"+tableparm+"__"+columnparm+"'/>";
			oaTagHtml +=  "<oa:affixbut butName='请选择文件' column='"+columnparm+"' table='"+tableparm+"'  title ='"+titles+"' operType='111' initFjDJBHForArchive ='"+drag_in_value+"' /> ";
		//}else{
		//	oaTagHtml =  "<oa:affixbut butName='请选择文件' column='"+columnparm+"' table='"+tableparm+"'  title ='"+titles+"' operType='111'/> ";
		//}
		
		displayHtml = "<span style='float:left;padding-left:5px;padding-top:10px;'>"+titlesadd+" </span>"+ "<span style='float:left;padding-left:5px;padding-top:10px;'><a href=\"javascript:void(0);\" >请选择文件</a></span>"
		
	}else if(ctype == "afixlist"){//如果是附件列表
		displayHtml = "<span style='float:left;padding-left:5px;padding-top:10px;'>"+titlesadd+" </span>";
		oaTagHtml =  "<oa:affixshow  title ='"+titles+"'/>";
	}else if(ctype == "ismsg"){//如果是消息提醒
		displayHtml = "<span style='float:left;padding-left:5px;padding-top:5px;'>"+titlesadd+" <input type='checkbox' name='ismsg' value ='ismsg'></span> ";
		oaTagHtml =  "<oa:ismsg title ='"+titles+"'/>";
	}else if(ctype == "number"){//如果是编号
		var tmp = "<%=FormserviceImpl.DRAG_IN_NUMBER_PG%>";
		displayHtml = "<span style='float:left;padding-left:5px;padding-top:10px;'>"+titlesadd+" </span>" + "<input type='text' ";
		oaTagHtml="<input type='hidden' id='field_"+getChar(tmp)+"' value='"+tableparm+"__"+columnparm+"'/>";
		oaTagHtml +=	"<oa:numberinput title='"+titles+"' column='"+columnparm+"' table='"+tableparm+"' ";
		if(cssType =="1"){
			displayHtml += "style= '"+csstypetext+"'/>";
			oaTagHtml += "style= '"+csstypetext+"'/>";
			//width: 90%;border: 0px;line-height:30px; height:30px;
		}
		//displayHtml += " value = '"+tmp
		//oaTagHtml += " value = '"+tmp+"'/>";
	}else if(ctype == "sernum"){//如果是编号
		var default_value1 = $("#default_value1").val();//输入框默认值
		displayHtml = "<span style='float:left;padding-left:5px;padding-top:10px;'>"+titlesadd+" </span>" + "<input type='text' ";
		oaTagHtml +=	"<oa:sernuminput title='"+titles+"' column='"+columnparm+"' table='"+tableparm+"' sernumrule='"+default_value1+"'";
		if(cssType =="1"){
			displayHtml += "style= '"+csstypetext+"'/>";
			oaTagHtml += "style= '"+csstypetext+"'/>";
		}
	}
	if(ctype=="txt"){//如果是正文配置，那么将TAGID设置为正文ID
		liid= '<%=txt_form_id%>';
	}
	var paramJson = "{'tag_id':'" + liid  
				 + "','form_id':'"+form_id
				 + "','tag_type_id':'" + ctype
				 + "','title':'" + titles
				 + "','table_id':'" + tableparm
				 + "','column_id':'" + columnparm
				 + "','style_text':'" + $("#csstypetext").val();
	 			 //+ "','tag_html':'" + oaTagHtml
				 if(ctype == "select"){//如果是下拉框，那么将下拉选项类型，或者脚本加入JSON。
					 paramJson += "','select_type':'" + selectType;
					 paramJson += "','select_text':'" + selectTypetext;
				 }
				 if(ctype == "input"){//如果是输入框，加入默认值
					 paramJson += "','default_value':'" + default_value;
					 var drag_in_value = $("#select6 select[name='drag_in_value']").val();
					 paramJson += "','drag_in_value':'" + drag_in_value;
				 }
				 if(ctype == "date" || ctype == "viewtext" ){//如果是日期值
					 paramJson += "','display_html':'" + display_html;
				 }
				 if(ctype == "afix"){
					 var drag_in_value = '<%=FormserviceImpl.DRAG_IN_ATTACH_PG%>';
				 	 paramJson += "','drag_in_value':'" + drag_in_value;
				}
				 if(ctype == "sernum"){
					 paramJson += "','default_value':'" + default_value1;
				}
	paramJson += "'}";
	
	$("#tag_html").val(oaTagHtml); //放入隐藏域
	//TODO 将该属性保存到数据库
	$("#paramJson").val(paramJson);//保存并更新填写状态
	document.all.formTagForm.target = "hiddenFrame";
	$("#formTagForm").submit();
	
	//getParentWindow("").jQuery("[id='oa_"+liid+"']").val(oaTagHtml);
	getParentWindow("").jQuery("[id='"+liid+"']").html(displayHtml);
	//removeAlertWindows('',true);
	//setTimeout(function(){alert("laile");removeAlertWindows('',true);},"2000");
	
	
}
//将动作改变的回调函数
function setAction(action){
	$("#action").val(action);
	removeAlertWindows('',true);
}
//切换模式
function changeBindType(value){
	if(value=="1"){
		$("#select1").show();
		$("#select2").show();
		$("#select3").hide();
		$("#select4").show();
		if($("#ctype").val()=="select"){//如果是下拉框，显示option定义框
			$("#select5").show();
		}
		if($("#ctype").val()=="input"){//如果是下拉框，显示option定义框
			$("#select6").show();
		}
		if($("#ctype").val()=="date"){//如果是下拉框，显示option定义框
			$("#select7").show();
		}
		if($("#ctype").val()=="viewtext"){//如果是下拉框，显示option定义框
			$("#select9").show();
		}
		if($("#ctype").val()=="sernum"){//如果是下拉框，显示option定义框
			$("#select10").show();
		}
		//if($("#ctype").val()=="afix"){//如果是下拉框，显示option定义框
		//	$("#select8").show();
		//}
	}else{
		$("#select1").hide();
		$("#select2").hide();
		$("#select3").show();
		$("#select4").hide();
		$("#select5").hide();
		$("#select6").hide();
		$("#select7").hide();
		$("#select9").hide();
		$("#select10").hide();
	}
}

//切换样式类型
function changeCssType(){
	
}

//切换绑定表
function changeTable(){
	//var table_id = $("#tableparm").attr("code");
	var table_id = $('#tableparm option:selected').attr("code");//获取表ID

	//ajax方式提交数据
    jQuery.ajax({
        type: "post", 
        url: "configparmdo.jsp", 
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data : {
            action : 'query',
            table_id : table_id    
        },
        dataType: "json", 
        success: function (data) {
        	jQuery("#columnparm").empty();
        	if(data!=null && data.length>0){
        		for(var i=0; i<data.length; i++){
        			//alert(data[i].column_code);
        			jQuery("#columnparm").append("<option value='"+data[i].column_code+"'>"+data[i].column_code+"["+data[i].column_name+"]</option>");  
        			//optionHtml += "<option value='"+data[i].column_code+"'>"+data[i].column_name+"</option>";
        		}
        	}
        	$('#columnparm').val("<%= column_id%>")
        }, 
        error: function (XMLHttpRequest, textStatus, errorThrown) { 
            alert("出现异常，请稍后再试！");
        } 
     });     
	
}
//控件类型切换
function ctypeChange(ctype){
	if(ctype == "select"){
		$("#select5").show();
	}else{
		$("#select5").hide();
	}
	if(ctype == "input"){
		$("#select6").show();
	}else{
		$("#select6").hide();
	}
	if(ctype == "date"){
		$("#select7").show();
	}else{
		$("#select7").hide();
	}
	if(ctype == "viewtext"){
		$("#select9").show();
	}else{
		$("#select9").hide();
	}
	if(ctype == "sernum"){
		$("#select10").show();
	}else{
		$("#select10").hide();
	}
	//if(ctype == "afix"){
	//	$("#select8").show();
	//}else{
	//	$("#select8").hide();
	//}
	//当控件类型切换时，切换默认样式
	setCssText(ctype);
}

//设置控件的默认样式
function setCssText(ctype){
	if(ctype == "input"){
		$("#csstypetext").val("width: 90%;border: 0px;line-height:26px; height:26px;");
	}else if(ctype == "select"){
		$("#csstypetext").val("width: 50%;line-height:22px; height:22px;margin-top:3px;");
	}else if(ctype == "textarea"){
		$("#csstypetext").val("border: 1;width:80%; height: 30px; overflow: auto;");
	}else if(ctype == "text"){
		$("#csstypetext").val("font-size: 20px; color: #ff0000; padding-left: 43%; line-height: 30px;");
	}else if(ctype == "date"){
		$("#csstypetext").val("height:22px;line-height: 22px;float:left;margin-top:3px;");
		$("#display_html").val("yyyy-MM-dd HH:mm:ss");
	}else if(ctype == "viewtext"){
		$("#csstypetext").val("border:0;width:90%; height: 30px; overflow: auto;");
		$("#display_html").val("uuuu,tt");
	}else if(ctype == "afix"){
		$("#csstypetext").val("");
	}else if(ctype == "afixlist"){
		$("#csstypetext").val("");
	}else if(ctype == "txt"){
		$("#csstypetext").val("");
	}else if(ctype == "ismsg"){
		$("#csstypetext").val("margin-top:3px;");
	}else if(ctype == "number"){
		$("#csstypetext").val("width: 120px;border: 0px;line-height:26px; height:26px;float:left;");
	}else if(ctype == "sernum"){
		$("#csstypetext").val("width: 120px;border: 0px;line-height:26px; height:26px;float:left;");
	}
}

$(function(){ //DOM Ready  绑定值
	setCssText($('#ctype').val());
	if(<%=oaFormTagConfigBean!=null%>){
		$('#ctype').val("<%= ctype%>")
		if($('#ctype').val()=="select"){
			$("#select5").show();
			$("input[name='selectType'][type='radio'][value='<%=selectType%>']").attr("checked",true);
			$('#selectTypetext').val("<%=selectText%>");
		}
		if($('#ctype').val()=="input"){
			$("#select6").show();
			initSelectObj("default_value","<%=defaultValue%>");
			$("#select6 select[name='drag_in_value']").val("<%=drag_in_value%>");
		}
		if($('#ctype').val()=="date"){
			$("#select7").show();
		}
		if($('#ctype').val()=="viewtext"){
			$("#select9").show();
		}
		if($('#ctype').val()=="sernum"){
			$("#select10").show();
			$("#select10 select[name='default_value1']").val("<%=defaultValue%>");
		}
		//选中表配置下拉框
		$('#tableparm').val("<%= table_id%>")
		changeTable();
		$('#csstypetext').val("<%= csstypetext%>")
	}else{
		$("#select6").show();
	}
	
	
});
//初始化下拉框
initSelectObj = function(objId,defaultVal){
	jQuery.ajax({
        type: "post", 
        url: "configparmdo.jsp", 
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data : {
            action : 'initSelectObj',
            objId : objId,
            dataArg:jQuery("#from_ext_parm",getParentWindow("").document).val()
        },
        dataType: "json",
        success: function (data){
        	debugger;
        	jQuery("#"+objId)[0].length==1;
        	if(data){
        		for(var i in data){
        			jQuery("#"+objId).append("<option value='"+i+"'>"+data[i]+"</option>");
        		}
        	}
        	$('#'+objId).val(defaultVal);
        }, 
        error: function (XMLHttpRequest, textStatus, errorThrown) { 
            alert("出现异常，请稍后再试！");
        } 
     });
}
</script>
<title>配置属性</title>
</head>
<body>
<form id="formTagForm" name="formTagForm" action="configparmdo.jsp" method="post">
	<input type="hidden" name="action" id="action" value="<%=action %>">
	<input type="hidden" name="paramJson" id="paramJson" value="">
	<input type="hidden" name="tag_html" id="tag_html" value="">
	<input value="<%=from_ext_parm%>" type="hidden" name ="from_ext_parm" id="from_ext_parm" />
	<table width="100%" border="0" cellpadding="0" cellspacing="0" style="padding-top: 10px;">
			<tr>
			<th width="30" valign="top" class="content_02_box_div_table_02_th">控件生成方式：</th>
	        <td width="400" class="content_02_box_div_table_02_td" colspan="3">
	            <input type="radio" name="bindType" value="1"  onclick="changeBindType(this.value)" checked="checked"/>选择控件
		   		<!--<input type="radio" name="bindType" value="2"  onclick="changeBindType(this.value)"/>自定义HTML  -->
	        </td>
			</tr>
			<tr id="select1" height="45">
				<th width="30" valign="top" class="content_02_box_div_table_02_th">控件类型：&nbsp;</th>
				<td width="210"  class="content_02_box_div_table_02_td" >
					<select id="ctype" style="width:210px;" onchange="ctypeChange(this.value)" >
						<option value="input">文本框</option>
						<option value="select">下拉框</option>
						<option value="textarea">文本域</option>
						<option value="date">日期</option>
						<option value="text">文本</option>
						<option value="viewtext">意见框</option>
						<option value="afix">附件</option>
						<option value="afixlist">附件列表</option>
						<option value="number">公文编号</option>
						<option value="sernum">流水号</option>
						<!--在送后续环节的时候配置短信，而不需要短信控件 
						<option value="ismsg">短信通知</option> -->
					</select>
				</td>
				<th width="60" valign="top" class="content_02_box_div_table_02_th">标题：&nbsp;</th>
				<td width="210"  class="content_02_box_div_table_02_td" >
				<input type="text" style="width: 205px;height:15px;" id="titles" value="<%= oaFormTagConfigBean!=null?oaFormTagConfigBean.getTitle():"" %>">
				</td>
			</tr>
			
			<tr id="select2" height="45">
				<th width="30" valign="top" class="content_02_box_div_table_02_th">选择表：&nbsp;</th>
				<td width="210"  class="content_02_box_div_table_02_td" >
					<select id="tableparm" style="width:210px;" onchange="changeTable()">
						<option value="">请选择</option>
						<%for(int i=0; i<oaMdTableBeanlist.size(); i++){
							if(oaFormTagConfigBean!=null){
								
							}
							%>
							<option value="<%= oaMdTableBeanlist.get(i).getTable_code() %>"  code="<%= oaMdTableBeanlist.get(i).getTable_id() %>"  
							  title="<%= oaMdTableBeanlist.get(i).getTable_code()+"["+oaMdTableBeanlist.get(i).getTable_name()+"]" %>"
							  >
							  <%= oaMdTableBeanlist.get(i).getTable_code()+"["+oaMdTableBeanlist.get(i).getTable_name()+"]" %>
							</option>
						<% } %>
					</select>
				</td>
				<th width="60" valign="top" class="content_02_box_div_table_02_th">选择字段：&nbsp;</th>
				<td width="180"  class="content_02_box_div_table_02_td" >
					<select id="columnparm" style="width:210px;">
					</select>
				</td>
			</tr>
			<tr id="select10" height="45" style="display: none;">
				<th width="60" valign="top" class="content_02_box_div_table_02_th">流水号规则：&nbsp;</th>
				<td width="210"  class="content_02_box_div_table_02_td" >
					<select id="default_value1" name='default_value1' style="width:210px;">
						<option value="">请选择</option>
						<option value="S">收文流水号</option>
						<option value="C">呈批件流水号</option>
				   </select>
				</td>
			</tr>
			<tr id="select6" height="45" style="display: none;">
				<th width="60" valign="top" class="content_02_box_div_table_02_th">默认值：&nbsp;</th>
				<td width="210"  class="content_02_box_div_table_02_td" >
					<select id="default_value" name='default_value' style="width:210px;">
						<option value="">请选择</option>
				   </select>
				</td>
				<th width="60" valign="top" class="content_02_box_div_table_02_th">内容类型：</th>
				<td width="210"  class="content_02_box_div_table_02_td" >
					<select name="drag_in_value" style="width:210px;">
						<option value="">请选择</option>
						<%-- 变量利用在 archiveform.vm --%>
						<option value="<%=FormserviceImpl.DRAG_IN_TITLE_PG%>">标题</option>
				   </select>
					
				</td>
			</tr>
			<!--  <tr id="select8" height="45" style="display: none;">
				<th width="60" valign="top" class="content_02_box_div_table_02_th">内容类型：</th>
				<td width="210"  class="content_02_box_div_table_02_td" >
					<select name="drag_in_value" style="width:210px;">
						<option value="">请选择</option>
						<%-- 变量利用在 archiveform.vm --%>
						<option value="<=FormserviceImpl.DRAG_IN_ATTACH_PG%>">附件</option>
				   </select>
				</td>
				<th width="60" valign="top" class="content_02_box_div_table_02_th"></th>
				<td width="210"  class="content_02_box_div_table_02_td" >&nbsp;</td>
			</tr>-->
			<tr id="select9" height="45" style="display: none;">
				<th width="60" valign="top" class="content_02_box_div_table_02_th">意见格式：&nbsp;</th>
				<td width="210"  class="content_02_box_div_table_02_td" >
				<input type="text" style="width: 210px;height:15px;" id="display_html" title="u代表一个空格，t代表一个制表符"
				 value="<%= oaFormTagConfigBean!=null?oaFormTagConfigBean.getDisplay_html():"uuuu,tt" %>">
				</td>
			</tr>
			<tr id="select7" height="45" style="display: none;">
				<th width="60" valign="top" class="content_02_box_div_table_02_th">日期格式：&nbsp;</th>
				<td width="210"  class="content_02_box_div_table_02_td" >
				<input type="text" style="width: 210px;height:15px;" id="display_html" value="<%= oaFormTagConfigBean!=null?oaFormTagConfigBean.getDisplay_html():"yyyy-MM-dd HH:mm:ss" %>">
				</td>
			</tr>
			<tr id="select5" height="55" style="display: none;">
				<th width="80" valign="top" class="content_02_box_div_table_02_th">
				<input type="radio" name="selectType" value="1" checked="checked"/>枚举型&nbsp;&nbsp;&nbsp;&nbsp;
				<br/>
				<input type="radio" name="selectType" value="2" />自定义SQL&nbsp;
			    </th>
			 	<td width="380"  class="content_02_box_div_table_02_td" colspan="3">
				<input type="text" style="width: 380px;height:25px;" id="selectTypetext" value="value1:text1,value2:text2,value3:text13">
			    </td>
			</tr>
			<tr id="select4" height="45">
				<th width="80" valign="top" class="content_02_box_div_table_02_th">
				样式代码：
				<!-- 
				<input type="radio" name="cssType" value="1"  onclick="changeCssType(this.value)" checked="checked"/>公文样式&nbsp;
				<br/>
				<input type="radio" name="cssType" value="2"  onclick="changeCssType(this.value)"/>无样式&nbsp;&nbsp;&nbsp -->
				
			    </th>
			   <td width="380"  class="content_02_box_div_table_02_td" colspan="3">
				<input type="text" style="width: 380px;height:25px;" id="csstypetext" value="">
			   </td>
			</tr>
			<tr id="select3" style="display: none">
				<td width="15%" align="right">自定HTML：&nbsp;</td>
				<td colspan="3">
				<textarea  rows="13" style="width: 95%;overflow-y:auto;"  name="html_text"
					id="html_text"></textarea>
				</td>
			</tr>
		</table>
	<div class="cue_box_foot">
		<input type="button" class="but_y_01" style="" onclick="onsubmitconfig()" id="button_submit"  value="确定" />
  	</div>
</form> 
<iframe name="hiddenFrame" height="0" width="0"></iframe>	
</body>
</html>