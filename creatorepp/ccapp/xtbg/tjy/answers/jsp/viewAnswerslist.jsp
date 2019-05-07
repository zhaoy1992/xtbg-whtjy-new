<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String loginUserName = accesscontroler.getUserAccount();
%>
<title>问答公布栏列表</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="<%=path %>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入my97时间控件 -->
<script src="<%=path %>/ccapp/oa/resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<script src="<%=path %>/ccapp/oa/resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="<%=path %>/ccapp/oa/resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="<%=path %>/ccapp/oa/resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<!-- 公共部分引用结束 -->
<!-- 当jqGrid列的字过多的时候显示...样式  -->

<script type="text/javascript">
var loginUserName = '<%=loginUserName%>';
$(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			announcementSearch();
		}
	});

	$("#gridTable").jqGrid({
		url: '<%=path%>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.tjy.answers.list.ViewAnswersList',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
		//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
		datatype: "json",
		//这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
		mtype: "POST",
		//定义使用哪种方法发起请求，GET或者POST
		height: "100%",//270
		//Grid的高度，可以接受数字、%值、auto，默认值为150
		//width ：800, //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
		//shrinkToFit ：true 此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条
		autowidth: true,
		//默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；如果当父容器尺寸变化了，同时也需要变化Grid的尺寸的话，则需要在自己的代码中调用setGridWidth方法来完成。
		colNames: ['实例id','业务id','表单','办件编号 ',  '标题', '问题类型','提出人 ','发布时间','办件历史 ', 'busitype_code', 'act_index','环节实例ID','流程ID','模板ID'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
        {
      		name: 'ins_id',
      		index: 'ins_id',
      		hidden: true
       	},
    	{
   			name: 'busi_id',
   			index: 'busi_id',
   			hidden: true
    	},
    	{
   			name: 'action_form',
   			index: 'action_form',
   			hidden: true
    	},
		{
			name: 'ins_code',
			index: 'ins_code',
			width: 90,
			hidden: true
		},
		{
			name: 'ins_name',
			index: 'ins_name',
			width: 120,
			editable: true
		},
		{
			name: 'template_id',
			index: 'template_id',
			width: 50,
			search: true
		},
		{
			name: 'accepter',
			index: 'accepter',
			width: 50,
			search: true
		},
		{
			name: 'accept_time',
			index: 'accept_time',
			width: 80,
			search: true
		},
		{
			name: 'act_index',
			index: 'act_index',
			width: 50,
			search: true,
			hidden: true
		},
		{
			name: 'act',
			index: 'act',
			width: 70,
			search: false,
			sortable: false,
			editable: false,
			hidden: true
		},
		{
  			name: 'busitype_code',
  			index: 'busitype_code',
  			hidden: true
   		},
   		{
  			name: 'act_insid',
  			index: 'act_insid',
  			hidden: true
   		},
   		{
  			name: 'flow_id',
  			index: 'flow_id',
  			hidden: true
   		},
	   	{
	   		name: 'template_id',
   			index: 'template_id',
   			hidden: true
	   	}
		],
		sortname: 'accept_time',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 10,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() { 
			var ids = $("#gridTable").getDataIDs();
			for (var i = 0; i < ids.length; i++) {
                var cl = ids[i];
				var model = jQuery("#gridTable").jqGrid('getRowData', cl);
			}
		},
		
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		//pager: "#gridPager",
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		//定义页码控制条Page Bar
		//caption: "已办列表",
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		search : toAnnouncementParamJosn(),
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			//表示请求行数的参数名称  
			sort: "sidx",
			//表示用于排序的列名的参数名称  
			order: "sord",
			//表示采用的排序方式的参数名称 
			search : "search"
		},
		toolbar: [true,"top",""],
		multiselect: false,
		onCellSelect: function(id,iCol) {
			if(iCol!=0){
				jQuery("#gridTable").setSelection(id,false);
				handle(id);
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
	 函数:  toAnnouncementParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toAnnouncementParamJosn = function() {
	 var str = "{'username':'"+loginUserName+"',"+
	  "'busitype_code':'',"+
	  "'ins_name':'"+$('#ins_name').val()+"',"+
	  "'accepter':'"+$('#accepter').val()+"','startSlTime':'"+$('#startSlTime').val()+"','endSlTime':'"+$('#endSlTime').val()+"'}";
		return descape(escape(str));
}

/*
	 函数:  userSearch
	 说明:  查询用户信息
	 参数:   无
	 返回值: 用户列表
*/
var announcementSearch = function() {
	var sdata = { //构建查询需要的参数 
		paramJson: toAnnouncementParamJosn()
	}; //获得当前postData选项的值  
	var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
	$.extend(postData, sdata);
	$("#gridTable").jqGrid("setGridParam", {
		search: true ,// 将jqGrid的search选项设为true  
		userFilters:toAnnouncementParamJosn()
	}).trigger("reloadGrid", [{
		page: 1
	}]); //重新载入Grid表格，以使上述设置生效 
	
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
		paramJson: toAnnouncementParamJosn()
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
var resetSingleSearchDialog = function() { //$("radio","#singleSearchDialog").attr("checked", false);  
	$(":text", "#queryTable").val("");
	$('#ckzt option:first').attr('selected', 'selected');
};

/*
函数:  delNotice
说明:  删除信息
参数:   无
返回值: 无
*/
var delNotice = function(id) {
	var ids = "";
	
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	for ( var i = 0; i < selectedIds.length; i++) {
		var model = jQuery("#gridTable").jqGrid('getRowData',
				selectedIds[i]);
		if ("" != ids) {
			ids += ",";
		}
	   ids +=  model.act_index ;
	}
	if (IsSpace(ids)) {
		alert("请选择要删除的记录！");
	} else{
		var okF = function(){
		$("#n_receiverids").val(ids);
			var fm = document.getElementById("delForm1");
		  	var url = "announcementdrewdo.jsp";
			document.all.delForm1.target = "hiddenFrame";
			fm.value=url
		$("#delForm1").submit();}
		var p={
				headerText:'提示',
				okName:'确认',
		        okFunction:okF,
		        cancelName:'取消'
		};
		alert("确定要删除该信息吗？",p)
	}
	

}

/*
	 函数:  handle
	 说明:  修改
	 参数:   无
	 返回值: 无
*/
function handle(id){ 
    var model = jQuery("#gridTable").jqGrid('getRowData', id);
    var url = '<%=path %>' + "/ccapp/xtbg/tjy/answers/jsp/answersShow.jsp" + "?ins_id="+model.ins_id+"&busi_id="+model.busi_id+"&list_type=worklis&operType=yiban&act_name="+model.act_name+"&actiontype_code=04&busiTypeCode="+model.busitype_code
  			  +"&template_id="+model.template_id+"&Template=word"+model.template_id+"&p_id="+model.act_index;
    window.location.href=url; //父页面调用打开窗口	
}
	
	



</script>
</head>
<body>
<div>


<table width="100%">
	<tr>
		<td><!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="tabs_search_ctable_box">
			<tr>
				<td><!-- 固定查询 -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="tabs_search_ctable">
					<tr>
						<th width="90" class="input_cx_title_th">标题：</th>
						<td width="296" class="cx_title_td"><input
							class="input_cx_title_283" type="text" id="n_title" name="n_title" />

						</td>
						<td width="385" colspan="3"><input name="Input2" value="搜索"
							type="button" onclick="announcementSearch()" class="but_y_01" />
						<span id="selAreaImg" class="all_search_condition"><a
							onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')">更多搜索条件</a></span></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td><!-- 隐藏查询 -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="tabs_search_ctable" id="hiddenArea" style="display: none">
					<tr>
						<th class="input_cx_title_th">发布单位：</th>
						<td class="cx_title_td"><input class="input_cx_title_283" type="text" id="n_orgname" name="n_orgname" /></td>
						<th class="input_cx_title_th">提问时间：</th>
						<td class="cx_title_td">
							<input class="date_120 Wdate" type="text" id="n_creator_time" name="n_creator_time" onfocus="WdatePicker({onpicked:function(){$('#n_release_time').focus();}})" />
							<span class="date_120_span">至</span> 
							<input class="date_120 Wdate" type="text" id="n_release_time" name="n_release_time" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'n_creator_time\')}',dateFmt:'yyyy-MM-dd'})" />
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<!-- 查询列表区 cGridArea(查询区样式)-->
<div class="cGridArea">
<table id="gridTable"></table>
<div id="gridPager"></div>
</div>
<!-- 查询列表区 --></div>
<form id="delForm1" name="delForm1" method="post" action="noticedo.jsp">
	<input type="hidden" name="n_receiverids" id="n_receiverids" /> 
	<input type="hidden" name="action" value="deleteNoticeReceiver" />
</form>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>