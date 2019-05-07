<%--
　　描述：配置word参数页面
　　作者：黄艺平
　　版本：1.0
　　日期：2013-08-1
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@ page import="com.chinacreator.xtbg.core.common.iweboffice.service.WordTemplateServiceIfc"%>
<%@ page import="com.chinacreator.xtbg.core.common.iweboffice.service.impl.WordTemplateServiceImpl"%>
<%
	String path = request.getContextPath();
	String template_id = StringUtil.deNull(request.getParameter("template_id"));
	String kj_id = StringUtil.deNull(request.getParameter("kj_id"));
	String kj_type = StringUtil.deNull(request.getParameter("kj_type"));
	String window_source = StringUtil.deNull(request.getParameter("window_source"));
	Map<String, String> ruleItemBeanMap = new HashMap<String, String>();

	WordTemplateServiceIfc wordTemplate = new  WordTemplateServiceImpl();
	if(!StringUtil.isBlank(kj_id)) {
		ruleItemBeanMap = wordTemplate.getRuleItemBean(kj_id);
	}else{
		String defalutTable = StringUtil.deNull(request.getParameter("defalutTable"));
		ruleItemBeanMap.put("table_id",defalutTable);//将表名放入缓存 不要每次选表
	}
	
	FormserviceImpl FormserviceImpl = new FormserviceImpl();
	List<OaMdTableBean> oaMdTableBeanlist = FormserviceImpl.getTableList();//获取表LIST
	
	String column_id = ""; //字段ID
%>	

<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.form.service.impl.FormserviceImpl"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.form.entity.OaMdTableBean"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>配置word参数</title>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" ></script>
<script language="javascript" src="js/wordtemplateutil.js"> </script>
<script type="text/javascript">
var obj = getParentWindow('windowId1');
var template_id = "<%=template_id%>";//模版ID
if(template_id == "") {
	template_id = obj.parent.frames["rightFrame"].jQuery("#template_id").value;
}
var kj_id = "<%=kj_id%>";//控件ID
var kj_type = "<%=kj_type%>";//控件类型
var kj_name = "";

var window_source = "<%=window_source%>"; //窗体来源 1窗体 2列表
var webOffice = "";
if(window_source == "1") {
    webOffice = obj.parent.frames["mainFrame"].document.getElementsByName("WebOffice")[0];
} 
if(window_source == "2"){
    webOffice = obj.parent.parent.frames["mainFrame"].document.getElementsByName("WebOffice")[0];
}
controlTableCellColor = function(value){
	if(value=='1'||value=='4'||value=='5'||value=='6'){
			jQuery('#table_cell_need').show();
		}else{
			jQuery('#table_cell_need').hide();
		}
	if(value=='2'||value=='3'){
		jQuery('#table_cell').val("");
		jQuery('#table_cell').attr("disabled","disabled");
	}else{
		jQuery('#table_cell').removeAttr("disabled");
	}
};
/*
	函数：init
	描述：初始化
	参数：
	返回值：
*/
function init() {
	jQuery("#kj_remark").focus();
	var kj_lx="<%=ruleItemBeanMap.get("textinput_value_type")%>";
	jQuery("#kj_lx").val(kj_lx);
    //if(kj_lx=="1"){
    //    $('input:radio[value="1"]').attr("checked",true);
    //}else if(kj_lx=="2"){
    //    $('input:radio[value="2"]').attr("checked",true);
    //}else if(kj_lx=="3"){
    //    $('input:radio[value="3"]').attr("checked",true);
    //}else if(kj_lx=="4"){
    //    $('input:radio[value="4"]').attr("checked",true);
    //}
    $('#tableparm').val("<%= StringUtil.deNull(ruleItemBeanMap.get("table_id")) %>");
    $('#data_come_from_table_id').val("<%= StringUtil.deNull(ruleItemBeanMap.get("data_come_from_table_id")) %>");
    changeTable('tableparm','columnparm','1',true);
    changeTable('data_come_from_table_id','data_come_from_column_id','2',true);
    controlTableCellColor(jQuery("#kj_lx").val());
   
    tablecolumn();
    jQuery("#table_cell").val("<%=StringUtil.deNull(ruleItemBeanMap.get("table_cell")) %>");
    
}

/*
	函数：kjSave
	描述：保存参数
	参数：
	返回值：
*/
function kjSave() {
    if(!validate()){
        return;
    }
    var url = "wordtemplatedo.jsp?operationType=dosavewordparam&kj_type="+kj_type;
    document.all.form1.action = url;
    document.all.form1.target = "hiddenFrame";
    document.all.form1.submit();
}

/*
	函数：validate
	描述：验证
	参数：
	返回值：
*/
function validate() {
    var tableparm = jQuery("#tableparm").val();
    var columnparm = jQuery("#columnparm").val();
    var kj_id = jQuery("#kj_id").val();
    var kj_lx = jQuery("#kj_lx").val();
    var bl_name = jQuery("#bl_name").val();
    var sjj_name = jQuery("#sjj_name").val();
    var table_cell = jQuery("#table_cell").val();
    if(template_id == "" || template_id == "null") {
        alert("模版基本信息未保存，请先保存");
        return false;
    }
    if(tableparm == "") {
        alert("请选择表");
        return false;
    }
    if(columnparm == "") {
        alert("请选择字段");
        return false;
    }
    if(kj_lx == "") {
        alert("请选择控件取值");
        return false;
    }  
    if((kj_lx =="1"||kj_lx =="4"||kj_lx =="5"||kj_lx =="6") && table_cell =="") {
        alert("请填写表格位置");
        return false;
    }
    if(kj_type == "orderlyTable") {
        var wordSelection = webOffice.WebObject.ActiveWindow.Selection;
        if (!wordSelection.Information(wdWithInTable)) {
            alert("请先在WORD模版中创建表格");
            return false;
        }
    }
    var tbaleDef = table_cell.split(",");
    if(kj_lx =="1" || kj_lx =="4"||kj_lx =="5"||kj_lx =="6"||kj_lx =="7"){//如果是普通变量或者是文号字段 要确定表格位置
    if(tbaleDef.length == 3){
		var iWebOffice = obj.parent.frames["mainFrame"].document.getElementsByName("WebOffice")[0];
		if(iWebOffice.WebObject.Tables.Count>=tbaleDef[0]){//如果WORD里的表格数大于定义的表格数。
				var tables = iWebOffice.WebObject.Tables.Item(tbaleDef[0]);
				if(tables.Columns.Count>=tbaleDef[2]  && tables.Rows.Count >= tbaleDef[1]){//如果行列存在
					var cell = tables.Cell(tbaleDef[1],tbaleDef[2]);
					if(cell){
						cell.Select();
					}
				}else{
					alert("行列定义错误，该表格有"+tables.Rows.Count+"行，"+tables.Columns.Count+"列！");
					return false;
				}
		}else{
			alert("表格位置定位错误，该文档有"+iWebOffice.WebObject.Tables.Count+"个表格！");
			return false;
		}
	}else{
		alert("表格位置定义错误，请按照 表位置，行位置，列位置 定义。");
        return false;
	}
    }
    return true;
}
function isintable(table_cell){
	var tbaleDef = table_cell.split(",");
	if(tbaleDef.length == 3){
		var iWebOffice = obj.parent.frames["mainFrame"].document.getElementsByName("WebOffice")[0];
		if(iWebOffice.WebObject.Tables.Count>=tbaleDef[0]){//如果WORD里的表格数大于定义的表格数。
				var tables = iWebOffice.WebObject.Tables.Item(tbaleDef[0]);
				if(tables.Columns.Count>=tbaleDef[2]  && tables.Rows.Count >= tbaleDef[1]){//如果行列存在
					try{
						var cell = tables.Cell(tbaleDef[1],tbaleDef[2]);
						return true;
					}catch (e) {
						return false;
					}
				}else{
					return false;
				}
		}else{
			return false;
		}
	}else{
        return false;
	}
}
function tablecolumn(){
	jQuery("<option value='' >请选择</option>").appendTo("#table_cell");
	var iWebOffice = obj.parent.frames["mainFrame"].document.getElementsByName("WebOffice")[0];
	var tablecount=iWebOffice.WebObject.Tables.Count;
	var j=0;
	for(var i=1;i<=tablecount;i++){
		var tables = iWebOffice.WebObject.Tables.Item(i);
		var rows=tables.Rows.Count;
		var columns=tables.Columns.Count;
		for(var a=1;a<=rows;a++){
			for(var b=1;b<=columns;b++){
				var value=i+","+a+","+b;
				var flag=isintable(value);
				if(flag){
					jQuery("<option value="+value+" >"+value+" </option>").appendTo("#table_cell");
				}
			}
		}
	}
}
var listValue  = new Array();//全局参数，在wordtemplatedo.jsp中赋值   
/*
	函数：doReturnOK
	描述：添加成功后word中插入文档区域
	参数：
	返回值：
*/
function doReturnOK(parm){
		obj.parent.frames["rightFrame"].search();
		obj.setDefalutTable(jQuery("#tableparm").val());
		obj.closeAlertWindowFun();
		removeAlertWindows('windowId1',false,true,'',false,'',true);
}

/*
	函数：kjClose
	描述：关闭事件
	参数：
	返回值：
*/
function kjClose() {
	obj.closeAlertWindowFun();
	removeAlertWindows('windowId1',false,true,'',false,'',true);
}

/*
	函数：changeTable
	描述：切换绑定表
	参数：
	返回值：
*/
function changeTable(selectIdA,selectIdB,flag,isInit){
	var successFn = function(data){};
	var dataArg={};
	if(flag==1){
		dataArg = {
	          action : 'query',
	          table_id : $('#'+selectIdA+' option:selected').attr("code")
	    };
		successFn = function (data) {
	      	jQuery("#"+selectIdB).empty();
	      	if(data!=null && data.length>0){
	      		for(var i=0; i<data.length; i++){
	      			jQuery("#"+selectIdB).append("<option value='"+data[i].column_code+"'>"+data[i].column_code+"["+data[i].column_name+"]</option>");  
	      		}
	      	}
	      	if(jQuery("#"+selectIdB+" option").size()==0){
	      		jQuery("#"+selectIdB).attr("disabled","true");
	      	}else{
	      		jQuery("#"+selectIdB).removeAttr("disabled");
	      	}
	      	if(isInit){
	      		$('#'+selectIdB).val("<%= StringUtil.deNull(ruleItemBeanMap.get("column_id"))%>")
	      	}
	    };
	}else{
		dataArg = {
	          action : 'query',
	          type:'type',
	          table_id : $('#'+selectIdA+' option:selected').attr("code")
		};
		successFn = function (data) {
	      	jQuery("#"+selectIdB).empty();
	      	if(data!=null && data.length>0){
	      		for(var i=0; i<data.length; i++){
	      			jQuery("#"+selectIdB).append("<option value='"+data[i].column_code+"' title='"+data[i].column_id+"'>"+data[i].column_code+"["+data[i].column_name+"]</option>");  
	      		}
	      	}
	      	if(jQuery("#"+selectIdB+" option").size()==0){
	      		jQuery("#"+selectIdB).attr("disabled","true");
	      	}else{
	      		jQuery("#"+selectIdB).removeAttr("disabled");
	      	}
	      	if(isInit){
	      		$('#'+selectIdB).val("<%=StringUtil.deNull(ruleItemBeanMap.get("data_come_from_column_id"))%>")
	      	}
	    };
	}
	//ajax方式提交数据
	jQuery.ajax({
	    type: "post", 
	    url: "../../form/configparmdo.jsp", 
	    contentType: "application/x-www-form-urlencoded; charset=utf-8",
	    data : dataArg,
	    dataType: "json", 
	    success: successFn, 
	    error: function (XMLHttpRequest, textStatus, errorThrown) {alert("出现异常，请稍后再试！");}
	});
}

</script>
</head>
<body onload = "init();">
<form name="form1" method="post">
<input type = "hidden" name = "template_id" value = "<%=template_id %>"/>
<input type = "hidden" id="temp_value" name = "temp_value" value = ""/>
<input type="hidden" id="kj_name" name="kj_name"  value="<%=StringUtil.deNull(ruleItemBeanMap.get("textinput_name")) %>" />
<input id="kj_id" name="kj_id" type="hidden" value = "<%=kj_id %>">
	<div style=" width: 100%; ">
		 <div>
		 <div>
				<table  border="0" cellspacing="0" cellpadding="0"  >
				 <tr>
		           	   <th class="content_02_box_div_table_th">
		           	   		<font color="red">*</font>控件取值 ：
		           	   </th>
			           <td class="content_02_box_div_table_td">
				        <select id="kj_lx" name="kj_lx" style="width:210px;" onchange="controlTableCellColor(this.value)">
							<option value="1">普通变量</option>
							<option value="2">正文ID</option>
							<option value="3">附件ID</option>
							<option value="4">配置文号</option>
							<option value="5">配置标题</option>
							<option value="6">配置意见</option>
							<option value="7">附件名称</option>
							<option value="8">配置主键</option>
							<option value="9">信息公开</option>
						</select>
			          		<!--<input type="radio" value="1" name="kj_lx" checked>变量
			          		<input type="radio" value="2" name="kj_lx" >正文
			          		<input type="radio" value="3" name="kj_lx" >附件
			          		<input type="radio" value="4" name="kj_lx" >文号
			           --></td>
					   <td class="content_02_box_div_table_td">
			           </td>
		         </tr>	
		         <tr >
		           	   <th class="content_02_box_div_table_th"><FONT color="red" id='table_cell_need'>*</FONT>表格位置：</th>
			           <td class="content_02_box_div_table_td">
			           <select id="table_cell" name="table_cell" style="width:210px;"  >
						</select>
			           </td>
		         </tr>
		         <tr>
		           	   <th class="content_02_box_div_table_th"><FONT color="red">*</FONT>选择表：</th>
			           <td class="content_02_box_div_table_td">
				          
				          <select id="tableparm" name="tableparm" style="width:210px;" onchange="changeTable('tableparm','columnparm','1')">
							<option value="">请选择</option>
							<%for(int i=0; i<oaMdTableBeanlist.size(); i++){
								%>
								<option value="<%= oaMdTableBeanlist.get(i).getTable_code() %>"  code="<%= oaMdTableBeanlist.get(i).getTable_id() %>"  
								  title="<%= oaMdTableBeanlist.get(i).getTable_code()+"["+oaMdTableBeanlist.get(i).getTable_name()+"]" %>"
								  >
								  <%= oaMdTableBeanlist.get(i).getTable_code()+"["+oaMdTableBeanlist.get(i).getTable_name()+"]" %>
								</option>
							<% } %>
							
						 </select>
			           </td>
		         </tr>
		         
		          <tr>
		           	   <th class="content_02_box_div_table_th"><FONT color="red">*</FONT>选择字段：</th>
			           <td class="content_02_box_div_table_td">
				          <select id="columnparm" name="columnparm" style="width:210px;"></select>
			           </td>
		         </tr>
		         
		         <tr>
		           	   <th class="content_02_box_div_table_th" title="支持公文接收">选择来文表名：</th>
			           <td class="content_02_box_div_table_td">
				          <select id="data_come_from_table_id" name="data_come_from_table_id" style="width:210px;" onchange="changeTable('data_come_from_table_id','data_come_from_column_id','2')">
							<option value="">请选择</option>
							<option value="OA_GWRECEIVE"
									code="OA_GWRECEIVE"
									selected="selected"
									title="">TA_OA_GWRECEIVE[公文接收表]</option>
						 </select>
			           </td>
		         </tr>
		         
		         <tr>
		           	   <th class="content_02_box_div_table_th" title="支持公文接收">选择来文字段：</th>
			           <td class="content_02_box_div_table_td">
				          <select id="data_come_from_column_id" name="data_come_from_column_id" style="width:210px;"></select>
			           </td>
		         </tr>
		          <tr>
		           	   <th class="content_02_box_div_table_th">过滤字段：</th>
			           <td class="content_02_box_div_table_td" >
			           <TEXTAREA id="kj_help" name = "kj_help" style="width: 100%; height: 40px" value="<%=StringUtil.deNull(ruleItemBeanMap.get("textinput_help")) %>" class="cTextarea" ><%=StringUtil.deNull(ruleItemBeanMap.get("textinput_help")) %></TEXTAREA>
			           </td>
		          </tr>	
				  <tr>
		           	   <th class="content_02_box_div_table_th">描述：</th>
			           <td class="content_02_box_div_table_td">
			          <textarea id="kj_remark" name  ="kj_remark" style="width: 100%; height: 40px" value="<%=StringUtil.deNull(ruleItemBeanMap.get("textinput_remark")) %>" class="cTextarea" ><%=StringUtil.deNull(ruleItemBeanMap.get("textinput_remark")) %></TEXTAREA>
			           </td>
		         </tr>	
				  <tr>
		           	   <th class="content_02_box_div_table_th">状态：</th>
			           <td class="content_02_box_div_table_td">
			           <TEXTAREA id="kj_flag" name = "kj_flag" style="WIDTH: 100%; HEIGHT: 40px" value="<%=StringUtil.deNull(ruleItemBeanMap.get("textinput_flag")) %>" class="cTextarea" ><%=StringUtil.deNull(ruleItemBeanMap.get("textinput_flag")) %></TEXTAREA>
			           </td>
		         </tr>	
				</table>
			</div>
			</div>
			<div class="cue_box_foot">
		<input class="but_y_01" type="reset" id="resert" value="关闭" onclick="kjClose()" />
		<input class="but_y_01" type="button" onclick="kjSave()" value="保存"/>
  	</div>
	</div>
<iframe name = "hiddenFrame" width="100%" height="0"></iframe>
</form>
</body>
</html>