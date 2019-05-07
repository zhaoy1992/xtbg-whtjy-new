<%-- 
描述：新建业务表、新增数据元表、新增数据元字段表
作者：黄海
版本：1.0
日期：2013-06-08
 --%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.service.impl.MdTableAndColumnsServiceIml"%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.service.MdTableAndColumnsService"%>
<%@page import="java.util.Map"%>
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
	
	//主键名称列表
	List<Map<String,String>> pklist=service.findPkNameList(mdTableBean);
	String pknamelist=",";
	for(int i=0;i<pklist.size();i++){
		pknamelist+=pklist.get(i).get("constraint_name")+",";
	}
	Map<String,String> tablemap=new HashMap<String,String>();;
	List<Map<String,String>> columnslist=new ArrayList<Map<String,String>>();
	MdTableAndColumnsService tcservice=new MdTableAndColumnsServiceIml();
	if(!StringUtil.isBlank(table_id)){
		tablemap= tcservice.getOneMdTable(table_id);
		tablemap.put("table_code",tablemap.get("table_code")+"_copy");
		
		columnslist= tcservice.getMdColumns(table_id);
	}
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
	if(""=='<%=table_id%>'){
		tableControl.addHtml("", "T_ID", "主键", "VARCHAR2", "50");
		tableControl.addHtml("", "T_FJ_ID", "附件id", "VARCHAR2", "50");
		tableControl.addHtml("", "T_ZW_ID", "正文id", "VARCHAR2", "50");
		
		jQuery("#pk").val("T_ID");
	}
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
    var arr_column_name = jQuery("input[name=column_name]");
    var arr_data_type = jQuery("select[name=data_type]");
    var arr_data_length = jQuery("input[name=data_length]");
    var arr_column_sn = jQuery("input[name=column_sn]");
	
	for(var i=0;i<arr_column_code.length;i++){
		if ((arr_data_type[i].value != "DATE" && arr_data_type[i].value != "NUMBER")) {//char varchar2
			if(isSpace(arr_data_length[i].value)){
				alert("字段长度不能为空(第"+i.toString()+"行)");
	        	return;
			}
	        if(!isNumber(arr_data_length[i].value)){
				alert("字段长度只能是正整数(第"+i.toString()+"行)");
	        	return;
			}
		}
	}
	var okF = function(){
		
		var mdtablejson = "{" +
						    "'table_code':'" + $("#table_code").val() + "'," +
						    "'table_name':'" + $("#table_name").val() + "'," +
						    "'pkname':'" + $("#pkname").val() + "'," +
						    "'table_pk':'" + $("#pk").val() + "'," +
						    "'havepk':'" + ($("#pk").val() ? "1" : "0") + "'" +
	    "}";

	    for(var i=0;i<arr_column_code.length;i++){
	    	mdcolumnlistjson += "{" +
							    "'column_code':'" + arr_column_code[i].value + "'," +
							    "'column_name':'" + arr_column_name[i].value + "'," +
							    "'data_type':'" + arr_data_type[i].value + "'," +
							    "'data_length':'" + arr_data_length[i].value + "'," +
							    "'column_sn':'" + arr_column_sn[i].value + "'," +
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
		if(flag=="false"){
			alert("你还没添加主键字段，请先添加！");
			return;
		}
	    var code='<%=code%>';
	    var table_code=","+jQuery("#table_code").val().toUpperCase()+",";
	    if(code.indexOf(table_code)!=-1){
		    alert("该表名已存在,请更换表名！");
		    return;
	    }
	    var pknamelist='<%=pknamelist%>';
	    var pkname=","+jQuery("#pkname").val().toUpperCase()+",";
	    if(pknamelist.indexOf(pkname)!=-1){
		    alert("该主键名称已存在,请更换主键名！");
		    return;
	    }
		var url="savecreatetableform.jsp";
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
	alert("确定要创建新表吗？",p);
}

/* 
	函数:  closeform
	说明:  关闭指定窗口，刷新其父页面列表
	参数:  windowId 窗口id
 */
function closeform(windowId){
    closeAlertWindows(windowId, false, true);
}
/**
 * 字段增删控制
 */
var tableControl = {
    tableId: "option_List", //dom id
    countCode: 0,
    addHtml: function (id, column_code, column_name, data_type, data_length) {
    	var id= jQuery("#option_List tr").last()[0].id;
    	if(!IsSpace(id)){
	    	this.countCode=parseInt(id.replace('tr',''))+1;
    	}
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

var onchangepk=function(id){
	jQuery("#pkname").val("PK_"+jQuery("#"+id).val());
}
</script>
</head>
<body onload="">
<form action="" id="form1" name="form1" method="post" >
<div class="content_02_box">
	<div class="content_02_box_title_bg"><span>新建表</span></div>
		<div class="content_02_box_div">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table_02">
				<tr>
					<th class="content_02_box_div_table_th">
						<font color="red">*</font>表名：
					</th>
					<td class="content_02_box_div_table_td">
						 <input type="text"  name="table_code" id="table_code" class="validate[required,maxSize[40],custom[nameCheck]] input_185" onchange="onchangepk(this.id)" value="<%=StringUtil.deNull(tablemap.get("table_code"))%>" />
					</td>
					<th class="content_02_box_div_table_th" >
						<font color="red">*</font>全名（注释）：
					</th>
					<td class="content_02_box_div_table_td">
						 <input type="text" name="table_name" id="table_name" value="<%=StringUtil.deNull(tablemap.get("table_name")) %>" class="validate[required,maxSize[20]] input_185"  />
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">
						<font color="red">*</font>主键名：
					</th>
					<td class="content_02_box_div_table_td">
						 <input type="text"  name="pkname" id="pkname" value="<%=StringUtil.deNull(tablemap.get("pkname")) %>" class="validate[required,maxSize[40],custom[nameCheck]] input_185" />
					</td>
					<th class="content_02_box_div_table_th" >
						<font color="red">*</font>主键字段：
					</th>
					<td class="content_02_box_div_table_td">
						 <input type="text" name="pk" id="pk" value="<%=StringUtil.deNull(tablemap.get("table_pk")) %>"  class="validate[required,maxSize[20]] input_185"  />
					</td>
				</tr>
			</table>
		</div>
		
		
		<div class="content_02_box_div" style="height:300px">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table_02" >
			    <tr>
			        <td width="100%" class="content_02_box_div_table_02_td">
			        	<input name="" type="button" value="添加字段" class="but_y_01" onclick="tableControl.addHtml('','','','','','');" />
			            <input name="" type="button" value="删除"     class="but_y_01" onclick="tableControl.removeHtml();" />
		            </td>
			    </tr>
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
		        			<%if(""!=table_id){ for(int i=0;i<columnslist.size();i++){ %>
		        			<tr id="tr<%=i%>">
								<td class="content_02_box_div_table_td" style="text-align: center;"><input name="option_box" type="checkbox" value="tr<%=i %>" style="width:15px;"/></td>
								<td class="content_02_box_div_table_td" style="text-align: center;"><input type="text"  id="column_sn<%=i%>" name="column_sn" value="<%=i%>" class="input_185" style="width:15px;"/></td>
								<td class="content_02_box_div_table_td" style="text-align: center;"><input type="text"  id="column_code<%=i%>" name="column_code" maxlength="100" value="<%=columnslist.get(i).get("column_code") %>" class="input_185"  style="width:200px;"/>
								<input type="hidden"  id="column_id<%=i%>" name="column_id" maxlength="100" value="<%=columnslist.get(i).get("column_id") %>"  readonly="readonly"/></td>
								<td class="content_02_box_div_table_td" style="text-align: center;"><input type="text"  id="column_name<%=i%>" name="column_name" maxlength="100" value="<%=columnslist.get(i).get("column_name") %>" class="validate[required,maxSize[100]] input_185" style="width:200px;"/></td>
								<td class="content_02_box_div_table_td" style="text-align: left;">
								<select id="data_type<%=i%>" name="data_type" value="<%=columnslist.get(i).get("data_type") %>" style="text-align: left;height: 20px;width:100px;"><option <%if("VARCHAR2".equals(columnslist.get(i).get("data_type"))) {%>selected="selected" <%} %> value="VARCHAR2">VARCHAR2</option>
								<option <%if("CHAR".equals(columnslist.get(i).get("data_type"))) {%>selected="selected" <%} %> value="CHAR">CHAR</option>
								<option <%if("NUMBER".equals(columnslist.get(i).get("data_type"))) {%>selected="selected" <%} %> value="NUMBER">NUMBER</option>
								<option <%if("DATE".equals(columnslist.get(i).get("data_type"))) {%>selected="selected" <%} %> value="DATE">DATE</option></select>
								</td>
								
								<td class="content_02_box_div_table_td" style="text-align: center;">
								<%if(!"DATE".equals(columnslist.get(i).get("data_type"))){%>
								<input type="text"  id="data_length<%=i%>" name="data_length" maxlength="100" value="<%=columnslist.get(i).get("data_length") %>" class="input_185"  style="width:50px;"/>
								<%}else{ %>
								<input type="text"  id="data_length<%=i%>" name="data_length" maxlength="100" value="" class="input_185"  style="width:50px;"/>
								<%} %>
								</td>
        					</tr>
		        			<% }}%>
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