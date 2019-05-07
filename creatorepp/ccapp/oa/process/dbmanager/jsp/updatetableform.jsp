<%-- 
描述：更新业务表、新增数据元表、新增数据元字段表
作者：肖杰
版本：1.0
日期：2013-11-27
 --%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.service.impl.MdTableAndColumnsServiceIml"%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.service.MdTableAndColumnsService"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="org.apache.velocity.runtime.directive.Foreach"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.dssave.entity.MdTableBean"%>
<%@page import="com.chinacreator.xtbg.core.process.dbmanager.service.impl.MdServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.process.dbmanager.service.MdServiceIfc"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request, response);
    String path = request.getContextPath();
    
    String table_id=StringUtil.deNull(request.getParameter("table_id"));
    
    MdServiceIfc service = new MdServiceImpl();
	MdTableBean mdTableBean = new MdTableBean();
	List<MdTableBean> list = service.findMdTableList(mdTableBean);
	String code=",";
	for(int i=0;i<list.size();i++){
		code+=list.get(i).getTable_code()+",";
	}
	
	MdTableAndColumnsService tcservice=new MdTableAndColumnsServiceIml();
	Map<String,String> tablemap= tcservice.getOneMdTable(table_id);
	
	List<Map<String,String>> columnslist= tcservice.getMdColumns(table_id);
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></meta>
<title>JGRID</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<script>
jQuery(document).ready(function() {
	jQuery("#table_code").focus();
});
/* 
	函数:  createMdTablesForm
	说明:  新建表保存
 */
function createMdTablesForm(){
	
	var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
    if(!isFlag){
       return;
    }
	var arr_column_code=jQuery("input[name=column_code]");
	if (arr_column_code.length<=0){
		alert("错误，未新增字段列！");
		return;
	}
	var mdcolumnlistjson = "";
	var arr_column_id = jQuery("input[name=column_id]");
    var arr_column_name = jQuery("input[name=column_name]");
    var arr_data_type = jQuery("input[name=data_type]");
    var arr_data_length = jQuery("input[name=data_length]");
    var arr_column_sn = jQuery("input[name=column_sn]");
	
	var okF = function(){
		
		var mdtablejson = "{" +
						    "'table_code':'" + $("#table_code").val() + "'," +
						    "'table_id':'" + $("#table_id").val() + "'," +
						    "'table_name':'" + $("#table_name").val() + "'," +
						    "'pkname':'" + $("#pkname").val() + "'," +
						    "'table_pk':'" + $("#pk").val() + "'," +
						    "'havepk':'" + ($("#pk").val() ? "1" : "0") + "'" +
	    "}";

	    for(var i=0;i<arr_column_code.length;i++){
	    	mdcolumnlistjson += "{" +
							    "'column_code':'" + arr_column_code[i].value + "'," +
							    "'column_id':'" + arr_column_id[i].value + "'," +
							    "'column_name':'" + arr_column_name[i].value + "'," +
							    "'data_type':'" + arr_data_type[i].value + "'," +
							    "'data_length':'" + arr_data_length[i].value + "'," +
							    "'column_sn':'" + arr_column_sn[i].value + "'" +
			"},";
	    }	
	    mdcolumnlistjson = "["+mdcolumnlistjson.substring(0,mdcolumnlistjson.length-1)+"]";//去掉最后一个逗号，再加上[]组装成标准的对象数组	
	    var params = {
				mdtablejson: descape(escape(mdtablejson)),
				mdcolumnlistjson: descape(escape(mdcolumnlistjson))
		};
	    var flag="false";
	    jQuery("input[name=column_code]").each(function () {
	    	if(this.value==jQuery("#pk").val()){
	    		flag="true";
	    	}
        });
		
		var url="saveupdatetableform.jsp";
		$.ajax({
			url: url,
			type: 'POST',
			dataType: 'json',
			data: params,
			async : false,
			success: function(flag){
				if(flag){
					alert("操作成功！");
					setTimeout(function(){closeform('windowId');},500);
				}
				else{
					alert("操作失败！");
				}
				
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert("提示:"+textStatus);
				closeform('');
			}
		});
	};
	
	var p={
		headerText:'提示',
		okName:'确认',
        okFunction:okF,
        cancelName:'取消'
	};
	alert("确定要更新表吗？",p);
}

/* 
	函数:  closeform
	说明:  关闭指定窗口，刷新其父页面列表
	参数:  windowId 窗口id
 */
function closeform(windowId){
    getParentWindow(windowId).parent.location.reload();
   	closeAlertWindows(windowId, false, true);
    
}
/**
 * 字段增删控制
 */
var tableControl = {
    tableId: "option_List", //dom id
    countCode: 0,
    addHtml: function (id, column_code, column_name, data_type, data_length) {
        var table = jQuery("#" + this.tableId);
        var tr = '<tr id="tr'+this.countCode+'">'+
					'<td class="content_02_box_div_table_td" style="text-align: center;"><input name="option_box" type="checkbox" value="tr'+this.countCode+'" style="width:15px;"/></td>'+
					'<td class="content_02_box_div_table_td" style="text-align: center;"><input type="text"  id="column_sn"' + this.countCode + '" name="column_sn" value="' + this.countCode + '" class="validate[required,custom[onlyNumberSp]] input_185" style="width:15px;"/></td>'+
					'<td class="content_02_box_div_table_td" style="text-align: center;"><input type="text"  id="column_code' + this.countCode + '" name="column_code" maxlength="100" value="' + column_code + '"' +' class="validate[required,maxSize[100]] input_185" style="width:200px;"/></td>'+
					'<td class="content_02_box_div_table_td" style="text-align: center;"><input type="text"  id="column_name' + this.countCode + '" name="column_name" maxlength="100" value="' + column_name + '"' + ' class="validate[required,maxSize[100]] input_185" style="width:200px;"/></td>'+
					'<td class="content_02_box_div_table_td" style="text-align: left;"><select               id="data_type' + this.countCode + '"   name="data_type" style="text-align: left;height: 20px;width:100px;"><option value="VARCHAR2">VARCHAR2</option><option value="CHAR">CHAR</option><option value="NUMBER">NUMBER</option><option value="DATE">DATE</option></select></td>'+
					'<td class="content_02_box_div_table_td" style="text-align: center;"><input type="text"  id="data_length' + this.countCode + '" name="data_length" maxlength="100" value="' + data_length + '"' +' class="input_185" style="width:50px;"/></td>'+
        		 '</tr>';
        //给table添加列
        table.html(table.html() + tr);
        this.countCode = this.countCode + 1;
    },
    /**
     *移除html
     */
    removeHtml: function () {
        //移除选中的行  
        jQuery("input[name=option_box]").each(function () {
            if (jQuery(this).attr("checked")) {
                jQuery("#" + this.value).remove();
            }
        });
    }
	
}
</script>
</head>
<body onload="">
<form action="" id="form1" name="form1" method="post" >
<div class="content_02_box">
	<div class="content_02_box_title_bg"><span>修改表</span></div>
		<div class="content_02_box_div">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table_02">
				<tr>
					<th class="content_02_box_div_table_th">
						<font color="red">*</font>表名：
					</th>
					<td class="content_02_box_div_table_td">
						<input type="hidden"  name="table_id" id="table_id" value="<%=tablemap.get("table_id") %>" />
						<input type="text"  name="table_code" id="table_code" class="validate[required,maxSize[40]] input_185" readonly="readonly" value="<%=tablemap.get("table_code") %>" />
					</td>
					<th class="content_02_box_div_table_th" >
						<font color="red">*</font>全名（注释）：
					</th>
					<td class="content_02_box_div_table_td">
						 <input type="text" name="table_name" id="table_name" class="validate[required,maxSize[20]] input_185" value="<%=tablemap.get("table_name") %>" />
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">
						<font color="red">*</font>主键名：
					</th>
					<td class="content_02_box_div_table_td">
						 <input type="text"  name="pkname" id="pkname"   class="validate[required,maxSize[40]] input_185"  readonly="readonly" value="<%=tablemap.get("pkname") %>"  />
					</td>
					<th class="content_02_box_div_table_th" >
						<font color="red">*</font>主键字段：
					</th>
					<td class="content_02_box_div_table_td">
						 <input type="text" name="pk" id="pk" class="validate[required,maxSize[20]] input_185"  readonly="readonly" value="<%=tablemap.get("table_pk") %>" />
					</td>
				</tr>
			</table>
		</div>
		
		
		<div class="content_02_box_div" style="height:300px">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table_02" >
			    <tr>
			        <td class="content_02_box_div_table_02_td" >
			        <div style="height:250px; overflow: auto;overflow-x:hidden;width:100%" scrolling="yes">
					 	<table id="option_List" width="100%" border="0" cellspacing="0"  cellpadding="0" class="content_02_box_div_table_02">
		            		<tr>
		            		<th class="content_02_box_div_table_th" style="text-align: center;width:15px">&nbsp;</th>
		            		<th class="content_02_box_div_table_th" style="text-align: center;width:15px">序号</th>
							<th class="content_02_box_div_table_th" style="text-align: center;width:100px">字段名称</th>
							<th class="content_02_box_div_table_th" style="text-align: center;width:100px">注释</th>
							<th class="content_02_box_div_table_th" style="text-align: center;width:100px">字段类型</th>
							<th class="content_02_box_div_table_th" style="text-align: center;width:30px">字段长度</th>
		        			</tr>
		        			<% for(int i=0;i<columnslist.size();i++){ %>
		        		<tr id="tr<%=i%>">
							<td class="content_02_box_div_table_td" style="text-align: center;"><input name="option_box" type="checkbox" value="tr'+this.countCode+'" style="width:15px;"/></td>
							<td class="content_02_box_div_table_td" style="text-align: center;"><input type="text"  id="column_sn<%=i%>" name="column_sn" value="<%=i%>" class="input_185" readonly="readonly" style="width:15px;"/></td>
							<td class="content_02_box_div_table_td" style="text-align: center;"><input type="text"  id="column_code<%=i%>" name="column_code" maxlength="100" value="<%=columnslist.get(i).get("column_code") %>" class="input_185" readonly="readonly" style="width:200px;"/>
							<input type="hidden"  id="column_id<%=i%>" name="column_id" maxlength="100" value="<%=columnslist.get(i).get("column_id") %>"  readonly="readonly"/></td>
							<td class="content_02_box_div_table_td" style="text-align: center;"><input type="text"  id="column_name<%=i%>" name="column_name" maxlength="100" value="<%=columnslist.get(i).get("column_name") %>" class="validate[required,maxSize[100]] input_185" style="width:200px;"/></td>
							<td class="content_02_box_div_table_td" style="text-align: left;"><input type="text"  id="data_type<%=i%>" name="data_type" maxlength="100" value="<%=columnslist.get(i).get("data_type") %>" class="input_185" readonly="readonly" style="width:200px;"/></td>
							<td class="content_02_box_div_table_td" style="text-align: center;">
							<%if(!"DATE".equals(columnslist.get(i).get("data_type"))){%>
							<input type="text"  id="data_length<%=i%>" name="data_length" maxlength="100" value="<%=columnslist.get(i).get("data_length") %>" class="input_185" readonly="readonly" style="width:50px;"/>
							<%}else{ %>
							<input type="text"  id="data_length<%=i%>" name="data_length" maxlength="100" value="" class="input_185" readonly="readonly" style="width:50px;"/>
							<%} %>							
							</td>
        				</tr>
        				<%} %>	        			
		        		</table>
			        </div>
			        </td>
			    </tr>
			</table>
		</div>
		
		
	</div>
	<div class="cue_box_foot">
		<input class="but_y_01" type="reset" id="resert" value="关闭" onclick="removeAlertWindows('',true)" />
		<input class="but_y_01" type="button" value="保存" onclick="createMdTablesForm()"/>
  	</div>
</form>
</body>
</html>