<%--
describe:正文配置页面
author:shuqi.liu
date: 2013-6-24
--%>
<%@page import="org.apache.velocity.runtime.directive.Foreach"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
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
	FormserviceImpl FormserviceImpl = new FormserviceImpl();
	List<OaMdTableBean> oaMdTableBeanlist = FormserviceImpl.getTableList();//获取表LIST
	StringBuffer optionStr = new StringBuffer("<option value=\"\">请选择</option>") ;
	for(int i=0; i<oaMdTableBeanlist.size();i++){
		optionStr.append("<option ");
		optionStr.append("value=\"").append(oaMdTableBeanlist.get(i).getTable_code()).append("\" ");
		optionStr.append("code=\"").append(oaMdTableBeanlist.get(i).getTable_id()).append("\" ");
		optionStr.append("title=\"").append(oaMdTableBeanlist.get(i).getTable_code()+"["+oaMdTableBeanlist.get(i).getTable_name()+"]").append("\">");
		optionStr.append(oaMdTableBeanlist.get(i).getTable_code()+"["+oaMdTableBeanlist.get(i).getTable_name()+"]" );
		optionStr.append("</option>");
	}
	
	List<OaFormTagConfigBean> hideTagList = FormserviceImpl.getHideTagConfig(form_id);//获取TAG配置
	
	String pzycy="select d.dictdata_value,d.dictdata_name from oa_dict_data d left join oa_dict_type t on d.dict_id=t.dict_id where t.dict_code='zdybd' "
				+" and d.dictdata_parent_id= (select dd.dictdata_id from oa_dict_data dd where dd.dictdata_value='pzycy' ) order by  d.dictdata_order";
	String[][] pz=DictDropDownList.queryDictData(pzycy);
	StringBuffer optionPZ = new StringBuffer("<option value=\"\">请选择</option>") ;
	for(int i=0;i<pz.length;i++){
		optionPZ.append("<option ");
		optionPZ.append("value=\"").append(pz[i][0]).append("\" >");
		optionPZ.append(pz[i][1]);
		optionPZ.append("</option>");
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- 引入jQuery -->
<script type="text/javascript" src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery_dialog -->
<script src="../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<!-- 引入formvValidatetion -->
<script src="<%=path%>/ccapp/oa/resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="<%=path%>/ccapp/oa/resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<!-- 引入公共JS -->
<script src="../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript">
var form_id = '<%=form_id%>';
var path = "<%=path%>";//工程路径

function onsubmitconfig(){ //点击确定
	var isFlag = jQuery('#formTagForm').validationEngine('validate'); //是否全部验证通过
    if(!isFlag ){
      return ;
    }
  	var paramjson = "";
    var tableparm = jQuery("select[name=tableparm]");//表名
    var columnparm = jQuery("select[name=columnparm]");//字段名
    var defaultvalue = jQuery("select[name=default_value]");//默认值
    var id = jQuery("input[name=option_id]");//选项id
    var check_max = jQuery("input[name=check_max]");//最大可选数
    paramjson += "[";
    for(var i=0;i<tableparm.length;i++){
        if(i != 0){
        	paramjson += ",";
        }
        paramjson += "{'table_id':'"+tableparm[i].value+"',"+
                "'column_id':'"+columnparm[i].value+"',"+
                "'default_value':'"+defaultvalue[i].value+"',"+
                "'form_id':'"+form_id+"',"+
                "'tag_type_id':'hide'"+
                "}";
    }
    paramjson += "]";
	//TODO 将该属性保存到数据库
	$("#paramJson").val(paramjson);//保存并更新填写状态
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
function changeTable(id,cvalue){
	//var table_id = $("#tableparm").attr("code");
	var table_id = $('#tableparm'+id+' option:selected').attr("code");//获取表ID

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
        	jQuery("#columnparm"+id).empty();
        	if(data!=null && data.length>0){
        		for(var i=0; i<data.length; i++){
        			//alert(data[i].column_code);
        			jQuery("#columnparm"+id).append("<option value='"+data[i].column_code+"'>"+data[i].column_code+"["+data[i].column_name+"]</option>");  
        			//optionHtml += "<option value='"+data[i].column_code+"'>"+data[i].column_name+"</option>";
        		}
        	}
        	$('#columnparm'+id).val(cvalue)
        }, 
        error: function (XMLHttpRequest, textStatus, errorThrown) { 
            alert("出现异常，请稍后再试！");
        } 
     });     
	
}

/**
 * 控制添加问题选项
 */
var tableControl = {
   tableId : "option_List",//dom id
   count : 0, //添加条数，用于唯一标示
   startCode : 65,//选项编号起始的ASSCI码值，即为（A）
   countCode : 0 ,
   /**
    *添加
    */
   addHtml : function(id,code,content,checkMax){
     var table = jQuery("#"+this.tableId);
     //传入的选项为空，则自动给选项赋值
     code =IsSpace(code) ? String.fromCharCode(this.startCode+this.countCode):code;
     var tr = '<tr id="tr'+this.count+'">'+
     '<td style="width:30px"><input name="option_box" type="checkbox" value="tr'+this.count+'"/></td>'+
     '<td style="width:20px">表:</td>'+
     '<td style="width:180px">'+
     '<select id="tableparm'+this.count+'" style="width:180px;" name="tableparm" class="validate[required]"  onchange="changeTable('+this.count+')">'+
     '<%=optionStr%>'+
     '</select>'+
     '</td>'+
     '<td  style="width:60px">&nbsp;字段:</td>'+
     '<td >'+
     '<select id="columnparm'+this.count+'" name="columnparm" class="validate[required]"  style="width:140px;">'+
     '</select>'+
     '</td>'+
     '<td style="width:30px;text-align:right;">值：</td>'+
     '<td><select id ="default_value'+this.count+'" name="default_value" style="width:150px;">'+
     '<%=optionPZ%>'+
		/* '<option value="">请选择</option>'+
		'<option value="{user_id}">用户ID</option>'+
		'<option value="{user_name}">用户名称</option>'+
		'<option value="{org_id}">部门ID</option>'+
		'<option value="{org_name}">部门名称</option>'+
		'<option value="{unit_id}">单位ID</option>'+
		'<option value="{unit_name}">单位名称</option>'+
		'<option value="{time}">当前时间（yyyy-MM-dd hh-mm-ss）</option>'+
		'<option value="{date}">当前时间（yyyy-MM-dd）</option>'+ */
  	 '</select>'+
     '<input type="hidden"  id="option_id'+this.count+'"  name="option_id" value="'+id+'"/>'+
     '</td>'+
     '</tr>';
     //给table添加列
     table.append(tr);
     
     this.count = this.count +1;
     this.countCode = this.countCode + 1;
   },
   /**
    *移除html
    */
   removeHtml : function(){
     //移除选中的行  
     jQuery("input[name=option_box]").each(function () {         
      if (jQuery(this).attr("checked")) {    
          jQuery("#"+this.value).remove();
      }
     });
     
   }
}

$(function(){ //DOM Ready  绑定值
	//添加隐藏域
    <%if(null != hideTagList && !hideTagList.isEmpty()){
      for(int i=0; i<hideTagList.size(); i++){
    %>
    tableControl.addHtml("","","","");
    $('#tableparm<%=i%>').val("<%= hideTagList.get(i).getTable_id()%>");//选择表
	changeTable(<%=i%>,'<%= hideTagList.get(i).getColumn_id()%>');//选择字段
	$('#default_value<%=i%>').val("<%= hideTagList.get(i).getDefault_value()%>");//默认值
    <%}}%>
});

jQuery(document).ready(function() {
    jQuery("#formTagForm").validationEngine();
});
</script>
<title>配置属性</title>
</head>
<body>
<form id="formTagForm" name="formTagForm" action="configparmdo.jsp" method="post">
	<input type="hidden" name="action" id="action" value="savehide">
	<input type="hidden" name="paramJson" id="paramJson" value="">
	<input type="hidden" name="tag_html" id="tag_html" value="">
	<input type="hidden" name="form_id" id="form_id" value="<%=form_id %>">
	<div class="content_02_box">
	<div class="content_02_box_div">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table_02">
	    <tr>
	        <th width="45" valign="top" class="content_02_box_div_table_02_th">隐藏域选项：</th>
	        <td width="700" class="content_02_box_div_table_02_td">
	        	<input name="" type="button" value="添加" class="but_y_01" onclick="tableControl.addHtml('','','','');" /> 
	            <input name="" type="button" value="删除" class="but_y_01" onclick="tableControl.removeHtml();" />
	         </td>
	    </tr>
	    <tr>
	        <th width="45" valign="top"  class="content_02_box_div_table_02_th">隐藏域列表：</th>
	        <td width="700"  class="content_02_box_div_table_02_td" >
	        <div style="height:120px; overflow: auto;overflow-x:hidden;width:100%" scrolling="yes">
	        <table id="option_List" width="95%" border="0" cellspacing="0"
	            cellpadding="0" class="content_02_box_div_table_02">
	            
	        </table>
	        </div>
	        </td>
	    </tr>
	</table>
	</div>
	</div>
	<div class="cue_box_foot">
		<input type="button" class="but_y_01" style="" onclick="onsubmitconfig()" id="button_submit"  value="确定" />
  	</div>
</form> 
<iframe name="hiddenFrame" height="0" width="0"></iframe>	
</body>
</html>