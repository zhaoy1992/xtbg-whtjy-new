<%@page import="com.chinacreator.xtbg.core.archive.entity.SfwdjUserListConfBean"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.archive.dao.impl.WorkCountDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.archive.dao.WorkCountDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.HashSet"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String path = request.getContextPath();
	String grinfoIds = "";
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String loginUserName = accesscontroler.getUserAccount();
	String userid = accesscontroler.getUserID();
	String subid = request.getParameter("subid");
	String listtype = request.getParameter("listtype");
	
	WorkCountDao workCountDao = new WorkCountDaoImpl();
	List<Map<String,String>> tables = workCountDao.getAllGWTableByListType(listtype);
	
	SfwdjUserListConfBean sfwdjUserListConfBean = workCountDao.getUserListConfigInfo(listtype, userid);
	

%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入formvValidatetion -->
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>

<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入其它 -->
<script src="./../../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<style type="text/css">
	body{font-size:14px;}
	.column{
		margin-left:30px;
	}
	.column ul{
		width:550px;
	}
	.column li{
		width:120px;
		float:left;margin-right:15px;line-height:20px;
	}
	.column li .column_sort{
		margin-left:5px;
		text-align:center;
		width:20px;
	}
	.tablediv{
		float:left;
		margin-right:20px;
	}
	.red {
		color:red;
	}
	.clear{
		clear:both;
	}

</style>
<!-- 公共部分引用结束 -->
<title>公文登记薄列表配置</title>
<script type="text/javascript">
var selectedTablecode = "<%=(null != sfwdjUserListConfBean)?sfwdjUserListConfBean.getExtable():""%>";
var selectedColumns = "<%=(null != sfwdjUserListConfBean)?sfwdjUserListConfBean.getColumn_list():""%>";
var listtype = "<%=listtype%>";
var saveformurl = getContextPath()+"/ccapp/oa/archive/worklistcount/jsp/gwcountlistdo.jsp";
$(function(){

	$("#tableselect").bind("propertychange",function(){
		changeTable($("option:selected",this).val().split(",")[1]);
	})
	
	$("#savebut").click(function(){save();});

	//初始化界面元素
	if('' != selectedTablecode){
		var initSelectedOption = $("option[value^='"+selectedTablecode+"']","#tableselect");
		initSelectedOption.attr("selected",true);
	}

})


var changeTable = function(tableid){

		params = {
				tableid : tableid,
				action : "queryColumns"
				 };
		$.ajax({
			url: saveformurl,
			type: 'POST',
			dataType: 'json',
			data: params,
			success: function(data){
				createColumnDiv(data);
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert("查询表字段失败！");
			}
		});
}

var createColumnDiv = function(columns){
	$("#column").html("");
	var isInitTableOption = ($("option:selected","#tableselect").val().indexOf(selectedTablecode) != -1) ;//是否选中了初始化的table
	var temp_columnvalue_index = 0;//临时变量,标记已获取了字段值的第几位 
	var ul = $("<ul></ul>");
	for(var i = 0 ; i < columns.length; i++){
		
		if(i != 0 && i%4 == 0){
			$("#column").append(ul);
			ul = $("<ul></ul>");
		}
		var column_var = columns[i];
		var checked = "";
		var columnsort_style = "display:none;";//字段排序输入框默认显示是隐藏
		var columnsort_value = "";//字段排序输入框的value值
		if(isInitTableOption){
			if(_pub.util.isContainStr(selectedColumns.split("#")[0],column_var.column_code)){
				checked = "checked=true";
				columnsort_style = "";
				if(selectedColumns.split("#").length > 2){
					columnsort_value = selectedColumns.split("#")[2].split(",")[temp_columnvalue_index];
					temp_columnvalue_index++;
				}
				
			}
		}
		var checkid = "column_check_"+i;//checkbox的id
		var column_sort_id = "columnsort_input"+i;//字段排序输入框的id
		var column_li = $("<li><input type='checkbox' id='"+checkid+"' "+checked+" value='"+column_var.column_code+"'><span>"+column_var.column_name+"</span></input>"+ 
							"<input type='text' id='"+column_sort_id+"' value='"+columnsort_value+"' maxlength='2' class='column_sort validate[required,custom[integer]]' style='"+columnsort_style+"'></input></li>");
		$("#"+checkid,column_li).click(function(){
			if("checked" == $(this).attr("checked")){//如果check被选上了，则显示字段排序输入框
				$("input[type=text]",$(this).parent()).show();
			}else{
				$("input[type=text]",$(this).parent()).hide();
			}
		});
		$(ul).append(column_li);
	}
	$("#column").append(ul);
}

var save = function(){
	var isFlag = jQuery('#form_').validationEngine('validate'); //是否全部验证通过
	if(!isFlag){
		return;
	}
	
	var tablecode = $("option:selected","#tableselect").val().split(",")[0];
	var choose_columns = "";
	var tempArry = new Array();
	var tempArry2 = new Array();
	var tempArry3 = new Array();
	$("input:checked","#column").each(function(i,e){
		tempArry.push($(e).val());
		tempArry2.push($(e).next("span").text());
		var temp_value = $("input[type=text]",$(e).parent()).val();
		tempArry3.push($("input[type=text]",$(e).parent()).val());
	})
	if(tempArry.length > 0)
		choose_columns = tempArry.join()+"#"+tempArry2.join()+"#"+tempArry3.join();
	
	params = {
			tablecode : tablecode,
			listtype : listtype,
			choose_columns : choose_columns,
			action : "saveTableColumns"
			 };
	$.ajax({
		url: saveformurl,
		type: 'POST',
		dataType: 'script',
		data: params,
		success: function(data){
			closeAlertWindows("<%=subid%>",true,true);
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("查询表字段失败！");
		}
	});
}
	
</script>
</head>
<body>
	<div class="tablediv">
		需要扩展的业务表：
		<select id="tableselect" >
			<option value=""></option>
			<%for(int i = 0;i < tables.size();i++){ %>
				<option value="<%=tables.get(i).get("table_code")%>,<%=tables.get(i).get("table_id")%>"><%=tables.get(i).get("table_name")%></option>
			<%} %>
		</select>
		
	</div>
	<input type="button" value="保存" class="but_y_01" id="savebut"></input>
	<form id="form_" name="form_" method="post" >
		<div class="clear"></div>
		<div>
			对应表的字段(<span class="red">字段后面可以输入字段的排序号，进而控制字段在列表上展示的顺序</span>)：
			<div id="column" class="column">
			
			</div>
		</div>
	</form>
	<form id="form1" name="form1" method="post" >
  	<input id="grinfoId" name="grinfoId" type="hidden"/>
	</form>
	<iframe name="hiddenFrame" width=0 height=0></iframe>

</body>
</html>
