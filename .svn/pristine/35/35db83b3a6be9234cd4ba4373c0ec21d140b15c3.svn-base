<%--
describe: 发起任务列表
author:dailianchun
date: 2013-7-09
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.core.task.entity.* "%>
<%@page import="com.chinacreator.xtbg.core.task.util.*"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userId = accesscontroler.getUserID();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入my97时间控件 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>

<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>

<title>待办列表</title>
<script type="text/javascript">
var userId = "<%=userId%>";
//常量
var taskConstant = {
		IMPORTANCE_NORMAL : "<%=TaskConstant.IMPORTANCE_NORMAL%>",//普通
		IMPORTANCE_HIGHT : "<%=TaskConstant.IMPORTANCE_HIGHT%>",//重要
		IMPORTANCE_HIGHEST : "<%=TaskConstant.IMPORTANCE_HIGHEST%>",//非常重要
		STATUS_UNDO : "<%=TaskConstant.STATUS_UNDO%>",//未办理
		STATUS_DOING : "<%=TaskConstant.STATUS_DOING%>",//办理中
		STATUS_DID : "<%=TaskConstant.STATUS_DID%>"//已办结
};





$(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			tasksAssignedSearch();
		}
	});
   //多选框添加事件
   jQuery("#task_status").change(function(){
	   tasksAssignedSearch();
	});
   jQuery("#degree_of_importance").change(function(){
       tasksAssignedSearch();
    });
	
	$("#gridTable").jqGrid({
	url: '<%= path %>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.task.list.TasksAssignedList',  
	//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
	datatype: "json",
	//这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
	mtype: "POST",
	//定义使用哪种方法发起请求，GET或者POST
	height: "100%",//270
	//Grid的高度，可以接受数字、%值、auto，默认值为150
	autowidth: true,
	colModel: [ //最重要的数组之一，用于设定各列的参数
		 { 
			label : '负责人id',
		   	name: 'user_id',
		   	index: 'user_id',
		   	hidden: true
		 },
		{
			 label : '任务名称 ',
			name: 'task_name',
			index: 'task_name',
			width: 350,
			editable: true,
			formatter : function(value,column,row){
			 //如果未读回复不为0，则记录
             if("0" != row.report_count){
               return "<span style='color:#000'><span style='color:red;font-weight:bold;'>[未读回复"+row.report_count+"]</span></span>"+value;
             }
             return value;
           }
		},
		{
			label : '重要程度',
			name: 'degree_of_importance',
			index: 'degree_of_importance',
			width: 100,
			formatter : function(value){	
				if(taskConstant.IMPORTANCE_HIGHEST == value){
		            return "非常重要";
		         }else if(taskConstant.IMPORTANCE_HIGHT == value){
		            return "重要";
		         }else{
		            return "普通";
		         }
		    } 
		},{
            label : '任务状态',
            name: 'task_status_name',
            index: 'task_status_name',
            width: 100,
            search: true
        },
		{
			label : '任务状态',
			name: 'task_status',
			index: 'task_status',
			hidden: true
		},	
		{
			label : '开始时间',
			name: 'start_time',
			index: 'start_time',
			//hidden: true
			width: 120
		},
		{
			label : '计划完成时间',
			name: 'end_time',
			index: 'end_time',
			//hidden: true
			width: 120
		},
		{
			label : '实际办结时间',
			name: 'complete_time',
			index: 'complete_time',
			//hidden: true
			width: 120
		},
		{
			label :'负责人',
			name: 'receive_username',
			index: 'receive_username',
			//hidden: true
			width: 80
		},
		{  
			label : '负责人单位',
			name: 'receive_orgname',
			index: 'receive_orgname'
		},
		{  
			label : '主键id',
			name: 'id',
			index: 'id',
			hidden: true
		},
        {  
            label : '回复记录数',
            name: 'report_count',
            index: 'report_count',
            hidden: true
        }

	],
	sortname: 'start_time',
		
	//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
	sortorder: 'desc',
	
	viewrecords: true,
	
	//设置是否在Pager Bar显示所有记录的总数。
	rowNum: 10,
	jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
		repeatitems: false
	},
	//pager: "#gridPager",
	pagerintoolbar:true,//上面的分页条
	pagerinBottombar:true,//下面的分页条
	search : toTasksParamJosn(),
	caption: "",	
	prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
		rows: "rows",
		//表示请求行数的参数名称  
		sort: "sidx",
		//表示用于排序的列名的参数名称  
		order: "sord",
		//表示采用的排序方式的参数名称 
		search : "search"
	},
	toolbar: [true,"top","<input class='but_y_01' id='add' type='button' onclick='addInfo()' value='添加'/><input class='but_y_01' id='deletebutton' type='button' onclick='delInfo();' value='删除'/>"],
	multiselect: true,
	onCellSelect:function(id,iCol){
		if(iCol != 0 )
		{
			updateInfo(id);
		}
	}
}).navGrid('#gridPager', {
	edit: false,
	add: false,
	del: false,
	refresh: false,
	search: false
});

	
});
/*
函数:  toBriefsParamJosn
说明:  构建要查询的参数
参数:   无
返回值: 返回要查询的参数
*/
var toTasksParamJosn = function(){
	var str = "{'task_name':'" + StringCheck($("#task_name").val())		
			+ "','start_time':'" + $("#start_time").val()
			+ "','end_time':'" + $("#end_time").val()
			+ "','task_status':'" + $("#task_status").val() 
			+ "','degree_of_importance':'"+ $("#degree_of_importance").val()
			+ "','input_userid':'" + userId
			+ "','count_user_id':'"+ userId			
	        + "'}";
	return descape(escape(str));
}

/*
函数:  StringCheck
说明:  做查询时通配符处理问题
参数:   obj 文本框上获得的值
返回值: 返回转换后的值
*/
var StringCheck = function(obj){
    return obj.replaceAll('%','---').replaceAll("'","’").replaceAll(":","：");
}

/*
函数:  briefsSearch
说明:  查询信息
参数:   无
返回值: 列表
*/
var tasksAssignedSearch = function() {
	var sdata = { //构建查询需要的参数 
		paramJson : toTasksParamJosn()
	}; //获得当前postData选项的值  
	var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
	$.extend(postData, sdata);
	$("#gridTable").jqGrid("setGridParam", {
		search : true
	// 将jqGrid的search选项设为true  
	}).trigger("reloadGrid", [ {
		page : 1
	} ]); //重新载入Grid表格，以使上述设置生效 
	 }

	/*
		 函数:  addInfo
		 说明:  添加信息
		 参数:   无
		 返回值: 无
		 */
	var addInfo = function() {
				//JqueryDialog.Open1('添加信息', 'addtasks.jsp', 800, 450, true, true, true);
		var url = 'addtasks.jsp?windowId=add_taskbaseinfo&status=1';
		openWindows('add_taskbaseinfo','添加交办任务',url,'task',false,window);	
	}

	/*
		 函数:  updateInfo
		 说明:  修改信息
		 参数:   无
		 返回值: 无
		 */
	var updateInfo = function(id) {
			var model = jQuery("#gridTable").jqGrid('getRowData', id);			
			var url = 'addtasks.jsp?windowId=sub_updatetasks&id='+model.id+'&status='+model.task_status;
			var type_name = model.type_name;
			openWindows('sub_updatetasks','浏览交办任务',url,'task',false,window);	
	}

	
	/*
	    函数:  del
	   说明:  删除
	   参数:  无
	   返回值: 无
	*/
	var delInfo = function() {
	    var ids = "";
	    var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	    var ids = new Array();
	    $(selectedIds).each(function () {
	        var model = jQuery("#gridTable").jqGrid('getRowData', this);
	        //id不为空
	        ids.push(model.id);  
	    });
	        
	    if (!ids.length) {
	        alert("未选中数据，请重新选择要删除的数据！");
	    } else {
	        var okF = function(){
	            //ajax方式提交数据
	            jQuery.ajax({ 
	                type: "post", 
	                url: "taskseditordrewdo.jsp", 
	                contentType: "application/x-www-form-urlencoded; charset=utf-8",
	                data : {
	                    action : "delete",
	                    ids : ids.join(",") //要删除的id列表      
	                },
	                dataType: "json", 
	                success: function (data) {
	                    if(data){
	                        if(data.msg){
	                            alert(data.msg);
	                        }
	                        //如果删除成功，刷新数据
	                        if(data.flag&&"true" == data.flag){
	                        	tasksAssignedSearch();
	                        }
	                    }
	                }, 
	                error: function (XMLHttpRequest, textStatus, errorThrown) { 
	                    alert("系统异常，请稍后再试！");
	                }
	             });
	        }
	        var p={
	                    headerText:'提示',
	                    okName:'确认',
	                    okFunction:okF,
	                    cancelName:'取消'
	            };
	        alert("删除后将不能恢复，确定删除吗？",p); 
	    }
	}
	/*
	 函数:  clearSearch
	 说明:  重置
	 参数:   无
	 返回值: 无
	 */
	var clearSearch = function() {
		 resetSingleSearchDialog();
			var sdata = {
				paramJson: toTasksParamJosn()
			};
			var postData = $("#gridTable").jqGrid("getGridParam", "postData");
			$.extend(postData, sdata); //将postData中的查询参数覆盖为空值  
			$("#gridTable").jqGrid("setGridParam", {
				search: true // 将jqGrid的search选项设为false  
			}).trigger("reloadGrid", [{
				page: 1
			}]);
	};

	/*
	 函数:  resetSingleSearchDialog
	 说明:  清空值查询值
	 参数:   无
	 返回值: 无
	 */
var resetSingleSearchDialog = function() {
	$("#queryTable input[type=text]").val("");
	$("select option:first").attr("selected","selected");	
};

</script>
</head>
<body>
<form id="form1" name="form1" method="post" action="">	
		
<input type="hidden" name="testid" id="testid"> 
<table width="100%" id="queryTable">
	<tr>
		<td>
			<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
				<tr>
					<td>
						<!-- 固定查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
							<tr>
								<th width="90" class="input_cx_title_th" >任务名称：</th>
								<td width="296"  class="cx_title_td">
								<input  type="text" class="input_cx_title_283" id="task_name" name="task_name"/>
								</td>
								<td width="385"  colspan="2"  >
								<input name="Input2" value="搜索" type="button" onclick="tasksAssignedSearch()" class="but_y_01"/>
								
								<span id="selAreaImg" class="all_search_condition"><a onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')" >更多搜索条件</a></span></td>
							</tr>
						</table>
						<!-- 固定查询 end-->
					</td>
					</tr>
					
					<tr>
					<td>
					<!-- 隐藏查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable" id="hiddenArea" style="display:none">
						<tr>
						    <th class="input_cx_title_th">开始时间：</th>
						    <td class="cx_title_td">
								<input class="date_120 " type="text" id="start_time" name="start_time" 
									onFocus="var input_endtime=$dp.$('end_time');WdatePicker({onpicked:function(){end_time.focus();},dateFmt:'yyyy-MM-dd '})" 
									/>
									<span class="date_120_span">至</span>
								  <input class="date_120 " type="text" id="end_time" name="end_time" 
								  onfocus="WdatePicker({minDate:'#F{$dp.$D(\'start_time\')}',dateFmt:'yyyy-MM-dd '})" 
								  />
							</td>
     							
  							</tr>
  							<tr>
  							<th class="input_cx_title_th">任务状态：</th>
								<td  class="cx_title_td">
								<select style="width:150px;" name ="task_status" id= "task_status" size ="1"  class ="select_100_box_type" >
                               <option value ="">---请选择---</option>
                               <option value ="1">未办理</option>
                                <option value ="2">办理中</option>
                                <option value ="3">已办结</option>     
                      </select>
							</td>
							<th class="input_cx_title_th">重要程度：</th>
								<td  class="cx_title_td">
								  <select style="width:150px;" name ="degree_of_importance" id= "degree_of_importance" size ="1"  class ="select_100_box_type" >
                                <option value ="">---请选择---</option>
                                <option value ="1">普通</option>
                                <option value ="2">重要</option>
                                <option value ="3">非常重要</option>                                
                                </select>
							</td>
  								
  							</tr>
						</table>
						<!-- 隐藏查询 end-->
							</td>
				</tr>
			</table>
			
		<!-- 查询列表区[开始]-->
		<div class="cGridArea">
			<table id="gridTable"></table>
			<div id="gridPager"></div>
		</div>
		<iframe name="hiddenFrame" width=0 height=0></iframe>
	</td>
	</tr>
	</table>
	</form>
	<form id="delForm" name="delForm" method="post" action="taskseditordrewdo.jsp">
					<input type="hidden" name="userIds" id="userIds" />
					<input type="hidden" name="Ids" id="Ids" /> 
					<input type="hidden" name="action1" value="del" />
	</form>	
</body>
</html>