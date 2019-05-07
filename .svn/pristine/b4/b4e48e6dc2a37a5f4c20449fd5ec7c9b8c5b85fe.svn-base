<%--
　　描述：新增/修改 表字段
　　作者：黄海
　　版本：1.0
　　日期：2013-06-07
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.List"%>
<%@ page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@ page import="com.chinacreator.xtbg.core.common.util.DataControlUtil"%>
<%@page import="com.chinacreator.xtbg.core.process.dbmanager.service.MdServiceIfc" %>
<%@page import="com.chinacreator.xtbg.core.process.dbmanager.service.impl.MdServiceImpl" %>
<%@page import="com.chinacreator.xtbg.core.dssave.entity.MdColumnBean" %>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String table_id = request.getParameter("table_id"); //数据元表主键id           
String table_code = request.getParameter("table_code");//业务表名                                    
//修改会传column_id 主键
String column_id = StringUtil.deNull(request.getParameter("column_id"));//数据元字段表主键id		  	
String updatetype = StringUtil.deNull(request.getParameter("updatetype"));//更新类型  ：add/edit 
String path = request.getContextPath();
String column_name = "";
String column_code = "";
String data_type="";
String data_length="";
String nullable="";
String column_sn = "";
String canEdit = "";
boolean flag = false;
MdServiceIfc service = new MdServiceImpl();

if (updatetype.equalsIgnoreCase("add")){
	
}else if (updatetype.equalsIgnoreCase("edit")){
	canEdit = " disabled='disabled' ";
	MdColumnBean model = new MdColumnBean();
	//查系统表
	model = service.findMdColumnsById(column_id);
	column_name=StringUtil.deNull(model.getColumn_name());//不会更新到业务表的
	column_code=StringUtil.deNull(model.getColumn_code());
	data_type=StringUtil.deNull(model.getData_type());
	data_length=StringUtil.deNull(model.getData_length());
	nullable=StringUtil.deNull(model.getNullable());
	column_sn=StringUtil.deNull(model.getColumn_sn());
}else{
	flag=false;
	throw new Exception("业务异常：操作类型出错！可能用非法方式访问程序" );
}


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></meta>
<title>新增/修改 表字段</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<script>
$(document).ready(function() {
	$("#column_name").focus();
	$("#data_type").attr('value',$('#db_data_type').val()); 
	if(jQuery("#data_type").val()=='DATE'){
		jQuery("#font").text("");
		jQuery("#data_length").attr("disabled","disabled");
	}
});
/*
	表单验证
*/
function nativeValidate(){
    //字段长度
    if ((jQuery("#data_type").val() != "DATE" && jQuery("#data_type").val() != "NUMBER")) {
        if(isSpace(jQuery("#data_length").val())){
			alert("字段长度不能为空");
       		 return;
		}
		if(!isNumber(jQuery("#data_length").val())){
			alert("字段长度只能是正整数");
        	return;
		}
    }
    if(jQuery("#data_type").val() == "NUMBER" && jQuery("#data_length").val()>38 ){
    	alert("NUMBER的最大长度为38,请重新填写NUMBER型长度！");
    	return;
    }
    return true;    
}
/* 
	函数:  saveMdColumnsForm
	说明:  保存 新增/修改后的表字段
*/
function saveMdColumnsForm(){
	var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
    if(!isFlag){
       return;
    }
    //本地验证
    var nFlag = nativeValidate();
    if(!nFlag){
       return;
    }
	var jsonparam = "{"+
						"'column_id':'"+$("#column_id").val()+"'," +
						"'table_id':'" +$("#table_id").val()+"',"+
						"'column_code':'" +$("#column_code").val()+"',"+
						"'column_name':'" +$("#column_name").val()+"',"+
						"'column_sn':'" +$("#column_sn").val()+"',"+
						"'table_name':'" +$("#table_code").val()+"',"+
						"'data_type':'"+$("#data_type").val()+"',"+
						"'data_length':'"+$("#data_length").val()+"'"+
					"}";
	var okF = function(){
		var params = {
			    jsonparam: descape(escape(jsonparam)),
			    updatetype: $('#updatetype').val()
		};
		url="savemdcolumnsform.jsp";
		$.ajax({
			url: url,
			type: 'POST',
			dataType: 'json',
			data: params,
			async : true, 
			success: function(data){
				if(data.flag){
					alert("操作成功！");
				}else{
					if(data.info=="false"){
						alert("操作失败！");
					}else{
						alert(data.info);
					}
				}
				setTimeout(function(){closeform('windowId');},500);
				//closeform('windowId');
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert("error:"+textStatus+"--"+jqXHR);
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
	alert("确定要更新表字段吗？",p);
}

/* 
	函数:  closeform
	说明:  关闭指定窗口，静态刷新其父页面列表
	参数:  windowId 窗口id
 */
function closeform(windowId){
	getParentWindow(windowId).refreshGrid();
	//setTimeout(function(){removeAlertWindows('',true)},500);
	removeAlertWindows('',true)
}
function changes(){
	if(jQuery("#data_type").val()=='DATE'){
		jQuery("#font").text("");
		jQuery("#data_length").attr("disabled","disabled");
		jQuery("#data_length").val("");
	}else{
		jQuery("#font").text("*");
		jQuery("#data_length").removeAttr("disabled","disabled");
	}
}

</script>
</head>
<body onload="">
<form action="" id="form1" name="form1" method="post" >
<input type="hidden" id="jsonparam"   name="jsonparam" />
<input type="hidden" id="column_id"   name="column_id"    value="<%=column_id %>" />
<input type="hidden" id="table_code"  name="table_code"   value="<%=table_code %>" />
<input type="hidden" id="table_id"    name="table_code"   value="<%=table_id %>" />
<input type="hidden" id="updatetype"  name="updatetype"   value="<%=updatetype %>" />
<div class="content_02_box">
	<div class="content_02_box_title_bg"><span>表名：<%=table_code %></span></div>
		<div class="content_02_box_div">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table_02">
				<tr>
					<th class="content_02_box_div_table_th">
						<font color="red">*</font>字段名称：
					</th>
					<td class="content_02_box_div_table_td">
						 <input type="text" <%=canEdit %> name="column_code" id="column_code" class="validate[required] input_185" value="<%=column_code %>" />
					</td>
					<th class="content_02_box_div_table_th" >
						<font color="red">*</font>全名（注释）：
					</th>
					<td class="content_02_box_div_table_td">
						 <input type="text" name="column_name" id="column_name" class="validate[required] input_185" value="<%=column_name %>" />
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">
						<font color="red">*</font>字段类型：
					</th>
					<td class="content_02_box_div_table_td">
						  <input type="hidden" name="db_data_type" id="db_data_type"  value="<%=data_type %>" />
						  <select name="data_type" id="data_type" class="validate[required] select_188_box" onchange="changes()">
						  	<option value="VARCHAR2">VARCHAR2</option>
							<option value="CHAR">CHAR</option>
							<option value="NUMBER">NUMBER</option>
							<option value="DATE">DATE</option>
						  </select>
					</td>
					<th class="content_02_box_div_table_th" id="length" >
						<font color="red" id="font" style="">*</font>字段长度：
					</th>
					<td class="content_02_box_div_table_td">
						  <input type="text" name="data_length" id="data_length" class="input_185" value="<%=data_length %>" />
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">
						<font color="red">*</font>排序号：
					</th>
					<td class="content_02_box_div_table_td">
						  <input type="text" name="column_sn" id="column_sn" class="validate[required,custom[onlyNumberSp]] input_185" value="<%=column_sn %>" />
					</td>
					<th class="content_02_box_div_table_th" >
						
					</th>
					<td class="content_02_box_div_table_td">
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="cue_box_foot">
		<input class="but_y_01" type="reset" id="resert" value="关闭" onclick="closeform('')" />
		<input class="but_y_01" type="button" value="保存" onclick="saveMdColumnsForm()"/>
  	</div>
</form>
</body>
</html>