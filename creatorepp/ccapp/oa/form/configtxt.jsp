<%--
describe:正文配置页面
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
	
	String form_id = request.getParameter("form_id");//li控件ID
	String txt_form_id = request.getParameter("txt_form_id");//正文ID
	FormserviceImpl FormserviceImpl = new FormserviceImpl();
	List<OaMdTableBean> oaMdTableBeanlist = FormserviceImpl.getTableList();//获取表LIST
	OaFormTagConfigBean oaFormTagConfigBean = FormserviceImpl.queryTagConfigInfo(txt_form_id);//获取TAG配置
	String table_id = "";  //表ID
	String column_id = ""; //字段ID
	String action = "save"; //aciton 方法，默认保存
	
	if(oaFormTagConfigBean!=null){
		action="update";
		table_id = oaFormTagConfigBean.getTable_id();
		column_id = oaFormTagConfigBean.getColumn_id();
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
var liid = '<%=txt_form_id%>';
var form_id = '<%=form_id%>';
var path = "<%=path%>";//工程路径
function checkFromBeforeSubmit(){
	var tableparm = $("#tableparm").val();
	var columnparm = $("#columnparm").val();
	if(!tableparm||!columnparm){
		alert("请选择表和字段");
		return false;	
	}
	
	return true;
}
function onsubmitconfig(){ //点击确定
	if(!checkFromBeforeSubmit()){
		return false;
	}
	var tableparm = $("#tableparm").val();
	var columnparm = $("#columnparm").val();
	var paramJson = "{'tag_id':'" + liid  
				 + "','form_id':'"+form_id
				 + "','tag_type_id':'txt" 
				 + "','table_id':'" + tableparm
				 + "','column_id':'" + columnparm
	paramJson += "'}";

	//TODO 将该属性保存到数据库
	$("#paramJson").val(paramJson);//保存并更新填写状态
	document.all.formTagForm.target = "hiddenFrame";
	$("#formTagForm").submit();
}
//将动作改变的回调函数
function setAction(action){
	$("#action").val(action);
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

$(function(){ //DOM Ready  绑定值
	
	if(<%=oaFormTagConfigBean!=null%>){
		$('#tableparm').val("<%= table_id%>")
		changeTable();
	}
});
</script>
<title>配置属性</title>
</head>
<body>
<form id="formTagForm" name="formTagForm" action="configparmdo.jsp" method="post">
	<input type="hidden" name="action" id="action" value="<%=action %>">
	<input type="hidden" name="paramJson" id="paramJson" value="">
	<input type="hidden" name="tag_html" id="tag_html" value="">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" style="padding-top: 10px;">
			<tr id="select2" height="55">
				<td width="15%" align="right">选择表：&nbsp;</td>
				<td>
					<select id="tableparm" style="width:180px;" onchange="changeTable()">
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
				<td width="15%" align="right">选择字段：&nbsp;</td>
				<td>
					<select id="columnparm" style="width:180px;">
					</select>
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